Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264655AbRFPUtG>; Sat, 16 Jun 2001 16:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264656AbRFPUsz>; Sat, 16 Jun 2001 16:48:55 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:25104 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S264655AbRFPUsp>; Sat, 16 Jun 2001 16:48:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Pavel Machek <pavel@suse.cz>, John Stoffel <stoffel@casc.com>
Subject: Re: spindown [was Re: 2.4.6-pre2, pre3 VM Behavior]
Date: Sat, 16 Jun 2001 22:50:57 +0200
X-Mailer: KMail [version 1.2]
Cc: Roger Larsson <roger.larsson@norran.net>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0106140013000.14934-100000@imladris.rielhome.conectiva> <15145.8435.312548.682190@gargle.gargle.HOWL> <20010615152306.B37@toy.ucw.cz>
In-Reply-To: <20010615152306.B37@toy.ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <0106162250570J.00879@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 June 2001 17:23, Pavel Machek wrote:
> Hi!
>
> > Roger> It does if you are running on a laptop. Then you do not want
> > Roger> the pages go out all the time. Disk has gone too sleep, needs
> > Roger> to start to write a few pages, stays idle for a while, goes to
> > Roger> sleep, a few more pages, ...
> >
> > That could be handled by a metric which says if the disk is spun down,
> > wait until there is more memory pressure before writing.  But if the
> > disk is spinning, we don't care, you should start writing out buffers
> > at some low rate to keep the pressure from rising too rapidly.
>
> Notice that write is not free (in terms of power) even if disk is spinning.
> Seeks (etc) also take some power. And think about flashcards. It certainly
> is cheaper tha spinning disk up but still not free.
>
> Also note that kernel does not [currently] know that disks went spindown.

There's an easy answer that should work well on both servers and laptops, 
that goes something like this: when memory pressure has been brought to 0, if 
there there is plenty of disk bandwidth available, continue writeout for a 
while and clean some extra pages.  In other words, any episode of pageouts 
is followed immediately by a short episode of preemptive cleaning.

This gives both the preemptive cleaning we want in order to respond to the 
next surge, and lets the laptop disk spin down.  The definition of 'for a 
while' and 'plenty of disk bandwidth' can be tuned, but I don't think either 
is particularly critical.

As a side note, the good old multisecond delay before bdflush kicks in 
doesn't really make a lot of sense - when bandwidth is available the 
filesystem-initiated writeouts should happen right away.

It's not necessary or desirable to write out more dirty pages after the 
machine has been idle for a while, if only because the longer it's idle the 
less the 'surge protection' matters in terms of average throughput.

--
Daniel
