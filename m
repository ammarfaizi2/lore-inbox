Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317980AbSIESJZ>; Thu, 5 Sep 2002 14:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317986AbSIESJZ>; Thu, 5 Sep 2002 14:09:25 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:3200 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S317980AbSIESJY>;
	Thu, 5 Sep 2002 14:09:24 -0400
Date: Thu, 5 Sep 2002 20:13:50 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] IDE cleanup (1.612) broke all fdisks I have...
Message-ID: <20020905181350.GA1822@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,
   it is nice that blkdev_ioctl calls blk_ioctl itself, but unfortunately
it does that only if driver's ioctl returns -EINVAL - and IDE returns -EIO :-(

Patch below is tested for disks - I do not have IDE floppy nor IDE tape.

   I have couple of additional questions: 
(1) should not we use -ENOTTY for unimplemented ioctl, like other subsystems do?
(2) IDE returns -EIO also for default_open. -ENXIO/-ENODEV?
(3) if drive->driver == NULL, ioctl returns -EPERM. I believe that this check
    is not needed because of ide_open checks for drive->driver != NULL. And
    if we can invoke ide's ioctl without previous open, should not we return
    -ENODEV?
						Thanks,
							Petr Vandrovec
							vandrove@vc.cvut.cz

diff -urN linux-2.5.33-c615.dist/drivers/ide/ide-floppy.c linux-2.5.33-c615/drivers/ide/ide-floppy.c
--- linux-2.5.33-c615.dist/drivers/ide/ide-floppy.c	2002-09-05 14:40:47.000000000 +0200
+++ linux-2.5.33-c615/drivers/ide/ide-floppy.c	2002-09-05 20:06:24.000000000 +0200
@@ -1817,7 +1817,7 @@
 		return (idefloppy_get_format_progress(drive, inode, file,
 						      (int *)arg));
 	}
- 	return -EIO;
+ 	return -EINVAL;
 }
 
 /*
diff -urN linux-2.5.33-c615.dist/drivers/ide/ide-tape.c linux-2.5.33-c615/drivers/ide/ide-tape.c
--- linux-2.5.33-c615.dist/drivers/ide/ide-tape.c	2002-09-05 14:40:43.000000000 +0200
+++ linux-2.5.33-c615/drivers/ide/ide-tape.c	2002-09-05 20:06:11.000000000 +0200
@@ -4365,7 +4365,7 @@
 				return -EFAULT;
 			break;
 		default:
-			return -EIO;
+			return -EINVAL;
 	}
 	return 0;
 }
diff -urN linux-2.5.33-c615.dist/drivers/ide/ide.c linux-2.5.33-c615/drivers/ide/ide.c
--- linux-2.5.33-c615.dist/drivers/ide/ide.c	2002-09-05 14:40:42.000000000 +0200
+++ linux-2.5.33-c615/drivers/ide/ide.c	2002-09-05 19:58:15.000000000 +0200
@@ -3347,7 +3347,7 @@
 static int default_ioctl (ide_drive_t *drive, struct inode *inode, struct file *file,
 			  unsigned int cmd, unsigned long arg)
 {
-	return -EIO;
+	return -EINVAL;
 }
 
 static int default_open (struct inode *inode, struct file *filp, ide_drive_t *drive)
