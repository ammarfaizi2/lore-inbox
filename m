Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263580AbUDZVOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbUDZVOP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 17:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263581AbUDZVOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 17:14:14 -0400
Received: from gprs214-178.eurotel.cz ([160.218.214.178]:1408 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263580AbUDZVOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 17:14:08 -0400
Date: Mon, 26 Apr 2004 23:13:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, vojtech@ucw.cz
Subject: Fix two theoretical races in atkbd
Message-ID: <20040426211356.GA931@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes two theoretical problems in atkbd.c.

1) It is not okay to use volatile char instead of atomic type. It
should not matter on most architectures.

2) Theoretical race on smp. atkbd->ack = 1 at the begining.

sendbyte:

atkbd->ack = 0;
serio_write()
				atkbd_interrupt:
				if (!atkbd->ack)
[cpu delayed write up-to now]
				[acknowledge lost]

Memory barriers are needed to prevent that. Please apply,

						Pavel

--- tmp/linux/drivers/input/keyboard/atkbd.c	2004-04-05 10:45:16.000000000 +0200
+++ linux/drivers/input/keyboard/atkbd.c	2004-04-26 23:01:12.000000000 +0200
@@ -182,7 +182,7 @@
 	unsigned char extra;
 	unsigned char release;
 	int lastkey;
-	volatile signed char ack;
+	atomic_t ack;			/* 0 .. nothing, 1 .. ACK, 2 .. NAK */
 	unsigned char emul;
 	unsigned short id;
 	unsigned char write;
@@ -233,13 +233,14 @@
 		atkbd->resend = 0;
 #endif
 
-	if (!atkbd->ack)
+	mb();
+	if (!atomic_read(&atkbd->ack))
 		switch (code) {
 			case ATKBD_RET_ACK:
-				atkbd->ack = 1;
+				atomic_set(&atkbd->ack, 1);
 				goto out;
 			case ATKBD_RET_NAK:
-				atkbd->ack = -1;
+				atomic_set(&atkbd->ack, 2);
 				goto out;
 		}
 
@@ -368,7 +369,7 @@
 static int atkbd_sendbyte(struct atkbd *atkbd, unsigned char byte)
 {
 	int timeout = 20000; /* 200 msec */
-	atkbd->ack = 0;
+	atomic_set(&atkbd->ack, 0); mb();
 
 #ifdef ATKBD_DEBUG
 	printk(KERN_DEBUG "atkbd.c: Sent: %02x\n", byte);
@@ -376,9 +377,12 @@
 	if (serio_write(atkbd->serio, byte))
 		return -1;
 
-	while (!atkbd->ack && timeout--) udelay(10);
+	while (!atomic_read(&atkbd->ack) && timeout--) {
+		udelay(10);
+		mb();
+	}
 
-	return -(atkbd->ack <= 0);
+	return -(atomic_read(&atkbd->ack) != 1);
 }
 
 /*
@@ -710,7 +714,7 @@
 		atkbd->dev.rep[REP_PERIOD] = 33;
 	}
 
-	atkbd->ack = 1;
+	atomic_set(&atkbd->ack, 1); mb();
 	atkbd->serio = serio;
 
 	init_input_dev(&atkbd->dev);

-- 
934a471f20d6580d5aad759bf0d97ddc
