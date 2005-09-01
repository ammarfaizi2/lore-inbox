Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030432AbVIAWXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030432AbVIAWXz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030465AbVIAWXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:23:55 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:26384 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1030432AbVIAWXy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:23:54 -0400
Message-Id: <200509012217.j81MH8wu011545@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 6/12] UML - Add host AIO support to block driver
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Sep 2005 18:17:08 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds AIO support to the ubd driver.
The driver breaks a struct request into IO requests to the host,
based on the hardware segments in the request and on any COW blocks
covered by the request.
The ubd IO thread is gone, since there is now an equivalent thread in the
AIO module.
There is provision for multiple outstanding requests now.  Requests aren't
retired until all pieces of it have been completed.  The AIO requests have
a shared count, which is decremented as IO operations come in until
it reaches 0.  This can be possibly moved to the request struct -
haven't looked at this yet.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: test/arch/um/drivers/Makefile
===================================================================
--- test.orig/arch/um/drivers/Makefile	2005-09-01 16:02:46.000000000 -0400
+++ test/arch/um/drivers/Makefile	2005-09-01 16:05:06.000000000 -0400
@@ -13,7 +13,7 @@
 net-objs := net_kern.o net_user.o
 mconsole-objs := mconsole_kern.o mconsole_user.o
 hostaudio-objs := hostaudio_kern.o
-ubd-objs := ubd_kern.o ubd_user.o
+ubd-objs := ubd_kern.o
 port-objs := port_kern.o port_user.o
 harddog-objs := harddog_kern.o harddog_user.o
 
Index: test/arch/um/drivers/ubd_kern.c
===================================================================
--- test.orig/arch/um/drivers/ubd_kern.c	2005-09-01 16:03:16.000000000 -0400
+++ test/arch/um/drivers/ubd_kern.c	2005-09-01 16:05:06.000000000 -0400
@@ -35,6 +35,7 @@
 #include "linux/blkpg.h"
 #include "linux/genhd.h"
 #include "linux/spinlock.h"
+#include "asm/atomic.h"
 #include "asm/segment.h"
 #include "asm/uaccess.h"
 #include "asm/irq.h"
@@ -53,20 +54,21 @@
 #include "mem.h"
 #include "mem_kern.h"
 #include "cow.h"
+#include "aio.h"
 
 enum ubd_req { UBD_READ, UBD_WRITE };
 
 struct io_thread_req {
-	enum ubd_req op;
+	enum aio_type op;
 	int fds[2];
 	unsigned long offsets[2];
 	unsigned long long offset;
 	unsigned long length;
 	char *buffer;
 	int sectorsize;
-	unsigned long sector_mask;
-	unsigned long long cow_offset;
-	unsigned long bitmap_words[2];
+	int bitmap_offset;
+	long bitmap_start;
+	long bitmap_end;
 	int error;
 };
 
@@ -80,28 +82,31 @@
 			   unsigned long *bitmap_len_out,
 			   int *data_offset_out);
 extern int read_cow_bitmap(int fd, void *buf, int offset, int len);
-extern void do_io(struct io_thread_req *req);
+extern void do_io(struct io_thread_req *req, struct request *r, 
+		  unsigned long *bitmap);
 
-static inline int ubd_test_bit(__u64 bit, unsigned char *data)
+static inline int ubd_test_bit(__u64 bit, void *data)
 {
+	unsigned char *buffer = data;
 	__u64 n;
 	int bits, off;
 
-	bits = sizeof(data[0]) * 8;
+	bits = sizeof(buffer[0]) * 8;
 	n = bit / bits;
 	off = bit % bits;
-	return((data[n] & (1 << off)) != 0);
+	return((buffer[n] & (1 << off)) != 0);
 }
 
-static inline void ubd_set_bit(__u64 bit, unsigned char *data)
+static inline void ubd_set_bit(__u64 bit, void *data)
 {
+	unsigned char *buffer = data;
 	__u64 n;
 	int bits, off;
 
-	bits = sizeof(data[0]) * 8;
+	bits = sizeof(buffer[0]) * 8;
 	n = bit / bits;
 	off = bit % bits;
-	data[n] |= (1 << off);
+	buffer[n] |= (1 << off);
 }
 /*End stuff from ubd_user.h*/
 
@@ -110,8 +115,6 @@
 static DEFINE_SPINLOCK(ubd_io_lock);
 static DEFINE_SPINLOCK(ubd_lock);
 
-static void (*do_ubd)(void);
-
 static int ubd_open(struct inode * inode, struct file * filp);
 static int ubd_release(struct inode * inode, struct file * file);
 static int ubd_ioctl(struct inode * inode, struct file * file,
@@ -158,6 +161,8 @@
         int data_offset;
 };
 
+#define MAX_SG 64
+
 struct ubd {
 	char *file;
 	int count;
@@ -168,6 +173,7 @@
 	int no_cow;
 	struct cow cow;
 	struct platform_device pdev;
+        struct scatterlist sg[MAX_SG];
 };
 
 #define DEFAULT_COW { \
