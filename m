Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129529AbRCBVnq>; Fri, 2 Mar 2001 16:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129550AbRCBVn1>; Fri, 2 Mar 2001 16:43:27 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:33209 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129529AbRCBVmt>;
	Fri, 2 Mar 2001 16:42:49 -0500
Date: Fri, 2 Mar 2001 16:42:43 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Pavel Roskin <proski@gnu.org>, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] Re: usbdevfs can be mounted multiple times
In-Reply-To: <Pine.GSO.4.21.0103021617500.15463-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0103021640170.15463-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Mar 2001, Alexander Viro wrote:

> I.e. replace the last argument in declaration of usbdevfs with FS_SINGLE -
> without that we get a new instance every time.

Grr... Proper patch follows. Please, apply.
								Cheers,
									Al
--- drivers/usb/inode.c	Fri Feb 16 18:24:31 2001
+++ drivers/usb/inode.c.new	Fri Mar  2 16:39:44 2001
@@ -596,7 +596,7 @@
 	return NULL;
 }
 
-static DECLARE_FSTYPE(usbdevice_fs_type, "usbdevfs", usbdevfs_read_super, 0);
+static DECLARE_FSTYPE(usbdevice_fs_type, "usbdevfs", usbdevfs_read_super, FS_SINGLE);
 
 /* --------------------------------------------------------------------- */
 
@@ -691,6 +691,7 @@
 		return ret;
 	if ((ret = register_filesystem(&usbdevice_fs_type)))
 		usb_deregister(&usbdevfs_driver);
+	kern_mount(&usbdevice_fs_type);
 #ifdef CONFIG_PROC_FS		
 	/* create mount point for usbdevfs */
 	usbdir = proc_mkdir("usb", proc_bus);
@@ -702,6 +703,7 @@
 {
 	usb_deregister(&usbdevfs_driver);
 	unregister_filesystem(&usbdevice_fs_type);
+	kern_umount(usbdevice_fs_type.kern_mnt);
 #ifdef CONFIG_PROC_FS	
         if (usbdir)
                 remove_proc_entry("usb", proc_bus);

