Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262629AbVCKKPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbVCKKPr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 05:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbVCKKPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 05:15:47 -0500
Received: from cpe-24-94-57-164.stny.res.rr.com ([24.94.57.164]:21926 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262629AbVCKKPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 05:15:40 -0500
Date: Fri, 11 Mar 2005 05:15:39 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Ingo Molnar <mingo@elte.hu>
cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
In-Reply-To: <20050311095747.GA21820@elte.hu>
Message-ID: <Pine.LNX.4.58.0503110508360.19798@localhost.localdomain>
References: <20050204100347.GA13186@elte.hu> <1108789704.8411.9.camel@krustophenia.net>
 <Pine.LNX.4.58.0503100323370.14016@localhost.localdomain>
 <Pine.LNX.4.58.0503100447150.14016@localhost.localdomain> <20050311095747.GA21820@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Mar 2005, Ingo Molnar wrote:

>
> * Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > > The short term fix is probably to put back the preempt_disables, the long
> > > term is to get rid of these stupid bit_spin_lock busy loops.
> >
> > Doing a quick search on the kernel, it looks like only kjournald uses
> > the bit_spin_locks. I'll start converting them to spinlocks. The use
> > seems to be more of a hack, since it is using bits in the state field
> > for locking, and these bits aren't used for anything else.
>
> yeah. bit-spinlocks are really a hack.
>
> 	Ingo
>

And this really sucks too!  I've been looking into a fix for this and have
yet to get something stable.  As you probably already know, you can't just
put back the preempt_disable since your spinlocks now schedule. So I've
been looking into finding a way to get rid of these.

I've tried making two global spinlocks, one for the state bit and one for
the journal head bit use.  But this deadlocks with j_state_lock. The
journal head lock seems to be ok to be global, but the state lock needs to
have one for every buffer head.  I'm now hacking away to do this without
touching the actual buffer head. But I'm not sure what some of the
side effects this is having.  I'll keep you posted when I get something
working.  I'm now having a crash course in how kjournal and friends work.

-- Steve

