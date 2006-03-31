Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWCaIYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWCaIYE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 03:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWCaIYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 03:24:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19167 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751263AbWCaIYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 03:24:03 -0500
Date: Fri, 31 Mar 2006 10:23:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Bompart Cedric <cedric.bompart@thales-is.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Hook collie frontlight into sysfs
Message-ID: <20060331082352.GF1663@elf.ucw.cz>
References: <6CE648B340455F479A7AE27769282663018A276F@gva0013.ch.intra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6CE648B340455F479A7AE27769282663018A276F@gva0013.ch.intra>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> During our test with Richard, we've been thinking can you implement the
> full range of brightness intensity values? For example for the others
> Zaurus, I think the range is between 0 and 63. So the userspace can

Well, I'm not sure if other values are "legal". They could damage
frontlight long-term or just eat too much power...

> adjust a wider range of levels for the backlight. Another thing, I
> didn't see anything different visually between the value 3 and 4.

You are right, the code to go brightness 4 is attached. It probably
needs to be converted to writel/readl...

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index 8c53ebc..bcce028 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -1046,13 +1046,46 @@ void locomo_m62332_senddata(struct locom
  *	Frontlight control
  */
 
+#define LOCOMO_GPIO9        (1<<9)
+
+#ifdef DONE
+/* Should be same for collie and poodle */
+static int poodlefl_enable_accel(void)
+{
+	if (!(LOCOMO_GPO & LOCOMO_GPIO9)) {
+		LOCOMO_GPD &= ~LOCOMO_GPIO9;
+		LOCOMO_GPE &= ~LOCOMO_GPIO9;
+		LOCOMO_GPO |=  LOCOMO_GPIO9;
+	}
+	return 0;
+}
+
+/* Should be same for collie and poodle */
+static int poodlefl_disable_accel(void)
+{
+	if (LOCOMO_GPO & LOCOMO_GPIO9) {
+	        LOCOMO_GPD &= ~LOCOMO_GPIO9;
+		LOCOMO_GPE &= ~LOCOMO_GPIO9;
+		LOCOMO_GPO &= ~LOCOMO_GPIO9;
+	}
+	return 0;
+}
+#endif
+
 static struct locomo *locomo_chip_driver(struct locomo_dev *ldev);
 
+#define LOCOMO_ALC_EN	0x8000
+
 void locomo_frontlight_set(struct locomo_dev *dev, int duty, int vr, int bpwf)
 {
 	unsigned long flags;
 	struct locomo *lchip = locomo_chip_driver(dev);
 
+#ifdef DONE
+	if (vr) poodlefl_enable_accel();
+	else 	poodlefl_disable_accel();
+#endif
+
 	spin_lock_irqsave(&lchip->lock, flags);
 	locomo_writel(bpwf, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
 	udelay(100);

								Pavel
-- 
Picture of sleeping (Linux) penguin wanted...
