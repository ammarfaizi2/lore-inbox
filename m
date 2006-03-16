Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932640AbWCPBF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640AbWCPBF4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 20:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932642AbWCPBFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 20:05:55 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:44212 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932640AbWCPBFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 20:05:55 -0500
Date: Thu, 16 Mar 2006 02:05:37 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 5/8] hrtimer remove state field
In-Reply-To: <1142180796.19916.497.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0603152055380.16802@scrub.home>
References: <20060312080316.826824000@localhost.localdomain> 
 <20060312080332.274315000@localhost.localdomain>  <Pine.LNX.4.64.0603121302590.16802@scrub.home>
  <1142169010.19916.397.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0603121422180.16802@scrub.home>  <1142170505.19916.402.camel@localhost.localdomain>
  <Pine.LNX.4.64.0603121444530.16802@scrub.home>  <1142172917.19916.421.camel@localhost.localdomain>
  <Pine.LNX.4.64.0603121523320.16802@scrub.home>  <1142175286.19916.459.camel@localhost.localdomain>
  <Pine.LNX.4.64.0603121608440.17704@scrub.home>  <1142178108.19916.475.camel@localhost.localdomain>
  <Pine.LNX.4.64.0603121650230.16802@scrub.home> <1142180796.19916.497.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 12 Mar 2006, Thomas Gleixner wrote:

> But the problem I described now happened with the current patch queue -
> without the hrtimer_active() check. I have no direct access to the
> machine which lets this surface and I just tried to reconstruct the
> scenario from the sparse information which was provided by the customer.
> All I can tell, that it is related to something similar and a requeue
> happens where none should happen.

I have an idea what might have happened. You don't advance the pending 
state, if the signal isn't queued, so that the pending state is screwed up 
afterwards. Although I don't see how it could crash the kernel (it has 
only the potential to mess up the timer queue via hrtimer_forward() a 
bit), but I don't know what other patches were applied.

> I make the check a BUG_ON(!hrtimer_active(timer) so it might show up in
> -mm again. Ok ?

That's fine.
The point is that it's currently not needed to allow the user this 
behaviour. It's a bit unfortunate that such API details were not discussed 
before it got merged - users have a tendency to (ab)use a system in the 
least expected way (especially if they somehow gotten the idea it's much 
better than the old stuff in every way).
For example no current user restarts an active timer, which could be used 
to simplify the locking. If we tightened a bit what a user is allowed to 
do, we could gain flexibility on the other side, e.g. allow drivers to 
create timer sources or how to integrate cpu timer.

bye, Roman

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

Index: linux-2.6-git/kernel/posix-timers.c
===================================================================
--- linux-2.6-git.orig/kernel/posix-timers.c	2006-03-14 19:48:21.000000000 +0100
+++ linux-2.6-git/kernel/posix-timers.c	2006-03-15 20:54:38.000000000 +0100
@@ -353,6 +353,7 @@
 				hrtimer_forward(&timr->it.real.timer,
 						timr->it.real.interval);
 			ret = HRTIMER_RESTART;
+			++timr->it_requeue_pending;
 		}
 	}
 
