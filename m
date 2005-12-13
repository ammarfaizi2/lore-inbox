Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbVLMPGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbVLMPGz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 10:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbVLMPGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 10:06:54 -0500
Received: from ns2.suse.de ([195.135.220.15]:50911 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964993AbVLMPGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 10:06:53 -0500
Message-ID: <439EE38C.6020602@suse.de>
Date: Tue, 13 Dec 2005 16:06:52 +0100
From: Gerd Knorr <kraxel@suse.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [patch 1/2] uml/xen: make the vt subsystem a runtime option
Content-Type: multipart/mixed;
 boundary="------------060509030309090105000601"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060509030309090105000601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

   Hi,

This patch enables the VT console to be disabled at runtime even if it 
is built into the kernel.  The UML framebuffer driver (patch follows) 
depends on this.  Xen will need that one too.

please apply,

   Gerd

--------------060509030309090105000601
Content-Type: text/plain;
 name="xen-vt-runtime"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xen-vt-runtime"

Subject: [patch] xen vt runtime
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>

This patch enables the VT console to be disabled at runtime even if it is
built into the kernel.  Arch xen needs this to avoid trying to initialise a VT
in virtual machine that doesn't have access to the console hardware.

Signed-off-by: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Gerd Knorr <kraxel@suse.de>
Index: linux-2.6.14/drivers/char/tty_io.c
===================================================================
--- linux-2.6.14.orig/drivers/char/tty_io.c	2005-12-02 11:58:50.000000000 +0100
+++ linux-2.6.14/drivers/char/tty_io.c	2005-12-02 12:03:13.000000000 +0100
@@ -132,6 +132,8 @@ LIST_HEAD(tty_drivers);			/* linked list
    vt.c for deeply disgusting hack reasons */
 DECLARE_MUTEX(tty_sem);
 
+int console_use_vt = 1;
+
 #ifdef CONFIG_UNIX98_PTYS
 extern struct tty_driver *ptm_driver;	/* Unix98 pty masters; for /dev/ptmx */
 extern int pty_limit;		/* Config limit on Unix98 ptys */
@@ -1825,7 +1827,7 @@ retry_open:
 		goto got_driver;
 	}
 #ifdef CONFIG_VT
-	if (device == MKDEV(TTY_MAJOR,0)) {
+	if (console_use_vt && device == MKDEV(TTY_MAJOR,0)) {
 		extern struct tty_driver *console_driver;
 		driver = console_driver;
 		index = fg_console;
@@ -3014,6 +3016,8 @@ static int __init tty_init(void)
 #endif
 
 #ifdef CONFIG_VT
+	if (!console_use_vt)
+		goto out_vt;
 	cdev_init(&vc0_cdev, &console_fops);
 	if (cdev_add(&vc0_cdev, MKDEV(TTY_MAJOR, 0), 1) ||
 	    register_chrdev_region(MKDEV(TTY_MAJOR, 0), 1, "/dev/vc/0") < 0)
@@ -3022,6 +3026,7 @@ static int __init tty_init(void)
 	class_device_create(tty_class, NULL, MKDEV(TTY_MAJOR, 0), NULL, "tty0");
 
 	vty_init();
+ out_vt:
 #endif
 	return 0;
 }

--------------060509030309090105000601--
