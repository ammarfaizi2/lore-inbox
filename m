Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbULQUKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbULQUKS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 15:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbULQUKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 15:10:18 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:3913 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262138AbULQUKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 15:10:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=E92Z07UYPqZUhUK8MsDoe8Uw3zgjuA0841kyFn3c2r19C/PMINX+tfmem+ieQj/z/RDVxOiJ9I8Q+ZiCOxNCyo3+ak0wnA06uGUf1lkAWc/8z7g1DduPmNxcdh3YOG5/EDPOg7kr3hGJlE045zKTKnWYb+uxqMqBs2VtBN/EiF8=
Message-ID: <29495f1d04121712102b1e609f@mail.gmail.com>
Date: Fri, 17 Dec 2004 12:10:08 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: dynamic-hz
Cc: andrea@suse.de, kernel@kolivas.org, pavel@suse.cz,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041213202939.12285212.akpm@osdl.org>
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
	 <20041213202939.12285212.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2004 20:29:39 -0800, Andrew Morton <akpm@osdl.org> wrote:
> Nish Aravamudan <nish.aravamudan@gmail.com> wrote:
> >
> > On Mon, 13 Dec 2004 03:25:21 -0800, Andrew Morton <akpm@osdl.org> wrote:
> > > Andrea Arcangeli <andrea@suse.de> wrote:
> > > >
> > > > The patch only does HZ at dynamic time. But of course it's absolutely
> > > >  trivial to define it at compile time, it's probably a 3 liner on top of
> > > >  my current patch ;). However personally I don't think the three liner
> > > >  will worth the few seconds more spent configuring the kernel ;).
> > >
> > > We still have 1000-odd places which do things like
> > >
> > >         schedule_timeout(HZ/10);
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
> 
> Presumably they meant 10 milliseconds.  Or at least, that is the delay
> which the developer did his testing with.
> 
> > If they really meant to use schedule_timeout(1) in the sense of
> > highest resolution delay possible (the latter above), then they
> > probably should just call schedule() directly.
> 
> argh.  Never do that.  It's basically a busywait and can cause lockups if
> the calling task has realtime scheduling policy.

For those drivers that use schedule() calls currently to delay, what
would you recommend? drivers/atm/ambassador.c contains a few examples.
I can get rid of most of the schedule_timeout() calls, but the
schedule() ones are a little more difficult. Would schedule_timeout(1)
be preferred to schedule()?

Thanks,
Nish
