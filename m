Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbULNEcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbULNEcQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 23:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbULNEcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 23:32:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:33256 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261407AbULNEaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 23:30:08 -0500
Date: Mon, 13 Dec 2004 20:29:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: andrea@suse.de, kernel@kolivas.org, pavel@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
Message-Id: <20041213202939.12285212.akpm@osdl.org>
In-Reply-To: <29495f1d041213195451677dab@mail.gmail.com>
References: <20041211142317.GF16322@dualathlon.random>
	<20041212163547.GB6286@elf.ucw.cz>
	<20041212222312.GN16322@dualathlon.random>
	<41BCD5F3.80401@kolivas.org>
	<20041213030237.5b6f6178.akpm@osdl.org>
	<20041213111741.GR16322@dualathlon.random>
	<20041213032521.702efe2f.akpm@osdl.org>
	<29495f1d041213195451677dab@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nish Aravamudan <nish.aravamudan@gmail.com> wrote:
>
> On Mon, 13 Dec 2004 03:25:21 -0800, Andrew Morton <akpm@osdl.org> wrote:
> > Andrea Arcangeli <andrea@suse.de> wrote:
> > >
> > > The patch only does HZ at dynamic time. But of course it's absolutely
> > >  trivial to define it at compile time, it's probably a 3 liner on top of
> > >  my current patch ;). However personally I don't think the three liner
> > >  will worth the few seconds more spent configuring the kernel ;).
> > 
> > We still have 1000-odd places which do things like
> > 
> >         schedule_timeout(HZ/10);
> 
> Yes, yes, we do :) I replaced far more than I ever thought I could...
> There are a few issues I have with the remaining schedule_timeout()
> calls which I think fit ok with this thread... I'd especially like
> your input, Andrew, as you end up getting most of my patches from KJ.
> 
> Many drivers use
> 
> set_current_state(TASK_{UN,}INTERRUPTIBLE);
> schedule_timeout(1); // or some other small value < 10
> 
> This may or may not hide a dependency on a particular HZ value. If the
> code is somewhat old, perhaps the author intended the task to sleep
> for 1 jiffy when HZ was equal to 100. That meants that they ended up
> sleeping for 10 ms. If the code is new, the author intends that the
> task sleeps for 1 ms (HZ==1000). The question is, what should the
> replacement be?

Presumably they meant 10 milliseconds.  Or at least, that is the delay
which the developer did his testing with.

> If they really meant to use schedule_timeout(1) in the sense of
> highest resolution delay possible (the latter above), then they
> probably should just call schedule() directly.

argh.  Never do that.  It's basically a busywait and can cause lockups if
the calling task has realtime scheduling policy.

> schedule_timeout(1)
> simply sets up a timer to fire off after 1 jiffy & then calls
> schedule() itself. The overhead of setting up a timer and the
> execution of schedule() itself probably means that the timer will go
> off in the middle of the schedule() call or very shortly thereafter (I
> think). In which case, it makes more sense to use schedule()
> directly...
> 
> If they meant to schedule a delay of 10ms, then msleep() should be
> used in those cases. msleep() will also resolve the issues with 0-time
> timeouts because of rounding, as it adds 1 to the converted parameter.
> 
> Obviously, changing more and more sleeps to msecs & secs will really
> help make the changing of HZ more transparent. And specifying the time
> in real time units just seems so much clearer to me.
> 
> What do people think?

I'd say that replacing them with msleep(10) is the safest approach.
Depending on what the surronding code is actually doing, of course.

