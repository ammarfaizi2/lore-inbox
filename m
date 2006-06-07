Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWFGCpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWFGCpQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 22:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWFGCpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 22:45:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9864 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750733AbWFGCpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 22:45:14 -0400
Date: Tue, 6 Jun 2006 22:49:38 -0400
From: Don Zickus <dzickus@redhat.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Shaohua Li <shaohua.li@intel.com>, Miles Lane <miles.lane@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in	arch/i386/kernel/nmi.c:174
Message-ID: <20060607024938.GG11696@redhat.com>
References: <4480C102.3060400@goop.org> <4483DF32.4090608@goop.org> <20060605004823.566b266c.akpm@osdl.org> <a44ae5cd0606050135w66c2abeu698394b4268e4790@mail.gmail.com> <1149576246.32046.166.camel@sli10-desk.sh.intel.com> <4485AC1F.9050001@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4485AC1F.9050001@goop.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Makes the start/stop paths of nmi watchdog more robust to handle the
suspend/resume cases more gracefully.

Signed-off-by:  Don Zickus <dzickus@redhat.com>

---

On Tue, Jun 06, 2006 at 09:23:59AM -0700, Jeremy Fitzhardinge wrote:
> Shaohua Li wrote:
> >Does below patch help? The nmi suspend/resume doesn't look good to me.
> >Only CPU0 uses the suspend/resume code path. Other CPUs run the CPU
> >hotplug code path.
> >  
> Unfortunately this just oopses immediately on the first suspend.  The 
> stack trace is unclear (and I'm just going from memory at the moment), 
> but it looked like it got an invalid op.  I'll try to get a clearer idea 
> of the crash later today.
> 
>    J

Can you apply this patch on top of Shaohua's.  This should fix all your
suspend problems.  

Inside the patch is a little hack to handle the scenario when we come out
of resume we do _not_ want the nmi watchdog enabled (to match the
case entering suspend).  

Compiled but not tested, as I don't have easy access to my test machines
right now.  Mainly posted for Andrew to pick up for rc6-mm1.

Cheers,
Don

Index: linux-don/arch/i386/kernel/nmi.c
===================================================================
--- linux-don.orig/arch/i386/kernel/nmi.c
+++ linux-don/arch/i386/kernel/nmi.c
@@ -745,6 +745,7 @@ static void stop_intel_arch_watchdog(voi
 
 void setup_apic_nmi_watchdog (void *unused)
 {
+	struct nmi_watchdog_ctlblk *wd = &__get_cpu_var(nmi_watchdog_ctlblk);
 #ifdef CONFIG_LOCKDEP
 	/*
 	 * The NMI watchdog uses spinlocks (notifier chains, etc.),
@@ -761,6 +762,14 @@ void setup_apic_nmi_watchdog (void *unus
 	    (nmi_watchdog != NMI_IO_APIC))
 	    	return;
 
+	if (wd->enabled == 1)
+		return;
+
+	/* cheap hack to support suspend/resume */
+	/* if cpu0 is not active neither should the other cpus */
+	if ((smp_processor_id() != 0) && (atomic_read(&nmi_active) <= 0))
+		return;
+
 	if (nmi_watchdog == NMI_LOCAL_APIC) {
 		switch (boot_cpu_data.x86_vendor) {
 		case X86_VENDOR_AMD:
@@ -798,17 +807,22 @@ void setup_apic_nmi_watchdog (void *unus
 			return;
 		}
 	}
-	__get_cpu_var(nmi_watchdog_ctlblk.enabled) = 1;
+	wd->enabled = 1;
 	atomic_inc(&nmi_active);
 }
 
 void stop_apic_nmi_watchdog(void *unused)
 {
+	struct nmi_watchdog_ctlblk *wd = &__get_cpu_var(nmi_watchdog_ctlblk);
+
 	/* only support LOCAL and IO APICs for now */
 	if ((nmi_watchdog != NMI_LOCAL_APIC) &&
 	    (nmi_watchdog != NMI_IO_APIC))
 	    	return;
 
+	if (wd->enabled == 0)
+		return;
+
 	if (nmi_watchdog == NMI_LOCAL_APIC) {
 		switch (boot_cpu_data.x86_vendor) {
 		case X86_VENDOR_AMD:
@@ -836,7 +850,7 @@ void stop_apic_nmi_watchdog(void *unused
 			return;
 		}
 	}
-	__get_cpu_var(nmi_watchdog_ctlblk.enabled) = 0;
+	wd->enabled = 0;
 	atomic_dec(&nmi_active);
 }
 
Index: linux-don/arch/x86_64/kernel/nmi.c
===================================================================
--- linux-don.orig/arch/x86_64/kernel/nmi.c
+++ linux-don/arch/x86_64/kernel/nmi.c
@@ -672,6 +672,7 @@ static void stop_intel_arch_watchdog(voi
 
 void setup_apic_nmi_watchdog(void *unused)
 {
+	struct nmi_watchdog_ctlblk *wd = &__get_cpu_var(nmi_watchdog_ctlblk);
 #ifdef CONFIG_LOCKDEP
 	/*
 	 * The NMI watchdog uses spinlocks (notifier chains, etc.),
@@ -688,6 +689,14 @@ void setup_apic_nmi_watchdog(void *unuse
 	    (nmi_watchdog != NMI_IO_APIC))
 	    	return;
 
+	if (wd->enabled == 1)
+		return;
+
+	/* cheap hack to support suspend/resume */
+	/* if cpu0 is not active neither should the other cpus */
+	if ((smp_processor_id() != 0) && (atomic_read(&nmi_active) <= 0))
+		return;
+
 	if (nmi_watchdog == NMI_LOCAL_APIC) {
 		switch (boot_cpu_data.x86_vendor) {
 		case X86_VENDOR_AMD:
@@ -709,17 +718,22 @@ void setup_apic_nmi_watchdog(void *unuse
 			return;
 		}
 	}
-	__get_cpu_var(nmi_watchdog_ctlblk.enabled) = 1;
+	wd->enabled = 1;
 	atomic_inc(&nmi_active);
 }
 
 void stop_apic_nmi_watchdog(void *unused)
 {
+	struct nmi_watchdog_ctlblk *wd = &__get_cpu_var(nmi_watchdog_ctlblk);
+
 	/* only support LOCAL and IO APICs for now */
 	if ((nmi_watchdog != NMI_LOCAL_APIC) &&
 	    (nmi_watchdog != NMI_IO_APIC))
 	    	return;
 
+	if (wd->enabled == 0)
+		return;
+
 	if (nmi_watchdog == NMI_LOCAL_APIC) {
 		switch (boot_cpu_data.x86_vendor) {
 		case X86_VENDOR_AMD:
@@ -738,7 +752,7 @@ void stop_apic_nmi_watchdog(void *unused
 			return;
 		}
 	}
-	__get_cpu_var(nmi_watchdog_ctlblk.enabled) = 0;
+	wd->enabled = 0;
 	atomic_dec(&nmi_active);
 }
 
