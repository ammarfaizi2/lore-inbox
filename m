Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbTEMUOC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 16:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbTEMUOC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 16:14:02 -0400
Received: from holomorphy.com ([66.224.33.161]:25020 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262310AbTEMUMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 16:12:30 -0400
Date: Tue, 13 May 2003 13:25:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.69-mm4
Message-ID: <20030513202508.GR8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030512225504.4baca409.akpm@digeo.com> <20030513201734.GQ8978@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513201734.GQ8978@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 10:55:04PM -0700, Andrew Morton wrote:
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.69-mm4/
>> Lots of small things.

On Tue, May 13, 2003 at 01:17:34PM -0700, William Lee Irwin III wrote:
> Nuke various warnings:
> (1) noreturn function does return all over i386 arch code
> (2) CONFIG_SHARE_RUNQUEUE bits, mostly Helge Hafting's thing, but also
> 	handle some more arch code nailed by it
> (3) some kind of dmi_blacklist excess array initializer oddity

Take 2: I missed one of the noreturns, in machine_halt_1():


diff -prauN mm4-2.5.69-1/arch/i386/kernel/apic.c mm4-2.5.69-2/arch/i386/kernel/apic.c
--- mm4-2.5.69-1/arch/i386/kernel/apic.c	2003-05-13 12:16:23.000000000 -0700
+++ mm4-2.5.69-2/arch/i386/kernel/apic.c	2003-05-13 12:32:08.000000000 -0700
@@ -1204,6 +1204,9 @@ void stop_apics(NORET_TYPE void(*rest)(v
 		set_cpus_allowed(current, 1 << arg.reboot_cpu_id);
 	}
 	on_each_cpu(cpu_stop_apics, &arg, 1, 0);
+	while (1) {
+		;
+	}
 }
 
 /*
diff -prauN mm4-2.5.69-1/arch/i386/kernel/cpu/proc.c mm4-2.5.69-2/arch/i386/kernel/cpu/proc.c
--- mm4-2.5.69-1/arch/i386/kernel/cpu/proc.c	2003-05-13 12:16:24.000000000 -0700
+++ mm4-2.5.69-2/arch/i386/kernel/cpu/proc.c	2003-05-13 12:44:27.000000000 -0700
@@ -115,7 +115,7 @@ static int show_cpuinfo(struct seq_file 
 		     fpu_exception ? "yes" : "no",
 		     c->cpuid_level,
 		     c->wp_works_ok ? "yes" : "no");
-#ifdef CONFIG_SHARE_RUNQUEUE
+#if CONFIG_SHARE_RUNQUEUE
 {
 	extern long __rq_idx[NR_CPUS];
 
diff -prauN mm4-2.5.69-1/arch/i386/kernel/dmi_scan.c mm4-2.5.69-2/arch/i386/kernel/dmi_scan.c
--- mm4-2.5.69-1/arch/i386/kernel/dmi_scan.c	2003-05-13 12:16:24.000000000 -0700
+++ mm4-2.5.69-2/arch/i386/kernel/dmi_scan.c	2003-05-13 12:47:01.000000000 -0700
@@ -816,7 +816,8 @@ static __initdata struct dmi_blacklist d
 	{ acer_cpufreq_pst, "Acer Aspire", {
 			MATCH(DMI_SYS_VENDOR, "Insyde Software"),
 			MATCH(DMI_BIOS_VERSION, "3A71"),
-			NO_MATCH, NO_MATCH, NO_MATCH
+			NO_MATCH,
+			NO_MATCH,
 			} },
 
 	{ NULL, }
diff -prauN mm4-2.5.69-1/arch/i386/kernel/reboot.c mm4-2.5.69-2/arch/i386/kernel/reboot.c
--- mm4-2.5.69-1/arch/i386/kernel/reboot.c	2003-05-13 12:16:24.000000000 -0700
+++ mm4-2.5.69-2/arch/i386/kernel/reboot.c	2003-05-13 13:04:24.000000000 -0700
@@ -229,7 +229,8 @@ void machine_real_restart(unsigned char 
 				: "i" ((void *) (0x1000 - sizeof (real_mode_switch) - 100)));
 }
 
-static void machine_restart_1(void * __unused)
+static NORET_TYPE void machine_restart_1(void *) ATTRIB_NORET;
+static NORET_TYPE void machine_restart_1(void *__unused)
 {
 	if(!reboot_thru_bios) {
 		/* rebooting needs to touch the page at absolute addr 0 */
@@ -243,26 +244,37 @@ static void machine_restart_1(void * __u
 	}
 
 	machine_real_restart(jump_to_bios, sizeof(jump_to_bios));
+	while (1) {
+		;
+	}
 }
 void machine_restart(char * __unused)
 {
 	stop_apics(machine_restart_1, 0);
 }
 
