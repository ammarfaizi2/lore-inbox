Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965335AbWJ2TUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965335AbWJ2TUw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 14:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965340AbWJ2TUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 14:20:44 -0500
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:22120 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965330AbWJ2TU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 14:20:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=35T8ja7L4/VtMiEmdt8NEy1ROMpOqnR1NS1cR4jD1DBBBCN4w1iC2WqahA8TrXEtErsFH5J3CvMhXbdQmoWP6icCVUUPVV4tbd7VG9vLBURYBqir4rQt8qRY+y6LN8pSNBWBQ3ftCiFyUbVmElViqP6uYJaf6XY6EuA0cwrqhrM=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 03/11] uml ubd driver: var renames
Date: Sun, 29 Oct 2006 20:20:29 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20061029192029.12292.15703.stgit@americanbeauty.home.lan>
In-Reply-To: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
References: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Rename the ubd_dev array to ubd_devs and then call any "struct ubd" ubd_dev
instead of dev, which doesn't make clear what we're treating (and no, it's not
hungarian notation - not any more than calling all vm_area_struct vma or all
inodes inode).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/ubd_kern.c |  198 ++++++++++++++++++++++----------------------
 1 files changed, 99 insertions(+), 99 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index e034ca4..50385cc 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -195,14 +195,14 @@ #define DEFAULT_UBD { \
         .cow =			DEFAULT_COW, \
 }
 
-struct ubd ubd_dev[MAX_DEV] = { [ 0 ... MAX_DEV - 1 ] = DEFAULT_UBD };
+struct ubd ubd_devs[MAX_DEV] = { [ 0 ... MAX_DEV - 1 ] = DEFAULT_UBD };
 
 static int ubd0_init(void)
 {
-	struct ubd *dev = &ubd_dev[0];
+	struct ubd *ubd_dev = &ubd_devs[0];
 
-	if(dev->file == NULL)
-		dev->file = "root_fs";
+	if(ubd_dev->file == NULL)
+		ubd_dev->file = "root_fs";
 	return(0);
 }
 
