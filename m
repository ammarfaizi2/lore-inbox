Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262277AbSI1RTh>; Sat, 28 Sep 2002 13:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262278AbSI1RTh>; Sat, 28 Sep 2002 13:19:37 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:32260 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S262277AbSI1RTf>; Sat, 28 Sep 2002 13:19:35 -0400
Date: Sat, 28 Sep 2002 18:24:50 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Sleeping function called from illegal context...
Message-ID: <20020928172449.GA54680@compsoc.man.ac.uk>
References: <20020927233044.GA14234@kroah.com> <1033174290.23958.17.camel@phantasy> <20020928145418.GB50842@compsoc.man.ac.uk> <3D95E14D.9134405C@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D95E14D.9134405C@digeo.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *17vLKk-000L9u-00*AiG8mP0y6e6* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2002 at 10:05:17AM -0700, Andrew Morton wrote:

> We need a standalone CONFIG_MIGHT_SLEEP.  I sinfully hooked it
> to CONFIG_DEBUG_KERNEL (it's not obvious why CONFIG_DEBUG_KERNEL
> exists actually).

Ah, OK.

> > I have a bit of a problem with __might_sleep because I call sleepable
> > stuff holding a spinlock (yes, it is justified, and yes, it is safe
> > afaics, at least with PREEMPT=n)
> 
> I'm looking at you suspiciously.  How come?

NMI interrupt handler cannot block so it trylocks against a spinlock
instead. Buffer processing code needs to block against concurrent NMI
interrupts so takes the spinlock for them. All actual blocks on the
spinlock are beneath a down() on another semaphore, so a sleep whilst
holding the spinlock won't actually cause deadlock.

I don't know a way out of this that can safely ensure we've finished
processing an NMI on the remote CPU the buffer processing code is about
to look at.

[I'll post a new patch against 2.5.39 in a bit so you can see in
context]

regards
john

-- 
"When your name is Winner, that's it. You don't need a nickname."
	- Loser Lane
