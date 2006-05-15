Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWEOGqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWEOGqA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 02:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWEOGqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 02:46:00 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:25245 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932346AbWEOGp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 02:45:59 -0400
Date: Mon, 15 May 2006 02:43:52 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Daniel Walker <dwalker@mvista.com>
cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -rt] scheduling while atomic in fs/file.c
In-Reply-To: <1147627976.15392.39.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Message-ID: <Pine.LNX.4.58.0605150239570.6512@gandalf.stny.rr.com>
References: <200605141545.k4EFj6Cv001901@dwalker1.mvista.com> 
 <Pine.LNX.4.58.0605141241320.25158@gandalf.stny.rr.com>
 <1147627976.15392.39.camel@c-67-180-134-207.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 May 2006, Daniel Walker wrote:

> On Sun, 2006-05-14 at 12:44 -0400, Steven Rostedt wrote:
> > On Sun, 14 May 2006, Daniel Walker wrote:
> >
> > > Quite the smp_processor_id() wanrings. I don't see any SMP
> > > concerns here . It just adds to a percpu list, so it shouldn't
> > > matter if it switches after sampling fdtable_defer_list .
> >
> > I'm not so sure that there isn't SMP concerns here. I have to catch a
> > train in a few minutes, otherwise I would look deeper into this. But this
> > might be a candidate to turn fdtable_defer_list into a per_cpu_locked.
>
> I reviewed it again, and it looks like these percpu structures have a
> spinlock to protect the list from being emptied by a work queue while
> things are being added to the list . The lock appears to be used
> properly .  The work queue frees struct fdtable pointers added to the
> list , the only place these structures are added is in the block I've
> modified .
>
> I think making this a locked percpu would just be overkill ..
>

It seems that the timer is percpu. So it has a timer for each cpu.  If you
switch CPUs after the put, the modtimer might put the fddef->timer onto
another CPU, and thus have more than one going off on the same CPU.

-- Steve