@@ -290,7 +290,7 @@ static int parse_unit(char **ptr)
 
 static int ubd_setup_common(char *str, int *index_out)
 {
-	struct ubd *dev;
+	struct ubd *ubd_dev;
 	struct openflags flags = global_openflags;
 	char *backing_file;
 	int n, err, i;
@@ -345,8 +345,8 @@ static int ubd_setup_common(char *str, i
 	err = 1;
 	spin_lock(&ubd_lock);
 
-	dev = &ubd_dev[n];
-	if(dev->file != NULL){
+	ubd_dev = &ubd_devs[n];
+	if(ubd_dev->file != NULL){
 		printk(KERN_ERR "ubd_setup : device already configured\n");
 		goto out;
 	}
@@ -363,10 +363,10 @@ static int ubd_setup_common(char *str, i
 			flags.s = 1;
 			break;
 		case 'd':
-			dev->no_cow = 1;
+			ubd_dev->no_cow = 1;
 			break;
 		case 'c':
-			dev->shared = 1;
+			ubd_dev->shared = 1;
 			break;
 		case '=':
 			str++;
@@ -393,7 +393,7 @@ break_loop:
 	}
 
 	if(backing_file){
-		if(dev->no_cow)
+		if(ubd_dev->no_cow)
 			printk(KERN_ERR "Can't specify both 'd' and a "
 			       "cow file\n");
 		else {
@@ -401,9 +401,9 @@ break_loop:
 			backing_file++;
 		}
 	}
-	dev->file = str;
-	dev->cow.file = backing_file;
-	dev->boot_openflags = flags;
+	ubd_dev->file = str;
+	ubd_dev->cow.file = backing_file;
+	ubd_dev->boot_openflags = flags;
 out:
 	spin_unlock(&ubd_lock);
 	return(err);
@@ -544,83 +544,83 @@ void kill_io_thread(void)
 
 __uml_exitcall(kill_io_thread);
 
-static int ubd_file_size(struct ubd *dev, __u64 *size_out)
+static int ubd_file_size(struct ubd *ubd_dev, __u64 *size_out)
 {
 	char *file;
 
-	file = dev->cow.file ? dev->cow.file : dev->file;
+	file = ubd_dev->cow.file ? ubd_dev->cow.file : ubd_dev->file;
 	return(os_file_size(file, size_out));
 }
 
-static void ubd_close(struct ubd *dev)
+static void ubd_close(struct ubd *ubd_dev)
 {
-	os_close_file(dev->fd);
-	if(dev->cow.file == NULL)
+	os_close_file(ubd_dev->fd);
+	if(ubd_dev->cow.file == NULL)
 		return;
 
-	os_close_file(dev->cow.fd);
-	vfree(dev->cow.bitmap);
-	dev->cow.bitmap = NULL;
+	os_close_file(ubd_dev->cow.fd);
+	vfree(ubd_dev->cow.bitmap);
+	ubd_dev->cow.bitmap = NULL;
 }
 
-static int ubd_open_dev(struct ubd *dev)
+static int ubd_open_dev(struct ubd *ubd_dev)
 {
 	struct openflags flags;
 	char **back_ptr;
 	int err, create_cow, *create_ptr;
 
-	dev->openflags = dev->boot_openflags;
+	ubd_dev->openflags = ubd_dev->boot_openflags;
 	create_cow = 0;
-	create_ptr = (dev->cow.file != NULL) ? &create_cow : NULL;
-	back_ptr = dev->no_cow ? NULL : &dev->cow.file;
-	dev->fd = open_ubd_file(dev->file, &dev->openflags, dev->shared,
-				back_ptr, &dev->cow.bitmap_offset,
-				&dev->cow.bitmap_len, &dev->cow.data_offset,
+	create_ptr = (ubd_dev->cow.file != NULL) ? &create_cow : NULL;
+	back_ptr = ubd_dev->no_cow ? NULL : &ubd_dev->cow.file;
+	ubd_dev->fd = open_ubd_file(ubd_dev->file, &ubd_dev->openflags, ubd_dev->shared,
+				back_ptr, &ubd_dev->cow.bitmap_offset,
+				&ubd_dev->cow.bitmap_len, &ubd_dev->cow.data_offset,
 				create_ptr);
 
-	if((dev->fd == -ENOENT) && create_cow){
-		dev->fd = create_cow_file(dev->file, dev->cow.file,
-					  dev->openflags, 1 << 9, PAGE_SIZE,
-					  &dev->cow.bitmap_offset,
-					  &dev->cow.bitmap_len,
-					  &dev->cow.data_offset);
-		if(dev->fd >= 0){
+	if((ubd_dev->fd == -ENOENT) && create_cow){
+		ubd_dev->fd = create_cow_file(ubd_dev->file, ubd_dev->cow.file,
+					  ubd_dev->openflags, 1 << 9, PAGE_SIZE,
+					  &ubd_dev->cow.bitmap_offset,
+					  &ubd_dev->cow.bitmap_len,
+					  &ubd_dev->cow.data_offset);
+		if(ubd_dev->fd >= 0){
 			printk(KERN_INFO "Creating \"%s\" as COW file for "
-			       "\"%s\"\n", dev->file, dev->cow.file);
+			       "\"%s\"\n", ubd_dev->file, ubd_dev->cow.file);
 		}
 	}
 
-	if(dev->fd < 0){
-		printk("Failed to open '%s', errno = %d\n", dev->file,
-		       -dev->fd);
-		return(dev->fd);
+	if(ubd_dev->fd < 0){
+		printk("Failed to open '%s', errno = %d\n", ubd_dev->file,
+		       -ubd_dev->fd);
+		return(ubd_dev->fd);
 	}
 
-	if(dev->cow.file != NULL){
+	if(ubd_dev->cow.file != NULL){
 		err = -ENOMEM;
-		dev->cow.bitmap = (void *) vmalloc(dev->cow.bitmap_len);
-		if(dev->cow.bitmap == NULL){
+		ubd_dev->cow.bitmap = (void *) vmalloc(ubd_dev->cow.bitmap_len);
+		if(ubd_dev->cow.bitmap == NULL){
 			printk(KERN_ERR "Failed to vmalloc COW bitmap\n");
 			goto error;
 		}
 		flush_tlb_kernel_vm();
 
-		err = read_cow_bitmap(dev->fd, dev->cow.bitmap,
-				      dev->cow.bitmap_offset,
-				      dev->cow.bitmap_len);
+		err = read_cow_bitmap(ubd_dev->fd, ubd_dev->cow.bitmap,
+				      ubd_dev->cow.bitmap_offset,
+				      ubd_dev->cow.bitmap_len);
 		if(err < 0)
 			goto error;
 
-		flags = dev->openflags;
+		flags = ubd_dev->openflags;
 		flags.w = 0;
-		err = open_ubd_file(dev->cow.file, &flags, dev->shared, NULL,
+		err = open_ubd_file(ubd_dev->cow.file, &flags, ubd_dev->shared, NULL,
 				    NULL, NULL, NULL, NULL);
 		if(err < 0) goto error;
-		dev->cow.fd = err;
+		ubd_dev->cow.fd = err;
 	}
 	return(0);
  error:
-	os_close_file(dev->fd);
+	os_close_file(ubd_dev->fd);
 	return(err);
 }
 
@@ -650,14 +650,14 @@ static int ubd_new_disk(int major, u64 s
 
 	/* sysfs register (not for ide fake devices) */
 	if (major == MAJOR_NR) {
-		ubd_dev[unit].pdev.id   = unit;
-		ubd_dev[unit].pdev.name = DRIVER_NAME;
-		ubd_dev[unit].pdev.dev.release = dummy_device_release;
-		platform_device_register(&ubd_dev[unit].pdev);
-		disk->driverfs_dev = &ubd_dev[unit].pdev.dev;
+		ubd_devs[unit].pdev.id   = unit;
+		ubd_devs[unit].pdev.name = DRIVER_NAME;
+		ubd_devs[unit].pdev.dev.release = dummy_device_release;
+		platform_device_register(&ubd_devs[unit].pdev);
+		disk->driverfs_dev = &ubd_devs[unit].pdev.dev;
 	}
 
-	disk->private_data = &ubd_dev[unit];
+	disk->private_data = &ubd_devs[unit];
 	disk->queue = ubd_queue;
 	add_disk(disk);
 
@@ -669,25 +669,25 @@ #define ROUND_BLOCK(n) ((n + ((1 << 9) -
 
 static int ubd_add(int n)
 {
-	struct ubd *dev = &ubd_dev[n];
+	struct ubd *ubd_dev = &ubd_devs[n];
 	int err;
 
 	err = -ENODEV;
-	if(dev->file == NULL)
+	if(ubd_dev->file == NULL)
 		goto out;
 
-	err = ubd_file_size(dev, &dev->size);
+	err = ubd_file_size(ubd_dev, &ubd_dev->size);
 	if(err < 0)
 		goto out;
 
-	dev->size = ROUND_BLOCK(dev->size);
+	ubd_dev->size = ROUND_BLOCK(ubd_dev->size);
 
-	err = ubd_new_disk(MAJOR_NR, dev->size, n, &ubd_gendisk[n]);
+	err = ubd_new_disk(MAJOR_NR, ubd_dev->size, n, &ubd_gendisk[n]);
 	if(err)
 		goto out;
 
 	if(fake_major != MAJOR_NR)
-		ubd_new_disk(fake_major, dev->size, n,
+		ubd_new_disk(fake_major, ubd_dev->size, n,
 			     &fake_gendisk[n]);
 
 	/* perhaps this should also be under the "if (fake_major)" above */
@@ -719,7 +719,7 @@ static int ubd_config(char *str)
  	spin_lock(&ubd_lock);
 	err = ubd_add(n);
 	if(err)
-		ubd_dev[n].file = NULL;
+		ubd_devs[n].file = NULL;
  	spin_unlock(&ubd_lock);
 
 	return(err);
@@ -727,7 +727,7 @@ static int ubd_config(char *str)
 
 static int ubd_get_config(char *name, char *str, int size, char **error_out)
 {
-	struct ubd *dev;
+	struct ubd *ubd_dev;
 	int n, len = 0;
 
 	n = parse_unit(&name);
@@ -736,19 +736,19 @@ static int ubd_get_config(char *name, ch
 		return(-1);
 	}
 
-	dev = &ubd_dev[n];
+	ubd_dev = &ubd_devs[n];
 	spin_lock(&ubd_lock);
 
-	if(dev->file == NULL){
+	if(ubd_dev->file == NULL){
 		CONFIG_CHUNK(str, size, len, "", 1);
 		goto out;
 	}
 
-	CONFIG_CHUNK(str, size, len, dev->file, 0);
+	CONFIG_CHUNK(str, size, len, ubd_dev->file, 0);
 
-	if(dev->cow.file != NULL){
+	if(ubd_dev->cow.file != NULL){
 		CONFIG_CHUNK(str, size, len, ",", 0);
-		CONFIG_CHUNK(str, size, len, dev->cow.file, 1);
+		CONFIG_CHUNK(str, size, len, ubd_dev->cow.file, 1);
 	}
 	else CONFIG_CHUNK(str, size, len, "", 1);
 
@@ -769,7 +769,7 @@ static int ubd_id(char **str, int *start
 
 static int ubd_remove(int n)
 {
-	struct ubd *dev;
+	struct ubd *ubd_dev;
 	int err = -ENODEV;
 
 	spin_lock(&ubd_lock);
@@ -777,14 +777,14 @@ static int ubd_remove(int n)
 	if(ubd_gendisk[n] == NULL)
 		goto out;
 
-	dev = &ubd_dev[n];
+	ubd_dev = &ubd_devs[n];
 
-	if(dev->file == NULL)
+	if(ubd_dev->file == NULL)
 		goto out;
 
 	/* you cannot remove a open disk */
 	err = -EBUSY;
-	if(dev->count > 0)
+	if(ubd_dev->count > 0)
 		goto out;
 
 	del_gendisk(ubd_gendisk[n]);
@@ -797,8 +797,8 @@ static int ubd_remove(int n)
 		fake_gendisk[n] = NULL;
 	}
 
-	platform_device_unregister(&dev->pdev);
-	*dev = ((struct ubd) DEFAULT_UBD);
+	platform_device_unregister(&ubd_dev->pdev);
+	*ubd_dev = ((struct ubd) DEFAULT_UBD);
 	err = 0;
 out:
 	spin_unlock(&ubd_lock);
@@ -876,7 +876,7 @@ int ubd_driver_init(void){
 		return(0);
 	}
 	err = um_request_irq(UBD_IRQ, thread_fd, IRQ_READ, ubd_intr,
-			     IRQF_DISABLED, "ubd", ubd_dev);
+			     IRQF_DISABLED, "ubd", ubd_devs);
 	if(err != 0)
 		printk(KERN_ERR "um_request_irq failed - errno = %d\n", -err);
 	return 0;
@@ -887,24 +887,24 @@ device_initcall(ubd_driver_init);
 static int ubd_open(struct inode *inode, struct file *filp)
 {
 	struct gendisk *disk = inode->i_bdev->bd_disk;
-	struct ubd *dev = disk->private_data;
+	struct ubd *ubd_dev = disk->private_data;
 	int err = 0;
 
-	if(dev->count == 0){
-		err = ubd_open_dev(dev);
+	if(ubd_dev->count == 0){
+		err = ubd_open_dev(ubd_dev);
 		if(err){
 			printk(KERN_ERR "%s: Can't open \"%s\": errno = %d\n",
-			       disk->disk_name, dev->file, -err);
+			       disk->disk_name, ubd_dev->file, -err);
 			goto out;
 		}
 	}
-	dev->count++;
-	set_disk_ro(disk, !dev->openflags.w);
+	ubd_dev->count++;
+	set_disk_ro(disk, !ubd_dev->openflags.w);
 
 	/* This should no more be needed. And it didn't work anyway to exclude
 	 * read-write remounting of filesystems.*/
-	/*if((filp->f_mode & FMODE_WRITE) && !dev->openflags.w){
-	        if(--dev->count == 0) ubd_close(dev);
+	/*if((filp->f_mode & FMODE_WRITE) && !ubd_dev->openflags.w){
+	        if(--ubd_dev->count == 0) ubd_close(ubd_dev);
 	        err = -EROFS;
 	}*/
  out:
@@ -914,10 +914,10 @@ static int ubd_open(struct inode *inode,
 static int ubd_release(struct inode * inode, struct file * file)
 {
 	struct gendisk *disk = inode->i_bdev->bd_disk;
-	struct ubd *dev = disk->private_data;
+	struct ubd *ubd_dev = disk->private_data;
 
-	if(--dev->count == 0)
-		ubd_close(dev);
+	if(--ubd_dev->count == 0)
+		ubd_close(ubd_dev);
 	return(0);
 }
 
@@ -985,12 +985,12 @@ static void cowify_req(struct io_thread_
 static int prepare_request(struct request *req, struct io_thread_req *io_req)
 {
 	struct gendisk *disk = req->rq_disk;
-	struct ubd *dev = disk->private_data;
+	struct ubd *ubd_dev = disk->private_data;
 	__u64 offset;
 	int len;
 
 	/* This should be impossible now */
-	if((rq_data_dir(req) == WRITE) && !dev->openflags.w){
+	if((rq_data_dir(req) == WRITE) && !ubd_dev->openflags.w){
 		printk("Write attempted on readonly ubd device %s\n",
 		       disk->disk_name);
 		end_request(req, 0);
@@ -1000,8 +1000,8 @@ static int prepare_request(struct reques
 	offset = ((__u64) req->sector) << 9;
 	len = req->current_nr_sectors << 9;
 
-	io_req->fds[0] = (dev->cow.file != NULL) ? dev->cow.fd : dev->fd;
-	io_req->fds[1] = dev->fd;
+	io_req->fds[0] = (ubd_dev->cow.file != NULL) ? ubd_dev->cow.fd : ubd_dev->fd;
+	io_req->fds[1] = ubd_dev->fd;
 	io_req->cow_offset = -1;
 	io_req->offset = offset;
 	io_req->length = len;
@@ -1010,13 +1010,13 @@ static int prepare_request(struct reques
 
 	io_req->op = (rq_data_dir(req) == READ) ? UBD_READ : UBD_WRITE;
 	io_req->offsets[0] = 0;
-	io_req->offsets[1] = dev->cow.data_offset;
+	io_req->offsets[1] = ubd_dev->cow.data_offset;
 	io_req->buffer = req->buffer;
 	io_req->sectorsize = 1 << 9;
 
-	if(dev->cow.file != NULL)
-		cowify_req(io_req, dev->cow.bitmap, dev->cow.bitmap_offset,
-			   dev->cow.bitmap_len);
+	if(ubd_dev->cow.file != NULL)
+		cowify_req(io_req, ubd_dev->cow.bitmap, ubd_dev->cow.bitmap_offset,
+			   ubd_dev->cow.bitmap_len);
 
 	return(0);
 }
@@ -1054,18 +1054,18 @@ static void do_ubd_request(request_queue
 
 static int ubd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 {
-	struct ubd *dev = bdev->bd_disk->private_data;
+	struct ubd *ubd_dev = bdev->bd_disk->private_data;
 
 	geo->heads = 128;
 	geo->sectors = 32;
-	geo->cylinders = dev->size / (128 * 32 * 512);
+	geo->cylinders = ubd_dev->size / (128 * 32 * 512);
 	return 0;
 }
 
 static int ubd_ioctl(struct inode * inode, struct file * file,
 		     unsigned int cmd, unsigned long arg)
 {
-	struct ubd *dev = inode->i_bdev->bd_disk->private_data;
+	struct ubd *ubd_dev = inode->i_bdev->bd_disk->private_data;
 	struct hd_driveid ubd_id = {
 		.cyls		= 0,
 		.heads		= 128,
@@ -1075,7 +1075,7 @@ static int ubd_ioctl(struct inode * inod
 	switch (cmd) {
 		struct cdrom_volctrl volume;
 	case HDIO_GET_IDENTITY:
-		ubd_id.cyls = dev->size / (128 * 32 * 512);
+		ubd_id.cyls = ubd_dev->size / (128 * 32 * 512);
 		if(copy_to_user((char __user *) arg, (char *) &ubd_id,
 				 sizeof(ubd_id)))
 			return(-EFAULT);
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
