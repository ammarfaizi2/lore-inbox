Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSE2PQg>; Wed, 29 May 2002 11:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313307AbSE2PQf>; Wed, 29 May 2002 11:16:35 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:4733 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S313305AbSE2PQe>; Wed, 29 May 2002 11:16:34 -0400
Date: Wed, 29 May 2002 17:15:52 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Robert Love <rml@mvista.com>
Cc: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] updated O(1) scheduler for 2.4
Message-ID: <20020529151552.GJ31701@dualathlon.random>
In-Reply-To: <1021939600.967.5.camel@sinai> <20020524160223.GA1761@werewolf.able.es> <1022641021.23427.329.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2002 at 07:57:00PM -0700, Robert Love wrote:
> On Fri, 2002-05-24 at 09:02, J.A. Magallon wrote:
> 
> > I had to make this to get it built:
> > <snip>
> 
> Thanks, I have put these changes into the 2.4.19-pre9 version of the
> patch which is available at:
> 
> 	http://www.kernel.org/pub/linux/kernel/people/rml/sched/ingo-O1/sched-O1-rml-2.4.19-pre9-1.patch

I merged it and I've almost finished moving everything on top of it but
I've a few issues.

can you elaborate why you __save_flags in do_fork? do_fork is even a
blocking operation. fork_by_hand runs as well with irq enabled.
I don't like to safe flags in a fast path if it's not required.

Then there are longstanding bugs that aren't yet fixed and I ported the
fixed on top of it (see the parent-timeslice patch in -aa).

the child-run first approch in o1 is suspect, it seems the parent will
keep running just after a wasteful reschedule, a sched yield instead
should be invoked like in -aa in the share-timeslice patch in order to
roll the current->run_list before the schedule is invoked while
returning to userspace after fork.

another suspect thing I noticed is the wmb() in resched_task. Can you
elaborate on what is it trying to serialize (I hope not the read of
p->need_resched with the stuff below)? Also if something it should be a
smp_wmb(), same smp_ prefix goes for the other mb() in schedule.

thanks,

Andrea
