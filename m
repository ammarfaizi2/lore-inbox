Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbVJaKWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbVJaKWT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 05:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbVJaKVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 05:21:50 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:46217 "EHLO mail.mnsspb.ru")
	by vger.kernel.org with ESMTP id S932487AbVJaKVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 05:21:48 -0500
From: Kirill Smelkov <kirr@mns.spb.ru>
Organization: MNS
Date: Mon, 31 Oct 2005 13:21:32 +0300
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Subject: [PATCH] serial moxa: fix wrong BUG
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Message-Id: <200510311321.33214.kirr@mns.spb.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a wrong BUG in mxser_close.

The BUG is triggered when tty->driver_data == NULL,
But in fact this is not a bug, because tty->driver->close is called
even when tty->driver->open fails.

LDD3 tells us to do nothing in such cases.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>

Index: linux-2.6.14/drivers/char/mxser.c
===================================================================
--- linux-2.6.14.orig/drivers/char/mxser.c	2005-10-31 10:57:16.000000000 +0300
+++ linux-2.6.14/drivers/char/mxser.c	2005-10-31 11:24:58.000000000 +0300
@@ -917,6 +917,9 @@
 	struct mxser_struct *info;
 	int retval, line;
 
+	/* initialize driver_data in case something fails */
+	tty->driver_data = NULL;
+
 	line = tty->index;
 	if (line == MXSER_PORTS)
 		return 0;
@@ -979,7 +982,7 @@
 	if (tty->index == MXSER_PORTS)
 		return;
 	if (!info)
-		BUG();
+		return;
 
 	spin_lock_irqsave(&info->slock, flags);
 

