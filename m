Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267963AbUIWBgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267963AbUIWBgD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 21:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268127AbUIWBgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 21:36:03 -0400
Received: from build.arklinux.oregonstate.edu ([128.193.0.51]:41186 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S267963AbUIWBf6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 21:35:58 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
Organization: LINUX4MEDIA GmbH
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.9-rc2-mm2 breaks serial driver compiles
Date: Thu, 23 Sep 2004 03:33:19 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ffiUBAqH3JB+sHs"
Message-Id: <200409230333.19375.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_ffiUBAqH3JB+sHs
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

SSIA - fix attached.
The patch makes the serial drivers compile; due to lack of hardware I can't 
verify if they actually work.

LLaP
bero

--Boundary-00=_ffiUBAqH3JB+sHs
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.6.9-rc2-mm2-compile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.9-rc2-mm2-compile.patch"

--- linux-2.6.8/drivers/char/moxa.c.ark	2004-09-23 03:23:22.000000000 +0200
+++ linux-2.6.8/drivers/char/moxa.c	2004-09-23 03:23:35.000000000 +0200
@@ -958,7 +958,7 @@
 				if (MoxaPortTxQueue(ch->port) <= WAKEUP_CHARS) {
 					if (!tp->stopped) {
 						ch->statusflags &= ~LOWWAIT;
-						tty_wakeup(tty);
+						tty_wakeup(ch->tty);
 						wake_up_interruptible(&tp->write_wait);
 					}
 				}
@@ -1125,7 +1125,7 @@
 	if (ch->tty && (ch->statusflags & EMPTYWAIT)) {
 		if (MoxaPortTxQueue(ch->port) == 0) {
 			ch->statusflags &= ~EMPTYWAIT;
-			tty_wakeup(tty);
+			tty_wakeup(ch->tty);
 			wake_up_interruptible(&ch->tty->write_wait);
 			return;
 		}
--- linux-2.6.8/drivers/char/mxser.c.ark	2004-09-23 03:25:48.000000000 +0200
+++ linux-2.6.8/drivers/char/mxser.c	2004-09-23 03:26:28.000000000 +0200
@@ -740,6 +740,7 @@
 	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
 	unsigned long flags;
 	unsigned long timeout;
+	struct tty_ldisc *ld;
 
 	if (PORTNO(tty) == MXSER_PORTS)
 		return;
--- linux-2.6.8/drivers/char/generic_serial.c.ark	2004-09-23 03:27:54.000000000 +0200
+++ linux-2.6.8/drivers/char/generic_serial.c	2004-09-23 03:31:35.000000000 +0200
@@ -692,7 +692,7 @@
 	struct gs_port *port;
 	struct tty_ldisc *ld;
 
-	func_enter ()
+	func_enter ();
 
 	if (!tty) return;
 
@@ -760,7 +760,7 @@
 
 	ld = tty_ldisc_ref(tty);
 	if (ld != NULL) {
-		ld->flush_buffer)
+		if(ld->flush_buffer)
 			ld->flush_buffer(tty);
 		tty_ldisc_deref(ld);
 	}

--Boundary-00=_ffiUBAqH3JB+sHs--
