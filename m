Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbVERE1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbVERE1l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 00:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbVERE1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 00:27:40 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:23309 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262080AbVEREZg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 00:25:36 -0400
Message-Id: <200505180420.j4I4KV81017338@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 7/9] UML - Remove ubd-mmap support
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 18 May 2005 00:20:31 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Finally rip out the ubd-mmap code, which turned out to be broken by design.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/ubd_kern.c	2005-05-17 22:19:48.000000000 -0400
+++ linux-2.6.11/arch/um/drivers/ubd_kern.c	2005-05-17 22:21:58.000000000 -0400
@@ -55,7 +55,7 @@
 #include "mem_kern.h"
 #include "cow.h"
 
-enum ubd_req { UBD_READ, UBD_WRITE, UBD_MMAP };
+enum ubd_req { UBD_READ, UBD_WRITE };
 
 struct io_thread_req {
 	enum ubd_req op;
@@ -68,8 +68,6 @@ struct io_thread_req {
 	unsigned long sector_mask;
 	unsigned long long cow_offset;
 	unsigned long bitmap_words[2];
-	int map_fd;
-	unsigned long long map_offset;
 	int error;
 };
 
@@ -122,10 +120,6 @@ static int ubd_ioctl(struct inode * inod
 
 #define MAX_DEV (8)
 
-/* Changed in early boot */
-static int ubd_do_mmap = 0;
-#define UBD_MMAP_BLOCK_SIZE PAGE_SIZE
-
 static struct block_device_operations ubd_blops = {
         .owner		= THIS_MODULE,
         .open		= ubd_open,
@@ -175,12 +169,6 @@ struct ubd {
 	int no_cow;
 	struct cow cow;
 	struct platform_device pdev;
-
-	int map_writes;
-	int map_reads;
-	int nomap_writes;
-	int nomap_reads;
-	int write_maps;
 };
 
 #define DEFAULT_COW { \
@@ -200,11 +188,6 @@ struct ubd {
 	.openflags =		OPEN_FLAGS, \
         .no_cow =               0, \
         .cow =			DEFAULT_COW, \
-	.map_writes		= 0, \
-	.map_reads		= 0, \
-	.nomap_writes		= 0, \
-	.nomap_reads		= 0, \
-	.write_maps		= 0, \
 }
 
 struct ubd ubd_dev[MAX_DEV] = { [ 0 ... MAX_DEV - 1 ] = DEFAULT_UBD };
@@ -314,13 +297,6 @@ static int ubd_setup_common(char *str, i
 		int major;
 
 		str++;
-		if(!strcmp(str, "mmap")){
-			CHOOSE_MODE(printk("mmap not supported by the ubd "
-					   "driver in tt mode\n"),
-				    ubd_do_mmap = 1);
-			return(0);
-		}
-
 		if(!strcmp(str, "sync")){
 			global_openflags = of_sync(global_openflags);
 			return(0);
@@ -524,7 +500,7 @@ static void ubd_handler(void)
 {
 	struct io_thread_req req;
 	struct request *rq = elv_next_request(ubd_queue);
-	int n, err;
+	int n;
 
 	do_ubd = NULL;
 	intr_count++;
@@ -538,19 +514,6 @@ static void ubd_handler(void)
 		return;
 	}
         
-	if((req.op != UBD_MMAP) &&
-	   ((req.offset != ((__u64) (rq->sector)) << 9) ||
-	    (req.length != (rq->current_nr_sectors) << 9)))
-		panic("I/O op mismatch");
-	
-	if(req.map_fd != -1){
-		err = physmem_subst_mapping(req.buffer, req.map_fd,
-					    req.map_offset, 1);
-		if(err)
-			printk("ubd_handler - physmem_subst_mapping failed, "
-			       "err = %d\n", -err);
-	}
-
 	ubd_finish(rq, req.error);
 	reactivate_fd(thread_fd, UBD_IRQ);	
 	do_ubd_request(ubd_queue);
@@ -583,14 +546,10 @@ static int ubd_file_size(struct ubd *dev
 
 static void ubd_close(struct ubd *dev)
 {
-	if(ubd_do_mmap)
-		physmem_forget_descriptor(dev->fd);
 	os_close_file(dev->fd);
 	if(dev->cow.file == NULL)
 		return;
 
-	if(ubd_do_mmap)
-		physmem_forget_descriptor(dev->cow.fd);
 	os_close_file(dev->cow.fd);
 	vfree(dev->cow.bitmap);
 	dev->cow.bitmap = NULL;
@@ -1010,94 +969,13 @@ static void cowify_req(struct io_thread_
 			   req->bitmap_words, bitmap_len);
 }
 
-static int mmap_fd(struct request *req, struct ubd *dev, __u64 offset)
-{
-	__u64 sector;
-	unsigned char *bitmap;
-	int bit, i;
-
-	/* mmap must have been requested on the command line */
-	if(!ubd_do_mmap)
-		return(-1);
-
-	/* The buffer must be page aligned */
-	if(((unsigned long) req->buffer % UBD_MMAP_BLOCK_SIZE) != 0)
-		return(-1);
-
-	/* The request must be a page long */
-	if((req->current_nr_sectors << 9) != PAGE_SIZE)
-		return(-1);
-
-	if(dev->cow.file == NULL)
-		return(dev->fd);
-
-	sector = offset >> 9;
-	bitmap = (unsigned char *) dev->cow.bitmap;
-	bit = ubd_test_bit(sector, bitmap);
-
-	for(i = 1; i < req->current_nr_sectors; i++){
-		if(ubd_test_bit(sector + i, bitmap) != bit)
-			return(-1);
-	}
-
-	if(bit || (rq_data_dir(req) == WRITE))
-		offset += dev->cow.data_offset;
-
-	/* The data on disk must be page aligned */
-	if((offset % UBD_MMAP_BLOCK_SIZE) != 0)
-		return(-1);
-
-	return(bit ? dev->fd : dev->cow.fd);
-}
-
-static int prepare_mmap_request(struct ubd *dev, int fd, __u64 offset,
-				struct request *req,
-				struct io_thread_req *io_req)
-{
-	int err;
-
-	if(rq_data_dir(req) == WRITE){
-		/* Writes are almost no-ops since the new data is already in the
-		 * host page cache
-		 */
-		dev->map_writes++;
-		if(dev->cow.file != NULL)
-			cowify_bitmap(io_req->offset, io_req->length,
-				      &io_req->sector_mask, &io_req->cow_offset,
-				      dev->cow.bitmap, dev->cow.bitmap_offset,
-				      io_req->bitmap_words,
-				      dev->cow.bitmap_len);
-	}
-	else {
-		int w;
-
-		if((dev->cow.file != NULL) && (fd == dev->cow.fd))
-			w = 0;
-		else w = dev->openflags.w;
-
-		if((dev->cow.file != NULL) && (fd == dev->fd))
-			offset += dev->cow.data_offset;
-
-		err = physmem_subst_mapping(req->buffer, fd, offset, w);
-		if(err){
-			printk("physmem_subst_mapping failed, err = %d\n",
-			       -err);
-			return(1);
-		}
-		dev->map_reads++;
-	}
-	io_req->op = UBD_MMAP;
-	io_req->buffer = req->buffer;
-	return(0);
-}
-
 /* Called with ubd_io_lock held */
 static int prepare_request(struct request *req, struct io_thread_req *io_req)
 {
 	struct gendisk *disk = req->rq_disk;
 	struct ubd *dev = disk->private_data;
 	__u64 offset;
-	int len, fd;
+	int len;
 
 	if(req->rq_status == RQ_INACTIVE) return(1);
 
@@ -1114,34 +992,12 @@ static int prepare_request(struct reques
 
 	io_req->fds[0] = (dev->cow.file != NULL) ? dev->cow.fd : dev->fd;
 	io_req->fds[1] = dev->fd;
-	io_req->map_fd = -1;
 	io_req->cow_offset = -1;
 	io_req->offset = offset;
 	io_req->length = len;
 	io_req->error = 0;
 	io_req->sector_mask = 0;
 
-	fd = mmap_fd(req, dev, io_req->offset);
-	if(fd > 0){
-		/* If mmapping is otherwise OK, but the first access to the
-		 * page is a write, then it's not mapped in yet.  So we have
-		 * to write the data to disk first, then we can map the disk
-		 * page in and continue normally from there.
-		 */
-		if((rq_data_dir(req) == WRITE) && !is_remapped(req->buffer)){
-			io_req->map_fd = dev->fd;
-			io_req->map_offset = io_req->offset +
-				dev->cow.data_offset;
-			dev->write_maps++;
-		}
-		else return(prepare_mmap_request(dev, fd, io_req->offset, req,
-						 io_req));
-	}
-
-	if(rq_data_dir(req) == READ)
-		dev->nomap_reads++;
-	else dev->nomap_writes++;
-
 	io_req->op = (rq_data_dir(req) == READ) ? UBD_READ : UBD_WRITE;
 	io_req->offsets[0] = 0;
 	io_req->offsets[1] = dev->cow.data_offset;
@@ -1229,143 +1085,6 @@ static int ubd_ioctl(struct inode * inod
 	return(-EINVAL);
 }
 
-static int ubd_check_remapped(int fd, unsigned long address, int is_write,
-			      __u64 offset)
-{
-	__u64 bitmap_offset;
-	unsigned long new_bitmap[2];
-	int i, err, n;
-
-	/* If it's not a write access, we can't do anything about it */
-	if(!is_write)
-		return(0);
-
-	/* We have a write */
-	for(i = 0; i < sizeof(ubd_dev) / sizeof(ubd_dev[0]); i++){
-		struct ubd *dev = &ubd_dev[i];
-
-		if((dev->fd != fd) && (dev->cow.fd != fd))
-			continue;
-
-		/* It's a write to a ubd device */
-
-		/* This should be impossible now */
-		if(!dev->openflags.w){
-			/* It's a write access on a read-only device - probably
-			 * shouldn't happen.  If the kernel is trying to change
-			 * something with no intention of writing it back out,
-			 * then this message will clue us in that this needs
-			 * fixing
-			 */
-			printk("Write access to mapped page from readonly ubd "
-			       "device %d\n", i);
-			return(0);
-		}
-
-		/* It's a write to a writeable ubd device - it must be COWed
-		 * because, otherwise, the page would have been mapped in
-		 * writeable
-		 */
-
-		if(!dev->cow.file)
-			panic("Write fault on writeable non-COW ubd device %d",
-			      i);
-
-		/* It should also be an access to the backing file since the
-		 * COW pages should be mapped in read-write
-		 */
-
-		if(fd == dev->fd)
-			panic("Write fault on a backing page of ubd "
-			      "device %d\n", i);
-
-		/* So, we do the write, copying the backing data to the COW
-		 * file...
-		 */
-
-		err = os_seek_file(dev->fd, offset + dev->cow.data_offset);
-		if(err < 0)
-			panic("Couldn't seek to %lld in COW file of ubd "
-			      "device %d, err = %d",
-			      offset + dev->cow.data_offset, i, -err);
-
-		n = os_write_file(dev->fd, (void *) address, PAGE_SIZE);
-		if(n != PAGE_SIZE)
-			panic("Couldn't copy data to COW file of ubd "
-			      "device %d, err = %d", i, -n);
-
-		/* ... updating the COW bitmap... */
-
-		cowify_bitmap(offset, PAGE_SIZE, NULL, &bitmap_offset,
-			      dev->cow.bitmap, dev->cow.bitmap_offset,
-			      new_bitmap, dev->cow.bitmap_len);
-
-		err = os_seek_file(dev->fd, bitmap_offset);
-		if(err < 0)
-			panic("Couldn't seek to %lld in COW file of ubd "
-			      "device %d, err = %d", bitmap_offset, i, -err);
-
-		n = os_write_file(dev->fd, new_bitmap, sizeof(new_bitmap));
-		if(n != sizeof(new_bitmap))
-			panic("Couldn't update bitmap  of ubd device %d, "
-			      "err = %d", i, -n);
-
-		/* Maybe we can map the COW page in, and maybe we can't.  If
-		 * it is a pre-V3 COW file, we can't, since the alignment will
-		 * be wrong.  If it is a V3 or later COW file which has been
-		 * moved to a system with a larger page size, then maybe we
-		 * can't, depending on the exact location of the page.
-		 */
-
-		offset += dev->cow.data_offset;
-
-		/* Remove the remapping, putting the original anonymous page
-		 * back.  If the COW file can be mapped in, that is done.
-		 * Otherwise, the COW page is read in.
-		 */
-
-		if(!physmem_remove_mapping((void *) address))
-			panic("Address 0x%lx not remapped by ubd device %d",
-			      address, i);
-		if((offset % UBD_MMAP_BLOCK_SIZE) == 0)
-			physmem_subst_mapping((void *) address, dev->fd,
-					      offset, 1);
-		else {
-			err = os_seek_file(dev->fd, offset);
-			if(err < 0)
-				panic("Couldn't seek to %lld in COW file of "
-				      "ubd device %d, err = %d", offset, i,
-				      -err);
-
-			n = os_read_file(dev->fd, (void *) address, PAGE_SIZE);
-			if(n != PAGE_SIZE)
-				panic("Failed to read page from offset %llx of "
-				      "COW file of ubd device %d, err = %d",
-				      offset, i, -n);
-		}
-
-		return(1);
-	}
-
-	/* It's not a write on a ubd device */
-	return(0);
-}
-
-static struct remapper ubd_remapper = {
-	.list	= LIST_HEAD_INIT(ubd_remapper.list),
-	.proc	= ubd_check_remapped,
-};
-
-static int ubd_remapper_setup(void)
-{
-	if(ubd_do_mmap)
-		register_remapper(&ubd_remapper);
-
-	return(0);
-}
-
-__initcall(ubd_remapper_setup);
-
 static int same_backing_files(char *from_cmdline, char *from_cow, char *cow)
 {
 	struct uml_stat buf1, buf2;
@@ -1568,15 +1287,6 @@ void do_io(struct io_thread_req *req)
 	int err;
 	__u64 off;
 
-	if(req->op == UBD_MMAP){
-		/* Touch the page to force the host to do any necessary IO to
-		 * get it into memory
-		 */
-		n = *((volatile int *) req->buffer);
-		req->error = update_bitmap(req);
-		return;
-	}
-
 	nsectors = req->length / req->sectorsize;
 	start = 0;
 	do {
Index: linux-2.6.11/arch/um/kernel/trap_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/trap_kern.c	2005-05-17 22:21:51.000000000 -0400
+++ linux-2.6.11/arch/um/kernel/trap_kern.c	2005-05-17 22:21:58.000000000 -0400
@@ -107,33 +107,6 @@ out_of_memory:
 	goto out;
 }
 
-LIST_HEAD(physmem_remappers);
-
-void register_remapper(struct remapper *info)
-{
-	list_add(&info->list, &physmem_remappers);
-}
-
-static int check_remapped_addr(unsigned long address, int is_write)
-{
-	struct remapper *remapper;
-	struct list_head *ele;
-	__u64 offset;
-	int fd;
-
-	fd = phys_mapping(__pa(address), &offset);
-	if(fd == -1)
-		return(0);
-
-	list_for_each(ele, &physmem_remappers){
-		remapper = list_entry(ele, struct remapper, list);
-		if((*remapper->proc)(fd, address, is_write, offset))
-			return(1);
-	}
-
-	return(0);
-}
-
 /*
  * We give a *copy* of the faultinfo in the regs to segv.
  * This must be done, since nesting SEGVs could overwrite
@@ -152,8 +125,6 @@ unsigned long segv(struct faultinfo fi, 
                 flush_tlb_kernel_vm();
                 return(0);
         }
-	else if(check_remapped_addr(address & PAGE_MASK, is_write))
-		return(0);
 	else if(current->mm == NULL)
 		panic("Segfault with no mm");
 	err = handle_page_fault(address, ip, is_write, is_user, &si.si_code);

