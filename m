Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263093AbVG3SaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbVG3SaW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 14:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263096AbVG3SaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 14:30:22 -0400
Received: from verein.lst.de ([213.95.11.210]:29060 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S263093AbVG3SaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 14:30:20 -0400
Date: Sat, 30 Jul 2005 20:30:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] switch fd1772.c from sleep_on to wait_event
Message-ID: <20050730183010.GB11877@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

doesn't make the local irq disabling around it less buggy, but at least
we replace the offender with the right kind of primitive.


Signed-off-by: Christoph Hellwig <hch@lst.de>


Index: linux-2.6/drivers/acorn/block/fd1772.c
===================================================================
--- linux-2.6.orig/drivers/acorn/block/fd1772.c	2005-04-30 10:17:13.000000000 +0200
+++ linux-2.6/drivers/acorn/block/fd1772.c	2005-05-27 14:15:43.000000000 +0200
@@ -1283,8 +1283,7 @@
 	if (fdc_busy) return;
 	save_flags(flags);
 	cli();
-	while (fdc_busy)
-		sleep_on(&fdc_wait);
+	wait_event(fdc_wait, !fdc_busy);
 	fdc_busy = 1;
 	ENABLE_IRQ();
 	restore_flags(flags);
