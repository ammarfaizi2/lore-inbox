Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751518AbWBCXFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbWBCXFb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 18:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWBCXFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 18:05:31 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:63125 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751513AbWBCXFa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 18:05:30 -0500
Subject: [PATCH -mm] cleanup register clocksource
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 03 Feb 2006 15:05:28 -0800
Message-Id: <1139007928.10057.136.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a tweaked patch from Paul that got dropped while the timekeeping
code was out of -mm:

Currently register_clocksource() is a bit unconventional in that it's
currently void, which has to be a first for kernel register_xxx()
routines. Additionally, register_clocksource() _can_ fail, and
essentially every caller of it has an int return type anyways, so it
doesn't make much sense to lie about it.

The other issue is that the clocksource documentation is wrong, the
example won't compile, defines everything as non-static, and the
initcall is never flagged as __init.

Also fixes a "teh" typo in a comment.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: John Stultz <johnstul@us.ibm.com>

---

 Documentation/timekeeping.txt |   25 +++++++++++--------------
 arch/i386/kernel/hpet.c       |    4 +---
 arch/i386/kernel/i8253.c      |    4 +---
 arch/i386/kernel/tsc.c        |    2 +-
 drivers/clocksource/acpi_pm.c |    4 +---
 drivers/clocksource/cyclone.c |    4 +---
 include/linux/clocksource.h   |    2 +-
 include/linux/time.h          |    2 +-
 kernel/time/clocksource.c     |   15 +++++++++++----
 kernel/time/jiffies.c         |    4 +---
 kernel/time/timeofday.c       |    2 +-
 11 files changed, 31 insertions(+), 37 deletions(-)


diff --git a/Documentation/timekeeping.txt b/Documentation/timekeeping.txt
index 255fd56..6518572 100644
--- a/Documentation/timekeeping.txt
+++ b/Documentation/timekeeping.txt
@@ -304,31 +304,28 @@ So lets start out an empty cool-counter.
 #define COOL_READ_PTR	0xFEEDF000
 #define COOL_START_PTR	0xFEEDF0F0
 
-static __iomem *cool_ptr = COOL_READ_PTR;
+static __iomem void *cool_ptr = (void*)COOL_READ_PTR;
 
-struct clocksource clocksource_cool
-{
+static struct clocksource clocksource_cool = {
 	.name = "cool",
 	.rating = 200,		/* its a pretty decent clock */
 	.mask = 0xFFFFFFFF,	/* 32 bits */
-	.mult = 0,			/*to be computed */
+	.mult = 0,		/*to be computed */
 	.shift = 10,
-}
-
+};
 
-Now let's write the read function:
+/* Now let's create the read function: */
 
-cycle_t cool_counter_read(void)
+static cycle_t cool_counter_read(void)
 {
-	cycle_t ret = readl(cool_ptr);
-	return ret;
+	return (cycle_t)readl(cool_ptr);
 }
 
-Finally, lets write the init function:
+/* Finally, lets create the init function: */
 
-void cool_counter_init(void)
+static int __init cool_counter_init(void)
 {
-	__iomem *ptr = COOL_START_PTR;
+	__iomem void *ptr = (void*)COOL_START_PTR;
 	u32 val;
 
 	/* start the counter */
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
index 51671dc..e0e30c2 100644
--- a/arch/i386/kernel/tsc.c
+++ b/arch/i386/kernel/tsc.c
@@ -419,7 +413,7 @@ static int __init init_tsc_clocksource(v
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
 
diff --git a/include/linux/time.h b/include/linux/time.h
index 037aefc..440a277 100644
--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -28,7 +28,7 @@ struct timezone {
 #ifdef __KERNEL__
 
 /* timeofday base types */
-typedef s64 nsec_t;
+typedef s64 nsec_t;  /* Large enough for 292+ years  */
 typedef u64 cycle_t;
 
 /* Parameters used to convert the timespec values: */
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 9e7f064..d2ce2c3 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -66,6 +66,8 @@ late_initcall(clocksource_done_booting);
 
 /**
  * get_next_clocksource - Returns the selected clocksource
+ *
+ * Accessor for timeofday_periodic_hook.
  */
 struct clocksource *get_next_clocksource(void)
 {
@@ -88,7 +90,7 @@ struct clocksource *get_next_clocksource
  *
  * Looks through the list of registered clocksources, returning
  * the one with the highest rating value. If there is a clocksource
- * name that matches the override string, return that clocksource.
+ * name that matches the override string, it returns that clocksource.
  */
 static struct clocksource *select_clocksource(void)
 {
@@ -143,16 +145,20 @@ static int is_registered_source(struct c
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
 	unsigned long flags;
 
 	spin_lock_irqsave(&clocksource_lock, flags);
 	/* check if clocksource is already registered */
 	if (is_registered_source(c)) {
-		printk("register_clocksource(%s): already registered!",
-		       c->name);
+		printk("register_clocksource: Cannot register %s. "
+			"Already registered!", c->name);
+		ret = -EBUSY;
 	} else {
 		/* register it */
  		list_add(&c->list, &clocksource_list);
@@ -160,6 +166,7 @@ void register_clocksource(struct clockso
 		next_clocksource = select_clocksource();
 	}
 	spin_unlock_irqrestore(&clocksource_lock, flags);
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
diff --git a/kernel/time/timeofday.c b/kernel/time/timeofday.c
index 63c181c..d37161e 100644
--- a/kernel/time/timeofday.c
+++ b/kernel/time/timeofday.c
@@ -50,7 +50,7 @@ static ktime_t system_time;
 static ktime_t wall_time_offset;
 
 /* [timespec based variables]
- * These variables mirror teh ktime_t based variables to avoid
+ * These variables mirror the ktime_t based variables to avoid
  * performance issues in the userspace syscall paths.
  *
  * wall_time_ts:


