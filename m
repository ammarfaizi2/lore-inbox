Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbTGHSMT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 14:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265176AbTGHSMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 14:12:19 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:43911 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265161AbTGHSMR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 14:12:17 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 8 Jul 2003 11:19:17 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Daniel Phillips <phillips@arcor.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.74-mm1
In-Reply-To: <200307081309.30651.phillips@arcor.de>
Message-ID: <Pine.LNX.4.55.0307080846520.4544@bigblue.dev.mcafeelabs.com>
References: <20030703023714.55d13934.akpm@osdl.org> <200307080307.18018.phillips@arcor.de>
 <Pine.LNX.4.55.0307072314490.3597@bigblue.dev.mcafeelabs.com>
 <200307081309.30651.phillips@arcor.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jul 2003, Daniel Phillips wrote:

> On Tuesday 08 July 2003 09:48, Davide Libenzi wrote:
> > On Tue, 8 Jul 2003, Daniel Phillips wrote:
> > > 4. So how do you propose to "program timings" so that it's really hard to
> > > miss those deadlines?
> >
> > Having a backup of 400-500ms gives you an average hang-over of 200-250ms
> > that are hardly noticeable by a human in this topic. The issue is not if
> > you always meet the deadline, the issue is what amount of load will make
> > you miss it.
>
> With realtime scheduling, you will make the deadline regardless of load (and
> there is the normal fudge when you add the word "soft").  You're arguing that
> having your sound skip, so long as it only skips under load, is good enough.
> I'm arguing that, no, that sucks too much, it should never skip.  I'll also
> argue that even on 2.4, sound skips under normal loads if your machine isn't
> very fast.
>
> So let's fix this properly, instead of wrapping on more duct tape.
>
> Now, I will not argue that -nice+mingo+con is a proper realtime approach, but
> I will argue that it's considerably better than just fiddling with buffer
> size and hoping for the best.

If you seek to meet the dead under any load, there's no patch that uses
the timeslice driven scheduling that will work. You need a non-timeslice
driven scheduling like SCHED_RR (and talking about realtime, it is not
even sufficent with Linux). Since the POSIX SCHED_RR definition cannot be
allowed to be used w/out superuser rights for obvious starvation issues
that might cause of other tasks, we would really need either to push
a new POSIX defintion or to modify the SCHED_RR behaviour if called from a
non-superuser account. For example, a slot above all standard priorities
and below RT priorities should be reserved to host those pseudo-rt tasks,
whose dynamic priority will not decay but that they might expire if they
abuse of a predetermined CPU utilization policy. Basically their timeslice
will vary depending on the CPU utilization pattern and they might end up
in the expired array if they abuse it. For example, when one of those
internally mapped SCHED_SOFTRR tasks will expire we will recalc their
timelisce like we are doing now and we will also register for the
timestamp (jiffies) when the got recharged. If (jiffies - last_charge) is
lower then a pre-defined threshold we drop the task in expired array,
otherwise in the active one. This will make our SCHED_SOFTRR to be able to
always preempt SCHED_OTHER tasks and the above trick will also avoid
starvation.



- Davide

