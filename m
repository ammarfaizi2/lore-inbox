Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316880AbSFVT05>; Sat, 22 Jun 2002 15:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316882AbSFVT05>; Sat, 22 Jun 2002 15:26:57 -0400
Received: from bitmover.com ([192.132.92.2]:58600 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S316880AbSFVT0z>;
	Sat, 22 Jun 2002 15:26:55 -0400
Date: Sat, 22 Jun 2002 12:26:56 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@transmeta.com>,
       Cort Dougan <cort@fsmlabs.com>, Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
Message-ID: <20020622122656.W23670@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Larry McVoy <lm@bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Cort Dougan <cort@fsmlabs.com>, Benjamin LaHaise <bcrl@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0206201003500.8225-100000@home.transmeta.com> <m1r8j1rwbp.fsf@frodo.biederman.org> <20020621105055.D13973@work.bitmover.com> <m1lm97rx16.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m1lm97rx16.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sat, Jun 22, 2002 at 12:25:09PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 22, 2002 at 12:25:09PM -0600, Eric W. Biederman wrote:
> I don't see a argument that locks that get to fine grained are not an
> issue.  However even traditional version of single cpu unix are multi
> threaded.  The locking in a multi cpu design just makes that explicit.
> 
> And the only really nasty place to get locks is when you get a
> noticeable number of them in your device drivers.  With the core code
> you can fix it without out worrying about killing the OS.

Just out of curiousity, have you actually ever worked on a fine grain
threaded OS?  One that scales to at least 32 processors?  Solaris?  IRIX?
Others?  It makes a difference, if you've been there, your perspective is
somewhat different than just talking about it.  If you have worked on one,
for how long?  Did you support the source base after it matured for any
length of time?

> Proactive don't add a lock unless you can really justify that you need
> it.  That is well suited to open source code review type practices,
> and it appears to be what we are doing now.  And if you don't add
> locks you certainly don't get into a lock tangle.

That's a great theory.  I support that theory, life would great if it
matched that theory.  Unfortunately, I don't know of any kernel which
matches that theory, do you?  Linux certainly doesn't.  FreeBSD certainly
doesn't.  Solaris/IRIX crossed that point years ago.  So where is the
OS which has managed to resist the lock tangle?

linux-2.5$ bk -r grep CONFIG_SMP | wc -l
1290

That's a lot of ifdefs for a supposedly tangle free kernel.  And I suspect
that the threading people will say Linux doesn't really scale beyond
2-4 CPUs for any I/O bound work load today.  What's it going to be when
Linux is at 32 CPUs?  Solaris was around 3000 statically allocated locks
when I left and I think it was scaling to maybe 8.  At SGI, they were
carefully putting the lock on the same cache line as the data structure
that it protected, for all locked data structure which had any contention.
The limit as the number of CPUs goes up is that each read/write cache
line in the data segment has a lock.  They certainly weren't there,
but they were much closer than you might guess.  It was definitely the
norm that you laid out your locks with the data, it was that pervasive.

Take a walk through sched.c and you can see the mess starting.  How 
can anyone support that code on both UP and SMP?  You are already 
supporting two code bases.  Imagine what it is going to look like when
the NUMA people get done.  Don't forget the preempt people.  Oh, yeah,
let's throw in some soft realtime, that shouldn't screw things up too
much.

> To specifics, I don't see the point of OSlets on a single cpu that is
> hyper threaded.  Traditional threading appears to make more sense to
> me.  Similarly I don't see the point in the 2-4 cpu range.

In general I agree with you here, but I think you haven't really considered
all the options.  I can see the benefit on a *single* CPU.  There are all
sorts of interesting games you could play in the area of fault tolerance
and containment.  Imagine a system, like what IBM has, that runs lots of
copies of Linux with the mmap sharing turned off.  ISPs would love it.

Jeff Dike pointed out that if UML can run one kernel in user space, why
not N?  And if so, the OS clustering stuff could be done on top of
UML and then "ported" to real hardware.  I think that's a great idea,
and you can carry it farther, you could run multiple kernels just for
fault containment.  See Sun's domains, DEC's Galaxy.

> Given that there are some scales when you don't want/need more than
> one kernel, who has a machine where OSlets start to pay off?  They
> don't exist in commodity hardware, so being proactive now looks
> stupid.

Not as stupid as having a kernel noone can maintain and not being able
to do anything about it.  There seems to be a subthread of elitist macho
attitude along the lines of "oh, it won't be that bad, and besides,
if you aren't good enough to code in a fine grained locked, soft real
time, preempted, NUMA aware, then you just shouldn't be in the kernel".
I'm not saying you are saying that, but I've definitely heard it on
the list.  

It's a great thing for bragging rights but it's a horrible thing from
the sustainability point of view.  
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
