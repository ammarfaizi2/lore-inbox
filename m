Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264615AbSIVXTR>; Sun, 22 Sep 2002 19:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264616AbSIVXTQ>; Sun, 22 Sep 2002 19:19:16 -0400
Received: from mx2.elte.hu ([157.181.151.9]:26836 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S264615AbSIVXTQ>;
	Sun, 22 Sep 2002 19:19:16 -0400
Date: Mon, 23 Sep 2002 01:32:30 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: bob <bob@watson.ibm.com>
Cc: Karim Yaghmour <karim@opersys.com>, <okrieg@us.ibm.com>, <trz@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [ltt-dev] Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
In-Reply-To: <15758.18582.488305.152950@k42.watson.ibm.com>
Message-ID: <Pine.LNX.4.44.0209230108001.3792-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this is that a trace point should do, at most:

--------------------->
task_t *tracer_task;

int curr_idx[NR_CPUS];
int curr_pending[NR_CPUS];

struct trace_event **trace_ring;

void trace(event, data1, data2, data3)
{
	int cpu = smp_processor_id();
	int idx, pending, *curr = curr_idx + cpu;
	struct trace_event *t;
	unsigned long flags;

	if (!event_wanted(current, event, data1, data2, data3))
		return;

	local_irq_save(flags);

        idx = ++curr_idx[cpu] & (NR_TRACE_ENTRIES - 1);
	pending = ++curr_pending[cpu];

        t = trace_ring[cpu] + idx;

        t->event = event;
        rdtscll(t->timestamp);
        t->data1 = data1;
        t->data2 = data2;
        t->data3 = data3;

	if (curr_pending == TRACE_LOW_WATERMARK && tracer_task)
		wake_up_process(tracer_task);

	local_irq_restore(flags);
}

this should cover most of what's needed. The event_wanted() filter
function should be made as fast as possible. Note that the irq-disabled
section is not strictly needed but nice and also makes it work on the
preemptible kernel. (It's not a big issue at all to run these few
instructions with irqs disabled.)

[there are also other details like putting curr_index and curr_pending
into the per-cpu area and similar stuff.]

	Ingo

