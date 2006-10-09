Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWJIJFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWJIJFs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 05:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWJIJFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 05:05:48 -0400
Received: from yacht.ocn.ne.jp ([222.146.40.168]:4548 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S932423AbWJIJFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 05:05:47 -0400
Date: Mon, 9 Oct 2006 18:06:03 +0900
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, "Digi International, Inc" <Eng.Linux@digi.com>
Subject: [PATCH] epca: privent from panic on tty_register_driver() failure
Message-ID: <20061009090603.GA6278@localhost>
Mail-Followup-To: akinobu.mita@gmail.com, linux-kernel@vger.kernel.org,
	akpm@osdl.org, "Digi International, Inc" <Eng.Linux@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: akinobu.mita@gmail.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes epca fail on initialization failure instead of panic.

Cc: "Digi International, Inc" <Eng.Linux@digi.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/char/epca.c |   32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

Index: work-fault-inject/drivers/char/epca.c
===================================================================
--- work-fault-inject.orig/drivers/char/epca.c	2006-10-09 15:06:32.000000000 +0900
+++ work-fault-inject/drivers/char/epca.c	2006-10-09 15:09:14.000000000 +0900
@@ -1160,6 +1160,7 @@ static int __init pc_init(void)
 	int crd;
 	struct board_info *bd;
 	unsigned char board_id = 0;
+	int err = -ENOMEM;
 
 	int pci_boards_found, pci_count;
 
@@ -1167,13 +1168,11 @@ static int __init pc_init(void)
 
 	pc_driver = alloc_tty_driver(MAX_ALLOC);
 	if (!pc_driver)
-		return -ENOMEM;
+		goto out1;
 
 	pc_info = alloc_tty_driver(MAX_ALLOC);
-	if (!pc_info) {
-		put_tty_driver(pc_driver);
-		return -ENOMEM;
-	}
+	if (!pc_info)
+		goto out2;
 
 	/* -----------------------------------------------------------------------
 		If epca_setup has not been ran by LILO set num_cards to defaults; copy
@@ -1373,11 +1372,17 @@ static int __init pc_init(void)
 
 	} /* End for each card */
 
-	if (tty_register_driver(pc_driver))
-		panic("Couldn't register Digi PC/ driver");
+	err = tty_register_driver(pc_driver);
+	if (err) {
+		printk(KERN_ERR "Couldn't register Digi PC/ driver");
+		goto out3;
+	}
 
-	if (tty_register_driver(pc_info))
-		panic("Couldn't register Digi PC/ info ");
+	err = tty_register_driver(pc_info);
+	if (err) {
+		printk(KERN_ERR "Couldn't register Digi PC/ info ");
+		goto out4;
+	}
 
 	/* -------------------------------------------------------------------
 	   Start up the poller to check for events on all enabled boards
@@ -1388,6 +1393,15 @@ static int __init pc_init(void)
 	mod_timer(&epca_timer, jiffies + HZ/25);
 	return 0;
 
+out4:
+	tty_unregister_driver(pc_driver);
+out3:
+	put_tty_driver(pc_driver);
+out2:
+	put_tty_driver(pc_info);
+out1:
+	return err;
+
 } /* End pc_init */
 
 /* ------------------ Begin post_fep_init  ---------------------- */
