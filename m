Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265112AbSKERym>; Tue, 5 Nov 2002 12:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265113AbSKERyl>; Tue, 5 Nov 2002 12:54:41 -0500
Received: from almesberger.net ([63.105.73.239]:38665 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S265112AbSKERya>; Tue, 5 Nov 2002 12:54:30 -0500
Date: Tue, 5 Nov 2002 15:00:48 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: [lkcd-devel] Re: What's left over.
Message-ID: <20021105150048.H1408@almesberger.net>
References: <Pine.LNX.4.44.0210310918260.1410-100000@penguin.transmeta.com> <3DC19A4C.40908@pobox.com> <20021031193705.C2599@almesberger.net> <20021105171230.A11443@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021105171230.A11443@in.ibm.com>; from suparna@in.ibm.com on Tue, Nov 05, 2002 at 05:12:30PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya wrote:
> Yes, we are putting [MCORE] in as one of the alternative dump targets
> available.

Great !

> Its not quite ready yet and we need something like kexec to be
> available which we can use on Intel systems to achieve the softboot
> (the acceptance status of that still doesn't seem to be clear),

Yes, I've just checked with Eric, and he hasn't received any
indication from Linus so far. I posted a reminder to linux-kernel.
I'd really hate to see kexec miss 2.6.

> Why do we even consider the other options when we are doing 
> this already ? Well, as we discussed earlier there's non-disruptive
> dumps for one, where this wouldn't work.

But they're very different anyway, aren't they ? I mean, you could
even implement them (well, almost) from user space, with today's
kernels.

> The other is that before overwriting 
> memory we need to be able to stop all activity in the system for certain
> (system may appear hung/locked up) and I'm not fully certain about
> how to do this for all environments. Maybe an answer lies in 
> rethinking some parts of the algorithm a bit.

This is certainly the hairiest part, yes. I think we have about
four types of devices/elements to worry about:

 - those that just sit there, and never talk unless spoken to
 - those that may generate interrupts
 - those that DMA if you ask them nicely
 - those that DMA when they feel like it (e.g. copy an incoming
   network packet to the next buffer in the free list)

The latter are the real problem. I see the following possibilities
for dealing with them:

 - faith-based computing: pray that nothing bad will befall your
   system :-)
 - de-activate them individually. There should be a lot of work
   that can be shared with power management. And that's one of
   the reasons why I think the memory target should be available
   early, or convergence will take forever.
 - try to reset them, without necessarily knowing what they are
   or what they do. I don't know is there is a useful way for
   resetting the PCI bus by software, but if there is one, this
   looks like the most promising strategy to me, even if it may
   be somethat lacking in elegance.
 - if all else fails, maybe introduce an "unsafe" memory type
   for potential DMA targets of unpredictable devices, that will
   not be re-used. I hope we won't need this, though. (But in case
   such a memory type gets introduced by the memory-scrubbers, at
   least you could blame _them_ :-)

> The general feeling here is that a one solution fits all thing 
> may not work best right now ... and hence the focus on an interface 
> based approach that gives us the needed flexibility. 

Yes, this is certainly important. I just think that the "memory
target" concept is closer to a general solution than disk dumps.
But there are always those 5% with special needs, and it's good
if they can use the same framework.

Thanks,
- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
