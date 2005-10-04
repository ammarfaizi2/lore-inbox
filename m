Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbVJDMo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbVJDMo5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 08:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbVJDMnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 08:43:01 -0400
Received: from mailgate2.urz.uni-halle.de ([141.48.3.8]:28131 "EHLO
	mailgate2.uni-halle.de") by vger.kernel.org with ESMTP
	id S932403AbVJDMm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 08:42:58 -0400
Date: Tue, 04 Oct 2005 14:41:38 +0200 (MEST)
From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 2/7] HPET: fix HPET_INFO calls from kernel space
In-reply-to: <20051004124126.23057.75614.schnuffi@turing>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Bob Picco <bob.picco@hp.com>,
       Clemens Ladisch <clemens@ladisch.de>
Message-id: <20051004124137.23057.91786.schnuffi@turing>
Content-transfer-encoding: 7BIT
References: <20051004124126.23057.75614.schnuffi@turing>
X-Scan-Signature: b60a4fd9f15a2178650dbc7e1e141b14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clemens Ladisch <clemens@ladisch.de>

Fix a wrong memory access in hpet_ioctl_common().  It was not possible
to use the HPET_INFO ioctl from kernel space because it always called
copy_to_user().

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

Index: linux-2.6.13/drivers/char/hpet.c
===================================================================
--- linux-2.6.13.orig/drivers/char/hpet.c	2005-10-03 22:53:09.000000000 +0200
+++ linux-2.6.13/drivers/char/hpet.c	2005-10-03 22:53:12.000000000 +0200
@@ -500,8 +500,12 @@ hpet_ioctl_common(struct hpet_dev *devp,
 			    readq(&timer->hpet_config) & Tn_PER_INT_CAP_MASK;
 			info.hi_hpet = devp->hd_hpets->hp_which;
 			info.hi_timer = devp - devp->hd_hpets->hp_dev;
-			if (copy_to_user((void __user *)arg, &info, sizeof(info)))
-				err = -EFAULT;
+			if (kernel)
+				memcpy((void *)arg, &info, sizeof(info));
+			else
+				if (copy_to_user((void __user *)arg, &info,
+						 sizeof(info)))
+					err = -EFAULT;
 			break;
 		}
 	case HPET_EPI:
