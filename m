Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131270AbRDBUBq>; Mon, 2 Apr 2001 16:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131300AbRDBUB1>; Mon, 2 Apr 2001 16:01:27 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:453 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S131270AbRDBUBZ>; Mon, 2 Apr 2001 16:01:25 -0400
Message-ID: <3AC8D95E.7E3A68B0@mvista.com>
Date: Mon, 02 Apr 2001 12:56:14 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: nigel@nrg.org
CC: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel
In-Reply-To: <Pine.LNX.4.05.10104011408460.14420-100000@cosmic.nrg.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Gamble wrote:
> 
> On Sat, 31 Mar 2001, george anzinger wrote:
> > I think this should be:
> >                 if (p->has_cpu || p->state & TASK_PREEMPTED)) {
> > to catch tasks that were preempted with other states.
> 
> But the other states are all part of the state change that happens at a
> non-preemtive schedule() point, aren't they, so those tasks are already
> safe to access the data we are protecting.
> 
If your saying that the task's "thinking" about a state change is
sufficient, ok.  The point is that a task changes it state prior to
calling schedule() and then, sometimes, doesn't call schedule and just
changes its state back to running.  Preemption can happen at any of
these times, after all that is what the TASK_PREEMPTED flag is used for.

On a higher level, I think the scanning of the run list to set flags and
counters is a bit off.  If these things need to be counted and kept
track of, the tasks should be doing it "in the moment" not some other
task at some distant time.  For example if what is being protected is a
data structure, a counter could be put in the structure that keeps track
of the number of tasks that are interested in seeing it stay around.  As
I understand the objective of the method being explored, a writer wants
to change the structure, but old readers can continue to use the old
while new readers get the new structure.  The issue then is when to
"garbage collect" the no longer used structures.  It seems to me that
the pointer to the structure can be changed to point to the new one when
the writer has it set up.  Old users continue to use the old.  When they
are done, they decrement the use count.  When the use count goes to
zero, it is time to "garbage collect".  At this time, the "garbage man"
is called (one simple one would be to check if the structure is still
the one a "new" task would get).  Various methods exist for determing
how and if the "garbage man" should be called, but this sort of thing,
IMNSHO, does NOT belong in schedule().

George