-static void machine_halt_1(void * __unused)
+static NORET_TYPE void machine_halt_1(void *) ATTRIB_NORET;
+static NORET_TYPE void machine_halt_1(void *__unused)
 {
 	stop_this_cpu();
+	while (1) {
+		;
+	}
 }
 void machine_halt(void)
 {
 	stop_apics(machine_halt_1, 0);
 }
 
-static void machine_power_off_1(void * __unused)
+static NORET_TYPE void machine_power_off_1(void *) ATTRIB_NORET;
+static NORET_TYPE void machine_power_off_1(void *__unused)
 {
 	if (pm_power_off)
 		pm_power_off();
 	stop_this_cpu();
+	while (1) {
+		;
+	}
 }
 void machine_power_off(void)
 {
diff -prauN mm4-2.5.69-1/include/linux/sched.h mm4-2.5.69-2/include/linux/sched.h
--- mm4-2.5.69-1/include/linux/sched.h	2003-05-13 12:16:38.000000000 -0700
+++ mm4-2.5.69-2/include/linux/sched.h	2003-05-13 12:45:02.000000000 -0700
@@ -158,7 +158,7 @@ extern void init_idle(task_t *idle, int 
 # define CONFIG_NR_SIBLINGS 0
 #endif
 
-#ifdef CONFIG_NR_SIBLINGS
+#if CONFIG_NR_SIBLINGS
 # define CONFIG_SHARE_RUNQUEUE 1
 #else
 # define CONFIG_SHARE_RUNQUEUE 0
diff -prauN mm4-2.5.69-1/kernel/sched.c mm4-2.5.69-2/kernel/sched.c
--- mm4-2.5.69-1/kernel/sched.c	2003-05-13 12:16:39.000000000 -0700
+++ mm4-2.5.69-2/kernel/sched.c	2003-05-13 12:44:05.000000000 -0700
@@ -161,7 +161,7 @@ struct prio_array {
  *  restrictions on the mappings - there can be 4 CPUs per
  *  runqueue or even assymetric mappings.)
  */
-#ifdef CONFIG_SHARE_RUNQUEUE
+#if CONFIG_SHARE_RUNQUEUE
 # define MAX_NR_SIBLINGS CONFIG_NR_SIBLINGS
   long __rq_idx[NR_CPUS] __cacheline_aligned;
   static long __cpu_idx[NR_CPUS] __cacheline_aligned;
@@ -1188,7 +1188,7 @@ out:
 	;
 }
 
-#ifdef CONFIG_SHARE_RUNQUEUE
+#if CONFIG_SHARE_RUNQUEUE
 static void active_load_balance(runqueue_t *this_rq, int this_cpu)
 {
 	runqueue_t *rq;
@@ -2789,7 +2789,7 @@ void __init sched_init(void)
 		/*
 		 * Start with a 1:1 mapping between CPUs and runqueues:
 		 */
-#ifdef CONFIG_SHARE_RUNQUEUE
+#if CONFIG_SHARE_RUNQUEUE
 		rq_idx(i) = i;
 		cpu_idx(i) = 0;
 #endif
