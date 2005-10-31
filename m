Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbVJaKVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbVJaKVt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 05:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbVJaKVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 05:21:49 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:45705 "EHLO mail.mnsspb.ru")
	by vger.kernel.org with ESMTP id S932476AbVJaKVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 05:21:47 -0500
From: Kirill Smelkov <kirr@mns.spb.ru>
Organization: MNS
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] serial moxa: fix leaks of struct tty_driver
Date: Mon, 31 Oct 2005 13:21:29 +0300
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pAfZDcUqHBVI99S"
Message-Id: <200510311321.29929.kirr@mns.spb.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_pAfZDcUqHBVI99S
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Fix leak of struct tty_driver in mxser_init & mxser_module_exit

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>


--Boundary-00=_pAfZDcUqHBVI99S
Content-Type: text/x-diff;
  charset="us-ascii";
  name="mxser-leaks.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mxser-leaks.patch"

Fix leak of struct tty_driver in mxser_init & mxser_module_exit

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>

Index: linux-2.6.14/drivers/char/mxser.c
===================================================================
--- linux-2.6.14.orig/drivers/char/mxser.c	2005-10-31 12:10:11.000000000 +0300
+++ linux-2.6.14/drivers/char/mxser.c	2005-10-31 12:10:47.000000000 +0300
@@ -494,14 +494,18 @@
 
 static void __exit mxser_module_exit(void)
 {
-	int i, err = 0;
+	int i, err;
 
 	if (verbose)
 		printk(KERN_DEBUG "Unloading module mxser ...\n");
 
-	if ((err |= tty_unregister_driver(mxvar_sdriver)))
+	err = tty_unregister_driver(mxvar_sdriver);
+	if (!err)
+		put_tty_driver(mxvar_sdriver);
+	else
 		printk(KERN_ERR "Couldn't unregister MOXA Smartio/Industio family serial driver\n");
 
+
 	for (i = 0; i < MXSER_BOARDS; i++) {
 		struct pci_dev *pdev;
 
@@ -690,7 +694,6 @@
 static int mxser_init(void)
 {
 	int i, m, retval, b, n;
-	int ret1;
 	struct pci_dev *pdev = NULL;
 	int index;
 	unsigned char busnum, devnum;
@@ -854,14 +857,11 @@
 	}
 #endif
 
-	ret1 = 0;
-	if (!(ret1 = tty_register_driver(mxvar_sdriver))) {
-		return 0;
-	} else
+	retval = tty_register_driver(mxvar_sdriver);
+	if (retval) {
 		printk(KERN_ERR "Couldn't install MOXA Smartio/Industio family driver !\n");
+		put_tty_driver(mxvar_sdriver);
 
-
-	if (ret1) {
 		for (i = 0; i < MXSER_BOARDS; i++) {
 			if (mxsercfg[i].board_type == -1)
 				continue;
@@ -870,10 +870,10 @@
 				//todo: release io, vector
 			}
 		}
-		return -1;
+		return retval;
 	}
 
-	return (0);
+	return 0;
 }
 
 static void mxser_do_softint(void *private_)

--Boundary-00=_pAfZDcUqHBVI99S--

