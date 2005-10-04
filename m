Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbVJDMoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbVJDMoJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 08:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbVJDMnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 08:43:06 -0400
Received: from mailgate2.urz.uni-halle.de ([141.48.3.8]:33251 "EHLO
	mailgate2.uni-halle.de") by vger.kernel.org with ESMTP
	id S932405AbVJDMm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 08:42:58 -0400
Date: Tue, 04 Oct 2005 14:41:53 +0200 (MEST)
From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 5/7] HPET: fix access to multiple HPET devices
In-reply-to: <20051004124126.23057.75614.schnuffi@turing>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Bob Picco <bob.picco@hp.com>,
       Clemens Ladisch <clemens@ladisch.de>
Message-id: <20051004124153.23057.79543.schnuffi@turing>
Content-transfer-encoding: 7BIT
References: <20051004124126.23057.75614.schnuffi@turing>
X-Scan-Signature: 196dc948e9075a1d4a96e576e957ccf8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clemens Ladisch <clemens@ladisch.de>

Fix two instances where a function would access the first HPET device
instead of the current one.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

Index: linux-2.6.13/drivers/char/hpet.c
===================================================================
--- linux-2.6.13.orig/drivers/char/hpet.c	2005-10-03 22:53:18.000000000 +0200
+++ linux-2.6.13/drivers/char/hpet.c	2005-10-03 22:53:21.000000000 +0200
@@ -430,7 +430,7 @@ static int hpet_ioctl_ieon(struct hpet_d
 	}
 
 	if (devp->hd_flags & HPET_SHARED_IRQ) {
-		isr = 1 << (devp - hpets->hp_dev);
+		isr = 1 << (devp - devp->hd_hpets->hp_dev);
 		writel(isr, &hpet->hpet_isr);
 	}
 	writeq(g, &timer->hpet_config);
@@ -769,7 +769,7 @@ static unsigned long hpet_calibrate(stru
 	if (!timer)
 		return 0;
 
-	hpet = hpets->hp_hpet;
+	hpet = hpetp->hp_hpet;
 	t = read_counter(&timer->hpet_compare);
 
 	i = 0;
