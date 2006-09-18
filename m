Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751936AbWIRWWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbWIRWWJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 18:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751943AbWIRWWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 18:22:09 -0400
Received: from smtp-out.google.com ([216.239.33.17]:49587 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751936AbWIRWWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 18:22:07 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=sc0MJwMkQO98Ti4jakuQkNG1UShjVPj8WN8eqGiRfHRrBzroNVJ/V2v5u24u2ZaOx
	lY4GIeTB/+xmruG+MclKQ==
Message-ID: <404ea8000609181521g4d5f2c1aq41d49b9941ea188@mail.google.com>
Date: Mon, 18 Sep 2006 15:21:53 -0700
From: "Dmitriy Zavin" <dmitriyz@google.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [PATCH] x86_64/i386: Rework thermal throttling detection/handling code for Intel P4/Xeons.
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <200609160634.55250.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060915004236.GA9766@google.com> <200609150859.28130.ak@suse.de>
	 <404ea8000609151333h32547601x7f6de316ff0df985@mail.google.com>
	 <200609160634.55250.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[dropping Zwane from CC since the address I have is wrong]

> > Each cpu can throttle at different times and have different counts, so
>
> The counts should be per CPU, but everything else (timestamp, enabled)
> etc. can be just global.  You just don't want the logs flooded with events,
> but if the rate limiting is global or local doesn't make much difference
> That would give much simpler code and I believe
> is sufficient for basically everybody

This will make you skip logging events for other CPUs once one has
throttled, which is important to me. In that case, one has to rely on
just the counts.

But I still think that it is important to report and rate limit on a
per CPU basis, which is how it is already done in the upstream kernel
(and has for a while), so it wouldn't be spamming logs any more than
it already does.

> Currently your patch is a bit too large for the relatively simple things
> it tries to attempt, so such ways to simplify it and slim it down are needed.
> If you have other ideas to make it simpler that would be appreciated too.

You are right, it was my newbie mistake. I am splitting it up into
logical, smaller chunks that are easier to review.

> > Then the caller has to maintain the thermal counter, which is what I
> > don't want. I wanted the managmente code to be separate. I can make
> > this an inline in the header if you want to get rid of the function
> > call.
>
> The function call doesn't matter, it is just that we don't want overabstracted
> kernel in the Linux kernel and your patch currently definitely has too many
> functions doing very simple things. That makes it harder to read etc.

I will roll the counter bump into process_event() so the user just calls that.

> > > I'm not sure what you need the timer for. Can't just just drive
> > > that from the interrupt handlers and check time stamps to do
> > > rate limiting? Then another timer wouldn't be needed.
> >
> > Problem is that the timestamps are in jiffies. You could potentially
> > have very long periods of time in between thermal events, assuming the
> > box has a long uptime. On  32bit systems, if the time delta in jiffies
> > between 2 events is >= 0x80000000, the time elapsed will be negative,
> > and will prevent you from logging events until jiffies wrap all the
> > way around (the counter will still increment though). The timer takes
> > care of clearing the flag after 5 minutes.
>
> But Jiffies wrap is several years. Even if we get a bogus overheat event
> after two years it isn't really a issue. Please just get rid of the timer

We won't get a bogus overheat event. The problem is that we will SKIP
reporting that event, and further events alltogether, until jiffies
pass the threshold. Then we will HAVE to rely on someone watching the
counter(s) to know that something has happened.

I understand your uneasiness with the timer, and will try to find a
different way.

> We have a 64bit jiffies for that now on 32bit too.

The problem with using jiffies_64 is that the time_before/time_after
macros in linux/jiffies.h always typecast to "long" which is not 64
bits on 32bit systems. So it will get truncated, and behave as 32bits
and won't solve the problem

> > > Instead of having this evinfo structure you could just directly
> > > fill in struct mces in the caller.
> >
> > But the caller won't know what to fill the struct mce with since this
> > function does the logic of figuring out the thermal event info. I
> > can't have this function take "struct mce *" since that doesn't exist
> > on i386. I could have it accept pointers to values as arguments, but
> > that's messy.
>
> Then either define struct mce for i386 or use two different functions
> for i386/x86-64.

I'll add a patch to pull out mcelog related stuff into mce_log.c, and
share that between i386/x86_64. Put mcelog.c to
arch/i386/kernel/cpu/mcheck, and have x86_64 just compile that in
directly. Does that sound like a workable solution? There's no need to
maintain identical code in 2 places.

> > > > +     struct mce m;
> > > > +
> > > > +     memset(&m, 0, sizeof(m));
> > > > +     m.cpu = evinfo->cpu;
> > > > +     m.bank = MCE_THERMAL_BANK;
> > >
> > > So how should user space distingush that event from other thermal events?
> >
> > What do you mean? This is already what x86_64 code does today for
> > thermal throttle events.
>
> It should be just clear where it came from since you added a new way
> to generate them.

I didn't add a new way to generate them :). Detection/generation of
the log entry is identical, just the actual code moved to a different
file.

Thanks.

--Dima
