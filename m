Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262505AbVAPODi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262505AbVAPODi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 09:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbVAPOBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 09:01:06 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:11426 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S262505AbVAPNxa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 08:53:30 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Cc: akpm@osdl.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050116135325.30109.62831.41853@localhost.localdomain>
In-Reply-To: <20050116135223.30109.26479.55757@localhost.localdomain>
References: <20050116135223.30109.26479.55757@localhost.localdomain>
Subject: [PATCH 9/13] moxa: remove cli()/sti() in drivers/char/moxa.c
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [209.158.220.243] at Sun, 16 Jan 2005 07:53:25 -0600
Date: Sun, 16 Jan 2005 07:53:25 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.11-rc1-mm1-original/drivers/char/moxa.c linux-2.6.11-rc1-mm1/drivers/char/moxa.c
--- linux-2.6.11-rc1-mm1-original/drivers/char/moxa.c	2004-12-24 16:35:28.000000000 -0500
+++ linux-2.6.11-rc1-mm1/drivers/char/moxa.c	2005-01-16 07:32:19.500529504 -0500
@@ -645,10 +645,9 @@
 	if (ch == NULL)
 		return (0);
 	port = ch->port;
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	len = MoxaPortWriteData(port, (unsigned char *) buf, count);
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	/*********************************************
 	if ( !(ch->statusflags & LOWWAIT) &&
@@ -723,11 +722,10 @@
 	if (ch == NULL)
 		return;
 	port = ch->port;
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	moxaXmitBuff[0] = c;
 	MoxaPortWriteData(port, moxaXmitBuff, 1);
-	restore_flags(flags);
+	local_irq_restore(flags);
 	/************************************************
 	if ( !(ch->statusflags & LOWWAIT) && (MoxaPortTxFree(port) <= 100) )
 	*************************************************/
@@ -1030,11 +1028,10 @@
 	printk("block_til_ready before block: ttys%d, count = %d\n",
 	       ch->line, ch->count);
 #endif
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	if (!tty_hung_up_p(filp))
 		ch->count--;
-	restore_flags(flags);
+	local_irq_restore(flags);
 	ch->blocked_open++;
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -1080,15 +1077,14 @@
 	struct moxa_str *ch = tty->driver_data;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	ch->statusflags |= EMPTYWAIT;
 	moxaEmptyTimer_on[ch->port] = 0;
 	del_timer(&moxaEmptyTimer[ch->port]);
 	moxaEmptyTimer[ch->port].expires = jiffies + HZ;
 	moxaEmptyTimer_on[ch->port] = 1;
 	add_timer(&moxaEmptyTimer[ch->port]);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void check_xmit_empty(unsigned long data)
@@ -1156,10 +1152,9 @@
 	charptr = tp->flip.char_buf_ptr;
 	flagptr = tp->flip.flag_buf_ptr;
 	rc = tp->flip.count;
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	count = MoxaPortReadData(ch->port, charptr, space);
-	restore_flags(flags);
+	local_irq_restore(flags);
 	for (i = 0; i < count; i++)
 		*flagptr++ = 0;
 	charptr += count;
