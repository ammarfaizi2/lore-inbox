Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbWEJDAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbWEJDAP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 23:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWEJC5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:57:23 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:8510 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S932446AbWEJC4w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:56:52 -0400
Date: Tue, 9 May 2006 19:55:59 -0700
Message-Id: <200605100255.k4A2txEr031706@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] isdn sc driver gcc 4.1 warnings fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warnings,

drivers/isdn/sc/shmem.c: In function 'memcpy_toshmem':
drivers/isdn/sc/shmem.c:60: warning: passing argument 1 of 'memcpy_toio' makes pointer from integer without a cast
drivers/isdn/sc/init.c: In function 'identify_board':
drivers/isdn/sc/init.c:492: warning: passing argument 1 of 'readl' makes pointer from integer without a cast
drivers/isdn/sc/init.c:502: warning: passing argument 1 of 'readl' makes pointer from integer without a cast
drivers/isdn/sc/init.c:512: warning: passing argument 1 of 'readl' makes pointer from integer without a cast

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/drivers/isdn/sc/init.c
===================================================================
--- linux-2.6.16.orig/drivers/isdn/sc/init.c
+++ linux-2.6.16/drivers/isdn/sc/init.c
@@ -489,7 +489,7 @@ static int identify_board(unsigned long 
 	 */
 	outb(PRI_BASEPG_VAL, pgport);
 	msleep_interruptible(1000);
-	sig = readl(rambase + SIG_OFFSET);
+	sig = readl((void *)(rambase + SIG_OFFSET));
 	pr_debug("Looking for a signature, got 0x%x\n", sig);
 	if(sig == SIGNATURE)
 		return PRI_BOARD;
@@ -499,7 +499,7 @@ static int identify_board(unsigned long 
 	 */
 	outb(BRI_BASEPG_VAL, pgport);
 	msleep_interruptible(1000);
-	sig = readl(rambase + SIG_OFFSET);
+	sig = readl((void *)(rambase + SIG_OFFSET));
 	pr_debug("Looking for a signature, got 0x%x\n", sig);
 	if(sig == SIGNATURE)
 		return BRI_BOARD;
@@ -509,7 +509,7 @@ static int identify_board(unsigned long 
 	/*
 	 * Try to spot a card
 	 */
-	sig = readl(rambase + SIG_OFFSET);
+	sig = readl((void *)(rambase + SIG_OFFSET));
 	pr_debug("Looking for a signature, got 0x%x\n", sig);
 	if(sig != SIGNATURE)
 		return -1;
Index: linux-2.6.16/drivers/isdn/sc/shmem.c
===================================================================
--- linux-2.6.16.orig/drivers/isdn/sc/shmem.c
+++ linux-2.6.16/drivers/isdn/sc/shmem.c
@@ -56,8 +56,8 @@ void memcpy_toshmem(int card, void *dest
 
 	outb(((sc_adapter[card]->shmem_magic + ch * SRAM_PAGESIZE) >> 14) | 0x80,
 		sc_adapter[card]->ioport[sc_adapter[card]->shmem_pgport]);
-	memcpy_toio(sc_adapter[card]->rambase +
-		((unsigned long) dest % 0x4000), src, n);
+	memcpy_toio((void *)(sc_adapter[card]->rambase +
+		((unsigned long) dest % 0x4000)), src, n);
 	spin_unlock_irqrestore(&sc_adapter[card]->lock, flags);
 	pr_debug("%s: set page to %#x\n",sc_adapter[card]->devicename,
 		((sc_adapter[card]->shmem_magic + ch * SRAM_PAGESIZE)>>14)|0x80);
