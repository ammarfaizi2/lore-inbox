Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbVKAXWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbVKAXWE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 18:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbVKAXWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 18:22:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31974 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751427AbVKAXWD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 18:22:03 -0500
Date: Wed, 2 Nov 2005 00:21:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: [patch] collie: enable frontlight
Message-ID: <20051101232122.GA27107@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enable frontlight on collie, so that display can be actually read
indoors.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit dc507abbd6658927bdef7a521c4aa16c511ec62f
tree 666babf57b70cdf7fbac66c96defc9be4eb2518a
parent 8d04f63101774a56e80ef76b4d40ab782541dd94
author <pavel@amd.(none)> Wed, 02 Nov 2005 00:20:26 +0100
committer <pavel@amd.(none)> Wed, 02 Nov 2005 00:20:26 +0100

 arch/arm/common/locomo.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -631,6 +631,23 @@ static int locomo_resume(struct device *
 }
 #endif
 
+static spinlock_t fl_lock = SPIN_LOCK_UNLOCKED;
+
+#define LCM_ALC_EN	0x8000
+
+void frontlight_set(struct locomo *lchip, int duty, int vr, int bpwf)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&fl_lock, flags);
+	locomo_writel(bpwf, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
+	udelay(100);
+	locomo_writel(duty, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALD);
+	locomo_writel(bpwf | LCM_ALC_EN, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
+	spin_unlock_irqrestore(&fl_lock, flags);
+}
+
+
 /**
  *	locomo_probe - probe for a single LoCoMo chip.
  *	@phys_addr: physical address of device.
@@ -690,6 +707,11 @@ __locomo_probe(struct device *me, struct
 	/* FrontLight */
 	locomo_writel(0, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
 	locomo_writel(0, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALD);
+
+	/* Same constants can be used for collie and poodle
+	   (depending on CONFIG options in original sharp code)? */
+	frontlight_set(lchip, 163, 0, 148);
+
 	/* Longtime timer */
 	locomo_writel(0, lchip->base + LOCOMO_LTINT);
 	/* SPI */

-- 
Thanks, Sharp!
