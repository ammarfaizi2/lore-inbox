Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269634AbUICLtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269634AbUICLtL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 07:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269631AbUICLtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 07:49:11 -0400
Received: from mx2.elte.hu ([157.181.151.9]:8361 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269632AbUICLsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 07:48:15 -0400
Date: Fri, 3 Sep 2004 13:49:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Charbonnel <thomas@undata.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Free Ekanayaka <free@agnula.org>,
       Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, luke@audioslack.com, free78@tin.it
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
Message-ID: <20040903114949.GA29493@elte.hu>
References: <1094181447.4815.6.camel@orbiter> <1094192788.19760.47.camel@krustophenia.net> <20040903063658.GA11801@elte.hu> <1094194157.19760.71.camel@krustophenia.net> <20040903070500.GB13100@elte.hu> <1094197233.19760.115.camel@krustophenia.net> <87acw7bxkh.fsf@agnula.org> <1094198755.19760.133.camel@krustophenia.net> <20040903092547.GA18594@elte.hu> <1094211218.5453.3.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <1094211218.5453.3.camel@localhost>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Thomas Charbonnel <thomas@undata.org> wrote:

> I still get > 170 us latency from rtl8139 :
> http://www.undata.org/~thomas/R1_rtl8139.trace

this is a single-packet latency, we wont get much lower than this with
the current techniques. Disabling ip_conntrack and tracing ought to
lower the real latency somewhat.

> And again this one :
> preemption latency trace v1.0.5 on 2.6.9-rc1-VP-R1
> --------------------------------------------------
>  latency: 597 us, entries: 12 (12)
>     -----------------
>     | task: swapper/0, uid:0 nice:0 policy:0 rt_prio:0
>     -----------------
>  => started at: smp_apic_timer_interrupt+0x32/0xd0
>  => ended at:   smp_apic_timer_interrupt+0x86/0xd0
> =======>
> 00010000 0.000ms (+0.000ms): smp_apic_timer_interrupt (apic_timer_interrupt)
> 00010000 0.000ms (+0.000ms): profile_tick (smp_apic_timer_interrupt)
> 00010000 0.000ms (+0.000ms): profile_hook (profile_tick)
> 00010001 0.000ms (+0.595ms): notifier_call_chain (profile_hook)
> 00010000 0.595ms (+0.000ms): do_nmi (mcount)
> 00020000 0.596ms (+0.000ms): profile_tick (nmi_watchdog_tick)
> 00020000 0.596ms (+0.000ms): profile_hook (profile_tick)
> 00020001 0.597ms (+0.000ms): notifier_call_chain (profile_hook)
> 00020000 0.597ms (+689953.444ms): profile_hit (nmi_watchdog_tick)
> 00010001 689954.042ms (+1.141ms): update_process_times (do_timer)
> 00000001 0.597ms (+0.000ms): sub_preempt_count (smp_apic_timer_interrupt)
> 00000001 0.598ms (+0.000ms): update_max_trace (check_preempt_timing)

this is a pretty weird one. First it shows an apparently non-monotonic
RDTSC: the jump forward and backward in time around profile_hit. I
suspect the real RDTSC value was lower than the previous one and caused
an underflow. What is your cpu_khz in /proc/cpuinfo?

the other weird one is the +0.595 usec entry at notifier_call_chain(). 
That code is just a couple of instructions, so no real for any overhead 
there.

could you try the attached robust-get-cycles.patch ontop of your current
tree and see whether it impacts these weirdnesses? The patch makes sure
that the cycle counter is sane: two subsequent readings of it were
monotonic and less than 1000 cycles apart.

this patch probably wont remove the +0.595 msec latency though - the
RDTSC value jumped forward there permanently. Maybe the RDTSC value is
somehow corrupted by NMIs - could you turn off the NMI watchdog to
check?

	Ingo

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="robust-get-cycles.patch"

--- linux/kernel/latency.c.orig2	
+++ linux/kernel/latency.c	
@@ -66,6 +66,18 @@ static unsigned long notrace cycles_to_u
 	return (unsigned long) delta;
 }
 
+static cycles_t notrace robust_get_cycles(void)
+{
+	cycles_t t0 = get_cycles(), t1;
+
+	for (;;) {
+		t1 = get_cycles();
+		if (t1 - t0 < 1000)
+			return t1;
+		t0 = t1;
+	}
+}
+
 #ifdef CONFIG_LATENCY_TRACE
 
 unsigned int trace_enabled = 1;
@@ -89,7 +101,7 @@ ____trace(struct cpu_trace *tr, unsigned
 		entry = tr->trace + tr->trace_idx;
 		entry->eip = eip;
 		entry->parent_eip = parent_eip;
-		entry->timestamp = get_cycles();
+		entry->timestamp = robust_get_cycles();
 		entry->preempt_count = preempt_count();
 	}
 	tr->trace_idx++;
@@ -295,7 +307,7 @@ check_preempt_timing(struct cpu_trace *t
 		return;
 #endif
 	atomic_inc(&tr->disabled);
-	latency = cycles_to_usecs(get_cycles() - tr->preempt_timestamp);
+	latency = cycles_to_usecs(robust_get_cycles() - tr->preempt_timestamp);
 
 	if (preempt_thresh) {
 		if (latency < preempt_thresh)
@@ -337,7 +349,7 @@ check_preempt_timing(struct cpu_trace *t
 out:
 #ifdef CONFIG_LATENCY_TRACE
 	tr->trace_idx = 0;
-	tr->preempt_timestamp = get_cycles();
+	tr->preempt_timestamp = robust_get_cycles();
 #endif
 	tr->critical_start = parent_eip;
 	__trace(eip, parent_eip);
@@ -376,7 +388,7 @@ void notrace add_preempt_count(int val)
 		struct cpu_trace *tr = &__get_cpu_var(trace);
 
 		local_irq_save(flags);
-		tr->preempt_timestamp = get_cycles();
+		tr->preempt_timestamp = robust_get_cycles();
 		tr->critical_start = eip;
 #ifdef CONFIG_LATENCY_TRACE
 		tr->trace_idx = 0;

--x+6KMIRAuhnl3hBn--
