Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262094AbTCLXYM>; Wed, 12 Mar 2003 18:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262112AbTCLXYM>; Wed, 12 Mar 2003 18:24:12 -0500
Received: from air-2.osdl.org ([65.172.181.6]:58589 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262094AbTCLXYH>;
	Wed, 12 Mar 2003 18:24:07 -0500
Date: Wed, 12 Mar 2003 15:32:27 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] OOPS counters
Message-Id: <20030312153227.1f027efe.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.30.0303120622290.15538-100000@divine.city.tvnet.hu>
References: <b4lvk2$vcd$1@cesium.transmeta.com>
	<Pine.LNX.4.30.0303120622290.15538-100000@divine.city.tvnet.hu>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Mar 2003 07:07:26 +0100 (MET) Szakacsits Szabolcs <szaka@sienet.hu> wrote:

| And in general, an oops counter would be also useful, not spending too
| much time decoding potentialy bogus oopses.

Hi,

This patch (to 2.5.64) adds an Oops counter to all die() and __die()
functions that I could find and prints the counter on each Oops: message
that looks like so (the "[#n]" part):

Oops: 0002 [#2]

Comments?

--
~Randy


patch_name:	oops_counter.patch
patch_version:	2003-03-12.14:50:05
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	Add an Oops counter to oops messages.
product:	Linux
product_versions: 2.5.64
changelog:	Add an oops counter message in all die() or __die() functions.
diffstat:	=
 arch/arm/kernel/traps.c    |    3 ++-
 arch/i386/kernel/traps.c   |    3 ++-
 arch/ia64/kernel/traps.c   |    4 +++-
 arch/mips/kernel/traps.c   |    3 ++-
 arch/mips64/kernel/traps.c |    3 ++-
 arch/ppc/kernel/traps.c    |    3 ++-
 arch/ppc64/kernel/traps.c  |    3 ++-
 arch/s390/kernel/traps.c   |    3 ++-
 arch/s390x/kernel/traps.c  |    3 ++-
 arch/sh/kernel/traps.c     |    3 ++-
 arch/x86_64/kernel/traps.c |    3 ++-
 11 files changed, 23 insertions(+), 11 deletions(-)


diff -Naur ./arch/ppc/kernel/traps.c%OOPSC ./arch/ppc/kernel/traps.c
--- ./arch/ppc/kernel/traps.c%OOPSC	Tue Mar  4 19:29:03 2003
+++ ./arch/ppc/kernel/traps.c	Wed Mar 12 14:48:47 2003
@@ -86,13 +86,14 @@
 
 void die(const char * str, struct pt_regs * fp, long err)
 {
+	static int die_counter = 0;
 	console_verbose();
 	spin_lock_irq(&die_lock);
 #ifdef CONFIG_PMAC_BACKLIGHT
 	set_backlight_enable(1);
 	set_backlight_level(BACKLIGHT_MAX);
 #endif
-	printk("Oops: %s, sig: %ld\n", str, err);
+	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
 	show_regs(fp);
 	spin_unlock_irq(&die_lock);
 	/* do_exit() should take care of panic'ing from an interrupt
diff -Naur ./arch/i386/kernel/traps.c%OOPSC ./arch/i386/kernel/traps.c
--- ./arch/i386/kernel/traps.c%OOPSC	Tue Mar  4 19:29:01 2003
+++ ./arch/i386/kernel/traps.c	Wed Mar 12 13:10:33 2003
@@ -247,11 +247,12 @@
 
 void die(const char * str, struct pt_regs * regs, long err)
 {
+	static int die_counter = 0;
 	console_verbose();
 	spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
 	handle_BUG(regs);
-	printk("%s: %04lx\n", str, err & 0xffff);
+	printk("%s: %04lx [#%d]\n", str, err & 0xffff, ++die_counter);
 	show_registers(regs);
 	bust_spinlocks(0);
 	spin_unlock_irq(&die_lock);
diff -Naur ./arch/mips/kernel/traps.c%OOPSC ./arch/mips/kernel/traps.c
--- ./arch/mips/kernel/traps.c%OOPSC	Tue Mar  4 19:29:17 2003
+++ ./arch/mips/kernel/traps.c	Wed Mar 12 14:38:40 2003
@@ -191,12 +191,13 @@
 extern void __die(const char * str, struct pt_regs * regs, const char *where,
                   unsigned long line)
 {
+	static int die_counter = 0;
 	console_verbose();
 	spin_lock_irq(&die_lock);
 	printk("%s", str);
 	if (where)
 		printk(" in %s, line %ld", where, line);
-	printk(":\n");
+	printk("[#%d]:\n", ++die_counter);
 	show_regs(regs);
 	printk("Process %s (pid: %d, stackpage=%08lx)\n",
 		current->comm, current->pid, (unsigned long) current);
diff -Naur ./arch/ppc64/kernel/traps.c%OOPSC ./arch/ppc64/kernel/traps.c
--- ./arch/ppc64/kernel/traps.c%OOPSC	Tue Mar  4 19:29:19 2003
+++ ./arch/ppc64/kernel/traps.c	Wed Mar 12 14:47:46 2003
@@ -62,10 +62,11 @@
 
 void die(const char *str, struct pt_regs *regs, long err)
 {
+	static int die_counter = 0;
 	console_verbose();
 	spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
-	printk("Oops: %s, sig: %ld\n", str, err);
+	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
 	show_regs(regs);
 	bust_spinlocks(0);
 	spin_unlock_irq(&die_lock);
diff -Naur ./arch/mips64/kernel/traps.c%OOPSC ./arch/mips64/kernel/traps.c
--- ./arch/mips64/kernel/traps.c%OOPSC	Tue Mar  4 19:29:30 2003
+++ ./arch/mips64/kernel/traps.c	Wed Mar 12 14:47:11 2003
@@ -161,12 +161,13 @@
 
 void die(const char * str, struct pt_regs * regs, unsigned long err)
 {
+	static int die_counter = 0;
 	if (user_mode(regs))	/* Just return if in user mode.  */
 		return;
 
 	console_verbose();
 	spin_lock_irq(&die_lock);
-	printk("%s: %04lx\n", str, err & 0xffff);
+	printk("%s: %04lx [#%d]\n", str, err & 0xffff, ++die_counter);
 	show_regs(regs);
 	printk("Process %s (pid: %d, stackpage=%08lx)\n",
 		current->comm, current->pid, (unsigned long) current);
diff -Naur ./arch/ia64/kernel/traps.c%OOPSC ./arch/ia64/kernel/traps.c
--- ./arch/ia64/kernel/traps.c%OOPSC	Tue Mar  4 19:29:52 2003
+++ ./arch/ia64/kernel/traps.c	Wed Mar 12 14:46:28 2003
@@ -101,6 +101,7 @@
 		.lock_owner =		-1,
 		.lock_owner_depth =	0
 	};
+	static int die_counter = 0;
 
 	if (die.lock_owner != smp_processor_id()) {
 		console_verbose();
@@ -111,7 +112,8 @@
 	}
 
 	if (++die.lock_owner_depth < 3) {
-		printk("%s[%d]: %s %ld\n", current->comm, current->pid, str, err);
+		printk("%s[%d]: %s %ld [%d]\n",
+			current->comm, current->pid, str, err, ++die_counter);
 		show_regs(regs);
   	} else
 		printk(KERN_ERR "Recursive die() failure, output suppressed\n");
diff -Naur ./arch/arm/kernel/traps.c%OOPSC ./arch/arm/kernel/traps.c
--- ./arch/arm/kernel/traps.c%OOPSC	Tue Mar  4 19:29:17 2003
+++ ./arch/arm/kernel/traps.c	Wed Mar 12 14:45:13 2003
@@ -208,12 +208,13 @@
 NORET_TYPE void die(const char *str, struct pt_regs *regs, int err)
 {
 	struct task_struct *tsk = current;
+	static int die_counter = 0;
 
 	console_verbose();
 	spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
 
-	printk("Internal error: %s: %x\n", str, err);
+	printk("Internal error: %s: %x [#%d]\n", str, err, ++die_counter);
 	print_modules();
 	printk("CPU: %d\n", smp_processor_id());
 	show_regs(regs);
diff -Naur ./arch/x86_64/kernel/traps.c%OOPSC ./arch/x86_64/kernel/traps.c
--- ./arch/x86_64/kernel/traps.c%OOPSC	Tue Mar  4 19:28:53 2003
+++ ./arch/x86_64/kernel/traps.c	Wed Mar 12 14:44:07 2003
@@ -325,11 +325,12 @@
 {
 	int cpu;
 	struct die_args args = { regs, str, err };
+	static int die_counter = 0;
 	console_verbose();
 	notifier_call_chain(&die_chain,  DIE_DIE, &args); 
 	bust_spinlocks(1);
 	handle_BUG(regs); 
-	printk("%s: %04lx\n", str, err & 0xffff);
+	printk("%s: %04lx [#%d]\n", str, err & 0xffff, ++die_counter);
 	cpu = safe_smp_processor_id(); 
 	/* racy, but better than risking deadlock. */ 
 	local_irq_disable();
diff -Naur ./arch/s390x/kernel/traps.c%OOPSC ./arch/s390x/kernel/traps.c
--- ./arch/s390x/kernel/traps.c%OOPSC	Tue Mar  4 19:29:32 2003
+++ ./arch/s390x/kernel/traps.c	Wed Mar 12 14:43:29 2003
@@ -228,10 +228,11 @@
 
 void die(const char * str, struct pt_regs * regs, long err)
 {
+	static int die_counter = 0;
         console_verbose();
         spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
-        printk("%s: %04lx\n", str, err & 0xffff);
+	printk("%s: %04lx [#%d]\n", str, err & 0xffff, ++die_counter);
         show_regs(regs);
 	bust_spinlocks(0);
         spin_unlock_irq(&die_lock);
diff -Naur ./arch/sh/kernel/traps.c%OOPSC ./arch/sh/kernel/traps.c
--- ./arch/sh/kernel/traps.c%OOPSC	Tue Mar  4 19:28:56 2003
+++ ./arch/sh/kernel/traps.c	Wed Mar 12 14:43:03 2003
@@ -58,9 +58,10 @@
 
 void die(const char * str, struct pt_regs * regs, long err)
 {
+	static int die_counter = 0;
 	console_verbose();
 	spin_lock_irq(&die_lock);
-	printk("%s: %04lx\n", str, err & 0xffff);
+	printk("%s: %04lx [#%d]\n", str, err & 0xffff, ++die_counter);
 	show_regs(regs);
 	spin_unlock_irq(&die_lock);
 	do_exit(SIGSEGV);
diff -Naur ./arch/s390/kernel/traps.c%OOPSC ./arch/s390/kernel/traps.c
--- ./arch/s390/kernel/traps.c%OOPSC	Tue Mar  4 19:29:15 2003
+++ ./arch/s390/kernel/traps.c	Wed Mar 12 14:42:21 2003
@@ -226,10 +226,11 @@
 
 void die(const char * str, struct pt_regs * regs, long err)
 {
+	static int die_counter = 0;
         console_verbose();
         spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
-        printk("%s: %04lx\n", str, err & 0xffff);
+	printk("%s: %04lx [#%d]\n", str, err & 0xffff, ++die_counter);
         show_regs(regs);
 	bust_spinlocks(0);
         spin_unlock_irq(&die_lock);
