Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbWISGVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbWISGVq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 02:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbWISGVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 02:21:46 -0400
Received: from ns2.suse.de ([195.135.220.15]:5546 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964934AbWISGVp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 02:21:45 -0400
From: Andi Kleen <ak@suse.de>
To: "Dmitriy Zavin" <dmitriyz@google.com>
Subject: Re: [PATCH] x86_64/i386: Rework thermal throttling detection/handling code for Intel P4/Xeons.
Date: Tue, 19 Sep 2006 08:11:16 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20060915004236.GA9766@google.com> <200609160634.55250.ak@suse.de> <404ea8000609181521g4d5f2c1aq41d49b9941ea188@mail.google.com>
In-Reply-To: <404ea8000609181521g4d5f2c1aq41d49b9941ea188@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609190811.16649.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 September 2006 00:21, Dmitriy Zavin wrote:
> > > Each cpu can throttle at different times and have different counts, so
> >
> > The counts should be per CPU, but everything else (timestamp, enabled)
> > etc. can be just global.  You just don't want the logs flooded with events,
> > but if the rate limiting is global or local doesn't make much difference
> > That would give much simpler code and I believe
> > is sufficient for basically everybody
> 
> This will make you skip logging events for other CPUs once one has
> throttled, which is important to me. In that case, one has to rely on
> just the counts.

Ok if you want complex features like this you'll have to get rid
of some other code in your patch. 

One possibility is to keep only some state per CPU,
but do the sys configuration globally, but that's probably not 
enough.

Currently the bloat:feature ratio is imho not good enough at least.

> > Currently your patch is a bit too large for the relatively simple things
> > it tries to attempt, so such ways to simplify it and slim it down are needed.
> > If you have other ideas to make it simpler that would be appreciated too.
> 
> You are right, it was my newbie mistake. I am splitting it up into
> logical, smaller chunks that are easier to review.

It's not just smaller chunks, the end result should be simple too


> > We have a 64bit jiffies for that now on 32bit too.
> 
> The problem with using jiffies_64 is that the time_before/time_after
> macros in linux/jiffies.h always typecast to "long" which is not 64
> bits on 32bit systems. So it will get truncated, and behave as 32bits
> and won't solve the problem

Then please submit a separate patch to add time_before/after64 instead of trying
to work around that.
 
> > > > Instead of having this evinfo structure you could just directly
> > > > fill in struct mces in the caller.
> > >
> > > But the caller won't know what to fill the struct mce with since this
> > > function does the logic of figuring out the thermal event info. I
> > > can't have this function take "struct mce *" since that doesn't exist
> > > on i386. I could have it accept pointers to values as arguments, but
> > > that's messy.
> >
> > Then either define struct mce for i386 or use two different functions
> > for i386/x86-64.
> 
> I'll add a patch to pull out mcelog related stuff into mce_log.c, and
> share that between i386/x86_64. Put mcelog.c to
> arch/i386/kernel/cpu/mcheck

Please keep it in x86-64.

> , and have x86_64 just compile that in 
> directly. Does that sound like a workable solution? There's no need to 
> maintain identical code in 2 places.

It depends on how ugly that patch is. Unification is fine as long
as it improves something, but if it requires weird hacks again it's a net loss.

-Andi
