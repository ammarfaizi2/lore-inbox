Return-Path: <linux-kernel-owner+w=401wt.eu-S964774AbXALRU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbXALRU3 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 12:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbXALRU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 12:20:29 -0500
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:55731 "EHLO
	tomts16-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932332AbXALRU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 12:20:28 -0500
Date: Fri, 12 Jan 2007 12:15:12 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 05/05] Linux Kernel Markers, non optimised architectures
Message-ID: <20070112171512.GB2888@Krystal>
References: <11685601382063-git-send-email-mathieu.desnoyers@polymtl.ca> <11685601404005-git-send-email-mathieu.desnoyers@polymtl.ca> <45A710F8.7000405@yahoo.com.au> <20070112050032.GA14100@Krystal> <45A71827.6020300@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <45A71827.6020300@yahoo.com.au>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 10:29:21 up 142 days, 12:36,  4 users,  load average: 0.36, 0.50, 0.45
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nick Piggin (nickpiggin@yahoo.com.au) wrote:
> Mathieu Desnoyers wrote:
> >* Nick Piggin (nickpiggin@yahoo.com.au) wrote:
> >
> >>Mathieu Desnoyers wrote:
> >>
> >>
> >>>+#define MARK(name, format, args...) \
> >>>+	do { \
> >>>+		static marker_probe_func *__mark_call_##name = \
> >>>+					__mark_empty_function; \
> >>>+		volatile static char __marker_enable_##name = 0; \
> >>>+		static const struct __mark_marker_c __mark_c_##name \
> >>>+			__attribute__((section(".markers.c"))) = \
> >>>+			{ #name, &__mark_call_##name, format } ; \
> >>>+		static const struct __mark_marker __mark_##name \
> >>>+			__attribute__((section(".markers"))) = \
> >>>+			{ &__mark_c_##name, &__marker_enable_##name } ; \
> >>>+		asm volatile ( "" : : "i" (&__mark_##name)); \
> >>>+		__mark_check_format(format, ## args); \
> >>>+		if (unlikely(__marker_enable_##name)) { \
> >>>+			preempt_disable(); \
> >>>+			(*__mark_call_##name)(format, ## args); \
> >>>+			preempt_enable_no_resched(); \
> >>
> >>Why not just preempt_enable() here?
> >>
> >
> >
> >Because the preempt_enable() macro contains preempt_check_resched(), which
> >may call preempt_schedule() which leads us to a call to schedule(). 
> >Therefore,
> >all those very interesting scheduler functions would cause an infinite
> >recursive scheduler call if we marked schedule() and used preempt_enable() 
> >in
> >the marker.
> 
> The vast majority of schedule() has preempt turned off, so that shouldn't
> be a problem, if you provide a comment.
> 
> >The primary goal for the markers (and the probes that attaches to them) is 
> >to
> >have the fewest side-effects possible : any kernel method called from an
> >instrumentation site adds this precise kernel method to the "cannot be
> >instrumented" list, which I want to keep as small possible.
> 
> OK, well one problem is that it can cause a resched event to be lost, so
> you might say it has more side-effects without checking resched.
> 

I agree : this a side-effect I pointed out in my LTTng presentation last
summer at OLS.

Here is a quick idea of the potentially problematic instrumentation points
(i386 example) :

- with the task_rq_lock held (therefore preemption is disabled, so it's not a
  problem)
sched.c wait_task_inactive()
sched.c try_to_wake_up()
sched.c wake_up_new_task()
sched.c sched_migrate_task()

sched.c schedule() after prepare_task_switch call, before context_switch call.
  Surrounded by preempt_disable(), preempt_enable_no_resched(), should be ok.

- IRQs : irq_enter()/irq_exit() calls in do_IRQ makes sure that the
  preempt_count is incremented. irq_enter() is called with interrupts still
  disabled.
kernel/irq/handle.c handle_IRQ_event()

- NMIs : nmi_enter() -> irq_enter() -> add_preempt_count(HARDIRQ_OFFSET) called
  with interrupts still disabled.
  Therefore, preemption is disabled within trace points in do_nmi.

- traps : GPF, do_trap, do_page_fault, do_debug, spurious_interrupt,
  math_emulate.
  It is not uncommon for these trap handlers to reenable interrupts very soon.
  They do not increment the preemption count.
  Therefore, preemption must be expected when these handlers run : we cannot
  rely of the fact that hard IRQs would be disabled to prevent the scheduler
  from running, as markers becomes a new source of scheduler events.

- local_irq_enable()/local_irq_disable() :
  It can call trace_hardirqs_on()/trace_hardirqs_off(). These macros are
  sprinkled in _every_ possible context cited above, from trap handlers to
  preemptible code.

Other contexts or code location are not a problem (process context, softirq).

If we are sure that we expect calls to preempt_schedule() from each of these
contexts, then it's ok to put preempt_enable(). It is important to note that a
marker would then act as a source of scheduler events in code paths where
disabling interrupts is expected to disable the scheduler.

Mathieu

-- 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
