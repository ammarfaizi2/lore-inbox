Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268893AbUHLXuC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268893AbUHLXuC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 19:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268894AbUHLXuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 19:50:02 -0400
Received: from mx2.elte.hu ([157.181.151.9]:46829 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268893AbUHLXtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 19:49:50 -0400
Date: Fri, 13 Aug 2004 01:51:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
Message-ID: <20040812235116.GA27838@elte.hu>
References: <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810132654.GA28915@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-1.524, required 5.9,
	autolearn=not spam, BAYES_01 -1.52
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i've uploaded the latest version of the voluntary-preempt patch:
     
  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc4-O6

during the past couple of weeks there has been a steady trend towards
rarer and harder to analyze latencies.

The preempt-timing patch was a nice starting point but it only prints
limited info about the beginning and the end of a critical section -
often leaving us in the dark about what happened within the critical
section. Often the trace only contains generic entry/exit points like
e.g. do_poll() which are not very helpful in determining the precise
reason for the latency.

so in -O6 i've implemented a 'latency tracer', which automatically
records all kernel functions called during a maximum-latency incident.
This typically means thousands of functions per critical section. I've
combined this tracer with the preempt-timing approach to produce a
pretty powerful tool to find & squash latencies.

there's a new /proc/latency_trace file that holds the current latency
trace (belonging to the previous high-latency event). It has a format
that is intended to make it as easy as possible for kernel developers to
fix any particular latency source. Audio developers and users can
generate such traces and send them along to kernel developers as text
files.

Sample use of the latency tracer:

E.g. the following incident:

 (default.hotplug/1470): 121 us critical section violates 100 us threshold.
  => started at: <kmap_high+0x2b/0x2d0>
  => ended at:   <kmap_high+0x1a9/0x2d0>
  [<c0105a23>] dump_stack+0x23/0x30
  [<c0140d14>] check_preempt_timing+0x184/0x1e0
  [<c0140e84>] sub_preempt_count+0x54/0x5d
  [<c0152959>] kmap_high+0x1a9/0x2d0
  [<c017655a>] copy_strings+0xea/0x230
  [<c01766db>] copy_strings_kernel+0x3b/0x50
  [<c017840d>] do_execve+0x12d/0x1f0
  [<c0103284>] sys_execve+0x44/0x80
  [<c0104b95>] sysenter_past_esp+0x52/0x71

this doesnt tell us too much about why it took 121 usecs to get from one
end of kmap_high() to the other end of kmap_high(). Looking at
/proc/latency_trace tells us the full story:

  preemption latency trace v1.0
  -----------------------------
   latency: 121 us, entries: 1032 (1032)
   process: default.hotplug/1470, uid: 0
   nice: -10, policy: 0, rt_priority: 0
  =======>
   0.000ms (+0.000ms): page_address (kmap_high)
   0.000ms (+0.000ms): page_slot (page_address)
   0.000ms (+0.000ms): flush_all_zero_pkmaps (kmap_high)
   0.000ms (+0.000ms): set_page_address (flush_all_zero_pkmaps)
  [...]
   0.118ms (+0.000ms): page_slot (set_page_address)
   0.118ms (+0.000ms): check_preempt_timing (sub_preempt_count)

it's the rare but possible call to flush_all_zero_pkmaps() that
generates this particular latency.

as can be seen in the above the example, the trace contains a header
portion and a trace line for every kernel function called. Only function
entries are recorded (not function returns) so i've added the parent
function to the trace too, for easier identification of the call
sequence.

there's a MAX_TRACE define in kernel/latency.c - set to 4000 currently -
this is the maximum number of function calls traced per critical
section. Feel free to increase/decrease this. The header portion shows
the true number of functions called in a critical section, e.g.:

   latency: 1531 us, entries: 4000 (16098)

tells us that there were 16098 trace entries but only the first 4000
were recorded.

-O6 also adds another timing option besides preempt_thresh: if
preempt_thresh is set to 0 then the tracer will automatically track the
largest-previous latency. (i.e. the system does a search for the
absolute maximum latency.) The /proc/sys/kernel/preempt_max_latency 
control can be used to reset this value to conduct a new search for a 
new workload, without having to reboot the system.

-O6 also does some SMP improvements: the IRQ threads now listen to the
/proc/irq/*/smp_affinity mask and bind themselves to the configured CPU. 
This means that e.g. the irqbalance daemon will work as expected.

-O6 also fixes and cleans up a number of other aspects of the
preempt-timing mechanism.

the latency tracer can be turned on/off via CONFIG_LATENCY_TRACE at
compile time. An active tracer means considerable runtime overhead. 
Especially code that does alot of small function calls will see a
performance hit. I'm seeing a ~10% overhead on a 2GHz system, but YMMV. 

reports, suggestions welcome,

	Ingo
