Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270978AbTHFSnm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 14:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270991AbTHFSnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 14:43:42 -0400
Received: from [66.212.224.118] ([66.212.224.118]:3598 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S270978AbTHFSnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 14:43:33 -0400
Date: Wed, 6 Aug 2003 14:31:46 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: john stultz <johnstul@us.ibm.com>
Cc: =?ISO-8859-1?Q?Mathias_Fr=F6hlich?= <Mathias.Froehlich@web.de>,
       lkml <linux-kernel@vger.kernel.org>, Mark Haverkamp <markh@osdl.org>,
       Dave Jones <davej@suse.de>
Subject: Re: [RFC][PATCH] linux-2.6.0-test2_mtrr-race-fix_A0
In-Reply-To: <1060190104.10732.52.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.53.0308061423080.7244@montezuma.mastecende.com>
References: <200308061052.18550.Mathias.Froehlich@web.de>
 <1060190104.10732.52.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Aug 2003, john stultz wrote:

> On Wed, 2003-08-06 at 01:52, Mathias Fröhlich wrote:

> > You should not remove the barrier past mtrr change. If you do that, it is 
> > possible that cpu's run with inconsistent mtrrs. This can have bad 
> > sideeffects since at least the cache snooping protocol used by intel uses 
> > assumptions about the cachability of memory regions. Those information about 
> > the cachability is also taken from the mtrrs as far as I remember.
> > This intel cpu developer manual, which documented the early PII and PPro 
> > chips, recommended this algorithm. Since actual intel cpus use the same old 
> > cpu to chipset bus protocol, this old documentation most propably still 
> > applies.
> 
> Hmm. I should dig up that doc. Its a little hazy in my mind, but I think
> I understand your description. I'm glad you caught this, as I can't
> imagine the subtle bugs that might have popped up. 
> 
> Well, let me look at it again and see if I can come up with a proper
> fix. 

The intel manual (10-36 Memory Cache Control - vol3) actually recommends 
the following procedure I was a bit anal about explicitely setting and 
clearing flags and used the specific TLB flush via cr3->reg->cr3. John 
could you give this a spin on your afflicted systems?

Index: linux-2.5/arch/i386/kernel/cpu/mtrr/generic.c
===================================================================
RCS file: /home/cvs/linux-2.5/arch/i386/kernel/cpu/mtrr/generic.c,v
retrieving revision 1.8
diff -u -p -B -r1.8 generic.c
--- linux-2.5/arch/i386/kernel/cpu/mtrr/generic.c	15 Feb 2003 20:30:00 -0000	1.8
+++ linux-2.5/arch/i386/kernel/cpu/mtrr/generic.c	6 Aug 2003 17:05:59 -0000
@@ -8,6 +8,7 @@
 #include <asm/msr.h>
 #include <asm/system.h>
 #include <asm/cpufeature.h>
+#include <asm/tlbflush.h>
 #include "mtrr.h"
 
 struct mtrr_state {
@@ -241,19 +242,22 @@ static void prepare_set(void)
 	   more invasive changes to the way the kernel boots  */
 	spin_lock(&set_atomicity_lock);
 
+	/*  Enter the no-fill (CD=1, NW=0) cache mode and flush caches. */
+	cr0 = read_cr0() | 0x40000000;	/* set CD flag */
+	cr0 &= ~(0x20000000);		/* clear NW flag */
+	wbinvd();
+	write_cr0(cr0);
+	wbinvd();
+
 	/*  Save value of CR4 and clear Page Global Enable (bit 7)  */
 	if ( cpu_has_pge ) {
 		cr4 = read_cr4();
 		write_cr4(cr4 & (unsigned char) ~(1 << 7));
 	}
 
-	/*  Disable and flush caches. Note that wbinvd flushes the TLBs as
-	    a side-effect  */
-	cr0 = read_cr0() | 0x40000000;
-	wbinvd();
-	write_cr0(cr0);
-	wbinvd();
-
+	/* Flush all TLBs via a mov %cr3, %reg; mov %reg, %cr3 */
+	__flush_tlb();
+	
 	/*  Save MTRR state */
 	rdmsr(MTRRdefType_MSR, deftype_lo, deftype_hi);
 
@@ -263,14 +267,18 @@ static void prepare_set(void)
 
 static void post_set(void)
 {
+	unsigned long cr0;
+
 	/*  Flush caches and TLBs  */
 	wbinvd();
+	__flush_tlb();
 
 	/* Intel (P6) standard MTRRs */
 	wrmsr(MTRRdefType_MSR, deftype_lo, deftype_hi);
 		
-	/*  Enable caches  */
-	write_cr0(read_cr0() & 0xbfffffff);
+	/*  Enable caches, clear previously set CD flag */
+	cr0 = read_cr0() & ~(0x40000000);
+	write_cr0(cr0);
 
 	/*  Restore value of CR4  */
 	if ( cpu_has_pge )
