Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268993AbTBWVXr>; Sun, 23 Feb 2003 16:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268998AbTBWVXr>; Sun, 23 Feb 2003 16:23:47 -0500
Received: from pine.compass.com.ph ([202.70.96.37]:63017 "HELO
	pine.compass.com.ph") by vger.kernel.org with SMTP
	id <S268993AbTBWVXp>; Sun, 23 Feb 2003 16:23:45 -0500
Subject: Re: [Linux-fbdev-devel] cat /dev/fb1 produces kernel bug
From: Antonino Daplas <adaplas@pol.net>
To: Siim Vahtre <siim@pld.ttu.ee>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.31.0302231958260.28624-100000@pitsa.pld.ttu.ee>
References: <Pine.SOL.4.31.0302231958260.28624-100000@pitsa.pld.ttu.ee>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1046035982.1308.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 24 Feb 2003 05:34:24 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-24 at 02:07, Siim Vahtre wrote:

> Call Trace:
>  [<c020e678>] kobject_register+0x58/0x70
>  [<c021a58b>] bus_add_driver+0x5b/0xe0
>  [<c021a9df>] driver_register+0x2f/0x40
>  [<c017a8e3>] create_proc_entry+0x83/0xd0
>  [<c021170b>] pci_register_driver+0x4b/0x60
>  [<c010507f>] init+0x3f/0x160
>  [<c0105040>] init+0x0/0x160
>  [<c010726d>] kernel_thread_helper+0x5/0x18
> 

For a quick fix, try this:

diff -Naur linux-2.5.61/drivers/video/riva/fbdev.c linux/drivers/video/riva/fbdev.c
--- linux-2.5.61/drivers/video/riva/fbdev.c	2003-02-16 00:49:23.000000000 +0000
+++ linux/drivers/video/riva/fbdev.c	2003-02-23 21:30:50.000000000 +0000
@@ -1961,12 +1961,10 @@
 
 int __init rivafb_init(void)
 {
-	int err;
-	err = pci_module_init(&rivafb_driver);
-	if (err)
-		return err;
-	pci_register_driver(&rivafb_driver);
-	return 0;
+	if (pci_register_driver(&rivafb_driver) > 0) 
+		return 0;
+	pci_unregister_driver(&rivafb_driver);
+	return -ENODEV;
 }
 

Or Try James' patch...
http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

...and Geert's "Logo Updates" which he just sent recently.

Tony

