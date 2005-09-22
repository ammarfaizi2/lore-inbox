Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030394AbVIVPIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030394AbVIVPIu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 11:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030395AbVIVPIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 11:08:50 -0400
Received: from mailgate2.urz.uni-halle.de ([141.48.3.8]:46507 "EHLO
	mailgate2.uni-halle.de") by vger.kernel.org with ESMTP
	id S1030394AbVIVPIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 11:08:48 -0400
Date: Thu, 22 Sep 2005 17:08:41 +0200 (MEST)
From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 2/2] HPET: make frequency calculations 32 bit safe
In-reply-to: <20050922150832.21412.18884.balrog@ifiu24.informatik.uni-halle.de>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Clemens Ladisch <clemens@ladisch.de>,
       Bob Picco <robert.picco@hp.com>
Message-id: <20050922150841.21412.65581.balrog@ifiu24.informatik.uni-halle.de>
Content-transfer-encoding: 7BIT
References: <20050922150832.21412.18884.balrog@ifiu24.informatik.uni-halle.de>
X-Scan-Signature: 592cb73b4abb271c9ba586ac5f90193c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 32-bit architectures, the multiplication in the argument for
hpet_time_div() often overflows.  In the typical case of a 14.32 MHz
timer, this happens when the desired frequency exceeds 61 Hz.

To avoid this multiplication, we can precompute and store the hardware
timer frequency, instead of the period, in the device structure, which
leaves us with a simple division when computing the number of timer
ticks.

As a side effect, this also removes a theoretical bug where the timer
interpolator's frequency would be computed as a 32-bit value even if
the HPET frequency is greater than 2^32 Hz (the HPET spec allows up to
10 GHz).

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

--- linux-2.6.13.orig/drivers/char/hpet.c	2005-09-22 11:10:01.000000000 +0200
+++ linux-2.6.13/drivers/char/hpet.c	2005-09-22 12:08:48.000000000 +0200
@@ -78,7 +78,7 @@ struct hpets {
 	struct hpet __iomem *hp_hpet;
 	unsigned long hp_hpet_phys;
 	struct time_interpolator *hp_interpolator;
-	unsigned long hp_period;
+	unsigned long long hp_tick_freq;
 	unsigned long hp_delta;
 	unsigned int hp_ntimer;
 	unsigned int hp_which;
@@ -427,12 +427,14 @@ static int hpet_ioctl_ieon(struct hpet_d
 	return 0;
 }
 
-static inline unsigned long hpet_time_div(unsigned long dis)
+/* converts Hz to number of timer ticks */
+static inline unsigned long hpet_time_div(struct hpets *hpets,
+					  unsigned long dis)
 {
-	unsigned long long m = 1000000000000000ULL;
+	unsigned long long m;
 
+	m = hpets->hp_tick_freq + (dis >> 1);
 	do_div(m, dis);
-
 	return (unsigned long)m;
 }
 
@@ -480,7 +482,7 @@ hpet_ioctl_common(struct hpet_dev *devp,
 		{
 			struct hpet_info info;
 
-			info.hi_ireqfreq = hpet_time_div(hpetp->hp_period *
+			info.hi_ireqfreq = hpet_time_div(hpetp,
 							 devp->hd_ireqfreq);
 			info.hi_flags =
 			    readq(&timer->hpet_config) & Tn_PER_INT_CAP_MASK;
@@ -524,7 +526,7 @@ hpet_ioctl_common(struct hpet_dev *devp,
 			break;
 		}
 
-		devp->hd_ireqfreq = hpet_time_div(hpetp->hp_period * arg);
+		devp->hd_ireqfreq = hpet_time_div(hpetp, arg);
 	}
 
 	return err;
@@ -713,7 +715,7 @@ static void hpet_register_interpolator(s
 	ti->source = TIME_SOURCE_MMIO64;
 	ti->shift = 10;
 	ti->addr = &hpetp->hp_hpet->hpet_mc;
-	ti->frequency = hpet_time_div(hpets->hp_period);
+	ti->frequency = hpetp->hp_tick_freq;
 	ti->drift = ti->frequency * HPET_DRIFT / 1000000;
 	ti->mask = -1;
 
@@ -750,7 +752,7 @@ static unsigned long hpet_calibrate(stru
 	t = read_counter(&timer->hpet_compare);
 
 	i = 0;
-	count = hpet_time_div(hpetp->hp_period * TICK_CALIBRATE);
+	count = hpet_time_div(hpetp, TICK_CALIBRATE);
 
 	local_irq_save(flags);
 
@@ -775,7 +777,8 @@ int hpet_alloc(struct hpet_data *hdp)
 	size_t siz;
 	struct hpet __iomem *hpet;
 	static struct hpets *last = (struct hpets *)0;
-	unsigned long ns;
+	unsigned long ns, period;
+	unsigned long long temp;
 
 	/*
 	 * hpet_alloc can be called by platform dependent code.
@@ -825,8 +828,12 @@ int hpet_alloc(struct hpet_data *hdp)
 
 	last = hpetp;
 
-	hpetp->hp_period = (cap & HPET_COUNTER_CLK_PERIOD_MASK) >>
-	    HPET_COUNTER_CLK_PERIOD_SHIFT;
+	period = (cap & HPET_COUNTER_CLK_PERIOD_MASK) >>
+		HPET_COUNTER_CLK_PERIOD_SHIFT; /* fs, 10^-15 */
+	temp = 1000000000000000uLL; /* 10^15 femtoseconds per second */
+	temp += period >> 1; /* round */
+	do_div(temp, period);
+	hpetp->hp_tick_freq = temp; /* ticks per second */
 
 	printk(KERN_INFO "hpet%d: at MMIO 0x%lx, IRQ%s",
 		hpetp->hp_which, hdp->hd_phys_address,
@@ -835,8 +842,7 @@ int hpet_alloc(struct hpet_data *hdp)
 		printk("%s %d", i > 0 ? "," : "", hdp->hd_irq[i]);
 	printk("\n");
 
-	ns = hpetp->hp_period;	/* femptoseconds, 10^-15 */
-	ns /= 1000000;		/* convert to nanoseconds, 10^-9 */
+	ns = period / 1000000;	/* convert to nanoseconds, 10^-9 */
 	printk(KERN_INFO "hpet%d: %ldns tick, %d %d-bit timers\n",
 		hpetp->hp_which, ns, hpetp->hp_ntimer,
 		cap & HPET_COUNTER_SIZE_MASK ? 64 : 32);
