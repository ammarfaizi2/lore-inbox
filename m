Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264629AbSIWACc>; Sun, 22 Sep 2002 20:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264630AbSIWACc>; Sun, 22 Sep 2002 20:02:32 -0400
Received: from igw3.watson.ibm.com ([198.81.209.18]:6616 "EHLO
	igw3.watson.ibm.com") by vger.kernel.org with ESMTP
	id <S264629AbSIWAC3>; Sun, 22 Sep 2002 20:02:29 -0400
From: bob <bob@watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Sun, 22 Sep 2002 20:07:26 -0400 (EDT)
To: Ingo Molnar <mingo@elte.hu>
Cc: bob <bob@watson.ibm.com>, Karim Yaghmour <karim@opersys.com>,
       <okrieg@us.ibm.com>, <trz@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [ltt-dev] Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
In-Reply-To: <Pine.LNX.4.44.0209230108001.3792-100000@localhost.localdomain>
References: <15758.18582.488305.152950@k42.watson.ibm.com>
	<Pine.LNX.4.44.0209230108001.3792-100000@localhost.localdomain>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <15758.22318.507460.859271@k42.watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes this is simple code - similar to the model we use in K42.  Still,
couple of things about the below.  

1) the !event_wanted can be done outside the function, in a macro so that
the only cost if tracing is disabled is a hot cache hit on a mask (not
function call) - that helps with your comment:
> The event_wanted() filter function should be made as fast as possible.

2) If you use the lockless scheme you do not need to disable interrupts.
In K42 we manage to do the entire log operation in 21 instructions and
about as many cycles (couple more for getting time).  We do this from user
space as well, disabling interrupts precludes this model (may of may not be
a problem).  I was really leaning hard away from even the cost of making a
system call and disabling interrupts.  Do people on the kernel dev team
feel this is an acceptable cost?  Is migration prevented when interrupts
are disabled?  This is something for us to consider.

3) All trace events should not have to have the same number of data words
logged - though I think that's just a packaging/interface issue the code
below would just be placed behind macros which correctly package up the
right number of arguments.


Ingo Molnar writes:
 > 
 > this is that a trace point should do, at most:
 > 
 > --------------------->
 > task_t *tracer_task;
 > 
 > int curr_idx[NR_CPUS];
 > int curr_pending[NR_CPUS];
 > 
 > struct trace_event **trace_ring;
 > 
 > void trace(event, data1, data2, data3)
 > {
 > 	int cpu = smp_processor_id();
 > 	int idx, pending, *curr = curr_idx + cpu;
 > 	struct trace_event *t;
 > 	unsigned long flags;
 > 
 > 	if (!event_wanted(current, event, data1, data2, data3))
 > 		return;
 > 
 > 	local_irq_save(flags);
 > 
 >         idx = ++curr_idx[cpu] & (NR_TRACE_ENTRIES - 1);
 > 	pending = ++curr_pending[cpu];
 > 
 >         t = trace_ring[cpu] + idx;
 > 
 >         t->event = event;
 >         rdtscll(t->timestamp);
 >         t->data1 = data1;
 >         t->data2 = data2;
 >         t->data3 = data3;
 > 
 > 	if (curr_pending == TRACE_LOW_WATERMARK && tracer_task)
 > 		wake_up_process(tracer_task);
 > 
 > 	local_irq_restore(flags);
 > }
 > 
 > this should cover most of what's needed. The event_wanted() filter
 > function should be made as fast as possible. Note that the irq-disabled
 > section is not strictly needed but nice and also makes it work on the
 > preemptible kernel. (It's not a big issue at all to run these few
 > instructions with irqs disabled.)
 > 
 > [there are also other details like putting curr_index and curr_pending
 > into the per-cpu area and similar stuff.]
 > 
 > 	Ingo
 > 
 > 
 > _______________________________________________
 > ltt-dev mailing list
 > ltt-dev@listserv.shafik.org
 > http://www.listserv.shafik.org/listserv/listinfo/ltt-dev