@@ -460,81 +466,114 @@
 );
 
 static void do_ubd_request(request_queue_t * q);
-
-/* Only changed by ubd_init, which is an initcall. */
-int thread_fd = -1;
+static int in_ubd;
 
 /* Changed by ubd_handler, which is serialized because interrupts only
  * happen on CPU 0.
  */
 int intr_count = 0;
 
-/* call ubd_finish if you need to serialize */
-static void __ubd_finish(struct request *req, int error)
+static void ubd_end_request(struct request *req, int bytes, int uptodate)
 {
-	int nsect;
-
-	if(error){
-		end_request(req, 0);
-		return;
+	if (!end_that_request_first(req, uptodate, bytes >> 9)) {
+		add_disk_randomness(req->rq_disk);
+		end_that_request_last(req);
 	}
-	nsect = req->current_nr_sectors;
-	req->sector += nsect;
-	req->buffer += nsect << 9;
-	req->errors = 0;
-	req->nr_sectors -= nsect;
-	req->current_nr_sectors = 0;
-	end_request(req, 1);
-}
-
-static inline void ubd_finish(struct request *req, int error)
-{
- 	spin_lock(&ubd_io_lock);
-	__ubd_finish(req, error);
-	spin_unlock(&ubd_io_lock);
-}
-
-/* Called without ubd_io_lock held */
-static void ubd_handler(void)
-{
-	struct io_thread_req req;
-	struct request *rq = elv_next_request(ubd_queue);
-	int n;
-
-	do_ubd = NULL;
-	intr_count++;
-	n = os_read_file(thread_fd, &req, sizeof(req));
-	if(n != sizeof(req)){
-		printk(KERN_ERR "Pid %d - spurious interrupt in ubd_handler, "
-		       "err = %d\n", os_getpid(), -n);
-		spin_lock(&ubd_io_lock);
-		end_request(rq, 0);
-		spin_unlock(&ubd_io_lock);
-		return;
-	}
-        
-	ubd_finish(rq, req.error);
-	reactivate_fd(thread_fd, UBD_IRQ);	
-	do_ubd_request(ubd_queue);
 }
-
-static irqreturn_t ubd_intr(int irq, void *dev, struct pt_regs *unused)
+  
+/* call ubd_finish if you need to serialize */
+static void __ubd_finish(struct request *req, int bytes)
 {
-	ubd_handler();
-	return(IRQ_HANDLED);
-}
+	if(bytes < 0){
+		ubd_end_request(req, 0, 0);
+  		return;
+  	}
+  
+	ubd_end_request(req, bytes, 1);
+}
+  
+static inline void ubd_finish(struct request *req, int bytes)
+{
+   	spin_lock(&ubd_io_lock);
+	__ubd_finish(req, bytes);
+  	spin_unlock(&ubd_io_lock);
+}
+  
+struct bitmap_io {
+        atomic_t count;
+        struct aio_context aio;
+};
+
+struct ubd_aio {
+        struct aio_context aio;
+        struct request *req;
+        int len;
+        struct bitmap_io *bitmap;
+        void *bitmap_buf;
+};
 
-/* Only changed by ubd_init, which is an initcall. */
-static int io_pid = -1;
+static int ubd_reply_fd = -1;
 
-void kill_io_thread(void)
+static irqreturn_t ubd_intr(int irq, void *dev, struct pt_regs *unused)
 {
-	if(io_pid != -1) 
-		os_kill_process(io_pid, 1);
-}
+	struct aio_thread_reply reply;
+	struct ubd_aio *aio;
+	struct request *req;
+	int err, n, fd = (int) (long) dev;
+  
+	while(1){
+		err = os_read_file(fd, &reply, sizeof(reply));
+		if(err == -EAGAIN)
+			break;
+		if(err < 0){
+			printk("ubd_aio_handler - read returned err %d\n", 
+			       -err);
+			break;
+		}
+  
+                aio = container_of(reply.data, struct ubd_aio, aio);
+                n = reply.err;
+
+		if(n == 0){
+			req = aio->req;
+			req->nr_sectors -= aio->len >> 9;
+
+			if((aio->bitmap != NULL) &&
+			   (atomic_dec_and_test(&aio->bitmap->count))){
+                                aio->aio = aio->bitmap->aio;
+                                aio->len = 0;
+                                kfree(aio->bitmap);
+                                aio->bitmap = NULL;
+                                submit_aio(&aio->aio);
+			}
+			else {
+				if((req->nr_sectors == 0) &&
+                                   (aio->bitmap == NULL)){
+					int len = req->hard_nr_sectors << 9;
+					ubd_finish(req, len);
+				}
 
-__uml_exitcall(kill_io_thread);
+                                if(aio->bitmap_buf != NULL)
+                                        kfree(aio->bitmap_buf);
+				kfree(aio);
+			}
+		}
+                else if(n < 0){
+                        ubd_finish(aio->req, n);
+                        if(aio->bitmap != NULL)
+                                kfree(aio->bitmap);
+                        if(aio->bitmap_buf != NULL)
+                                kfree(aio->bitmap_buf);
+                        kfree(aio);
+                }
+	}
+	reactivate_fd(fd, UBD_IRQ);
 
