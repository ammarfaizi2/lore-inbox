Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWFFHFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWFFHFQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 03:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWFFHFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 03:05:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:39238 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932124AbWFFHFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 03:05:13 -0400
X-IronPort-AV: i="4.05,213,1146466800"; 
   d="scan'208"; a="46440217:sNHT14500119788"
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in
	arch/i386/kernel/nmi.c:174
From: Shaohua Li <shaohua.li@intel.com>
To: Miles Lane <miles.lane@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>,
       linux-kernel@vger.kernel.org, dzickus@redhat.com, ak@suse.de
In-Reply-To: <a44ae5cd0606050135w66c2abeu698394b4268e4790@mail.gmail.com>
References: <4480C102.3060400@goop.org> <4483DF32.4090608@goop.org>
	 <20060605004823.566b266c.akpm@osdl.org>
	 <a44ae5cd0606050135w66c2abeu698394b4268e4790@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 06 Jun 2006 14:44:06 +0800
Message-Id: <1149576246.32046.166.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 16:35 +0800, Miles Lane wrote:
> On 6/5/06, Andrew Morton <akpm@osdl.org> wrote:
> 
> > Do you think the suspend breakage is related to that patch? 
> > 
> > Miles also reports that every second suspend fails for him.  Miles,
> does 
> > 'nmi_watchdog=0' make it better?
> 
> I tried using that as an appended boot option, but it didn't change
> the 
> behavior.
Does below patch help? The nmi suspend/resume doesn't look good to me.
Only CPU0 uses the suspend/resume code path. Other CPUs run the CPU
hotplug code path.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---

 linux-2.6.17-rc5-mm3-root/arch/i386/kernel/nmi.c       |   14 +++++++++-----
 linux-2.6.17-rc5-mm3-root/arch/i386/kernel/smpboot.c   |    3 ++-
 linux-2.6.17-rc5-mm3-root/arch/x86_64/kernel/nmi.c     |   14 +++++++++-----
 linux-2.6.17-rc5-mm3-root/arch/x86_64/kernel/smpboot.c |    2 ++
 linux-2.6.17-rc5-mm3-root/include/asm-i386/nmi.h       |    1 +
 linux-2.6.17-rc5-mm3-root/include/asm-x86_64/nmi.h     |    1 +
 6 files changed, 24 insertions(+), 11 deletions(-)

diff -puN arch/i386/kernel/nmi.c~nmi arch/i386/kernel/nmi.c
--- linux-2.6.17-rc5-mm3/arch/i386/kernel/nmi.c~nmi	2006-06-04 15:22:06.000000000 +0800
+++ linux-2.6.17-rc5-mm3-root/arch/i386/kernel/nmi.c	2006-06-05 12:28:17.000000000 +0800
@@ -65,7 +65,6 @@ struct nmi_watchdog_ctlblk {
 static DEFINE_PER_CPU(struct nmi_watchdog_ctlblk, nmi_watchdog_ctlblk);
 
 /* local prototypes */
-static void stop_apic_nmi_watchdog(void *unused);
 static int unknown_nmi_panic_callback(struct pt_regs *regs, int cpu);
 
 extern void show_registers(struct pt_regs *regs);
@@ -377,15 +376,20 @@ static int nmi_pm_active; /* nmi_active 
 
 static int lapic_nmi_suspend(struct sys_device *dev, pm_message_t state)
 {
+	/* only CPU0 goes here, other CPUs should be offline */
 	nmi_pm_active = atomic_read(&nmi_active);
-	disable_lapic_nmi_watchdog();
+	stop_apic_nmi_watchdog(NULL);
+	BUG_ON(atomic_read(&nmi_active) != 0);
 	return 0;
 }
 
 static int lapic_nmi_resume(struct sys_device *dev)
 {
-	if (nmi_pm_active > 0)
-		enable_lapic_nmi_watchdog();
+	/* only CPU0 goes here, other CPUs should be offline */
+	if (nmi_pm_active > 0) {
+		setup_apic_nmi_watchdog(NULL);
+		touch_nmi_watchdog();
+	}
 	return 0;
 }
 
@@ -798,7 +802,7 @@ void setup_apic_nmi_watchdog (void *unus
 	atomic_inc(&nmi_active);
 }
 
