Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbVJDMm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbVJDMm7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 08:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbVJDMm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 08:42:59 -0400
Received: from mailgate2.urz.uni-halle.de ([141.48.3.8]:29923 "EHLO
	mailgate2.uni-halle.de") by vger.kernel.org with ESMTP
	id S932411AbVJDMm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 08:42:58 -0400
Date: Tue, 04 Oct 2005 14:41:43 +0200 (MEST)
From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 3/7] HPET: fix division by zero in HPET_INFO
In-reply-to: <20051004124126.23057.75614.schnuffi@turing>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Bob Picco <bob.picco@hp.com>,
       Clemens Ladisch <clemens@ladisch.de>
Message-id: <20051004124143.23057.56237.schnuffi@turing>
Content-transfer-encoding: 7BIT
References: <20051004124126.23057.75614.schnuffi@turing>
X-Scan-Signature: ddcb1167275539a271faf4605d0b8e77
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clemens Ladisch <clemens@ladisch.de>

Fix a division by zero that happened when the HPET_INFO ioctl was
called before a timer frequency had been set.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

Index: linux-2.6.13/drivers/char/hpet.c
===================================================================
--- linux-2.6.13.orig/drivers/char/hpet.c	2005-10-03 22:53:12.000000000 +0200
+++ linux-2.6.13/drivers/char/hpet.c	2005-10-03 22:53:15.000000000 +0200
@@ -494,8 +494,11 @@ hpet_ioctl_common(struct hpet_dev *devp,
 		{
 			struct hpet_info info;
 
-			info.hi_ireqfreq = hpet_time_div(hpetp,
-							 devp->hd_ireqfreq);
+			if (devp->hd_ireqfreq)
+				info.hi_ireqfreq =
+					hpet_time_div(hpetp, devp->hd_ireqfreq);
+			else
+				info.hi_ireqfreq = 0;
 			info.hi_flags =
 			    readq(&timer->hpet_config) & Tn_PER_INT_CAP_MASK;
 			info.hi_hpet = devp->hd_hpets->hp_which;
