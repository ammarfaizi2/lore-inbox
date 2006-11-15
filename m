Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966593AbWKOIBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966593AbWKOIBf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 03:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966636AbWKOIBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 03:01:35 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:8927 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S966593AbWKOIBd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 03:01:33 -0500
Date: Wed, 15 Nov 2006 00:03:23 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Andi Kleen <ak@muc.de>
Cc: Zachary Amsden <zach@vmware.com>, Andi Kleen <ak@suse.de>,
       virtualization@lists.osdl.org, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] Skip timer works.patch
Message-ID: <20061115080323.GK1397@sequoia.sous-sol.org>
References: <200610200009.k9K09MrS027558@zach-dev.vmware.com> <20061027145650.GA37582@muc.de> <45425976.3090508@vmware.com> <200610271416.12548.ak@suse.de> <4546669F.8020706@vmware.com> <20061030225016.GA95732@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061030225016.GA95732@muc.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@muc.de) wrote:
> On Mon, Oct 30, 2006 at 12:54:55PM -0800, Zachary Amsden wrote:
> > Andi Kleen wrote:
> > >no_timer_check. But it's only there on x86-64 in mainline - although there
> > >were some patches to add it to i386 too.
> > >  
> > 
> > I can rename to match the x86-64 name.
> 
> I will do that in my tree.

Looks like this one might have been lost.  Here's the renamed version
(it's against 2.6.19-rc5-mm2, which should have your tree in it).

thanks,
-chris
--

From: Zachary Amsden <zach@vmware.com>

Add a way to disable the timer IRQ routing check via a boot option.  The
VMI timer code uses this to avoid triggering the pester Mingo code, which
probes for some very unusual and broken motherboard routings.  It fires
100% of the time when using a paravirtual delay mechanism instead of
using a realtime delay, since there is no elapsed real time, and the 4 timer
IRQs have not yet been delivered.

In addition, it is entirely possible, though improbable, that this bug
could surface on real hardware which picks a particularly bad time to enter
SMM mode, causing a long latency during one of the timer IRQs.

While here, make check_timer be __init.

Signed-off-by: Zachary Amsden <zach@vmware.com>
[chrisw: use no_timer_check to bring inline with x86_64 as per Andi's request]
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

===================================================================
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -610,8 +610,6 @@ and is between 256 and 4096 characters. 
 
 	hugepages=	[HW,IA-32,IA-64] Maximal number of HugeTLB pages.
 
-	noirqbalance	[IA-32,SMP,KNL] Disable kernel irq balancing
-
 	i8042.direct	[HW] Put keyboard port into non-translated mode
 	i8042.dumbkbd	[HW] Pretend that controller can only read data from
 			     keyboard and cannot control its state
@@ -1081,8 +1079,13 @@ and is between 256 and 4096 characters. 
 			in certain environments such as networked servers or
 			real-time systems.
 
+	noirqbalance	[IA-32,SMP,KNL] Disable kernel irq balancing
+
 	noirqdebug	[IA-32] Disables the code which attempts to detect and
 			disable unhandled interrupt sources.
+
+	no_timer_check	[IA-32,X86_64,APIC] Disables the code which tests for
+			broken timer IRQ sources.
 
 	noisapnp	[ISAPNP] Disables ISA PnP code.
 
===================================================================
--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -1931,6 +1931,15 @@ static void __init setup_ioapic_ids_from
 static void __init setup_ioapic_ids_from_mpc(void) { }
 #endif
 
+static int no_timer_check __initdata;
+
+static int __init notimercheck(char *s)
+{
+	no_timer_check = 1;
+	return 1;
+}
+__setup("no_timer_check", notimercheck);
+
 /*
  * There is a nasty bug in some older SMP boards, their mptable lies
  * about the timer IRQ. We do the following to work around the situation:
@@ -1939,9 +1948,12 @@ static void __init setup_ioapic_ids_from
  *	- if this function detects that timer IRQs are defunct, then we fall
  *	  back to ISA timer IRQs
  */
-static int __init timer_irq_works(void)
+int __init timer_irq_works(void)
 {
 	unsigned long t1 = jiffies;
+
+	if (no_timer_check)
+		return 1;
 
 	local_irq_enable();
 	/* Let ten ticks pass... */
@@ -2219,7 +2231,7 @@ int timer_uses_ioapic_pin_0;
  * is so screwy.  Thanks to Brian Perkins for testing/hacking this beast
  * fanatically on his truly buggy board.
  */
-static inline void check_timer(void)
+static inline void __init check_timer(void)
 {
 	int apic1, pin1, apic2, pin2;
 	int vector;
