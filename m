Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265908AbSIRJ7L>; Wed, 18 Sep 2002 05:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265922AbSIRJ7L>; Wed, 18 Sep 2002 05:59:11 -0400
Received: from mx1.elte.hu ([157.181.1.137]:38103 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S265908AbSIRJ7K>;
	Wed, 18 Sep 2002 05:59:10 -0400
Date: Wed, 18 Sep 2002 12:11:30 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <20020918002240.GB2179@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0209181136180.2750-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Sep 2002, William Lee Irwin III wrote:

> Thank you for taking up the completion of development on and maintenance
> of this patch. I have not had the time resources to advance it myself,
> though now with your help I would be glad to contribute to the effort.
> If you would like to assume ownership, I'd be glad to hand it over, and
> send patches removing additional instances of for_each_process() to you
> as I find the time.

(well, it's your baby, i only dusted it off, merged it and redid the PID
allocator. I have intentionally left out some of the for_each_task
eliminations, to ease the merging - you are more than welcome to extend
the patch.)

the only thing that still needs to be resolved is the design of the idtags
subsystem. Is its current complexity at the absolute minimum we need? Eg.  
i was thinking about extending the pid-hash to hash all PID related items,
threads, process groups and sessions. But in the end i think it would look
much like idtags look like today. The main issue introducing the
complexity are the following properties:

 - process group PIDs, thread PIDs and session PIDs can overlap.

 - a session leader (or process group leader) can exit sooner than the
   process group itself - ie. the PID of the group has to stay allocated
   until the last member of the group exits. idtag refcounting solves this
   problem.

so i think the most we could get is to actually eliminate the pidhash and
use the idtag hash for it. This would concentrate all the performance
efforts on the idtag hash.

another, locking improvement is possible as well:

 - the idtag spinlock should be eliminated, we can reuse the tasklist lock
   for it - in the exit and fork path we hold it already. This also means
   we can walk an ID list by read-locking the tasklist lock.

the idtag spinlock is already superfluous i think, because the idtag task
list is only safely walked if we read-lock the task list. So it's not like
anyone could hash in a new idtag while we walk the list.

What do you think?

	Ingo

