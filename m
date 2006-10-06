Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422728AbWJFXDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422728AbWJFXDX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 19:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422729AbWJFXDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 19:03:22 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:1947 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1422728AbWJFXDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 19:03:21 -0400
Message-id: <34287982364@wsc.cz>
Subject: [PATCH 6/6] Char: mxser_new, register tty devices on the fly
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <support@moxa.com.tw>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sat,  7 Oct 2006 01:03:20 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, register tty devices on the fly

Register tty indexes only for real devices, udev then creates nodes for
them (and only for them). Move tty_register_driver before probing, to be
correct when calling tty_register_device. Also tell tty layer by tty_driver
flags, that we are registering devices.

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 56269f9ba9ccaf60a314ebcf58d4de650995c4e5
tree 4ba1724d042ceb299fc3d70c9d2e07acd814bfce
parent 27366d3720e2c8f1abad4dd24ca407544ba55cd5
author Jiri Slaby <jirislaby@gmail.com> Sat, 07 Oct 2006 00:53:28 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Sat, 07 Oct 2006 00:53:28 +0200

 drivers/char/mxser_new.c |   38 +++++++++++++++++++++++++++-----------
 1 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index a64e716..7a47433 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -2830,12 +2830,19 @@ static int __init mxser_module_init(void
 	mxvar_sdriver->subtype = SERIAL_TYPE_NORMAL;
 	mxvar_sdriver->init_termios = tty_std_termios;
 	mxvar_sdriver->init_termios.c_cflag = B9600|CS8|CREAD|HUPCL|CLOCAL;
-	mxvar_sdriver->flags = TTY_DRIVER_REAL_RAW;
+	mxvar_sdriver->flags = TTY_DRIVER_REAL_RAW|TTY_DRIVER_DYNAMIC_DEV;
 	tty_set_operations(mxvar_sdriver, &mxser_ops);
 	mxvar_sdriver->ttys = mxvar_tty;
 	mxvar_sdriver->termios = mxvar_termios;
 	mxvar_sdriver->termios_locked = mxvar_termios_locked;
 
+	retval = tty_register_driver(mxvar_sdriver);
+	if (retval) {
+		printk(KERN_ERR "Couldn't install MOXA Smartio/Industio family "
+				"tty driver !\n");
+		goto err_put;
+	}
+
 	mxvar_diagflag = 0;
 
 	m = 0;
@@ -2885,6 +2892,10 @@ static int __init mxser_module_init(void
 			if (mxser_initbrd(brd) < 0)
 				continue;
 
+			for (i = 0; i < brd->nports; i++)
+				tty_register_device(mxvar_sdriver,
+					m * MXSER_PORTS_PER_BOARD + i, NULL);
+
 			m++;
 		}
 
@@ -2939,6 +2950,11 @@ static int __init mxser_module_init(void
 			/* mxser_initbrd will hook ISR. */
 			if (mxser_initbrd(brd) < 0)
 				continue;
+			for (i = 0; i < brd->nports; i++)
+				tty_register_device(mxvar_sdriver,
+					m * MXSER_PORTS_PER_BOARD + i,
+					&pdev->dev);
+
 			m++;
 			/* Keep an extra reference if we succeeded. It will
 			   be returned at unload time */
@@ -2946,20 +2962,18 @@ static int __init mxser_module_init(void
 		}
 	}
 
-	retval = tty_register_driver(mxvar_sdriver);
-	if (retval) {
-		printk(KERN_ERR "Couldn't install MOXA Smartio/Industio family"
-				" driver !\n");
-		put_tty_driver(mxvar_sdriver);
-
-		for (i = 0; i < MXSER_BOARDS; i++)
-			if (mxser_boards[i].board_type != -1)
-				mxser_release_res(&mxser_boards[i], 1);
-		return retval;
+	if (!m) {
+		retval = -ENODEV;
+		goto err_unr;
 	}
 
 	pr_debug("Done.\n");
 
+	return 0;
+err_unr:
+	tty_unregister_driver(mxvar_sdriver);
+err_put:
+	put_tty_driver(mxvar_sdriver);
 	return retval;
 }
 
@@ -2969,6 +2983,8 @@ static void __exit mxser_module_exit(voi
 
 	pr_debug("Unloading module mxser ...\n");
 
+	for (i = 0; i < MXSER_PORTS; i++)
+		tty_unregister_device(mxvar_sdriver, i);
 	tty_unregister_driver(mxvar_sdriver);
 	put_tty_driver(mxvar_sdriver);
 
