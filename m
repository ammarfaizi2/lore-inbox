Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbUKMXXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbUKMXXT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 18:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbUKMXXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 18:23:19 -0500
Received: from hera.cwi.nl ([192.16.191.8]:53140 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261200AbUKMXWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 18:22:12 -0500
Date: Sun, 14 Nov 2004 00:22:05 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org, akpm@osdl.org
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, linux-kernel@vger.kernel.org
Subject: [PATCH] __init and i386 timers
Message-ID: <20041113232203.GA23484@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The i386 timers use a struct timer_opts that has a field init
pointing at a __init function. The rest of the struct is not __init.

Nothing is wrong, but if we want to avoid having references to init stuff
in non-init sections, some reshuffling is needed.

The below replaces

struct timer_opts {
	int (*init)(char *override);
	... more ...
};

by the two structs

struct timer_opts {
	... more ...
};

struct init_time_opts {
	int (*init)(char *override);
	struct timer_opts *opts;
};

where the second is __initdata.

Andries

diff -uprN -X /linux/dontdiff a/arch/i386/kernel/timers/timer.c b/arch/i386/kernel/timers/timer.c
--- a/arch/i386/kernel/timers/timer.c	2004-03-28 17:11:38.000000000 +0200
+++ b/arch/i386/kernel/timers/timer.c	2004-11-14 00:14:31.000000000 +0100
@@ -12,18 +12,18 @@
  */
 #endif
 /* list of timers, ordered by preference, NULL terminated */
-static struct timer_opts* timers[] = {
+static struct init_timer_opts* __initdata timers[] = {
 #ifdef CONFIG_X86_CYCLONE_TIMER
-	&timer_cyclone,
+	&timer_cyclone_init,
 #endif
 #ifdef CONFIG_HPET_TIMER
-	&timer_hpet,
+	&timer_hpet_init,
 #endif
 #ifdef CONFIG_X86_PM_TIMER
-	&timer_pmtmr,
+	&timer_pmtmr_init,
 #endif
-	&timer_tsc,
-	&timer_pit,
+	&timer_tsc_init,
+	&timer_pit_init,
 	NULL,
 };
 
@@ -49,7 +49,7 @@ void clock_fallback(void)
 /* iterates through the list of timers, returning the first 
  * one that initializes successfully.
  */
-struct timer_opts* select_timer(void)
+struct timer_opts* __init select_timer(void)
 {
 	int i = 0;
 	
@@ -57,7 +57,7 @@ struct timer_opts* select_timer(void)
 	while (timers[i]) {
 		if (timers[i]->init)
 			if (timers[i]->init(clock_override) == 0)
-				return timers[i];
+				return timers[i]->opts;
 		++i;
 	}
 		
diff -uprN -X /linux/dontdiff a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/timers/timer_cyclone.c
--- a/arch/i386/kernel/timers/timer_cyclone.c	2004-06-24 17:11:11.000000000 +0200
+++ b/arch/i386/kernel/timers/timer_cyclone.c	2004-11-14 00:14:31.000000000 +0100
@@ -245,11 +245,15 @@ static void delay_cyclone(unsigned long 
 /************************************************************/
 
 /* cyclone timer_opts struct */
-struct timer_opts timer_cyclone = {
+static struct timer_opts timer_cyclone = {
 	.name = "cyclone",
-	.init = init_cyclone, 
 	.mark_offset = mark_offset_cyclone, 
 	.get_offset = get_offset_cyclone,
 	.monotonic_clock =	monotonic_clock_cyclone,
 	.delay = delay_cyclone,
 };
+
+struct init_timer_opts __initdata timer_cyclone_init = {
+	.init = init_cyclone,
+	.opts = &timer_cyclone,
+};
diff -uprN -X /linux/dontdiff a/arch/i386/kernel/timers/timer_hpet.c b/arch/i386/kernel/timers/timer_hpet.c
--- a/arch/i386/kernel/timers/timer_hpet.c	2004-01-11 14:20:48.000000000 +0100
+++ b/arch/i386/kernel/timers/timer_hpet.c	2004-11-14 00:14:31.000000000 +0100
@@ -177,11 +177,15 @@ static int __init init_hpet(char* overri
 /************************************************************/
 
 /* tsc timer_opts struct */
-struct timer_opts timer_hpet = {
+static struct timer_opts timer_hpet = {
 	.name = 		"hpet",
-	.init =			init_hpet,
 	.mark_offset =		mark_offset_hpet,
 	.get_offset =		get_offset_hpet,
 	.monotonic_clock =	monotonic_clock_hpet,
 	.delay = 		delay_hpet,
 };
+
+struct init_timer_opts __initdata timer_hpet_init = {
+	.init =	init_hpet,
+	.opts = &timer_hpet,
+};
diff -uprN -X /linux/dontdiff a/arch/i386/kernel/timers/timer_none.c b/arch/i386/kernel/timers/timer_none.c
--- a/arch/i386/kernel/timers/timer_none.c	2004-08-26 22:05:08.000000000 +0200
+++ b/arch/i386/kernel/timers/timer_none.c	2004-11-14 00:14:31.000000000 +0100
@@ -1,11 +1,6 @@
 #include <linux/init.h>
 #include <asm/timer.h>
 
-static int __init init_none(char* override)
-{
-	return 0;
-}
-
 static void mark_offset_none(void)
 {
 	/* nothing needed */
@@ -37,7 +32,6 @@ static void delay_none(unsigned long loo
 /* none timer_opts struct */
 struct timer_opts timer_none = {
 	.name = 	"none",
-	.init =		init_none, 
 	.mark_offset =	mark_offset_none, 
 	.get_offset =	get_offset_none,
 	.monotonic_clock =	monotonic_clock_none,
diff -uprN -X /linux/dontdiff a/arch/i386/kernel/timers/timer_pit.c b/arch/i386/kernel/timers/timer_pit.c
--- a/arch/i386/kernel/timers/timer_pit.c	2004-10-30 21:43:59.000000000 +0200
+++ b/arch/i386/kernel/timers/timer_pit.c	2004-11-14 00:14:31.000000000 +0100
@@ -152,14 +152,18 @@ static unsigned long get_offset_pit(void
 
 /* tsc timer_opts struct */
 struct timer_opts timer_pit = {
-	.name = 	"pit",
-	.init =		init_pit, 
-	.mark_offset =	mark_offset_pit, 
-	.get_offset =	get_offset_pit,
+	.name = "pit",
+	.mark_offset = mark_offset_pit, 
+	.get_offset = get_offset_pit,
 	.monotonic_clock = monotonic_clock_pit,
 	.delay = delay_pit,
 };
 
+struct init_timer_opts __initdata timer_pit_init = {
+	.init = init_pit, 
+	.opts = &timer_pit,
+};
+
 void setup_pit_timer(void)
 {
 	extern spinlock_t i8253_lock;
diff -uprN -X /linux/dontdiff a/arch/i386/kernel/timers/timer_pm.c b/arch/i386/kernel/timers/timer_pm.c
--- a/arch/i386/kernel/timers/timer_pm.c	2004-08-26 22:05:08.000000000 +0200
+++ b/arch/i386/kernel/timers/timer_pm.c	2004-11-14 00:14:50.000000000 +0100
@@ -240,15 +240,18 @@ static unsigned long get_offset_pmtmr(vo
 
 
 /* acpi timer_opts struct */
-struct timer_opts timer_pmtmr = {
+static struct timer_opts timer_pmtmr = {
 	.name			= "pmtmr",
-	.init 			= init_pmtmr,
 	.mark_offset		= mark_offset_pmtmr,
 	.get_offset		= get_offset_pmtmr,
 	.monotonic_clock 	= monotonic_clock_pmtmr,
 	.delay 			= delay_pmtmr,
 };
 
+struct init_timer_opts __initdata timer_pmtmr_init = {
+	.init = init_pmtmr,
+	.opts = &timer_pmtmr,
+};
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
diff -uprN -X /linux/dontdiff a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	2004-10-30 21:43:59.000000000 +0200
+++ b/arch/i386/kernel/timers/timer_tsc.c	2004-11-14 00:14:31.000000000 +0100
@@ -28,7 +28,7 @@
 #ifdef CONFIG_HPET_TIMER
 static unsigned long hpet_usec_quotient;
 static unsigned long hpet_last;
-struct timer_opts timer_tsc;
+static struct timer_opts timer_tsc;
 #endif
 
 static inline void cpufreq_delayed_get(void);
@@ -546,11 +546,15 @@ __setup("notsc", tsc_setup);
 /************************************************************/
 
 /* tsc timer_opts struct */
-struct timer_opts timer_tsc = {
-	.name = 	"tsc",
-	.init =		init_tsc,
-	.mark_offset =	mark_offset_tsc, 
-	.get_offset =	get_offset_tsc,
-	.monotonic_clock =	monotonic_clock_tsc,
+static struct timer_opts timer_tsc = {
+	.name = "tsc",
+	.mark_offset = mark_offset_tsc, 
+	.get_offset = get_offset_tsc,
+	.monotonic_clock = monotonic_clock_tsc,
 	.delay = delay_tsc,
 };
+
+struct init_timer_opts __initdata timer_tsc_init = {
+	.init = init_tsc,
+	.opts = &timer_tsc,
+};
diff -uprN -X /linux/dontdiff a/include/asm-i386/timer.h b/include/asm-i386/timer.h
--- a/include/asm-i386/timer.h	2004-10-30 21:44:02.000000000 +0200
+++ b/include/asm-i386/timer.h	2004-11-14 00:14:31.000000000 +0100
@@ -1,5 +1,6 @@
 #ifndef _ASMi386_TIMER_H
 #define _ASMi386_TIMER_H
+#include <linux/init.h>
 
 /**
  * struct timer_ops - used to define a timer source
@@ -15,18 +16,22 @@
  *                   timer.
  * @delay: delays this many clock cycles.
  */
-struct timer_opts{
+struct timer_opts {
 	char* name;
-	int (*init)(char *override);
 	void (*mark_offset)(void);
 	unsigned long (*get_offset)(void);
 	unsigned long long (*monotonic_clock)(void);
 	void (*delay)(unsigned long);
 };
 
+struct init_timer_opts {
+	int (*init)(char *override);
+	struct timer_opts *opts;
+};
+
 #define TICK_SIZE (tick_nsec / 1000)
 
-extern struct timer_opts* select_timer(void);
+extern struct timer_opts* __init select_timer(void);
 extern void clock_fallback(void);
 void setup_pit_timer(void);
 
@@ -40,19 +45,20 @@ extern int timer_ack;
 /* list of externed timers */
 extern struct timer_opts timer_none;
 extern struct timer_opts timer_pit;
-extern struct timer_opts timer_tsc;
+extern struct init_timer_opts timer_pit_init;
+extern struct init_timer_opts timer_tsc_init;
 #ifdef CONFIG_X86_CYCLONE_TIMER
-extern struct timer_opts timer_cyclone;
+extern struct init_timer_opts timer_cyclone_init;
 #endif
 
 extern unsigned long calibrate_tsc(void);
 extern void init_cpu_khz(void);
 #ifdef CONFIG_HPET_TIMER
-extern struct timer_opts timer_hpet;
+extern struct init_timer_opts timer_hpet_init;
 extern unsigned long calibrate_tsc_hpet(unsigned long *tsc_hpet_quotient_ptr);
 #endif
 
 #ifdef CONFIG_X86_PM_TIMER
-extern struct timer_opts timer_pmtmr;
+extern struct init_timer_opts timer_pmtmr_init;
 #endif
 #endif
