Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265393AbUBFLPO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 06:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265427AbUBFLPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 06:15:13 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:43728 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265393AbUBFLPG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 06:15:06 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: [Linux 2.6.2] bttv0: skipped frame. no signal? high irq latency?
Date: 06 Feb 2004 12:19:35 +0100
Organization: SuSE Labs, Berlin
Message-ID: <87n07wlak8.fsf@bytesex.org>
References: <Pine.LNX.4.58.0402060923560.19743@joel.ist.utl.pt>
NNTP-Posting-Host: localhost
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: bytesex.org 1076066375 8475 127.0.0.1 (6 Feb 2004 11:19:35 GMT)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rui Saraiva <rmps@joel.ist.utl.pt> writes:

> Hello Gerd Knorr,
> 
> I've the dmesg full of this warnings (last 149 messages right now),
> although I didn't notice anything unusual in tvtime. I don't recall seeing
> those warnings with 2.4.x. Should I just ignore them?

It's more or less a leftover debug message.  As it says bttv drops a
frame on every message.  That may happen due to a bad signal (or when
you switch to another channel) or due to high irq latencies,
i.e. bttv's irq handler not being called fast enough.

Unless that happens very frequently without channel switches
triggering this don't worry.

The patch below makes bttv quiet.

  Gerd

--- video4linux/bttv-driver.c~	2004-01-09 11:25:10.000000000 +0100
+++ video4linux/bttv-driver.c	2004-02-06 11:48:54.818360213 +0100
@@ -3308,8 +3308,8 @@
 	unsigned long flags;
 	
 	if (bttv_verbose) {
-		printk(KERN_INFO "bttv%d: timeout: irq=%d/%d, risc=%08x, ",
-		       btv->c.nr, btv->irq_me, btv->irq_total,
+		printk(KERN_INFO "bttv%d: timeout: drop=%d irq=%d/%d, risc=%08x, ",
+		       btv->c.nr, btv->framedrop, btv->irq_me, btv->irq_total,
 		       btread(BT848_RISC_COUNT));
 		bttv_print_irqbits(btread(BT848_INT_STAT),0);
 		printk("\n");
@@ -3378,7 +3378,8 @@
 	bttv_irq_next_set(btv, &new);
 	rc = btread(BT848_RISC_COUNT);
 	if (rc < btv->main.dma || rc > btv->main.dma + 0x100) {
-		if (1 /* irq_debug */)
+		btv->framedrop++;
+		if (irq_debug)
 			printk("bttv%d: skipped frame. no signal? high irq latency? "
 			       "[main=%lx,o_vbi=%lx,o_field=%lx,rc=%lx]\n",
 			       btv->c.nr,
--- video4linux/bttvp.h~	2004-01-09 11:20:11.000000000 +0100
+++ video4linux/bttvp.h	2004-02-06 11:47:16.086017583 +0100
@@ -402,9 +402,10 @@
 	struct bttv_suspend_state state;
 
 	/* stats */
+	unsigned int errors;
+	unsigned int framedrop;
 	unsigned int irq_total;
 	unsigned int irq_me;
-	unsigned int errors;
 
 	unsigned int users;
 	struct bttv_fh init;
