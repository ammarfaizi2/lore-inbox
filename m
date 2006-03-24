Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbWCXSPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWCXSPY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWCXSOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:14:06 -0500
Received: from [198.99.130.12] ([198.99.130.12]:45718 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751352AbWCXSNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:13:41 -0500
Message-Id: <200603241814.k2OIEuNd005550@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 11/16] UML - Allow ubd devices to be shared in a cluster
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Mar 2006 13:14:56 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a 'c' option to the ubd switch which turns off host file locking
so that the device can be shared, as with a cluster.
There's also some whitespace cleanup while I was in this file.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.16.orig/arch/um/drivers/ubd_kern.c	2006-03-23 17:15:05.000000000 -0500
+++ linux-2.6.16/arch/um/drivers/ubd_kern.c	2006-03-23 17:37:47.000000000 -0500
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -71,7 +71,7 @@ struct io_thread_req {
 	int error;
 };
 
-extern int open_ubd_file(char *file, struct openflags *openflags,
+extern int open_ubd_file(char *file, struct openflags *openflags, int shared,
 			 char **backing_file_out, int *bitmap_offset_out,
 			 unsigned long *bitmap_len_out, int *data_offset_out,
 			 int *create_cow_out);
@@ -137,7 +137,7 @@ static int fake_major = MAJOR_NR;
 
 static struct gendisk *ubd_gendisk[MAX_DEV];
 static struct gendisk *fake_gendisk[MAX_DEV];
- 
+
 #ifdef CONFIG_BLK_DEV_UBD_SYNC
 #define OPEN_FLAGS ((struct openflags) { .r = 1, .w = 1, .s = 1, .c = 0, \
 					 .cl = 1 })
