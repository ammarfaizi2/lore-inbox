Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318355AbSILVDp>; Thu, 12 Sep 2002 17:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318561AbSILVDo>; Thu, 12 Sep 2002 17:03:44 -0400
Received: from packet.digeo.com ([12.110.80.53]:38854 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S318355AbSILVDo>;
	Thu, 12 Sep 2002 17:03:44 -0400
Message-ID: <3D810243.E2E6640E@digeo.com>
Date: Thu, 12 Sep 2002 14:08:19 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Robert Love <rml@tech9.net>, Steven Cole <elenstev@mesatop.com>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       Steven Cole <scole@lanl.gov>
Subject: Re: [PATCH] kernel BUG at sched.c:944! only with CONFIG_PREEMPT=y]
References: <1031862919.3770.103.camel@phantasy> <Pine.LNX.4.44.0209122242300.21936-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2002 21:08:21.0892 (UTC) FILETIME=[86942C40:01C25AA0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> On 12 Sep 2002, Robert Love wrote:
> 
> > While this sounds like a great debugging check, it is not useful in
> > general since we surely have some bad code that calls schedule() with
> > locks held.  Further, since the atomic accounting only includes locks if
> > CONFIG_PREEMPT is set, you only see this with kernel preemption enabled.
> 
> it *is* a great debugging check, at zero added cost. Scheduling from an
> atomic region *is* a critical bug that can and will cause problems in 99%
> of the cases. Rather fix the asserts that got triggered instead of backing
> out useful debugging checks ...
> 

The problem here is that some random piece of code has bumped
the preemption counter, and we've lost all trace of that at
the site where the problem is detected.

So...  In do_initcalls() we'd need:

        do {
                (*call)();
+		if (in_atomic())
+			printk("initcall at %p is buggy\n", call);
                call++;
        } while (call < &__initcall_end);

and to diagnose this particular problem I guess we need to
add

	if (in_atomic())
		printk("goofed at %d\n", __LINE__);

to twenty or so places in start_kernel().