+        do_ubd_request(ubd_queue);
+
+	return(IRQ_HANDLED);
+}
+  
 static int ubd_file_size(struct ubd *dev, __u64 *size_out)
 {
 	char *file;
@@ -569,7 +608,7 @@
 				&dev->cow.data_offset, create_ptr);
 
 	if((dev->fd == -ENOENT) && create_cow){
-		dev->fd = create_cow_file(dev->file, dev->cow.file, 
+		dev->fd = create_cow_file(dev->file, dev->cow.file,
 					  dev->openflags, 1 << 9, PAGE_SIZE,
 					  &dev->cow.bitmap_offset, 
 					  &dev->cow.bitmap_len,
@@ -831,6 +870,10 @@
 {
         int i;
 
+	ubd_reply_fd = init_aio_irq(UBD_IRQ, "ubd", ubd_intr);
+	if(ubd_reply_fd < 0)
+		printk("Setting up ubd AIO failed, err = %d\n", ubd_reply_fd);
+
 	devfs_mk_dir("ubd");
 	if (register_blkdev(MAJOR_NR, "ubd"))
 		return -1;
@@ -841,6 +884,7 @@
 		return -1;
 	}
 		
+	blk_queue_max_hw_segments(ubd_queue, MAX_SG);
 	if (fake_major != MAJOR_NR) {
 		char name[sizeof("ubd_nnn\0")];
 
@@ -852,40 +896,12 @@
 	driver_register(&ubd_driver);
 	for (i = 0; i < MAX_DEV; i++) 
 		ubd_add(i);
+
 	return 0;
 }
 
 late_initcall(ubd_init);
 
-int ubd_driver_init(void){
-	unsigned long stack;
-	int err;
-
-	/* Set by CONFIG_BLK_DEV_UBD_SYNC or ubd=sync.*/
-	if(global_openflags.s){
-		printk(KERN_INFO "ubd: Synchronous mode\n");
-		/* Letting ubd=sync be like using ubd#s= instead of ubd#= is
-		 * enough. So use anyway the io thread. */
-	}
-	stack = alloc_stack(0, 0);
-	io_pid = start_io_thread(stack + PAGE_SIZE - sizeof(void *), 
-				 &thread_fd);
-	if(io_pid < 0){
-		printk(KERN_ERR 
-		       "ubd : Failed to start I/O thread (errno = %d) - "
-		       "falling back to synchronous I/O\n", -io_pid);
-		io_pid = -1;
-		return(0);
-	}
-	err = um_request_irq(UBD_IRQ, thread_fd, IRQ_READ, ubd_intr, 
-			     SA_INTERRUPT, "ubd", ubd_dev);
-	if(err != 0)
-		printk(KERN_ERR "um_request_irq failed - errno = %d\n", -err);
-	return(err);
-}
-
-device_initcall(ubd_driver_init);
-
 static int ubd_open(struct inode *inode, struct file *filp)
 {
 	struct gendisk *disk = inode->i_bdev->bd_disk;
@@ -923,105 +939,55 @@
 	return(0);
 }
 
-static void cowify_bitmap(__u64 io_offset, int length, unsigned long *cow_mask,
-			  __u64 *cow_offset, unsigned long *bitmap,
-			  __u64 bitmap_offset, unsigned long *bitmap_words,
-			  __u64 bitmap_len)
+static void cowify_bitmap(struct io_thread_req *req, unsigned long *bitmap)
 {
-	__u64 sector = io_offset >> 9;
-	int i, update_bitmap = 0;
-
-	for(i = 0; i < length >> 9; i++){
-		if(cow_mask != NULL)
-			ubd_set_bit(i, (unsigned char *) cow_mask);
-		if(ubd_test_bit(sector + i, (unsigned char *) bitmap))
-			continue;
-
-		update_bitmap = 1;
-		ubd_set_bit(sector + i, (unsigned char *) bitmap);
-	}
-
-	if(!update_bitmap)
-		return;
+        __u64 sector = req->offset / req->sectorsize;
+        int i;
 
-	*cow_offset = sector / (sizeof(unsigned long) * 8);
+        for(i = 0; i < req->length / req->sectorsize; i++){
+                if(ubd_test_bit(sector + i, bitmap))
+                        continue;
+
+                if(req->bitmap_start == -1)
+                        req->bitmap_start = sector + i;
+                req->bitmap_end = sector + i + 1;
 
-	/* This takes care of the case where we're exactly at the end of the
-	 * device, and *cow_offset + 1 is off the end.  So, just back it up
-	 * by one word.  Thanks to Lynn Kerby for the fix and James McMechan
-	 * for the original diagnosis.
-	 */
-	if(*cow_offset == ((bitmap_len + sizeof(unsigned long) - 1) /
-			   sizeof(unsigned long) - 1))
-		(*cow_offset)--;
-
-	bitmap_words[0] = bitmap[*cow_offset];
-	bitmap_words[1] = bitmap[*cow_offset + 1];
-
-	*cow_offset *= sizeof(unsigned long);
-	*cow_offset += bitmap_offset;
-}
-
-static void cowify_req(struct io_thread_req *req, unsigned long *bitmap,
-		       __u64 bitmap_offset, __u64 bitmap_len)
-{
-	__u64 sector = req->offset >> 9;
-	int i;
-
-	if(req->length > (sizeof(req->sector_mask) * 8) << 9)
-		panic("Operation too long");
-
-	if(req->op == UBD_READ) {
-		for(i = 0; i < req->length >> 9; i++){
-			if(ubd_test_bit(sector + i, (unsigned char *) bitmap))
-				ubd_set_bit(i, (unsigned char *) 
-					    &req->sector_mask);
-                }
-	}
-	else cowify_bitmap(req->offset, req->length, &req->sector_mask,
-			   &req->cow_offset, bitmap, bitmap_offset,
-			   req->bitmap_words, bitmap_len);
+                ubd_set_bit(sector + i, bitmap);
+        }
 }
-
+  
 /* Called with ubd_io_lock held */
-static int prepare_request(struct request *req, struct io_thread_req *io_req)
+static int prepare_request(struct request *req, struct io_thread_req *io_req,
+                           unsigned long long offset, int page_offset,
+                           int len, struct page *page)
 {
 	struct gendisk *disk = req->rq_disk;
 	struct ubd *dev = disk->private_data;
-	__u64 offset;
-	int len;
-
-	if(req->rq_status == RQ_INACTIVE) return(1);
 
 	/* This should be impossible now */
 	if((rq_data_dir(req) == WRITE) && !dev->openflags.w){
 		printk("Write attempted on readonly ubd device %s\n", 
 		       disk->disk_name);
-		end_request(req, 0);
+                ubd_end_request(req, 0, 0);
 		return(1);
 	}
 
-	offset = ((__u64) req->sector) << 9;
-	len = req->current_nr_sectors << 9;
-
 	io_req->fds[0] = (dev->cow.file != NULL) ? dev->cow.fd : dev->fd;
 	io_req->fds[1] = dev->fd;
-	io_req->cow_offset = -1;
 	io_req->offset = offset;
 	io_req->length = len;
 	io_req->error = 0;
-	io_req->sector_mask = 0;
-
-	io_req->op = (rq_data_dir(req) == READ) ? UBD_READ : UBD_WRITE;
+	io_req->op = (rq_data_dir(req) == READ) ? AIO_READ : AIO_WRITE;
 	io_req->offsets[0] = 0;
 	io_req->offsets[1] = dev->cow.data_offset;
-	io_req->buffer = req->buffer;
+        io_req->buffer = page_address(page) + page_offset;
 	io_req->sectorsize = 1 << 9;
+        io_req->bitmap_offset = dev->cow.bitmap_offset;
+        io_req->bitmap_start = -1;
+        io_req->bitmap_end = -1;
 
-	if(dev->cow.file != NULL)
-		cowify_req(io_req, dev->cow.bitmap, dev->cow.bitmap_offset,
-			   dev->cow.bitmap_len);
-
+        if((dev->cow.file != NULL) && (io_req->op == UBD_WRITE))
+                cowify_bitmap(io_req, dev->cow.bitmap);
 	return(0);
 }
 
@@ -1030,30 +996,36 @@
 {
 	struct io_thread_req io_req;
 	struct request *req;
-	int err, n;
+	__u64 sector;
+	int err;
 
-	if(thread_fd == -1){
-		while((req = elv_next_request(q)) != NULL){
-			err = prepare_request(req, &io_req);
-			if(!err){
-				do_io(&io_req);
-				__ubd_finish(req, io_req.error);
-			}
-		}
-	}
-	else {
-		if(do_ubd || (req = elv_next_request(q)) == NULL)
-			return;
-		err = prepare_request(req, &io_req);
-		if(!err){
-			do_ubd = ubd_handler;
-			n = os_write_file(thread_fd, (char *) &io_req,
-					 sizeof(io_req));
-			if(n != sizeof(io_req))
-				printk("write to io thread failed, "
-				       "errno = %d\n", -n);
+	if(in_ubd)
+		return;
+	in_ubd = 1;
+	while((req = elv_next_request(q)) != NULL){
+		struct gendisk *disk = req->rq_disk;
+		struct ubd *dev = disk->private_data;
+		int n, i;
+		
+		blkdev_dequeue_request(req);
+
+		sector = req->sector;
+		n = blk_rq_map_sg(q, req, dev->sg);
+
+		for(i = 0; i < n; i++){
+			struct scatterlist *sg = &dev->sg[i];
+
+			err = prepare_request(req, &io_req, sector << 9,
+					      sg->offset, sg->length, 
+					      sg->page);
+			if(err)
+				continue;
+
+			sector += sg->length >> 9;
+			do_io(&io_req, req, dev->cow.bitmap);
 		}
 	}
+	in_ubd = 0;
 }
 
 static int ubd_ioctl(struct inode * inode, struct file * file,
@@ -1269,131 +1241,95 @@
 	return(err);
 }
 
-static int update_bitmap(struct io_thread_req *req)
-{
-	int n;
-
-	if(req->cow_offset == -1)
-		return(0);
-
-	n = os_seek_file(req->fds[1], req->cow_offset);
-	if(n < 0){
-		printk("do_io - bitmap lseek failed : err = %d\n", -n);
-		return(1);
-	}
-
-	n = os_write_file(req->fds[1], &req->bitmap_words,
-		          sizeof(req->bitmap_words));
-	if(n != sizeof(req->bitmap_words)){
-		printk("do_io - bitmap update failed, err = %d fd = %d\n", -n,
-		       req->fds[1]);
-		return(1);
-	}
-
-	return(0);
-}
-
-void do_io(struct io_thread_req *req)
+void do_io(struct io_thread_req *req, struct request *r, unsigned long *bitmap)
 {
-	char *buf;
-	unsigned long len;
-	int n, nsectors, start, end, bit;
-	int err;
-	__u64 off;
-
-	nsectors = req->length / req->sectorsize;
-	start = 0;
-	do {
-		bit = ubd_test_bit(start, (unsigned char *) &req->sector_mask);
-		end = start;
-		while((end < nsectors) &&
-		      (ubd_test_bit(end, (unsigned char *)
-				    &req->sector_mask) == bit))
-			end++;
-
-		off = req->offset + req->offsets[bit] +
-			start * req->sectorsize;
-		len = (end - start) * req->sectorsize;
-		buf = &req->buffer[start * req->sectorsize];
-
-		err = os_seek_file(req->fds[bit], off);
-		if(err < 0){
-			printk("do_io - lseek failed : err = %d\n", -err);
-			req->error = 1;
-			return;
-		}
-		if(req->op == UBD_READ){
-			n = 0;
-			do {
-				buf = &buf[n];
-				len -= n;
-				n = os_read_file(req->fds[bit], buf, len);
-				if (n < 0) {
-					printk("do_io - read failed, err = %d "
-					       "fd = %d\n", -n, req->fds[bit]);
-					req->error = 1;
-					return;
-				}
-			} while((n < len) && (n != 0));
-			if (n < len) memset(&buf[n], 0, len - n);
-		} else {
-			n = os_write_file(req->fds[bit], buf, len);
-			if(n != len){
-				printk("do_io - write failed err = %d "
-				       "fd = %d\n", -n, req->fds[bit]);
-				req->error = 1;
-				return;
-			}
-		}
+        struct ubd_aio *aio;
+        struct bitmap_io *bitmap_io = NULL;
+        char *buf;
+        void *bitmap_buf = NULL;
+        unsigned long len, sector;
+        int nsectors, start, end, bit, err;
+        __u64 off;
+
+        if(req->bitmap_start != -1){
+                /* Round up to the nearest word */
+                int round = sizeof(unsigned long);
+                len = (req->bitmap_end - req->bitmap_start + 
+                       round * 8 - 1) / (round * 8);
+                len *= round;
+
+                off = req->bitmap_start / (8 * round);
+                off *= round;
+
+                bitmap_io = kmalloc(sizeof(*bitmap_io), GFP_KERNEL);
+                if(bitmap_io == NULL){
+                        printk("Failed to kmalloc bitmap IO\n");
+                        req->error = 1;
+                        return;
+                }
 
-		start = end;
-	} while(start < nsectors);
+                bitmap_buf = kmalloc(len, GFP_KERNEL);
+                if(bitmap_buf == NULL){
+                        printk("do_io : kmalloc of bitmap chunk "
+                               "failed\n");
+                        kfree(bitmap_io);
+                        req->error = 1;
+                        return;
+                }
+                memcpy(bitmap_buf, &bitmap[off / sizeof(bitmap[0])], len);
 
-	req->error = update_bitmap(req);
-}
+                *bitmap_io = ((struct bitmap_io)
+                        { .count	= ATOMIC_INIT(0),
+                          .aio		= INIT_AIO(AIO_WRITE, req->fds[1], 
+                                                   bitmap_buf, len, 
+                                                   req->bitmap_offset + off,
+                                                   ubd_reply_fd) } );
+        }
 
-/* Changed in start_io_thread, which is serialized by being called only
- * from ubd_init, which is an initcall.
- */
-int kernel_fd = -1;
+        nsectors = req->length / req->sectorsize;
+        start = 0;
+        end = nsectors;
+        bit = 0;
+        do {
+                if(bitmap != NULL){
+                        sector = req->offset / req->sectorsize;
+                        bit = ubd_test_bit(sector + start, bitmap);
+                        end = start;
+                        while((end < nsectors) && 
+                              (ubd_test_bit(sector + end, bitmap) == bit))
+                                end++;
+                }
 
-/* Only changed by the io thread */
-int io_count = 0;
+                off = req->offsets[bit] + req->offset + 
+                        start * req->sectorsize;
+                len = (end - start) * req->sectorsize;
+                buf = &req->buffer[start * req->sectorsize];
+
+                aio = kmalloc(sizeof(*aio), GFP_KERNEL);
+                if(aio == NULL){
+                        req->error = 1;
+                        return;
+                }
 
-int io_thread(void *arg)
-{
-	struct io_thread_req req;
-	int n;
+                *aio = ((struct ubd_aio)
+                        { .aio		= INIT_AIO(req->op, req->fds[bit], buf,
+                                                   len, off, ubd_reply_fd),
+                          .len		= len,
+                          .req		= r,
+                          .bitmap	= bitmap_io,
+                          .bitmap_buf 	= bitmap_buf });
+
+                if(aio->bitmap != NULL)
+                        atomic_inc(&aio->bitmap->count);
+
+                err = submit_aio(&aio->aio);
+                if(err){
+                        printk("do_io - submit_aio failed, "
+                               "err = %d\n", err);
+                        req->error = 1;
+                        return;
+                }
 
-	ignore_sigwinch_sig();
-	while(1){
-		n = os_read_file(kernel_fd, &req, sizeof(req));
-		if(n != sizeof(req)){
-			if(n < 0)
-				printk("io_thread - read failed, fd = %d, "
-				       "err = %d\n", kernel_fd, -n);
-			else {
-				printk("io_thread - short read, fd = %d, "
-				       "length = %d\n", kernel_fd, n);
-			}
-			continue;
-		}
-		io_count++;
-		do_io(&req);
-		n = os_write_file(kernel_fd, &req, sizeof(req));
-		if(n != sizeof(req))
-			printk("io_thread - write failed, fd = %d, err = %d\n",
-			       kernel_fd, -n);
-	}
+                start = end;
+        } while(start < nsectors);
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: test/arch/um/include/aio.h
===================================================================
--- test.orig/arch/um/include/aio.h	2005-09-01 16:04:47.000000000 -0400
+++ test/arch/um/include/aio.h	2005-09-01 16:05:06.000000000 -0400
@@ -14,15 +14,27 @@
 };
 
 struct aio_context {
+	enum aio_type type;
+	int fd;
+	void *data;
+	int len;
+	unsigned long long offset;
 	int reply_fd;
 	struct aio_context *next;
 };
 
+#define INIT_AIO(aio_type, aio_fd, aio_data, aio_len, aio_offset, \
+		 aio_reply_fd) \
+	{ .type 	= aio_type, \
+	  .fd		= aio_fd, \
+	  .data		= aio_data, \
+	  .len		= aio_len, \
+	  .offset	= aio_offset, \
+	  .reply_fd	= aio_reply_fd }
+
 #define INIT_AIO_CONTEXT { .reply_fd	= -1, \
 			   .next	= NULL }
 
-extern int submit_aio(enum aio_type type, int fd, char *buf, int len, 
-		      unsigned long long offset, int reply_fd, 
-                      struct aio_context *aio);
+extern int submit_aio(struct aio_context *aio);
 
 #endif
Index: test/arch/um/os-Linux/aio.c
===================================================================
--- test.orig/arch/um/os-Linux/aio.c	2005-09-01 16:04:47.000000000 -0400
+++ test/arch/um/os-Linux/aio.c	2005-09-01 16:05:06.000000000 -0400
@@ -6,6 +6,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <signal.h>
+#include <string.h>
 #include <errno.h>
 #include <sched.h>
 #include <sys/syscall.h>
@@ -16,18 +17,31 @@
 #include "user.h"
 #include "mode.h"
 
-struct aio_thread_req {
-        enum aio_type type;
-        int io_fd;
-        unsigned long long offset;
-        char *buf;
-        int len;
-        struct aio_context *aio;
-};
-
 static int aio_req_fd_r = -1;
 static int aio_req_fd_w = -1;
 
+static int update_aio(struct aio_context *aio, int res)
+{
+        if(res < 0)
+                aio->len = res;
+        else if((res == 0) && (aio->type == AIO_READ)){
+                /* This is the EOF case - we have hit the end of the file
+                 * and it ends in a partial block, so we fill the end of
+                 * the block with zeros and claim success.
+                 */
+                memset(aio->data, 0, aio->len);
+                aio->len = 0;
+        }
+        else if(res > 0){
+                aio->len -= res;
+                aio->data += res;
+                aio->offset += res;
+                return aio->len;
+        }
+
+        return 0;
+}
+
 #if defined(HAVE_AIO_ABI)
 #include <linux/aio_abi.h>
 
@@ -66,8 +80,7 @@
  * that it now backs the mmapped area.
  */
 
-static int do_aio(aio_context_t ctx, enum aio_type type, int fd, char *buf, 
-                  int len, unsigned long long offset, struct aio_context *aio)
+static int do_aio(aio_context_t ctx, struct aio_context *aio)
 {
         struct iocb iocb, *iocbp = &iocb;
         char c;
@@ -75,37 +88,37 @@
 
         iocb = ((struct iocb) { .aio_data 	= (unsigned long) aio,
                                 .aio_reqprio	= 0,
-                                .aio_fildes	= fd,
-                                .aio_buf	= (unsigned long) buf,
-                                .aio_nbytes	= len,
-                                .aio_offset	= offset,
+                                .aio_fildes	= aio->fd,
+                                .aio_buf	= (unsigned long) aio->data,
+                                .aio_nbytes	= aio->len,
+                                .aio_offset	= aio->offset,
                                 .aio_reserved1	= 0,
                                 .aio_reserved2	= 0,
                                 .aio_reserved3	= 0 });
 
-        switch(type){
+        switch(aio->type){
         case AIO_READ:
                 iocb.aio_lio_opcode = IOCB_CMD_PREAD;
-                err = io_submit(ctx, 1, &iocbp);
                 break;
         case AIO_WRITE:
                 iocb.aio_lio_opcode = IOCB_CMD_PWRITE;
-                err = io_submit(ctx, 1, &iocbp);
                 break;
         case AIO_MMAP:
                 iocb.aio_lio_opcode = IOCB_CMD_PREAD;
                 iocb.aio_buf = (unsigned long) &c;
                 iocb.aio_nbytes = sizeof(c);
-                err = io_submit(ctx, 1, &iocbp);
                 break;
         default:
-                printk("Bogus op in do_aio - %d\n", type);
+                printk("Bogus op in do_aio - %d\n", aio->type);
                 err = -EINVAL;
-                break;
+                goto out;
         }
+
+        err = io_submit(ctx, 1, &iocbp);
         if(err > 0)
                 err = 0;
 
+ out:
         return err;
 }
 
@@ -114,8 +127,9 @@
 static int aio_thread(void *arg)
 {
         struct aio_thread_reply reply;
+        struct aio_context *aio;
         struct io_event event;
-        int err, n, reply_fd;
+        int err, n;
 
         signal(SIGWINCH, SIG_IGN);
 
@@ -128,15 +142,21 @@
                                "errno = %d\n", errno);
                 }
                 else {
+			aio = (struct aio_context *) event.data;
+			if(update_aio(aio, event.res)){
+				do_aio(ctx, aio);
+				continue;
+			}
+
                         reply = ((struct aio_thread_reply) 
-                                { .data = (void *) (long) event.data,
-                                  .err	= event.res });
-                        reply_fd = ((struct aio_context *) reply.data)->reply_fd;
-                        err = os_write_file(reply_fd, &reply, sizeof(reply));
+				{ .data = aio,
+				  .err	= aio->len });
+			err = os_write_file(aio->reply_fd, &reply, 
+					    sizeof(reply));
                         if(err != sizeof(reply))
-                                printk("not_aio_thread - write failed, "
-                                       "fd = %d, err = %d\n", 
-                                       aio_req_fd_r, -err);
+				printk("aio_thread - write failed, "
+				       "fd = %d, err = %d\n", aio->reply_fd,
+				       -err);
                 }
         }
         return 0;
@@ -144,35 +164,35 @@
 
 #endif
 
-static int do_not_aio(struct aio_thread_req *req)
+static int do_not_aio(struct aio_context *aio)
 {
         char c;
         int err;
 
-        switch(req->type){
+        switch(aio->type){
         case AIO_READ:
-                err = os_seek_file(req->io_fd, req->offset);
+                err = os_seek_file(aio->fd, aio->offset);
                 if(err)
                         goto out;
 
-                err = os_read_file(req->io_fd, req->buf, req->len);
+                err = os_read_file(aio->fd, aio->data, aio->len);
                 break;
         case AIO_WRITE:
-                err = os_seek_file(req->io_fd, req->offset);
+                err = os_seek_file(aio->fd, aio->offset);
                 if(err)
                         goto out;
 
-                err = os_write_file(req->io_fd, req->buf, req->len);
+                err = os_write_file(aio->fd, aio->data, aio->len);
                 break;
         case AIO_MMAP:
-                err = os_seek_file(req->io_fd, req->offset);
+                err = os_seek_file(aio->fd, aio->offset);
                 if(err)
                         goto out;
 
-                err = os_read_file(req->io_fd, &c, sizeof(c));
+                err = os_read_file(aio->fd, &c, sizeof(c));
                 break;
         default:
-                printk("do_not_aio - bad request type : %d\n", req->type);
+                printk("do_not_aio - bad request type : %d\n", aio->type);
                 err = -EINVAL;
                 break;
         }
@@ -183,14 +203,14 @@
 
 static int not_aio_thread(void *arg)
 {
-        struct aio_thread_req req;
+        struct aio_context *aio;
         struct aio_thread_reply reply;
         int err;
 
         signal(SIGWINCH, SIG_IGN);
         while(1){
-                err = os_read_file(aio_req_fd_r, &req, sizeof(req));
-                if(err != sizeof(req)){
+                err = os_read_file(aio_req_fd_r, &aio, sizeof(aio));
+                if(err != sizeof(aio)){
                         if(err < 0)
                                 printk("not_aio_thread - read failed, "
                                        "fd = %d, err = %d\n", aio_req_fd_r, 
@@ -201,17 +221,34 @@
                         }
                         continue;
                 }
-                err = do_not_aio(&req);
-                reply = ((struct aio_thread_reply) { .data 	= req.aio,
-                                                     .err	= err });
-                err = os_write_file(req.aio->reply_fd, &reply, sizeof(reply));
+ again:
+                err = do_not_aio(aio);
+
+                if(update_aio(aio, err))
+                        goto again;
+                        
+                reply = ((struct aio_thread_reply) { .data 	= aio,
+                                                     .err	= aio->len });
+                err = os_write_file(aio->reply_fd, &reply, sizeof(reply));
                 if(err != sizeof(reply))
                         printk("not_aio_thread - write failed, fd = %d, "
                                "err = %d\n", aio_req_fd_r, -err);
         }
 }
 
+static int submit_aio_24(struct aio_context *aio)
+{
+        int err;
+
+        err = os_write_file(aio_req_fd_w, &aio, sizeof(aio));
+        if(err == sizeof(aio))
+                err = 0;
+
+        return err;
+}
+
 static int aio_pid = -1;
+static int (*submit_proc)(struct aio_context *aio);
 
 static int init_aio_24(void)
 {
@@ -243,11 +280,33 @@
 #endif
 	printk("2.6 host AIO support not used - falling back to I/O "
 	       "thread\n");
+
+	submit_proc = submit_aio_24;
+
         return 0;
 }
 
 #ifdef HAVE_AIO_ABI
 #define DEFAULT_24_AIO 0
+static int submit_aio_26(struct aio_context *aio)
+{
+	struct aio_thread_reply reply;
+	int err;
+
+	err = do_aio(ctx, aio);
+	if(err){
+		reply = ((struct aio_thread_reply) { .data = aio,
+					             .err  = err });
+		err = os_write_file(aio->reply_fd, &reply, sizeof(reply));
+		if(err != sizeof(reply))
+			printk("submit_aio_26 - write failed, "
+			       "fd = %d, err = %d\n", aio->reply_fd, -err);
+		else err = 0;
+	}
+
+	return err;
+}
+
 static int init_aio_26(void)
 {
         unsigned long stack;
@@ -267,39 +326,22 @@
         aio_pid = err;
 
 	printk("Using 2.6 host AIO\n");
-        return 0;
-}
 
-static int submit_aio_26(enum aio_type type, int io_fd, char *buf, int len, 
-			 unsigned long long offset, struct aio_context *aio)
-{
-        struct aio_thread_reply reply;
-        int err;
-
-        err = do_aio(ctx, type, io_fd, buf, len, offset, aio);
-        if(err){
-                reply = ((struct aio_thread_reply) { .data = aio,
-                                                     .err  = err });
-                err = os_write_file(aio->reply_fd, &reply, sizeof(reply));
-                if(err != sizeof(reply))
-                        printk("submit_aio_26 - write failed, "
-                               "fd = %d, err = %d\n", aio->reply_fd, -err);
-                else err = 0;
-        }
+	submit_proc = submit_aio_26;
 
-        return err;
+        return 0;
 }
 
 #else
 #define DEFAULT_24_AIO 1
-static int init_aio_26(void)
+static int submit_aio_26(struct aio_context *aio)
 {
         return -ENOSYS;
 }
 
-static int submit_aio_26(enum aio_type type, int io_fd, char *buf, int len, 
-			 unsigned long long offset, struct aio_context *aio)
+static int init_aio_26(void)
 {
+	submit_proc = submit_aio_26;
         return -ENOSYS;
 }
 #endif
@@ -366,33 +408,7 @@
 
 __uml_exitcall(exit_aio);
 
-static int submit_aio_24(enum aio_type type, int io_fd, char *buf, int len, 
-			 unsigned long long offset, struct aio_context *aio)
-{
-        struct aio_thread_req req = { .type 		= type,
-                                      .io_fd		= io_fd,
-                                      .offset		= offset,
-                                      .buf		= buf,
-                                      .len		= len,
-                                      .aio		= aio,
-        };
-        int err;
-
-        err = os_write_file(aio_req_fd_w, &req, sizeof(req));
-        if(err == sizeof(req))
-                err = 0;
-
-        return err;
-}
-
-int submit_aio(enum aio_type type, int io_fd, char *buf, int len, 
-               unsigned long long offset, int reply_fd, 
-               struct aio_context *aio)
+int submit_aio(struct aio_context *aio)
 {
-        aio->reply_fd = reply_fd;
-        if(aio_24)
-                return submit_aio_24(type, io_fd, buf, len, offset, aio);
-        else {
-                return submit_aio_26(type, io_fd, buf, len, offset, aio);
-        }
+	return (*submit_proc)(aio);
 }

