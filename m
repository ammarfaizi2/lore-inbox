Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269028AbUHaT0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269028AbUHaT0G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 15:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268993AbUHaTYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:24:08 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:26321 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269027AbUHaTVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:21:08 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Schmitt <pnambic@unu.nu>, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
In-Reply-To: <20040831070658.GA31117@elte.hu>
References: <200408282210.03568.pnambic@unu.nu>
	 <20040828203116.GA29686@elte.hu>
	 <1093727453.8611.71.camel@krustophenia.net>
	 <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net>
	 <1093737080.1385.2.camel@krustophenia.net>
	 <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu>
	 <20040830090608.GA25443@elte.hu> <1093934448.5403.4.camel@krustophenia.net>
	 <20040831070658.GA31117@elte.hu>
Content-Type: text/plain
Message-Id: <1093980065.1603.5.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 31 Aug 2004 15:21:05 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-31 at 03:06, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Otherwise, this looks pretty good.  Here is a new one, I got this
> > starting X:
> > 
> > http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-bk4-Q5#/var/www/2.6.9-rc1-bk4-Q5/trace2.txt
> 
> ok, MTRR setting overhead. It is not quite clear to me which precise
> code took so much time, could you stick a couple of 'mcount();' lines
> into arch/i386/kernel/cpu/mtrr/generic.c's prepare_set() and
> generic_set_mtrr() functions? In particular the wbinvd() [cache
> invalidation] instructions within prepare_set() look like a possible
> source of latency.
> 
> (explicit calls to mcount() can be used to break up latency paths
> manually - they wont affect the latency itself, they make the resulting
> trace more finegrained.)

OK, here is the trace after adding a bunch of mcount()s:

preemption latency trace v1.0.2
-------------------------------
 latency: 713 us, entries: 31 (31)
    -----------------
    | task: X/1398, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: cond_resched+0xd/0x40
 => ended at:   sys_ioctl+0xdf/0x290
=======>
00000001 0.000ms (+0.000ms): touch_preempt_timing (cond_resched)
00000001 0.000ms (+0.000ms): generic_get_mtrr (mtrr_add_page)
00000001 0.001ms (+0.000ms): generic_get_mtrr (mtrr_add_page)
00000001 0.002ms (+0.000ms): generic_get_mtrr (mtrr_add_page)
00000001 0.002ms (+0.000ms): generic_get_mtrr (mtrr_add_page)
00000001 0.003ms (+0.000ms): generic_get_mtrr (mtrr_add_page)
00000001 0.004ms (+0.000ms): generic_get_mtrr (mtrr_add_page)
00000001 0.004ms (+0.000ms): generic_get_mtrr (mtrr_add_page)
00000001 0.005ms (+0.000ms): generic_get_mtrr (mtrr_add_page)
00000001 0.005ms (+0.000ms): generic_get_free_region (mtrr_add_page)
00000001 0.006ms (+0.000ms): generic_get_mtrr (generic_get_free_region)
00000001 0.006ms (+0.000ms): generic_get_mtrr (generic_get_free_region)
00000001 0.007ms (+0.000ms): generic_get_mtrr (generic_get_free_region)
00000001 0.008ms (+0.000ms): generic_get_mtrr (generic_get_free_region)
00000001 0.008ms (+0.000ms): set_mtrr (mtrr_add_page)
00000001 0.009ms (+0.000ms): generic_set_mtrr (set_mtrr)
00000001 0.009ms (+0.000ms): generic_set_mtrr (set_mtrr)
00000001 0.009ms (+0.000ms): prepare_set (generic_set_mtrr)
00000002 0.010ms (+0.000ms): prepare_set (generic_set_mtrr)
00000002 0.010ms (+0.000ms): prepare_set (generic_set_mtrr)
00000002 0.375ms (+0.364ms): prepare_set (generic_set_mtrr)
00000002 0.375ms (+0.000ms): prepare_set (generic_set_mtrr)
00000002 0.526ms (+0.150ms): prepare_set (generic_set_mtrr)
00000002 0.534ms (+0.008ms): generic_set_mtrr (set_mtrr)
00000002 0.541ms (+0.007ms): generic_set_mtrr (set_mtrr)
00000002 0.548ms (+0.006ms): generic_set_mtrr (set_mtrr)
00000002 0.552ms (+0.004ms): post_set (generic_set_mtrr)
00000001 0.708ms (+0.155ms): set_mtrr (mtrr_add_page)
00000001 0.713ms (+0.005ms): sub_preempt_count (sys_ioctl)
00000001 0.714ms (+0.000ms): _mmx_memcpy (check_preempt_timing)
00000001 0.715ms (+0.000ms): kernel_fpu_begin (_mmx_memcpy)

