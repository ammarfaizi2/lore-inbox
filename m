Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbTHZBAa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 21:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbTHZBA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 21:00:29 -0400
Received: from ns.aratech.co.kr ([61.34.11.200]:29362 "EHLO ns.aratech.co.kr")
	by vger.kernel.org with ESMTP id S262365AbTHZBAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 21:00:08 -0400
Date: Tue, 26 Aug 2003 10:02:04 +0900
From: TeJun Huh <tejun@aratech.co.kr>
To: linux-kernel@vger.kernel.org
Cc: andrea@suse.de
Subject: [PATCH] irq_enter() / wait_on_irq(), synchronize_irq() race fix
Message-ID: <20030826010204.GB5139@atj.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

 This patch fixes races between irq_enter() <-> wait_on_ira() and
irq_enter() <-> synchronize_irq().

 1. Archs which use bitops or spinlock for global_irq_lock
	- adds smp_mb() to [hard_]irq_enter()
	- adds smp_mb() to synchronize_irq()
	=> alpha, i386, ia64, mips, mips64, parisc, x86_64
	=> ppc also has atomic_inc() in hard_irq_enter(), so
	   smp_mb__after_atomic_inc() is used instead.

 2. Archs which use brlock for global_irq_lock
	- adds smp_mb() to synchronize_irq()
	=> ppc64, sparc, sparc64

 3. Archs with no SMP support
	- nothing needed
	=> arm, cris, generic, m68k, sh, sh64
 
 4. Archs which don't seem to need irq_enter() synchronization to
    disable irqs on on other CPUs.
	- I don't know.  Adds smp_mb() to synchronize_irq()?
	=> s390, s390x

 Please comment on how it should be done on s390 and s390x and point
out if anything is wrong.

-- 
tejun

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch.irqrace"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1098  -> 1.1100 
#	arch/mips64/kernel/irq.c	1.5     -> 1.6    
#	include/asm-ppc/hardirq.h	1.8     -> 1.9    
#	include/asm-x86_64/hardirq.h	1.1     -> 1.2    
#	arch/sparc/kernel/irq.c	1.12    -> 1.13   
#	arch/alpha/kernel/irq_smp.c	1.2     -> 1.3    
#	arch/i386/kernel/irq.c	1.7     -> 1.8    
#	arch/mips/kernel/irq.c	1.8     -> 1.9    
#	arch/x86_64/kernel/irq.c	1.2     -> 1.3    
#	include/asm-ia64/hardirq.h	1.4     -> 1.5    
#	include/asm-mips/hardirq.h	1.3     -> 1.4    
#	arch/ia64/kernel/irq.c	1.9     -> 1.10   
#	arch/sparc64/kernel/irq.c	1.13    -> 1.14   
#	include/asm-mips64/hardirq.h	1.2     -> 1.3    
#	include/asm-alpha/hardirq.h	1.3     -> 1.4    
#	include/asm-i386/hardirq.h	1.4     -> 1.5    
#	arch/ppc/kernel/irq.c	1.18    -> 1.19   
#	arch/parisc/kernel/irq_smp.c	1.1     -> 1.2    
#	arch/ppc64/kernel/irq.c	1.3     -> 1.4    
#	include/asm-parisc/hardirq.h	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/26	tj@atj.dyndns.org	1.1099
# - irq_enter() / wait_on_irq(), synchronize_irq() race fix.
# --------------------------------------------
# 03/08/26	tj@atj.dyndns.org	1.1100
# - irq race fix applied to other architectures.
# --------------------------------------------
#
diff -Nru a/arch/alpha/kernel/irq_smp.c b/arch/alpha/kernel/irq_smp.c
--- a/arch/alpha/kernel/irq_smp.c	Tue Aug 26 10:01:05 2003
+++ b/arch/alpha/kernel/irq_smp.c	Tue Aug 26 10:01:05 2003
@@ -242,6 +242,7 @@
 	} while (global_count != local_count);
 #else
 	/* Jay's version.  */
