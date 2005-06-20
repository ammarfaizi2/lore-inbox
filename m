Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbVFTVAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbVFTVAJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVFTU7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 16:59:15 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:24734 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261550AbVFTUQO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 16:16:14 -0400
Subject: PATCH: IDE timing violation on reset
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119298417.3279.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 20 Jun 2005 21:13:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pretty much theoretical for non MMIO thankfully. We _must_ use OUTBSYNC
for commands or they may be posted and thus ruin the 400nS required
delay.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.12/drivers/ide/ide-iops.c linux-2.6.12/drivers/ide/ide-iops.c
--- linux.vanilla-2.6.12/drivers/ide/ide-iops.c	2005-06-19 11:30:47.000000000 +0100
+++ linux-2.6.12/drivers/ide/ide-iops.c	2005-06-20 20:44:22.000000000 +0100
@@ -1181,7 +1181,8 @@
 		pre_reset(drive);
 		SELECT_DRIVE(drive);
 		udelay (20);
-		hwif->OUTB(WIN_SRST, IDE_COMMAND_REG);
+		hwif->OUTBSYNC(drive, WIN_SRST, IDE_COMMAND_REG);
+		ndelay(400);
 		hwgroup->poll_timeout = jiffies + WAIT_WORSTCASE;
 		hwgroup->polling = 1;
 		__ide_set_handler(drive, &atapi_reset_pollfunc, HZ/20, NULL);

