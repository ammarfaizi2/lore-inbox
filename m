Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129874AbRCGCCz>; Tue, 6 Mar 2001 21:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129865AbRCGCCo>; Tue, 6 Mar 2001 21:02:44 -0500
Received: from mnh-1-23.mv.com ([207.22.10.55]:24587 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S129861AbRCGCCh>;
	Tue, 6 Mar 2001 21:02:37 -0500
Message-Id: <200103070312.WAA04661@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: timw@splhi.com
Cc: Jonathan Lahr <lahr@sequent.com>, Anton Blanchard <anton@linuxcare.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: kernel lock contention and scalability 
In-Reply-To: Your message of "Tue, 06 Mar 2001 16:28:18 PST."
             <20010306162818.A1095@kochanski.internal.splhi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Mar 2001 22:12:17 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

timw@splhi.com said:
> If you're a UP system, it never makes sense to spin in userland, since
> you'll just burn up a timeslice and prevent the lock holder from
> running. I haven't looked, but assume that their code only uses
> spinlocks on SMP. If you're an SMP system, then you shouldn't be using
> a spinlock unless the critical section is "short", in which case the
> waiters should simply spin in userland rather than making system calls
> which is simply overhead.

This is a problem that UML is going to have when I turn SMP back on.  
Emulating a multiprocessor box on a UP host with the existing locking 
primitives is going to result in exactly this problem.

> Actually, what's really needed here is an efficient form of
> dynamically marking a process as non-preemptible so that when
> acquiring a spinlock the process can ensure that it exits the critical
> section as fast as possible, when it would relinquish its
> non-preemptible privilege.

That sounds like a pretty fundamental (and abusable) mechanism.

I had a suggestion from an IBM guy at ALS last year to make UML "spin"-locks 
actually sleep in the host (this doesn't make them sleep locks in userspace 
because they don't call schedule), which sounds reasonable.  This gives the 
lock-holder an opportunity to run immediately.  It's unclear to me what the 
wake-up mechanism would be, though.

Another thought I had was to raise the priority of a thread holding a 
spinlock.  This would reduce the chance that it would be preempted by a thread 
that will waste a timeslice spinning on that lock.  I don't know whether this 
is a good idea either.

> Another synchronization method popular with database peeps is "post/
> wait" for which SGI have a patch available for Linux. I understand
> that this is relatively "light weight" and might be a better choice
> for PG. 

URL?

				Jeff