+	smp_mb(); /* Sync with irq_enter() */
 	if (irqs_running()) {
 		cli();
 		sti();
diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	Tue Aug 26 10:01:05 2003
+++ b/arch/i386/kernel/irq.c	Tue Aug 26 10:01:05 2003
@@ -307,6 +307,7 @@
  */
 void synchronize_irq(void)
 {
+	smp_mb(); /* Sync with irq_enter() */
 	if (irqs_running()) {
 		/* Stupid approach */
 		cli();
diff -Nru a/arch/ia64/kernel/irq.c b/arch/ia64/kernel/irq.c
--- a/arch/ia64/kernel/irq.c	Tue Aug 26 10:01:05 2003
+++ b/arch/ia64/kernel/irq.c	Tue Aug 26 10:01:05 2003
@@ -344,6 +344,7 @@
  */
 void synchronize_irq(void)
 {
+	smp_mb(); /* Sync with irq_enter() */
 	if (irqs_running()) {
 		/* Stupid approach */
 		cli();
diff -Nru a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
--- a/arch/mips/kernel/irq.c	Tue Aug 26 10:01:05 2003
+++ b/arch/mips/kernel/irq.c	Tue Aug 26 10:01:05 2003
@@ -171,6 +171,7 @@
  */
 void synchronize_irq(void)
 {
+	smp_mb(); /* Sync with irq_enter() */
 	if (irqs_running()) {
 		/* Stupid approach */
 		cli();
diff -Nru a/arch/mips64/kernel/irq.c b/arch/mips64/kernel/irq.c
--- a/arch/mips64/kernel/irq.c	Tue Aug 26 10:01:05 2003
+++ b/arch/mips64/kernel/irq.c	Tue Aug 26 10:01:05 2003
@@ -171,6 +171,7 @@
  */
 void synchronize_irq(void)
 {
+	smp_mb(); /* Sync with irq_enter() */
 	if (irqs_running()) {
 		/* Stupid approach */
 		cli();
diff -Nru a/arch/parisc/kernel/irq_smp.c b/arch/parisc/kernel/irq_smp.c
--- a/arch/parisc/kernel/irq_smp.c	Tue Aug 26 10:01:05 2003
+++ b/arch/parisc/kernel/irq_smp.c	Tue Aug 26 10:01:05 2003
@@ -225,6 +225,7 @@
 synchronize_irq(void)
 {
 	/* Jay's version.  */
+	smp_mb(); /* Sync with irq_enter() */
 	if (irqs_running()) {
 		cli();
 		sti();
diff -Nru a/arch/ppc/kernel/irq.c b/arch/ppc/kernel/irq.c
--- a/arch/ppc/kernel/irq.c	Tue Aug 26 10:01:05 2003
+++ b/arch/ppc/kernel/irq.c	Tue Aug 26 10:01:05 2003
@@ -675,6 +675,7 @@
  */
 void synchronize_irq(void)
 {
+	smp_mb(); /* Sync with irq_enter() */
 	if (atomic_read(&global_irq_count)) {
 		/* Stupid approach */
 		cli();
diff -Nru a/arch/ppc64/kernel/irq.c b/arch/ppc64/kernel/irq.c
--- a/arch/ppc64/kernel/irq.c	Tue Aug 26 10:01:05 2003
+++ b/arch/ppc64/kernel/irq.c	Tue Aug 26 10:01:05 2003
@@ -666,6 +666,7 @@
 
 void synchronize_irq(void)
 {
+	smp_mb(); /* Sync with irq_enter() */
 	if (irqs_running()) {
 		cli();
 		sti();
diff -Nru a/arch/sparc/kernel/irq.c b/arch/sparc/kernel/irq.c
--- a/arch/sparc/kernel/irq.c	Tue Aug 26 10:01:05 2003
+++ b/arch/sparc/kernel/irq.c	Tue Aug 26 10:01:05 2003
@@ -243,6 +243,7 @@
  */
 void synchronize_irq(void)
 {
+	smp_mb(); /* Sync with irq_enter() */
 	if (irqs_running()) {
 		cli();
 		sti();
diff -Nru a/arch/sparc64/kernel/irq.c b/arch/sparc64/kernel/irq.c
--- a/arch/sparc64/kernel/irq.c	Tue Aug 26 10:01:05 2003
+++ b/arch/sparc64/kernel/irq.c	Tue Aug 26 10:01:05 2003
@@ -592,6 +592,7 @@
 
 void synchronize_irq(void)
 {
+	smp_mb(); /* Sync with irq_enter() */
 	if (irqs_running()) {
 		cli();
 		sti();
diff -Nru a/arch/x86_64/kernel/irq.c b/arch/x86_64/kernel/irq.c
--- a/arch/x86_64/kernel/irq.c	Tue Aug 26 10:01:05 2003
+++ b/arch/x86_64/kernel/irq.c	Tue Aug 26 10:01:05 2003
@@ -333,6 +333,7 @@
  */
 void synchronize_irq(void)
 {
+	smp_mb(); /* Sync with irq_enter() */
 	if (irqs_running()) {
 		/* Stupid approach */
 		cli();
diff -Nru a/include/asm-alpha/hardirq.h b/include/asm-alpha/hardirq.h
--- a/include/asm-alpha/hardirq.h	Tue Aug 26 10:01:05 2003
+++ b/include/asm-alpha/hardirq.h	Tue Aug 26 10:01:05 2003
@@ -75,6 +75,8 @@
 {
 	++local_irq_count(cpu);
 
+	smp_mb(); /* Sync with wait_on_irq() and synchronize_irq() */
+
 	while (spin_is_locked(&global_irq_lock))
 		barrier();
 }
diff -Nru a/include/asm-i386/hardirq.h b/include/asm-i386/hardirq.h
--- a/include/asm-i386/hardirq.h	Tue Aug 26 10:01:05 2003
+++ b/include/asm-i386/hardirq.h	Tue Aug 26 10:01:05 2003
@@ -67,6 +67,8 @@
 {
 	++local_irq_count(cpu);
 
+	smp_mb(); /* Sync with wait_on_irq() and synchronize_irq() */
+
 	while (test_bit(0,&global_irq_lock)) {
 		cpu_relax();
 	}
diff -Nru a/include/asm-ia64/hardirq.h b/include/asm-ia64/hardirq.h
--- a/include/asm-ia64/hardirq.h	Tue Aug 26 10:01:05 2003
+++ b/include/asm-ia64/hardirq.h	Tue Aug 26 10:01:05 2003
@@ -80,6 +80,8 @@
 {
 	really_local_irq_count()++;
 
+	smp_mb(); /* Sync with wait_on_irq() and synchronize_irq() */
+
 	while (test_bit(0,&global_irq_lock)) {
 		/* nothing */;
 	}
diff -Nru a/include/asm-mips/hardirq.h b/include/asm-mips/hardirq.h
--- a/include/asm-mips/hardirq.h	Tue Aug 26 10:01:05 2003
+++ b/include/asm-mips/hardirq.h	Tue Aug 26 10:01:05 2003
@@ -82,6 +82,8 @@
 {
 	++local_irq_count(cpu);
 
+	smp_mb(); /* Sync with wait_on_irq() and synchronize_irq() */
+
 	while (spin_is_locked(&global_irq_lock))
 		barrier();
 }
diff -Nru a/include/asm-mips64/hardirq.h b/include/asm-mips64/hardirq.h
--- a/include/asm-mips64/hardirq.h	Tue Aug 26 10:01:05 2003
+++ b/include/asm-mips64/hardirq.h	Tue Aug 26 10:01:05 2003
@@ -81,6 +81,8 @@
 {
 	++local_irq_count(cpu);
 
+	smp_mb(); /* Sync with wait_on_irq() and synchronize_irq() */
+
 	while (spin_is_locked(&global_irq_lock))
 		barrier();
 }
diff -Nru a/include/asm-parisc/hardirq.h b/include/asm-parisc/hardirq.h
--- a/include/asm-parisc/hardirq.h	Tue Aug 26 10:01:05 2003
+++ b/include/asm-parisc/hardirq.h	Tue Aug 26 10:01:05 2003
@@ -82,6 +82,8 @@
 {
 	++local_irq_count(cpu);
 
+	smp_mb(); /* Sync with wait_on_irq() and synchronize_irq() */
+
 	while (spin_is_locked(&global_irq_lock))
 		barrier();
 }
diff -Nru a/include/asm-ppc/hardirq.h b/include/asm-ppc/hardirq.h
--- a/include/asm-ppc/hardirq.h	Tue Aug 26 10:01:05 2003
+++ b/include/asm-ppc/hardirq.h	Tue Aug 26 10:01:05 2003
@@ -69,6 +69,7 @@
 
 	++local_irq_count(cpu);
 	atomic_inc(&global_irq_count);
+	smp_mb__after_atomic_inc(); /* Sync with wait_on_irq() and synchronize_irq() */
 	while (test_bit(0,&global_irq_lock)) {
 		if (cpu == global_irq_holder) {
 			printk("uh oh, interrupt while we hold global irq lock! (CPU %d)\n", cpu);
diff -Nru a/include/asm-x86_64/hardirq.h b/include/asm-x86_64/hardirq.h
--- a/include/asm-x86_64/hardirq.h	Tue Aug 26 10:01:05 2003
+++ b/include/asm-x86_64/hardirq.h	Tue Aug 26 10:01:05 2003
@@ -67,6 +67,8 @@
 {
 	++local_irq_count(cpu);
 
+	smp_mb(); /* Sync with wait_on_irq() and synchronize_irq() */
+
 	while (test_bit(0,&global_irq_lock)) {
 		cpu_relax();
 	}

--J/dobhs11T7y2rNN--
