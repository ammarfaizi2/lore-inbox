Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264569AbSIVWLR>; Sun, 22 Sep 2002 18:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264571AbSIVWLR>; Sun, 22 Sep 2002 18:11:17 -0400
Received: from mx2.elte.hu ([157.181.151.9]:43470 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S264569AbSIVWLQ>;
	Sun, 22 Sep 2002 18:11:16 -0400
Date: Mon, 23 Sep 2002 00:24:39 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
In-Reply-To: <3D8E3FA9.7389A61F@opersys.com>
Message-ID: <Pine.LNX.4.44.0209230021260.28641-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 22 Sep 2002, Karim Yaghmour wrote:

> > (this is in essence a moving spinlock at the tail of the trace buffer -
> > same problem.)
> 
> Hmm. No offense, but I think you ought to take a better look at the
> code.

i have, and i see stuff like this:

+       TRACE_PROCESS(TRACE_EV_PROCESS_WAKEUP, p->pid, p->state);

+static inline void TRACE_PROCESS(u8 ev_id, u32 data1, u32 data2)
+{
+       trace_process proc_event;
+
+       proc_event.event_sub_id = ev_id;
+       proc_event.event_data1 = data1;
+       proc_event.event_data2 = data2;
+
+       trace_event(TRACE_EV_PROCESS, &proc_event);
+}

where trace_event() is defined as:

+int trace_event(u8 pm_event_id,
+               void *pm_event_struct)
[...]
+       read_lock(&tracer_register_lock);

ie. it's using a global spinlock. (sure, it can be made lockless, as other
tracers have done it.)

	Ingo

