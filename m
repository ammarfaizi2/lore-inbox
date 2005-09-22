Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbVIVPIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbVIVPIt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 11:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030397AbVIVPIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 11:08:49 -0400
Received: from mailgate2.urz.uni-halle.de ([141.48.3.8]:44459 "EHLO
	mailgate2.uni-halle.de") by vger.kernel.org with ESMTP
	id S1030395AbVIVPIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 11:08:48 -0400
Date: Thu, 22 Sep 2005 17:08:32 +0200 (MEST)
From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 1/2] HPET: disallow zero interrupt frequency
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Clemens Ladisch <clemens@ladisch.de>,
       Bob Picco <robert.picco@hp.com>
Message-id: <20050922150832.21412.18884.balrog@ifiu24.informatik.uni-halle.de>
Content-transfer-encoding: 7BIT
X-Scan-Signature: 196dc948e9075a1d4a96e576e957ccf8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to set an interrupt frequency of zero would result in a
division by zero, so disallow this.

Enabling the interrupt when the frequency hasn't yet been set would
use an interrupt period of minimum length, so disallow this, too.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

--- linux-2.6.13.orig/drivers/char/hpet.c	2005-09-22 10:56:23.000000000 +0200
+++ linux-2.6.13/drivers/char/hpet.c	2005-09-22 10:56:26.000000000 +0200
@@ -365,6 +365,9 @@ static int hpet_ioctl_ieon(struct hpet_d
 	hpet = devp->hd_hpet;
 	hpetp = devp->hd_hpets;
 
+	if (!devp->hd_ireqfreq)
+		return -EIO;
+
 	v = readq(&timer->hpet_config);
 	spin_lock_irq(&hpet_lock);
 
@@ -517,7 +520,7 @@ hpet_ioctl_common(struct hpet_dev *devp,
 			break;
 		}
 
-		if (arg & (arg - 1)) {
+		if (arg < 1 || (arg & (arg - 1))) {
 			err = -EINVAL;
 			break;
 		}
