Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316840AbSEVDWG>; Tue, 21 May 2002 23:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316841AbSEVDWF>; Tue, 21 May 2002 23:22:05 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9739 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316840AbSEVDWF>; Tue, 21 May 2002 23:22:05 -0400
Date: Tue, 21 May 2002 20:21:56 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: zippel@linux-m68k.org, <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
In-Reply-To: <20020521.195716.84584338.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0205212013020.5712-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 May 2002, David S. Miller wrote:
>
> Unfortunately, today mmdrop() (which is where destroy_context is
> invoked) happens after exit_mmap().
>
> Maybe some kind of "switch_from_dead_context()" type of thing?

Yes, I was thinking of an extra step like that.

The problem is just finding a _good_ context to switch to. We can do this
two different ways:

 - actually doing a real context switch, but with a magic
   "schedule_tail()" that ends up being the rest of do_exit(). This is
   _really_ hard to get right, and implies that everything after the
   context switch has to be non-blocking (since we'd block in the "wrong"
   process context at that point.

 - my preferred solution: speculatively find _some_ process (preferably
   one that we are likely to schedule next), and use that process's
   "active_mm" to do a "switch_mm()" into (and set that to "current->mm")

   This is kind of like the lazy TLB thing, except going the other way.

The speculative thing has the problem of finding a good process, but I
would suggest something along the lines of:

 - take the first process in the run-queue on the current CPU.
 - if there is no process on th erun-queue, take our parent

The "parent" fallback is nice because (a) we're guaranteed to have a
parent and it is easily found and (b) we're going to wake our parent up
soon enough in "notify_parent()", so if the current runqueue is empty, the
parent is one of the likelier processes to end up there..

But no, I've not looked into the details. We've never stolen a mm from
anybody else before (lazy TLB _gives_ a mm to the next process, it doesn't
take it from anybody), so it might have nasty locking issues or something.

			Linus

