Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262953AbTCSJ3U>; Wed, 19 Mar 2003 04:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262955AbTCSJ3U>; Wed, 19 Mar 2003 04:29:20 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:14490 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S262953AbTCSJ3T>; Wed, 19 Mar 2003 04:29:19 -0500
Date: Wed, 19 Mar 2003 10:40:10 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: george anzinger <george@mvista.com>
cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix nanosleep() granularity bumps
In-Reply-To: <3E78384A.6040406@mvista.com>
Message-ID: <Pine.LNX.4.33.0303191030540.346-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Mar 2003, george anzinger wrote:

> In this case, the simple fix is to bump the
> base->timer_jiffies at the beginning of the loop rather than the end.
>    This would cause the new timer to be put in the next jiffie instead
> of the current one AND it is free!

Yes, doing it this way looks correct to me.

> > No, with the current implementation we need
> >  #define INDEX(N) (base->timer_jiffies >> (TVR_BITS + N * TVN_BITS) +1) &
> >  TVN_MASK
> > although I'd like to see that cleaned up.
>
> I tried with the +1 and boot hangs trying to set up networking.  I
> think the difference is that the init code is trying to set things up
> the way they would look AFTER cascade executes and this is doing it
> BEFORE the cascade call.

With the above change, it should be correct without the +1

> > Why 'jiffies -1'? This will just be made up for in the first
> > timer interrupt, where timer_jiffies will get incremented twice.
>
> Again, I removed the -1 in the attached.

If you really want to be conservative, we'd better start with
INITIAL_JIFFIES. Should be the same anyways. But if not, we might lose a
timer scheduled for INITIAL_JIFFIES (not that I think it's possible to
insert one before timer initialisation in the first place :-)
or even a timer cascade.

> > Did you bother to test the patch? It doesn't even boot for me, and I don't
> > see how it is supposed to.
> > I'll look into it more closely in the evening. Have to go to work now.
>
> The old one ran on 2.5.64 but not 2.5.65 ???  I found and fixed a bug
> (index needs to be caculated INSIDE the while loop) that seems to have
> been the cause.

Ok will test in the evening.

Tim

