Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316489AbSE0CUR>; Sun, 26 May 2002 22:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316490AbSE0CUQ>; Sun, 26 May 2002 22:20:16 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:41953 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S316489AbSE0CUO>; Sun, 26 May 2002 22:20:14 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Trivial: exit path cleanup in drivers/cdrom/sonycd535.c
Date: Mon, 27 May 2002 12:23:20 +1000
Message-Id: <E17CAAK-0001GP-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

johnpol@2ka.mipt.ru: 30) request_region check, 21-30:
  here is one more trivial check.
  
  So please test and apply.
  
  	Evgeniy Polyakov ( s0mbre )
  
  

--- trivial-2.5.18/drivers/cdrom/sonycd535.c.orig	Mon May 27 12:07:36 2002
+++ trivial-2.5.18/drivers/cdrom/sonycd535.c	Mon May 27 12:07:36 2002
@@ -1486,6 +1486,7 @@
 	int  got_result = 0;
 	int  tmp_irq;
 	int  i;
+	devfs_handle_t sony_devfs_handle;
 
 	/* Setting the base I/O address to 0 will disable it. */
 	if ((sony535_cd_base_io == 0xffff)||(sony535_cd_base_io == 0))
@@ -1509,11 +1510,6 @@
 	printk(KERN_INFO CDU535_MESSAGE_NAME ": probing base address %03X\n",
 			sony535_cd_base_io);
 #endif
-	if (check_region(sony535_cd_base_io,4)) {
-		printk(CDU535_MESSAGE_NAME ": my base address is not free!\n");
-		return -EIO;
-	}
-
 	/* look for the CD-ROM, follows the procedure in the DOS driver */
 	inb(select_unit_reg);
 	/* wait for 40 18 Hz ticks (reverse-engineered from DOS driver) */
@@ -1586,13 +1582,14 @@
 					printk("IRQ%d, ", tmp_irq);
 				printk("using %d byte buffer\n", sony_buffer_size);
 
-				devfs_register (NULL, CDU535_HANDLE,
-						DEVFS_FL_DEFAULT,
-						MAJOR_NR, 0,
-						S_IFBLK | S_IRUGO | S_IWUGO,
-						&cdu_fops, NULL);
+				sony_devfs_handle = devfs_register (NULL, CDU535_HANDLE,
+								DEVFS_FL_DEFAULT,
+								MAJOR_NR, 0,
+								S_IFBLK | S_IRUGO | S_IWUGO,
+								&cdu_fops, NULL);
 				if (devfs_register_blkdev(MAJOR_NR, CDU535_HANDLE, &cdu_fops)) {
 					printk("Unable to get major %d for %s\n",
+					devfs_unregister(sony_devfs_handle);
 							MAJOR_NR, CDU535_MESSAGE_NAME);
 					return -EIO;
 				}
@@ -1604,6 +1601,8 @@
 					kmalloc(sizeof *sony_toc, GFP_KERNEL);
 				if (sony_toc == NULL) {
 					blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
+					devfs_unregister_blkdev(MAJOR_NR, CDU535_HANDLE);
+					devfs_unregister(sony_devfs_handle);
 					return -ENOMEM;
 				}
 				last_sony_subcode = (struct s535_sony_subcode *)
@@ -1611,6 +1610,8 @@
 				if (last_sony_subcode == NULL) {
 					blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 					kfree(sony_toc);
+					devfs_unregister_blkdev(MAJOR_NR, CDU535_HANDLE);
+					devfs_unregister(sony_devfs_handle);
 					return -ENOMEM;
 				}
 				sony_buffer = (Byte **)
@@ -1619,6 +1620,8 @@
 					blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 					kfree(sony_toc);
 					kfree(last_sony_subcode);
+					devfs_unregister_blkdev(MAJOR_NR, CDU535_HANDLE);
+					devfs_unregister(sony_devfs_handle);
 					return -ENOMEM;
 				}
 				for (i = 0; i < sony_buffer_sectors; i++) {
@@ -1631,6 +1634,8 @@
 						kfree(sony_buffer);
 						kfree(sony_toc);
 						kfree(last_sony_subcode);
+						devfs_unregister_blkdev(MAJOR_NR, CDU535_HANDLE);
+						devfs_unregister(sony_devfs_handle);
 						return -ENOMEM;
 					}
 				}
@@ -1643,7 +1648,25 @@
 		printk("Did not find a " CDU535_MESSAGE_NAME " drive\n");
 		return -EIO;
 	}
-	request_region(sony535_cd_base_io, 4, CDU535_HANDLE);
+	if (!request_region(sony535_cd_base_io, 4, CDU535_HANDLE))
+		{
+		printk(KERN_WARNING"sonycd535: Unable to request region 0x%x\n",
+			sony535_cd_base_io);
+		for (i = 0; i < sony_buffer_sectors; i++)
+			if (sony_buffer[i]) 
+				kfree(sony_buffer[i]);
+		blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
+		kfree(sony_buffer);
+		kfree(sony_toc);
+		kfree(last_sony_subcode);
+		devfs_unregister_blkdev(MAJOR_NR, CDU535_HANDLE);
+		devfs_unregister(sony_devfs_handle);
+		if (sony535_irq_used)
+			free_irq(sony535_irq_used, NULL);
+		}
+	
+		return -EIO;
+		}
 	register_disk(NULL, mk_kdev(MAJOR_NR,0), 1, &cdu_fops, 0);
 	return 0;
 }

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
