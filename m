Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbTHUDnW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 23:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbTHUDnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 23:43:22 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:7379 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262391AbTHUDnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 23:43:19 -0400
Subject: Re: CPU boot problem on 2.6.0-test3-bk8
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Theurer <habanero@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <200308202013.51702.habanero@us.ibm.com>
References: <200308201658.05433.habanero@us.ibm.com>
	 <1061427779.9371.318.camel@nighthawk>
	 <200308202013.51702.habanero@us.ibm.com>
Content-Type: multipart/mixed; boundary="=-6FgK2s6uSK2mFMEFKXqR"
Organization: 
Message-Id: <1061437329.15363.92.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 20 Aug 2003 20:42:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6FgK2s6uSK2mFMEFKXqR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2003-08-20 at 18:13, Andrew Theurer wrote:
> On Wednesday 20 August 2003 20:02, Dave Hansen wrote:
> > On Wed, 2003-08-20 at 14:58, Andrew Theurer wrote:
> > > Maybe this is already known, but just in case:
> > > I cannot fully boot on an x440 system with 2.6.0-test3-bk8.  The kernel
> > > tries to boot more than the 16 logical processors, and after failing (no
> > > response) on cpus 16, 17, and 18, it still thinks it has 19 cpus total. 
> > > It finally gets stuck at "checking TSC synchronization across 19 CPUs:"
> > >
> > > Attached is the boot log.  Any ideas? I'll try -test3-bk7 next
> >
> > Can you see if it works without HT on?  Did it work on plain -test3?
> > My 16-way x440 with no HT boots fine on test3.
> 
> I'll try without HT to see what happens.  FWIW, it boots fine with HT if I set 
> maxcpus=16.  I am wondering if (apicid == BAD_APIC) test is not working in 
> smp_boot_cpus.

Hmmm.  This is looking like fallout from the massive wli-bomb.  Here's
the loop that controls the cpu booting, before and after cpumask_t:

-	for (bit = 0; kicked < NR_CPUS && bit < BITS_PER_LONG; bit++) +	for
(bit = 0; kicked < NR_CPUS && bit < MAX_APICS; bit++)
		apicid = cpu_present_to_apicid(bit);

"kicked" only gets incremented for CPUs that were successfully booted,
so it doesn't help terminate the loop much.  MAX_APICS is 256 on summit,
which is *MUCH* bigger than BITS_PER_LONG. 
cpu_2_logical_apicid[NR_CPUS] which is referenced from
cpu_present_to_apicid() is getting referenced up to MAX_APICs, which is
bigger than NR_CPUS.  Overflow.  Bang.  garbage != BAD_APICID :)

Attached patch fixes it.  We sure do have a lot of duplicate code in the
subarches.  <sigh>
-- 
Dave Hansen
haveblue@us.ibm.com

--=-6FgK2s6uSK2mFMEFKXqR
Content-Disposition: attachment; filename=cpu_to_logical_apicid-fix-2.6.0-test3-bk8-0.patch
Content-Type: text/x-patch; name=cpu_to_logical_apicid-fix-2.6.0-test3-bk8-0.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff -urp linux-2.6.0-test3-clean/include/asm-i386/mach-bigsmp/mach_apic.h linux-2.6.0-test3-work/include/asm-i386/mach-bigsmp/mach_apic.h
--- linux-2.6.0-test3-clean/include/asm-i386/mach-bigsmp/mach_apic.h	Wed Aug 20 19:54:32 2003
+++ linux-2.6.0-test3-work/include/asm-i386/mach-bigsmp/mach_apic.h	Wed Aug 20 20:23:52 2003
@@ -98,6 +98,8 @@ extern u8 cpu_2_logical_apicid[];
 /* Mapping from cpu number to logical apicid */
 static inline int cpu_to_logical_apicid(int cpu)
 {
+       if (cpu >= NR_CPUS)
+	       return BAD_APICID;
        return (int)cpu_2_logical_apicid[cpu];
  }
 
diff -urp linux-2.6.0-test3-clean/include/asm-i386/mach-es7000/mach_apic.h linux-2.6.0-test3-work/include/asm-i386/mach-es7000/mach_apic.h
--- linux-2.6.0-test3-clean/include/asm-i386/mach-es7000/mach_apic.h	Wed Aug 20 19:54:32 2003
+++ linux-2.6.0-test3-work/include/asm-i386/mach-es7000/mach_apic.h	Wed Aug 20 20:23:56 2003
@@ -123,6 +123,8 @@ extern u8 cpu_2_logical_apicid[];
 /* Mapping from cpu number to logical apicid */
 static inline int cpu_to_logical_apicid(int cpu)
 {
+       if (cpu >= NR_CPUS)
+	       return BAD_APICID;
        return (int)cpu_2_logical_apicid[cpu];
 }
 
diff -urp linux-2.6.0-test3-clean/include/asm-i386/mach-numaq/mach_apic.h linux-2.6.0-test3-work/include/asm-i386/mach-numaq/mach_apic.h
--- linux-2.6.0-test3-clean/include/asm-i386/mach-numaq/mach_apic.h	Wed Aug 20 19:54:32 2003
+++ linux-2.6.0-test3-work/include/asm-i386/mach-numaq/mach_apic.h	Wed Aug 20 20:23:59 2003
@@ -60,6 +60,8 @@ static inline physid_mask_t ioapic_phys_
 extern u8 cpu_2_logical_apicid[];
 static inline int cpu_to_logical_apicid(int cpu)
 {
+       if (cpu >= NR_CPUS)
+	       return BAD_APICID;
 	return (int)cpu_2_logical_apicid[cpu];
 }
 
diff -urp linux-2.6.0-test3-clean/include/asm-i386/mach-summit/mach_apic.h linux-2.6.0-test3-work/include/asm-i386/mach-summit/mach_apic.h
--- linux-2.6.0-test3-clean/include/asm-i386/mach-summit/mach_apic.h	Wed Aug 20 19:54:32 2003
+++ linux-2.6.0-test3-work/include/asm-i386/mach-summit/mach_apic.h	Wed Aug 20 20:24:03 2003
@@ -80,6 +80,8 @@ static inline int apicid_to_node(int log
 extern u8 cpu_2_logical_apicid[];
 static inline int cpu_to_logical_apicid(int cpu)
 {
+       if (cpu >= NR_CPUS)
+	       return BAD_APICID;
 	return (int)cpu_2_logical_apicid[cpu];
 }
 

--=-6FgK2s6uSK2mFMEFKXqR--

