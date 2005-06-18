Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVFRDAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVFRDAi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 23:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVFRDAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 23:00:38 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:2961 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261433AbVFRC6K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 22:58:10 -0400
Subject: [PATCH 2/6] new timeofday i386 arch specific changes, part 1 for
	-mm (v.B3)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <darren@dvhart.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org, kernel-stuff@comcast.net, frank@tuxrocks.com
In-Reply-To: <1119063400.9663.2.camel@cog.beaverton.ibm.com>
References: <1119063400.9663.2.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 17 Jun 2005 19:58:04 -0700
Message-Id: <1119063484.9663.4.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, All,
	To hopefully improve the review-ability of my changes, I've split up my
arch-i386 patch into four chunks. This patch is just a simple cleanup
for the i386 arch in preparation of moving the the new timeofday
infrastructure. It simply moves some code from timer_pit.c to i8259.c.
	
It applies on top of my timeofday-core_B3 patch. This patch is part the
timeofday-arch-i386 patchset, so without the following parts it is not
expected to compile (although just this one should).
	
Andrew, please consider for inclusion for testing into your tree.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

linux-2.6.12-rc6-mm1_timeofday-arch-i386-part1_B3.patch
=======================================================
diff -ruN linux-2.6.12-rc6-mm1/arch/i386/kernel/i8259.c linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/i8259.c
--- linux-2.6.12-rc6-mm1/arch/i386/kernel/i8259.c	2005-06-17 15:56:27.000000000 -0700
+++ linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/i8259.c	2005-06-17 18:28:05.576479704 -0700
@@ -400,6 +400,46 @@
 	}
 }
 
+void setup_pit_timer(void)
+{
+	extern spinlock_t i8253_lock;
+	unsigned long flags;
+
+	spin_lock_irqsave(&i8253_lock, flags);
+	outb_p(0x34,PIT_MODE);		/* binary, mode 2, LSB/MSB, ch 0 */
+	udelay(10);
+	outb_p(LATCH & 0xff , PIT_CH0);	/* LSB */
+	udelay(10);
+	outb(LATCH >> 8 , PIT_CH0);	/* MSB */
+	spin_unlock_irqrestore(&i8253_lock, flags);
+}
+
+static int timer_resume(struct sys_device *dev)
+{
+	setup_pit_timer();
+	return 0;
+}
+
+static struct sysdev_class timer_sysclass = {
+	set_kset_name("timer_pit"),
+	.resume	= timer_resume,
+};
+
+static struct sys_device device_timer = {
+	.id	= 0,
+	.cls	= &timer_sysclass,
+};
+
+static int __init init_timer_sysfs(void)
+{
+	int error = sysdev_class_register(&timer_sysclass);
+	if (!error)
+		error = sysdev_register(&device_timer);
+	return error;
+}
+
+device_initcall(init_timer_sysfs);
+
 void __init init_IRQ(void)
 {
 	int i;
diff -ruN linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/timer_pit.c linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/timers/timer_pit.c
--- linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/timer_pit.c	2005-06-17 15:56:27.000000000 -0700
+++ linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/timers/timer_pit.c	2005-06-17 18:28:05.586478462 -0700
@@ -163,44 +163,3 @@
 	.init = init_pit, 
 	.opts = &timer_pit,
 };
-
-void setup_pit_timer(void)
-{
-	extern spinlock_t i8253_lock;
-	unsigned long flags;
-
-	spin_lock_irqsave(&i8253_lock, flags);
-	outb_p(0x34,PIT_MODE);		/* binary, mode 2, LSB/MSB, ch 0 */
-	udelay(10);
-	outb_p(LATCH & 0xff , PIT_CH0);	/* LSB */
-	udelay(10);
-	outb(LATCH >> 8 , PIT_CH0);	/* MSB */
-	spin_unlock_irqrestore(&i8253_lock, flags);
-}
-
-static int timer_resume(struct sys_device *dev)
-{
-	setup_pit_timer();
-	return 0;
-}
-
-static struct sysdev_class timer_sysclass = {
-	set_kset_name("timer_pit"),
-	.resume	= timer_resume,
-};
-
-static struct sys_device device_timer = {
-	.id	= 0,
-	.cls	= &timer_sysclass,
-};
-
-static int __init init_timer_sysfs(void)
-{
-	int error = sysdev_class_register(&timer_sysclass);
-	if (!error)
-		error = sysdev_register(&device_timer);
-	return error;
-}
-
-device_initcall(init_timer_sysfs);
-


