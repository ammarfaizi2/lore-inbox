Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbWAXBa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbWAXBa3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 20:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbWAXBa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 20:30:29 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:60564 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030288AbWAXBa2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 20:30:28 -0500
Subject: [PATCH -mm] Time: cleanup register_clocksource()
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mundt <lethal@linux-sh.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 17:30:24 -0800
Message-Id: <1138066224.15682.65.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently register_clocksource() is a bit unconventional in that it's
currently void, which has to be a first for kernel register_xxx()
routines. Additionally, register_clocksource() _can_ fail, and
essentially every caller of it has an int return type anyways, so it
doesn't make much sense to lie about it.

The other issue is that the clocksource documentation is wrong, the
example won't compile, defines everything as non-static, and the
initcall is never flagged as __init.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: John Stultz <johnstul@us.ibm.com>

---

 Documentation/timekeeping.txt |   15 ++++++---------
 arch/i386/kernel/hpet.c       |    4 +---
 arch/i386/kernel/i8253.c      |    4 +---
 arch/i386/kernel/tsc.c        |    2 +-
 drivers/clocksource/acpi_pm.c |    4 +---
 drivers/clocksource/cyclone.c |    4 +---
 include/linux/clocksource.h   |    2 +-
 kernel/time/clocksource.c     |    8 +++++++-
 kernel/time/jiffies.c         |    4 +---
 9 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/Documentation/timekeeping.txt b/Documentation/timekeeping.txt
index 255fd56..9a4edf2 100644
--- a/Documentation/timekeeping.txt
+++ b/Documentation/timekeeping.txt
@@ -306,27 +306,24 @@ So lets start out an empty cool-counter.
 
 static __iomem *cool_ptr = COOL_READ_PTR;
 
-struct clocksource clocksource_cool
-{
+static struct clocksource clocksource_cool = {
 	.name = "cool",
 	.rating = 200,		/* its a pretty decent clock */
 	.mask = 0xFFFFFFFF,	/* 32 bits */
 	.mult = 0,			/*to be computed */
 	.shift = 10,
-}
-
+};
 
 Now let's write the read function:
 
-cycle_t cool_counter_read(void)
+static cycle_t cool_counter_read(void)
 {
-	cycle_t ret = readl(cool_ptr);
-	return ret;
+	return (cycle_t)readl(cool_ptr);
 }
 
 Finally, lets write the init function:
 
-void cool_counter_init(void)
+static int __init cool_counter_init(void)
 {
 	__iomem *ptr = COOL_START_PTR;
 	u32 val;
@@ -342,7 +339,7 @@ void cool_counter_init(void)
 					clocksource_cool.shift);
 
 	/* register the clocksource */
-	register_clocksource(&clocksource_cool);
+	return register_clocksource(&clocksource_cool);
 }
 module_init(cool_counter_init);
 
diff --git a/arch/i386/kernel/hpet.c b/arch/i386/kernel/hpet.c
index a620d15..61d8cd2 100644
--- a/arch/i386/kernel/hpet.c
+++ b/arch/i386/kernel/hpet.c
@@ -61,9 +61,7 @@ static int __init init_hpet_clocksource(
 	do_div(tmp, FSEC_PER_NSEC);
 	clocksource_hpet.mult = (u32)tmp;
 
-	register_clocksource(&clocksource_hpet);
-
-	return 0;
+	return register_clocksource(&clocksource_hpet);
 }
 
 module_init(init_hpet_clocksource);
diff --git a/arch/i386/kernel/i8253.c b/arch/i386/kernel/i8253.c
index 65917f9..cce0eb6 100644
--- a/arch/i386/kernel/i8253.c
+++ b/arch/i386/kernel/i8253.c
@@ -84,8 +84,6 @@ static int __init init_pit_clocksource(v
 		return 0;
 
 	clocksource_pit.mult = clocksource_hz2mult(CLOCK_TICK_RATE, 20);
-	register_clocksource(&clocksource_pit);
-
-	return 0;
+	return register_clocksource(&clocksource_pit);
 }
 module_init(init_pit_clocksource);
diff --git a/arch/i386/kernel/tsc.c b/arch/i386/kernel/tsc.c
index 7e72219..e0e30c2 100644
--- a/arch/i386/kernel/tsc.c
+++ b/arch/i386/kernel/tsc.c
@@ -413,7 +413,7 @@ static int __init init_tsc_clocksource(v
 		/* lower the rating if we already know its unstable: */
 		if (check_tsc_unstable())
 			clocksource_tsc.rating = 50;
-		register_clocksource(&clocksource_tsc);
+		return register_clocksource(&clocksource_tsc);
 	}
 
 	return 0;
diff --git a/drivers/clocksource/acpi_pm.c b/drivers/clocksource/acpi_pm.c
index e5bc091..7aeef22 100644
--- a/drivers/clocksource/acpi_pm.c
+++ b/drivers/clocksource/acpi_pm.c
@@ -115,9 +115,7 @@ pm_good:
 		clocksource_acpi_pm.rating = 110;
 	}
 
-	register_clocksource(&clocksource_acpi_pm);
-
-	return 0;
+	return register_clocksource(&clocksource_acpi_pm);
 }
 
 module_init(init_acpi_pm_clocksource);
diff --git a/drivers/clocksource/cyclone.c b/drivers/clocksource/cyclone.c
index 168e78b..c873263 100644
--- a/drivers/clocksource/cyclone.c
+++ b/drivers/clocksource/cyclone.c
@@ -113,9 +113,7 @@ static int __init init_cyclone_clocksour
 	clocksource_cyclone.mult = clocksource_hz2mult(CYCLONE_TIMER_FREQ,
 						clocksource_cyclone.shift);
 
-	register_clocksource(&clocksource_cyclone);
-
-	return 0;
+	return register_clocksource(&clocksource_cyclone);
 }
 
 module_init(init_cyclone_clocksource);
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 5a3d6c3..f6dde25 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -297,7 +297,7 @@ static inline nsec_t cyc2ns_fixed_rem(st
 }
 
 /* used to install a new clocksource */
-void register_clocksource(struct clocksource*);
+int register_clocksource(struct clocksource*);
 void reselect_clocksource(void);
 struct clocksource* get_next_clocksource(void);
 
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 65e00b7..d62cff0 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -138,21 +138,27 @@ static int is_registered_source(struct c
 /**
  * register_clocksource - Used to install new clocksources
  * @t:		clocksource to be registered
+ *
+ * Returns -EBUSY if registration fails, zero otherwise.
  */
-void register_clocksource(struct clocksource *c)
+int register_clocksource(struct clocksource *c)
 {
+	int ret = 0;
+
 	spin_lock(&clocksource_lock);
 
 	/* check if clocksource is already registered */
 	if (is_registered_source(c)) {
 		printk("register_clocksource: Cannot register %s. Already registered!",
 		       c->name);
+		ret = -EBUSY;
 	} else {
 		list_add(&c->list, &clocksource_list);
 		/* select next clocksource */
 		next_clocksource = select_clocksource();
 	}
 	spin_unlock(&clocksource_lock);
+	return ret;
 }
 
 EXPORT_SYMBOL(register_clocksource);
diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index 4f0bdd4..3a8ea42 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -67,9 +67,7 @@ struct clocksource clocksource_jiffies =
 
 static int __init init_jiffies_clocksource(void)
 {
-	register_clocksource(&clocksource_jiffies);
-
-	return 0;
+	return register_clocksource(&clocksource_jiffies);
 }
 
 module_init(init_jiffies_clocksource);


