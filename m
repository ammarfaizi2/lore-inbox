Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422724AbWJFXBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422724AbWJFXBj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 19:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422726AbWJFXBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 19:01:38 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:60312 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1422724AbWJFXBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 19:01:37 -0400
Message-id: <34281112314@wsc.cz>
Subject: [PATCH 1/6] Char: mxser_new, eliminate tty ldisc deref
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <support@moxa.com.tw>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sat,  7 Oct 2006 01:01:35 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, eliminate tty ldisc deref

Use tty_ldisc_flush and tty_wakeup helpers for accessing ldisc internals.

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit f1ec019ded64c90bc2c8017a41bd77c8f900711c
tree 2c0916affadc7d056cd8ce397109a3f85bfc4c1f
parent b886c49c87ee91a038b917f6933183db8ae58125
author Jiri Slaby <jirislaby@gmail.com> Fri, 06 Oct 2006 23:14:52 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Fri, 06 Oct 2006 23:14:52 +0200

 drivers/char/mxser_new.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index a555dda..1f53e07 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -1065,7 +1065,6 @@ static void mxser_close(struct tty_struc
 
 	unsigned long timeout;
 	unsigned long flags;
-	struct tty_ldisc *ld;
 
 	if (tty->index == MXSER_PORTS)
 		return;
@@ -1145,12 +1144,7 @@ static void mxser_close(struct tty_struc
 	if (tty->driver->flush_buffer)
 		tty->driver->flush_buffer(tty);
 
-	ld = tty_ldisc_ref(tty);
-	if (ld) {
-		if (ld->flush_buffer)
-			ld->flush_buffer(tty);
-		tty_ldisc_deref(ld);
-	}
+	tty_ldisc_flush(tty);
 
 	tty->closing = 0;
 	info->event = 0;
@@ -1303,9 +1297,7 @@ static void mxser_flush_buffer(struct tt
 	spin_unlock_irqrestore(&info->slock, flags);
 	/* above added by shinhay */
 
-	wake_up_interruptible(&tty->write_wait);
-	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) && tty->ldisc.write_wakeup)
-		(tty->ldisc.write_wakeup) (tty);
+	tty_wakeup(tty);
 }
 
 /*