And here is a patch showing where I added the mcount()s, with some extra
context for clarity:

--- linux-2.6.8.1-Q3-preemptible-hardirqs/arch/i386/kernel/cpu/mtrr/generic.c	2004-08-14 06:55:33.000000000 -0400
+++ linux-2.6.9-rc1-bk4-Q5/arch/i386/kernel/cpu/mtrr/generic.c	2004-08-31 15:05:36.000000000 -0400
@@ -234,28 +234,33 @@
 static spinlock_t set_atomicity_lock = SPIN_LOCK_UNLOCKED;
 
 static void prepare_set(void)
 {
 	unsigned long cr0;
 
 	/*  Note that this is not ideal, since the cache is only flushed/disabled
 	   for this CPU while the MTRRs are changed, but changing this requires
 	   more invasive changes to the way the kernel boots  */
 	spin_lock(&set_atomicity_lock);
 
 	/*  Enter the no-fill (CD=1, NW=0) cache mode and flush caches. */
+	mcount();
 	cr0 = read_cr0() | 0x40000000;	/* set CD flag */
+	mcount();
 	wbinvd();
+	mcount();
 	write_cr0(cr0);
+	mcount();
 	wbinvd();
+	mcount(); 
 
 	/*  Save value of CR4 and clear Page Global Enable (bit 7)  */
 	if ( cpu_has_pge ) {
 		cr4 = read_cr4();
 		write_cr4(cr4 & (unsigned char) ~(1 << 7));
 	}
 
 	/* Flush all TLBs via a mov %cr3, %reg; mov %reg, %cr3 */
 	__flush_tlb();
 
 	/*  Save MTRR state */
 	rdmsr(MTRRdefType_MSR, deftype_lo, deftype_hi);
@@ -305,38 +310,41 @@
 static void generic_set_mtrr(unsigned int reg, unsigned long base,
 			     unsigned long size, mtrr_type type)
 /*  [SUMMARY] Set variable MTRR register on the local CPU.
     <reg> The register to set.
     <base> The base address of the region.
     <size> The size of the region. If this is 0 the region is disabled.
     <type> The type of the region.
     <do_safe> If TRUE, do the change safely. If FALSE, safety measures should
     be done externally.
     [RETURNS] Nothing.
 */
 {
+	mcount();
 	prepare_set();
-
+	mcount();
 	if (size == 0) {
 		/* The invalid bit is kept in the mask, so we simply clear the
 		   relevant mask register to disable a range. */
 		wrmsr(MTRRphysMask_MSR(reg), 0, 0);
 	} else {
 		wrmsr(MTRRphysBase_MSR(reg), base << PAGE_SHIFT | type,
 		      (base & size_and_mask) >> (32 - PAGE_SHIFT));
+		mcount();
 		wrmsr(MTRRphysMask_MSR(reg), -size << PAGE_SHIFT | 0x800,
 		      (-size & size_and_mask) >> (32 - PAGE_SHIFT));
 	}
-
+	mcount();
 	post_set();
+	mcount();
 }
 
 int generic_validate_add_page(unsigned long base, unsigned long size, unsigned int type)
 {
 	unsigned long lbase, last;
 
 	/*  For Intel PPro stepping <= 7, must be 4 MiB aligned 
 	    and not touch 0x70000000->0x7003FFFF */
 	if (is_cpu(INTEL) && boot_cpu_data.x86 == 6 &&
 	    boot_cpu_data.x86_model == 1 &&
 	    boot_cpu_data.x86_mask <= 7) {
 		if (base & ((1 << (22 - PAGE_SHIFT)) - 1)) {


Lee

