Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWDLG2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWDLG2L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 02:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbWDLG2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 02:28:10 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:25784 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751004AbWDLG2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 02:28:09 -0400
Date: Wed, 12 Apr 2006 08:25:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Serge Noiraud <serge.noiraud@bull.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PREEMPT_RT : 2.6.16-rt12 and boot : BUG ?
Message-ID: <20060412062559.GB8499@elte.hu>
References: <200604061416.00741.Serge.Noiraud@bull.net> <200604061705.36303.Serge.Noiraud@bull.net> <200604101446.13610.Serge.Noiraud@bull.net> <200604111815.25494.Serge.Noiraud@bull.net> <1144807126.26133.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144807126.26133.21.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > Why do we need such a size ?
> 
> It seems that the -rt kernel has increased the size of structures that 
> are used in modules and are defined per cpu.

i'm still wondering what that could be. The most drastic increase is the 
size of locks (spinlocks, mutexes, etc.), especially with debugging 
enabled - maybe one of the drivers uses a big per-CPU array of locks?

ah. One thing that takes up _alot_ of per-CPU space is the 
latency-histogram stuff. I made the latency tracer itself use 
non-per-cpu constructs to avoid overflowing the per-cpu-area, but the 
latency-histogram code still uses PER_CPU:

 #ifdef CONFIG_INTERRUPT_OFF_HIST
 static DEFINE_PER_CPU(hist_data_t, interrupt_off_hist);
 static char * interrupt_off_hist_proc_dir = "interrupt_off_latency";
 #endif

 #ifdef CONFIG_PREEMPT_OFF_HIST
 static DEFINE_PER_CPU(hist_data_t, preempt_off_hist);
 static char * preempt_off_hist_proc_dir = "preempt_off_latency";
 #endif

 #ifdef CONFIG_WAKEUP_LATENCY_HIST
 static DEFINE_PER_CPU(hist_data_t, wakeup_latency_hist);
 static char * wakeup_latency_hist_proc_dir = "wakeup_latency";
 #endif

of a quite large array:

 typedef struct hist_data_struct {
         atomic_t hist_mode; /* 0 log, 1 don't log */
         unsigned long min_lat;
         unsigned long avg_lat;
         unsigned long max_lat;
         unsigned long long beyond_hist_bound_samples;
         unsigned long long accumulate_lat;
         unsigned long long total_samples;
         unsigned long long hist_array[MAX_ENTRY_NUM];
 } hist_data_t;

where MAX_ENTRY_NUM is 10240 right now. So the space used up is 
10240*3*8 - roughly +256K per-cpu space!

I think that explains it. So the rule for -rt is, +256K more per-cpu 
area is needed if the latency histograms are turned on.

	Ingo