-static void stop_apic_nmi_watchdog(void *unused)
+void stop_apic_nmi_watchdog(void *unused)
 {
 	/* only support LOCAL and IO APICs for now */
 	if ((nmi_watchdog != NMI_LOCAL_APIC) &&
diff -puN arch/i386/kernel/smpboot.c~nmi arch/i386/kernel/smpboot.c
--- linux-2.6.17-rc5-mm3/arch/i386/kernel/smpboot.c~nmi	2006-06-04 15:26:47.000000000 +0800
+++ linux-2.6.17-rc5-mm3-root/arch/i386/kernel/smpboot.c	2006-06-05 08:51:16.000000000 +0800
@@ -1368,7 +1368,8 @@ int __cpu_disable(void)
 	 */
 	if (cpu == 0)
 		return -EBUSY;
-
+	if (nmi_watchdog == NMI_LOCAL_APIC)
+		stop_apic_nmi_watchdog(NULL);
 	clear_local_APIC();
 	/* Allow any queued timer interrupts to get serviced */
 	local_irq_enable();
diff -puN include/asm-i386/nmi.h~nmi include/asm-i386/nmi.h
--- linux-2.6.17-rc5-mm3/include/asm-i386/nmi.h~nmi	2006-06-05 08:50:23.000000000 +0800
+++ linux-2.6.17-rc5-mm3-root/include/asm-i386/nmi.h	2006-06-05 08:50:33.000000000 +0800
@@ -23,6 +23,7 @@ extern int reserve_evntsel_nmi(unsigned 
 extern void release_evntsel_nmi(unsigned int);
 
 extern void setup_apic_nmi_watchdog (void *);
+extern void stop_apic_nmi_watchdog (void *);
 extern void disable_timer_nmi_watchdog(void);
 extern void enable_timer_nmi_watchdog(void);
 extern int nmi_watchdog_tick (struct pt_regs * regs, unsigned reason);
diff -puN arch/x86_64/kernel/nmi.c~nmi arch/x86_64/kernel/nmi.c
--- linux-2.6.17-rc5-mm3/arch/x86_64/kernel/nmi.c~nmi	2006-06-05 12:24:03.000000000 +0800
+++ linux-2.6.17-rc5-mm3-root/arch/x86_64/kernel/nmi.c	2006-06-05 12:26:00.000000000 +0800
@@ -65,7 +65,6 @@ struct nmi_watchdog_ctlblk {
 static DEFINE_PER_CPU(struct nmi_watchdog_ctlblk, nmi_watchdog_ctlblk);
 
 /* local prototypes */
-static void stop_apic_nmi_watchdog(void *unused);
 static int unknown_nmi_panic_callback(struct pt_regs *regs, int cpu);
 
 /* converts an msr to an appropriate reservation bit */
@@ -363,15 +362,20 @@ static int nmi_pm_active; /* nmi_active 
 
 static int lapic_nmi_suspend(struct sys_device *dev, pm_message_t state)
 {
+	/* only CPU0 goes here, other CPUs should be offline */
 	nmi_pm_active = atomic_read(&nmi_active);
-	disable_lapic_nmi_watchdog();
+	stop_apic_nmi_watchdog(NULL);
+	BUG_ON(atomic_read(&nmi_active) != 0);
 	return 0;
 }
 
 static int lapic_nmi_resume(struct sys_device *dev)
 {
-	if (nmi_pm_active > 0)
-		enable_lapic_nmi_watchdog();
+	/* only CPU0 goes here, other CPUs should be offline */
+	if (nmi_pm_active > 0) {
+		setup_apic_nmi_watchdog(NULL);
+		touch_nmi_watchdog();
+	}
 	return 0;
 }
 
@@ -709,7 +713,7 @@ void setup_apic_nmi_watchdog(void *unuse
 	atomic_inc(&nmi_active);
 }
 
-static void stop_apic_nmi_watchdog(void *unused)
+void stop_apic_nmi_watchdog(void *unused)
 {
 	/* only support LOCAL and IO APICs for now */
 	if ((nmi_watchdog != NMI_LOCAL_APIC) &&
diff -puN include/asm-x86_64/nmi.h~nmi include/asm-x86_64/nmi.h
--- linux-2.6.17-rc5-mm3/include/asm-x86_64/nmi.h~nmi	2006-06-05 12:34:27.000000000 +0800
+++ linux-2.6.17-rc5-mm3-root/include/asm-x86_64/nmi.h	2006-06-05 12:34:41.000000000 +0800
@@ -54,6 +54,7 @@ extern int reserve_evntsel_nmi(unsigned 
 extern void release_evntsel_nmi(unsigned int);
 
 extern void setup_apic_nmi_watchdog (void *);
+extern void stop_apic_nmi_watchdog (void *);
 extern void disable_timer_nmi_watchdog(void);
 extern void enable_timer_nmi_watchdog(void);
 extern int nmi_watchdog_tick (struct pt_regs * regs, unsigned reason);
diff -puN arch/x86_64/kernel/smpboot.c~nmi arch/x86_64/kernel/smpboot.c
--- linux-2.6.17-rc5-mm3/arch/x86_64/kernel/smpboot.c~nmi	2006-06-05 12:34:56.000000000 +0800
+++ linux-2.6.17-rc5-mm3-root/arch/x86_64/kernel/smpboot.c	2006-06-05 12:45:58.000000000 +0800
@@ -1232,6 +1232,8 @@ int __cpu_disable(void)
 	if (cpu == 0)
 		return -EBUSY;
 
+	if (nmi_watchdog == NMI_LOCAL_APIC)
+		stop_apic_nmi_watchdog(NULL);
 	clear_local_APIC();
 
 	/*
_
