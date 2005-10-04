Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbVJDPNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbVJDPNQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbVJDPNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:13:16 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63707 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964795AbVJDPNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:13:16 -0400
To: Andrew Morton <akpm@osdl.org>
cc: <linux-kernel@vger.kernel.org>, <fastboot@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: [PATCH 1/2] x86_64 nmi_watchdog: Make check_nmi_watchdog static
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 04 Oct 2005 09:11:42 -0600
Message-ID: <m17jct8ggh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


By using a late_initcall as i386 does we don't need to call
check_nmi_watchdog manually after SMP startup, and we don't
need different code paths for SMP and non SMP.

This paves the way for moving apic initialization into init_IRQ,
where it belongs.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 arch/x86_64/kernel/apic.c    |    1 -
 arch/x86_64/kernel/nmi.c     |    7 ++++++-
 arch/x86_64/kernel/smpboot.c |    2 --
 include/asm-x86_64/nmi.h     |    2 --
 4 files changed, 6 insertions(+), 6 deletions(-)

b80634473f58ddea568a41e9a779676bed64dc9c
diff --git a/arch/x86_64/kernel/apic.c b/arch/x86_64/kernel/apic.c
--- a/arch/x86_64/kernel/apic.c
+++ b/arch/x86_64/kernel/apic.c
@@ -1061,7 +1061,6 @@ int __init APIC_init_uniprocessor (void)
 		nr_ioapics = 0;
 #endif
 	setup_boot_APIC_clock();
-	check_nmi_watchdog();
 	return 0;
 }
 
diff --git a/arch/x86_64/kernel/nmi.c b/arch/x86_64/kernel/nmi.c
--- a/arch/x86_64/kernel/nmi.c
+++ b/arch/x86_64/kernel/nmi.c
@@ -139,12 +139,15 @@ static __init void nmi_cpu_busy(void *da
 }
 #endif
 
-int __init check_nmi_watchdog (void)
+static int __init check_nmi_watchdog (void)
 {
 	volatile int endflag = 0;
 	int *counts;
 	int cpu;
 
+	if (nmi_watchdog == NMI_NONE)
+		return 0;
+
 	counts = kmalloc(NR_CPUS * sizeof(int), GFP_KERNEL);
 	if (!counts)
 		return -1;
@@ -186,6 +189,8 @@ int __init check_nmi_watchdog (void)
 	kfree(counts);
 	return 0;
 }
+/* This needs to happen later in boot so counters are working */
+late_initcall(check_nmi_watchdog);
 
 int __init setup_nmi_watchdog(char *str)
 {
diff --git a/arch/x86_64/kernel/smpboot.c b/arch/x86_64/kernel/smpboot.c
--- a/arch/x86_64/kernel/smpboot.c
+++ b/arch/x86_64/kernel/smpboot.c
@@ -1077,8 +1077,6 @@ void __init smp_cpus_done(unsigned int m
 #endif
 
 	time_init_gtod();
-
-	check_nmi_watchdog();
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/include/asm-x86_64/nmi.h b/include/asm-x86_64/nmi.h
--- a/include/asm-x86_64/nmi.h
+++ b/include/asm-x86_64/nmi.h
@@ -54,6 +54,4 @@ extern void die_nmi(char *str, struct pt
 extern int panic_on_timeout;
 extern int unknown_nmi_panic;
 
-extern int check_nmi_watchdog(void);
- 
 #endif /* ASM_NMI_H */
