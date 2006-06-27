Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWF0GCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWF0GCL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 02:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWF0GCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 02:02:11 -0400
Received: from liaag2ac.mx.compuserve.com ([149.174.40.152]:55469 "EHLO
	liaag2ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932095AbWF0GCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 02:02:08 -0400
Date: Tue, 27 Jun 2006 01:57:39 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.17.1 new perfmon code base, libpfm, pfmon available
To: "eranian@hpl.hp.com" <eranian@hpl.hp.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       perfctr-devel <perfctr-devel@lists.sourceforge.net>,
       linux-ia64 <linux-ia64@vger.kernel.org>,
       perfmon <perfmon@napali.hpl.hp.com>,
       oprofile-list <oprofile-list@lists.sourceforge.net>
Message-ID: <200606270159_MC3-1-C391-1A2A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060626223716.GA16082@frankl.hpl.hp.com>

On Mon, 26 Jun 2006 15:37:17 -0700, Stephane Eranian wrote:

> > 32-bit works great.  Unfortunately, pfmon is far too limited for serious kernel
> > monitoring AFAICT.  E.g. you can't select edge counting instead of cycle
> > counting.  So you can count how many clock cycles were spent with interrupts
> 
> I put in an option to enable this mode, do pfmon --help. I think it's called
> edge-mask.

Silly me, I was reading the documentation, which doesn't cover this. :)
It works:

$ pfmon --system-wide -0 -e interrupts_masked_cycles,interrupts_taken --edge-mask 0,1 -t 10
<session to end in 10 seconds>
CPU0    16359 INTERRUPTS_MASKED_CYCLES
CPU0     5006 INTERRUPTS_TAKEN

5006 hardware interrupts in 10 seconds, 16359 interrupt-disable events ==>
the kernel disabled interrupts 11353 times for critical sections.  To get
useful results it looks like booting with idle=poll and disabling cpufreq
is needed, though, since interrupts_masked_cycles (non-edge mode) counts
even when the CPU is halted:

$ pfmon --system-wide -0 -e interrupts_masked_cycles,cpu_clk_unhalted -t 10
<session to end in 10 seconds>
CPU0    352020255 INTERRUPTS_MASKED_CYCLES
CPU0     65351172 CPU_CLK_UNHALTED

> > And is someone working on kernel profiling tools that use the perfmon2
> > infrastructure on i386?  I'd like to see kernel-based profiling that lets
> > you use something like the existing 'readprofile' to retrieve results.  This
> > would be a lot better than the current timer-based profiling.
> > 
> You can do this on your athlon using pfmon already, you need to enable a
> different sampling module. Here is an example:
> 
> $ pfmon --smpl-module=inst-hist -ecpu_clk_unhalted -k --long-smpl-period=100000 \
>      --resolve-addr --system-wide --session-timeout=10

That produces no output except for column headings.  Thinking it was a problem with
x86_64 32-bit support, I built a p6 version.  I tried both short and long
periods on both systems with the same result:

$ pfmon --smpl-module=inst-hist -ecpu_clk_unhalted -k --short-smpl-period=100000 --resolve-addr --system-wide -t 10
only kernel symbols are resolved in system-wide mode
<session to end in 10 seconds>
# counts   %self    %cum code address
# counts   %self    %cum code address

And here's what it took to get everything working on Pentium II (seems OK, not
thoroughly tested:)
_

perfmon: add Pentium II support (family 6 model 3 only.)

--- 2.6.17.1-d4-pfmon.orig/arch/i386/perfmon/perfmon_p6.c
+++ 2.6.17.1-d4-pfmon/arch/i386/perfmon/perfmon_p6.c
@@ -76,6 +76,9 @@ static int pfm_p6_probe_pmu(void)
 	}
 
 	switch(cpu_data->x86_model) {
+		case 3:
+			PFM_INFO("Pentium II PMU detected");
+			break;
 		case 7 ... 11:
 			PFM_INFO("P6 core PMU detected");
 			break;
_

libpfm: Add Pentium II support (family 6 model 3 only.)

--- libpfm-3.2-060621.orig/lib/pfmlib_i386_p6.c
+++ libpfm-3.2-060621/lib/pfmlib_i386_p6.c
@@ -136,6 +136,7 @@ pfm_i386_p6_detect(void)
 		return PFMLIB_ERR_NOTSUPP;
 
 	switch(model) {
+		case 3: /* Pentium II */
 		case 7: /* Pentium III Katmai */
 		case 8: /* Pentium III Coppermine */
 		case 9: /* Mobile Pentium III */
_

pfmon: don't build gen_ia32 sample module if not configured.

--- pfmon-3.2-060621.orig/pfmon/pfmon_smpl.c
+++ pfmon-3.2-060621/pfmon/pfmon_smpl.c
@@ -61,6 +61,8 @@ static pfmon_smpl_module_t *smpl_modules
 #endif
 #ifdef CONFIG_PFMON_I386_P6
 	&detailed_i386_p6_smpl_module, /* must be first for P6 */
+#endif
+#ifdef CONFIG_PFMON_GEN_IA32
 	&detailed_gen_ia32_smpl_module, /* must be last for I386 */
 #endif
 	&inst_hist_smpl_module,		/* works for any PMU model */
-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
