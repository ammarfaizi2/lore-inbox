Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266679AbSKHA1K>; Thu, 7 Nov 2002 19:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266680AbSKHA0C>; Thu, 7 Nov 2002 19:26:02 -0500
Received: from dp.samba.org ([66.70.73.150]:64738 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266679AbSKHAZ5>;
	Thu, 7 Nov 2002 19:25:57 -0500
Date: Thu, 7 Nov 2002 23:06:13 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: mbligh@aracnet.com, ahu@ds9a.nl, peter@chubb.wattle.id.au, jw@pegasys.ws,
       linux-kernel@vger.kernel.org
Subject: Re: ps performance sucks (was Re: dcache_rcu [performance results])
Message-Id: <20021107230613.5194156c.rusty@rustcorp.com.au>
In-Reply-To: <Pine.GSO.4.21.0211051932140.6521-100000@steklov.math.psu.edu>
References: <32290000.1036545797@flay>
	<Pine.GSO.4.21.0211051932140.6521-100000@steklov.math.psu.edu>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2002 19:34:47 -0500 (EST)
Alexander Viro <viro@math.psu.edu> wrote:
> On Tue, 5 Nov 2002, Martin J. Bligh wrote:
> 
> > It's not a few files if you have large numbers of tasks. It's an 
> > interface that fundamentally wasn't designed to scale, and futzing
> > around tweaking the thing isn't going to cut it, it needs a different
> > design. I'm not proposing throwing out any of the old simple interfaces,
> > just providing something efficient as a data gathering interface for
> > those people who wish to use it.
> 
> That's odd, to say the least.  Userland side is at least linear by
> number of tasks, regardless of the way you gather information.  So
> I really wonder how opening O(number of tasks) files can show up
> when you scale the things up - pure userland parts will grow at
> least as fast as that.

And I look forward to your "du" interface the kernel, too.  It uses
this terrible method of statting every file!

Now, according to wli, there's a real problem with starvation by saturating
the read side of the tasklist_lock so eg. the write_lock_irq(&tasklist_lock)
in exit.c's release_task causes a CPU to spin for ages (forever?) with
interrupts off.  This needs fixing, be it RCU or making that particular
lock give way to writers, or some other effect.

But the "ps takes too much time from my benchmarks" is a "don't do that".
Or you may really hate the /dev/kmem hack, but it's simple and effective.
The "hundreds of users doing ps/top" is easily solved with a "ps" daemon.

Fixing top is probably a worthwhile thing to do, and you'll note that after
the first iteration it should be rarely neccessary to read every "stat"
proc file.

Optimize userspace before putting a hack into the kernel, *please*!

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
