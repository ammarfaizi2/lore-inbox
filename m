Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266743AbRGKQbT>; Wed, 11 Jul 2001 12:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267348AbRGKQbK>; Wed, 11 Jul 2001 12:31:10 -0400
Received: from pat.uio.no ([129.240.130.16]:7820 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S266742AbRGKQax>;
	Wed, 11 Jul 2001 12:30:53 -0400
MIME-Version: 1.0
Message-ID: <15180.32563.739560.194630@charged.uio.no>
Date: Wed, 11 Jul 2001 18:30:43 +0200
To: Andrea Arcangeli <andrea@suse.de>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Andrew Morton <andrewm@uow.edu.au>,
        Klaus Dittrich <kladit@t-online.de>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.7p6 hang
In-Reply-To: <20010711175809.F3496@athlon.random>
In-Reply-To: <200107110849.f6B8nlm00414@df1tlpc.local.here>
	<shslmlv62us.fsf@charged.uio.no>
	<3B4C56F1.3085D698@uow.edu.au>
	<15180.24844.687421.239488@charged.uio.no>
	<20010711175809.F3496@athlon.random>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrea Arcangeli <andrea@suse.de> writes:

     > ksoftirqd is quite scheduler intensive, and while its startup
     > is correct (no need of any change there), it tends to trigger
     > scheduler bugs (one of those bugs was just fixed in pre5). The
     > reason I never seen the deadlock I also fixed this other
     > scheduler bug in my tree:

     > --- 2.4.4aa3/kernel/sched.c.~1~ Sun Apr 29 17:37:05 2001
     > +++ 2.4.4aa3/kernel/sched.c Tue May 1 16:39:42 2001
     > @@ -674,8 +674,10 @@
     >  #endif
     >  	spin_unlock_irq(&runqueue_lock);
 
     > - if (prev == next)
     > + if (prev == next) {
     > + current->policy &= ~SCHED_YIELD;
     >  		goto same_process;
     > + }
 
     >  #ifdef CONFIG_SMP
     >   	/*

I no longer see the hang with this patch, but I'm not sure I
understand why it works.
Does the above mean that the hang is occuring because spawn_ksoftirqd
is yielding back to itself? If so, the semaphore trick seems more
robust, as it causes a proper sleep until it's safe to wake up.

Cheers,
  Trond
