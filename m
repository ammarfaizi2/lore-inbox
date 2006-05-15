Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWEOHG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWEOHG2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 03:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWEOHG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 03:06:28 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:31641 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932354AbWEOHG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 03:06:27 -0400
Date: Mon, 15 May 2006 03:04:14 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Daniel Walker <dwalker@mvista.com>
cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -rt] scheduling while atomic in fs/file.c
In-Reply-To: <Pine.LNX.4.58.0605150239570.6512@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.58.0605150254440.6512@gandalf.stny.rr.com>
References: <200605141545.k4EFj6Cv001901@dwalker1.mvista.com> 
 <Pine.LNX.4.58.0605141241320.25158@gandalf.stny.rr.com>
 <1147627976.15392.39.camel@c-67-180-134-207.hsd1.ca.comcast.net>
 <Pine.LNX.4.58.0605150239570.6512@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 15 May 2006, Steven Rostedt wrote:

> On Sun, 14 May 2006, Daniel Walker wrote:
>
> > On Sun, 2006-05-14 at 12:44 -0400, Steven Rostedt wrote:
> > > On Sun, 14 May 2006, Daniel Walker wrote:
> > >
> > > > Quite the smp_processor_id() wanrings. I don't see any SMP
> > > > concerns here . It just adds to a percpu list, so it shouldn't
> > > > matter if it switches after sampling fdtable_defer_list .
> > >
> > > I'm not so sure that there isn't SMP concerns here. I have to catch a
> > > train in a few minutes, otherwise I would look deeper into this. But this
> > > might be a candidate to turn fdtable_defer_list into a per_cpu_locked.
> >
> > I reviewed it again, and it looks like these percpu structures have a
> > spinlock to protect the list from being emptied by a work queue while
> > things are being added to the list . The lock appears to be used
> > properly .  The work queue frees struct fdtable pointers added to the
> > list , the only place these structures are added is in the block I've
> > modified .
> >
> > I think making this a locked percpu would just be overkill ..
> >
>
> It seems that the timer is percpu. So it has a timer for each cpu.  If you
> switch CPUs after the put, the modtimer might put the fddef->timer onto
> another CPU, and thus have more than one going off on the same CPU.
>

Just to clarify, although fdtable_defer_list_init(int cpu) creates a timer
for each CPU but sets them to the same CPU.  The mod_timer in the changed
function is what is used to spread the timers out.

Although your patch wont actually break anything, since it is unlikely
that the timer would be moved, and if it was, it would probably be put
back again. The design is just not clean.  It's best to keep the timer
where it is.

So I'm NACKing the current patch.

-- Steve

