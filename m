Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbUK2Hlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbUK2Hlf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 02:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbUK2Hlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 02:41:35 -0500
Received: from [210.77.38.126] ([210.77.38.126]:13021 "EHLO
	ns.turbolinux.com.cn") by vger.kernel.org with ESMTP
	id S261183AbUK2Hl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 02:41:27 -0500
Message-ID: <41AAD28B.2070301@turbolinux.com>
Date: Mon, 29 Nov 2004 15:40:59 +0800
From: bobl <bobl@turbolinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031231
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Is this a bug of vt_ioctl ??
Content-Type: multipart/mixed;
 boundary="------------010909040005090906070901"
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010909040005090906070901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,All:

     I think this is a bug of vt_ioctl, who can give me a confirm?

     In the man page of consolechars(v 0.3.3), we can see the describe 
as follow:

---------------------------------------------------------------------
        --tty=device
               Use  device as console device for ioctls, instead of 
guessing which one to use, which usually chooses the current
               tty.  This can be useful for testing when under X, in 
conjunction with --no-act - actual ioctls are  refused  for
               some reason then.

--------------------------------------------------------------------

But when i use the command as follow,:
consolechars --sfm=/dir/name --tty=/dev/tty5  under tty1. The change 
happen on tty1, not on tty5! So i read the source code of consolechars 
and find the command as above use ioctl cmd PIO_UNIMAPCLR and 
PIO_UNIMAP. The source code of kernel 2.6.8.1 as follow:
(drivers/char/vt_ioctl.c)

         ...
         case PIO_UNIMAPCLR:
               { struct unimapinit ui;
                 if (!perm)
                         return -EPERM;
                 i = copy_from_user(&ui, (void *)arg, sizeof(struct 
unimapinit));
                 if (i) return -EFAULT;
                 con_clear_unimap(fg_console, &ui);
                 return 0;
               }

         case PIO_UNIMAP:
         case GIO_UNIMAP:
                 return do_unimap_ioctl(cmd, (struct unimapdesc *)arg, 
perm);
         ...


we can see in the case PIO_UNIMAPCLR, One parameter of con_clear_unimp 
is  "fg_console"! it's current tty!  In the implement of 
do_unimap_ioctl(), use "fg_console" too! Use "console" will be right!


The attachment is a patch against 2.6.8.1. If what i said is right, 
there also should do some other modify, such as in the case of 
GIO_SCRNMAP!

--------------010909040005090906070901
Content-Type: text/plain;
 name="vt_ioctl_2.6.8.1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vt_ioctl_2.6.8.1.patch"

--- linux/drivers/char/vt_ioctl.c.orig	2004-11-29 15:36:28.100257232 +0800
+++ linux/drivers/char/vt_ioctl.c	2004-11-29 15:36:10.772891392 +0800
@@ -332,7 +332,7 @@
 }
 
 static inline int 
-do_unimap_ioctl(int cmd, struct unimapdesc *user_ud,int perm)
+do_unimap_ioctl(int cmd, int con, struct unimapdesc *user_ud,int perm)
 {
 	struct unimapdesc tmp;
 	int i = 0; 
@@ -348,9 +348,9 @@
 	case PIO_UNIMAP:
 		if (!perm)
 			return -EPERM;
-		return con_set_unimap(fg_console, tmp.entry_ct, tmp.entries);
+		return con_set_unimap(con, tmp.entry_ct, tmp.entries);
 	case GIO_UNIMAP:
-		return con_get_unimap(fg_console, tmp.entry_ct, &(user_ud->entry_ct), tmp.entries);
+		return con_get_unimap(con, tmp.entry_ct, &(user_ud->entry_ct), tmp.entries);
 	}
 	return 0;
 }
@@ -966,13 +966,13 @@
 			return -EPERM;
 		i = copy_from_user(&ui, (void *)arg, sizeof(struct unimapinit));
 		if (i) return -EFAULT;
-		con_clear_unimap(fg_console, &ui);
+		con_clear_unimap(console, &ui);
 		return 0;
 	      }
 
 	case PIO_UNIMAP:
 	case GIO_UNIMAP:
-		return do_unimap_ioctl(cmd, (struct unimapdesc *)arg, perm);
+		return do_unimap_ioctl(cmd, console, (struct unimapdesc *)arg, perm);
 
 	case VT_LOCKSWITCH:
 		if (!capable(CAP_SYS_TTY_CONFIG))

--------------010909040005090906070901--

