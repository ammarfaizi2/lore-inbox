Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbULNQ4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbULNQ4G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 11:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbULNQ4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 11:56:05 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:4617 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261546AbULNQy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 11:54:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=GnV3cAemtSVW/aaZTbEgA8VNFznEWSzckHa8/XPGHJd0tz8OjPo+udGPlQj6eKSktCCepIXhsThNj+DdbzF6n7+CSsYthubElM24n5WpZ89nwZIrJTXS2yl7ImD0DYYfm9hHJ1nEC0MfXnVm+f+d5liKQ6Ejf3M0w/k26fkVuX0=
Message-ID: <29495f1d041214085457b8c725@mail.gmail.com>
Date: Tue, 14 Dec 2004 08:54:29 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: linux-os@analogic.com
Subject: Re: dynamic-hz
Cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       kernel@kolivas.org, pavel@suse.cz, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0412140914360.13406@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041211142317.GF16322@dualathlon.random>
	 <20041212163547.GB6286@elf.ucw.cz>
	 <20041212222312.GN16322@dualathlon.random>
	 <41BCD5F3.80401@kolivas.org> <20041213030237.5b6f6178.akpm@osdl.org>
	 <20041213111741.GR16322@dualathlon.random>
	 <20041213032521.702efe2f.akpm@osdl.org>
	 <29495f1d041213195451677dab@mail.gmail.com>
	 <Pine.LNX.4.61.0412140914360.13406@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2004 09:23:54 -0500 (EST), linux-os
<linux-os@chaos.analogic.com> wrote:
> On Mon, 13 Dec 2004, Nish Aravamudan wrote:
> 
> > On Mon, 13 Dec 2004 03:25:21 -0800, Andrew Morton <akpm@osdl.org> wrote:
> >> Andrea Arcangeli <andrea@suse.de> wrote:
> >>>
> >>> The patch only does HZ at dynamic time. But of course it's absolutely
> >>>  trivial to define it at compile time, it's probably a 3 liner on top of
> >>>  my current patch ;). However personally I don't think the three liner
> >>>  will worth the few seconds more spent configuring the kernel ;).
> >>
> >> We still have 1000-odd places which do things like
> >>
> >>         schedule_timeout(HZ/10);
> >
> > Yes, yes, we do :) I replaced far more than I ever thought I could...
> > There are a few issues I have with the remaining schedule_timeout()
> > calls which I think fit ok with this thread... I'd especially like
> > your input, Andrew, as you end up getting most of my patches from KJ.
> >
> > Many drivers use
> >
> > set_current_state(TASK_{UN,}INTERRUPTIBLE);
> > schedule_timeout(1); // or some other small value < 10
> >
> > This may or may not hide a dependency on a particular HZ value. If the
> > code is somewhat old, perhaps the author intended the task to sleep
> > for 1 jiffy when HZ was equal to 100. That meants that they ended up
> > sleeping for 10 ms. If the code is new, the author intends that the
> > task sleeps for 1 ms (HZ==1000). The question is, what should the
> > replacement be?
> >
> > If they really meant to use schedule_timeout(1) in the sense of
> > highest resolution delay possible (the latter above), then they
> > probably should just call schedule() directly. schedule_timeout(1)
> > simply sets up a timer to fire off after 1 jiffy & then calls
> > schedule() itself. The overhead of setting up a timer and the
> > execution of schedule() itself probably means that the timer will go
> > off in the middle of the schedule() call or very shortly thereafter (I
> > think). In which case, it makes more sense to use schedule()
> > directly...
> >
> > If they meant to schedule a delay of 10ms, then msleep() should be
> > used in those cases. msleep() will also resolve the issues with 0-time
> > timeouts because of rounding, as it adds 1 to the converted parameter.
> >
> > Obviously, changing more and more sleeps to msecs & secs will really
> > help make the changing of HZ more transparent. And specifying the time
> > in real time units just seems so much clearer to me.
> >
> > What do people think?
> >
> > -Nish
> 
> I found that if you use schedule() directly then the sleeping
> task appears to be spinning in "system" in `top`. If you use
> schedule_timeout(0), it works the same, but doesn't appear
> to be eating CPU cycles as shown by `top`. Many common
> drivers need to have the timeout interruptible, but wait
> <forever if necessary> for a particular event. They need
> to get the CPU back fairly often to check again for the
> event. They need the equavalent of user-mode sched_yield().
> sys_sched_yield() did't seem to work correctly, last time
> I tried.
> 
> Maybe somebody could make a sched_yield() for the kernel.
> That would improve a lot of drivers.

Hmm, schedule_timeout(0) working that way is interesting. There is
also the option to use schedule_timeout(MAX_SCHEDULE_TIMEOUT) which
should sleep indefinitely (depending of course on the conditions of
the state). Oh but I think I understand what you're saying... the
driver needs to sleep indefinitely in total (potentially), but needs
to be able to return quite often (like yield() used to) so they could
check a condition...

Thanks for the input!

-Nish
