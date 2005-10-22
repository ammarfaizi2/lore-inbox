Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965177AbVJVD6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965177AbVJVD6o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 23:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbVJVD6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 23:58:44 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:24454 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932584AbVJVD6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 23:58:43 -0400
Date: Sat, 22 Oct 2005 05:58:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: William Weston <weston@lysdexia.org>, cc@ccrma.Stanford.EDU,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>,
       Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Knecht <markknecht@gmail.com>
Subject: Re: 2.6.14-rc4-rt7
Message-ID: <20051022035851.GC12751@elte.hu>
References: <1129599029.10429.1.camel@cmn3.stanford.edu> <20051018072844.GB21915@elte.hu> <1129669474.5929.8.camel@cmn3.stanford.edu> <Pine.LNX.4.58.0510181423200.19498@echo.lysdexia.org> <20051019111943.GA31410@elte.hu> <1129835571.14374.11.camel@cmn3.stanford.edu> <20051020191620.GA21367@elte.hu> <1129852531.5227.4.camel@cmn3.stanford.edu> <20051021080504.GA5088@elte.hu> <1129937138.5001.4.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129937138.5001.4.camel@cmn3.stanford.edu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> Here's one with rc5-rt3:
> 
> Oct 21 15:01:46 cmn3 kernel: BUG: ktimer expired short without user
> signal! (hald-addon-stor:4309)

and no "BUG: foo:1234 waking up bar:4321, expiring ktimer short" message 
prior to that? Very weird, this line:

> Oct 21 15:01:46 cmn3 kernel: .. expires:   1012/751245500
> Oct 21 15:01:46 cmn3 kernel: .. expired:   1012/750908115
> Oct 21 15:01:46 cmn3 kernel: .. at line:   942

suggests that the ktimer was expired by ktimer_try_to_cancel() / 
ktimer_cancel(), in ktimer_schedule(). I.e. something must have woken 
the task early. Probably this theory of mine is incorrect then. I'll try 
extend the debug info a bit: it would be interesting to see a 'timer 
inserted at' timestamp as well (was it shortly before the problem 
happened?), and a 'which PID cancelled the timer' info.

a heavy-hitting but complex-to-set-up solution would be to add a serial 
console, and to enable WAKEUP_TIMING+LATENCY_TRACING in the .config, and 
to edit kernel/latency.c to initialize the default value of the 
following variables:

int wakeup_timing = 0;
int trace_all_cpus = 1;
int trace_freerunning = 1;
int trace_print_at_crash = 1;
int trace_user_triggered = 1;

these variables are in the top portion of latency.c. Important: if you 
try this then you should probably also enable IGNORE_PRINTK_LOGLEVEL, 
which will improve mass-output to the serial console. Another important 
thing is to add a stop_trace() call to kernel/ktimers.c's 
check_ktimer_signal() function:

        unlock_ktimer_base(timer, &flags);

        stop_trace();
        printk("BUG: ktimer expired short without user signal! (%s:%d)\n",
                current->comm, current->pid);

(otherwise all the trace output you'd be getting would be boring printk 
related trace entries.)

this will cause the dump_stack() to also output thousands of trace 
entries - all the kernel activity (from all CPUs) that preceded the 
ktimer problem. Hopefully this pinpoints the bug.

> In both cases the machine goes catatonic, I don't know if right after 
> this or not. It responds to the SysRQ key but that's pretty much it, I 
> should probably try to get a serial console going somehow.

would it be easy for you to try the UP kernel? One possibility is that 
this is some sort of SMP/APIC-timer related problem.

	Ingo
