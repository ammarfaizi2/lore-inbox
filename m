Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135817AbREFTe1>; Sun, 6 May 2001 15:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135813AbREFTeR>; Sun, 6 May 2001 15:34:17 -0400
Received: from s02.hamberger.co.at ([193.83.64.20]:44294 "EHLO
	khan.hamberger.loc") by vger.kernel.org with ESMTP
	id <S135675AbREFTd6>; Sun, 6 May 2001 15:33:58 -0400
Message-ID: <3AF5A68E.479471E1@tcp-ip.at>
Date: Sun, 06 May 2001 21:31:26 +0200
From: Thomas Warwaris <war@tcp-ip.at>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] capabilities instead of suser in vt.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch (on 2.4.4) replaces the calls for suser()
in vt.c by capable(CAP_SYS_ADMIN).

Any comments are welcome.

I am not on the kernel list. Please CC me followups
to war@tcp-ip.at

Thomas

diff -urN -X dontdiff linux-2.4.4.ori/drivers/char/vt.c linux/drivers/char/vt.c
--- linux-2.4.4.ori/drivers/char/vt.c	Fri Feb  9 20:30:22 2001
+++ linux/drivers/char/vt.c	Sun May  6 23:16:06 2001
@@ -435,10 +435,10 @@
 
 	/*
 	 * To have permissions to do most of the vt ioctls, we either have
-	 * to be the owner of the tty, or super-user.
+	 * to be the owner of the tty, or SYS_ADMIN capability.
 	 */
 	perm = 0;
-	if (current->tty == tty || suser())
+	if (current->tty == tty || capable(CAP_SYS_ADMIN))
 		perm = 1;
  
 	kbd = kbd_table + console;
@@ -505,7 +505,7 @@
 		struct kbd_repeat kbrep;
 		
 		if (!mach_kbdrate) return( -EINVAL );
-		if (!suser()) return( -EPERM );
+		if (!capable(CAP_SYS_ADMIN)) return( -EPERM );
 
 		if (copy_from_user(&kbrep, (void *)arg,
 				   sizeof(struct kbd_repeat)))
@@ -1038,12 +1038,12 @@
 		return do_unimap_ioctl(cmd, (struct unimapdesc *)arg, perm);
 
 	case VT_LOCKSWITCH:
-		if (!suser())
+		if (!capable(CAP_SYS_ADMIN))
 		   return -EPERM;
 		vt_dont_switch = 1;
 		return 0;
 	case VT_UNLOCKSWITCH:
-		if (!suser())
+		if (!capable(CAP_SYS_ADMIN))
 		   return -EPERM;
 		vt_dont_switch = 0;
 		return 0;
diff -urN -X dontdiff linux-2.4.4.ori/include/linux/capability.h linux/include/linux/capability.h
--- linux-2.4.4.ori/include/linux/capability.h	Sat Apr 28 00:48:29 2001
+++ linux/include/linux/capability.h	Sun May  6 23:22:31 2001
@@ -231,6 +231,7 @@
 /* Allow enabling/disabling tagged queuing on SCSI controllers and sending
    arbitrary SCSI commands */
 /* Allow setting encryption key on loopback filesystem */
+/* Allow using virtual terminal administrative ioctl() */
 
 #define CAP_SYS_ADMIN        21