@@ -168,6 +168,7 @@ struct ubd {
 	__u64 size;
 	struct openflags boot_openflags;
 	struct openflags openflags;
+	int shared;
 	int no_cow;
 	struct cow cow;
 	struct platform_device pdev;
@@ -189,6 +190,7 @@ struct ubd {
 	.boot_openflags =	OPEN_FLAGS, \
 	.openflags =		OPEN_FLAGS, \
         .no_cow =               0, \
+	.shared =		0, \
         .cow =			DEFAULT_COW, \
 }
 
@@ -305,7 +307,7 @@ static int ubd_setup_common(char *str, i
 		}
 		major = simple_strtoul(str, &end, 0);
 		if((*end != '\0') || (end == str)){
-			printk(KERN_ERR 
+			printk(KERN_ERR
 			       "ubd_setup : didn't parse major number\n");
 			return(1);
 		}
@@ -316,7 +318,7 @@ static int ubd_setup_common(char *str, i
  			printk(KERN_ERR "Can't assign a fake major twice\n");
  			goto out1;
  		}
- 
+
  		fake_major = major;
 
 		printk(KERN_INFO "Setting extra ubd major number to %d\n",
@@ -351,7 +353,7 @@ static int ubd_setup_common(char *str, i
 	if (index_out)
 		*index_out = n;
 
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < sizeof("rscd="); i++) {
 		switch (*str) {
 		case 'r':
 			flags.w = 0;
@@ -362,11 +364,14 @@ static int ubd_setup_common(char *str, i
 		case 'd':
 			dev->no_cow = 1;
 			break;
+		case 'c':
+			dev->shared = 1;
+			break;
 		case '=':
 			str++;
 			goto break_loop;
 		default:
-			printk(KERN_ERR "ubd_setup : Expected '=' or flag letter (r,s or d)\n");
+			printk(KERN_ERR "ubd_setup : Expected '=' or flag letter (r, s, c, or d)\n");
 			goto out;
 		}
 		str++;
@@ -515,7 +520,7 @@ static void ubd_handler(void)
 		spin_unlock(&ubd_io_lock);
 		return;
 	}
-        
+
 	ubd_finish(rq, req.error);
 	reactivate_fd(thread_fd, UBD_IRQ);	
 	do_ubd_request(ubd_queue);
@@ -532,7 +537,7 @@ static int io_pid = -1;
 
 void kill_io_thread(void)
 {
-	if(io_pid != -1) 
+	if(io_pid != -1)
 		os_kill_process(io_pid, 1);
 }
 
@@ -567,14 +572,15 @@ static int ubd_open_dev(struct ubd *dev)
 	create_cow = 0;
 	create_ptr = (dev->cow.file != NULL) ? &create_cow : NULL;
 	back_ptr = dev->no_cow ? NULL : &dev->cow.file;
-	dev->fd = open_ubd_file(dev->file, &dev->openflags, back_ptr,
-				&dev->cow.bitmap_offset, &dev->cow.bitmap_len, 
-				&dev->cow.data_offset, create_ptr);
+	dev->fd = open_ubd_file(dev->file, &dev->openflags, dev->shared,
+				back_ptr, &dev->cow.bitmap_offset,
+				&dev->cow.bitmap_len, &dev->cow.data_offset,
+				create_ptr);
 
 	if((dev->fd == -ENOENT) && create_cow){
-		dev->fd = create_cow_file(dev->file, dev->cow.file, 
+		dev->fd = create_cow_file(dev->file, dev->cow.file,
 					  dev->openflags, 1 << 9, PAGE_SIZE,
-					  &dev->cow.bitmap_offset, 
+					  &dev->cow.bitmap_offset,
 					  &dev->cow.bitmap_len,
 					  &dev->cow.data_offset);
 		if(dev->fd >= 0){
@@ -598,16 +604,16 @@ static int ubd_open_dev(struct ubd *dev)
 		}
 		flush_tlb_kernel_vm();
 
-		err = read_cow_bitmap(dev->fd, dev->cow.bitmap, 
-				      dev->cow.bitmap_offset, 
+		err = read_cow_bitmap(dev->fd, dev->cow.bitmap,
+				      dev->cow.bitmap_offset,
 				      dev->cow.bitmap_len);
 		if(err < 0)
 			goto error;
 
 		flags = dev->openflags;
 		flags.w = 0;
-		err = open_ubd_file(dev->cow.file, &flags, NULL, NULL, NULL, 
-				    NULL, NULL);
+		err = open_ubd_file(dev->cow.file, &flags, dev->shared, NULL,
+				    NULL, NULL, NULL, NULL);
 		if(err < 0) goto error;
 		dev->cow.fd = err;
 	}
@@ -685,11 +691,11 @@ static int ubd_add(int n)
 	dev->size = ROUND_BLOCK(dev->size);
 
 	err = ubd_new_disk(MAJOR_NR, dev->size, n, &ubd_gendisk[n]);
-	if(err) 
+	if(err)
 		goto out_close;
- 
+
 	if(fake_major != MAJOR_NR)
-		ubd_new_disk(fake_major, dev->size, n, 
+		ubd_new_disk(fake_major, dev->size, n,
 			     &fake_gendisk[n]);
 
 	/* perhaps this should also be under the "if (fake_major)" above */
@@ -854,7 +860,7 @@ int ubd_init(void)
 			return -1;
 	}
 	platform_driver_register(&ubd_driver);
-	for (i = 0; i < MAX_DEV; i++) 
+	for (i = 0; i < MAX_DEV; i++)
 		ubd_add(i);
 	return 0;
 }
@@ -872,16 +878,16 @@ int ubd_driver_init(void){
 		 * enough. So use anyway the io thread. */
 	}
 	stack = alloc_stack(0, 0);
-	io_pid = start_io_thread(stack + PAGE_SIZE - sizeof(void *), 
+	io_pid = start_io_thread(stack + PAGE_SIZE - sizeof(void *),
 				 &thread_fd);
 	if(io_pid < 0){
-		printk(KERN_ERR 
+		printk(KERN_ERR
 		       "ubd : Failed to start I/O thread (errno = %d) - "
 		       "falling back to synchronous I/O\n", -io_pid);
 		io_pid = -1;
 		return(0);
 	}
-	err = um_request_irq(UBD_IRQ, thread_fd, IRQ_READ, ubd_intr, 
+	err = um_request_irq(UBD_IRQ, thread_fd, IRQ_READ, ubd_intr,
 			     SA_INTERRUPT, "ubd", ubd_dev);
 	if(err != 0)
 		printk(KERN_ERR "um_request_irq failed - errno = %d\n", -err);
@@ -978,7 +984,7 @@ static void cowify_req(struct io_thread_
 	if(req->op == UBD_READ) {
 		for(i = 0; i < req->length >> 9; i++){
 			if(ubd_test_bit(sector + i, (unsigned char *) bitmap))
-				ubd_set_bit(i, (unsigned char *) 
+				ubd_set_bit(i, (unsigned char *)
 					    &req->sector_mask);
                 }
 	}
@@ -999,7 +1005,7 @@ static int prepare_request(struct reques
 
 	/* This should be impossible now */
 	if((rq_data_dir(req) == WRITE) && !dev->openflags.w){
-		printk("Write attempted on readonly ubd device %s\n", 
+		printk("Write attempted on readonly ubd device %s\n",
 		       disk->disk_name);
 		end_request(req, 0);
 		return(1);
@@ -1182,7 +1188,7 @@ int read_cow_bitmap(int fd, void *buf, i
 	return(0);
 }
 
-int open_ubd_file(char *file, struct openflags *openflags,
+int open_ubd_file(char *file, struct openflags *openflags, int shared,
 		  char **backing_file_out, int *bitmap_offset_out,
 		  unsigned long *bitmap_len_out, int *data_offset_out,
 		  int *create_cow_out)
@@ -1206,10 +1212,14 @@ int open_ubd_file(char *file, struct ope
 			return fd;
         }
 
-	err = os_lock_file(fd, openflags->w);
-	if(err < 0){
-		printk("Failed to lock '%s', err = %d\n", file, -err);
-		goto out_close;
+	if(shared)
+		printk("Not locking \"%s\" on the host\n", file);
+	else {
+		err = os_lock_file(fd, openflags->w);
+		if(err < 0){
+			printk("Failed to lock '%s', err = %d\n", file, -err);
+			goto out_close;
+		}
 	}
 
 	/* Succesful return case! */
@@ -1260,7 +1270,7 @@ int create_cow_file(char *cow_file, char
 	int err, fd;
 
 	flags.c = 1;
-	fd = open_ubd_file(cow_file, &flags, NULL, NULL, NULL, NULL, NULL);
+	fd = open_ubd_file(cow_file, &flags, 0, NULL, NULL, NULL, NULL, NULL);
 	if(fd < 0){
 		err = fd;
 		printk("Open of COW file '%s' failed, errno = %d\n", cow_file,

