Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265783AbSJTFqd>; Sun, 20 Oct 2002 01:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265784AbSJTFqd>; Sun, 20 Oct 2002 01:46:33 -0400
Received: from packet.digeo.com ([12.110.80.53]:52463 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265783AbSJTFqb>;
	Sun, 20 Oct 2002 01:46:31 -0400
Message-ID: <3DB2449D.C02B57F3@digeo.com>
Date: Sat, 19 Oct 2002 22:52:29 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: acme@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv4: only produce one record in fib_seq_show
References: <20021020050849.GD15254@conectiva.com.br> <20021019.221403.116117803.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Oct 2002 05:52:29.0635 (UTC) FILETIME=[E02DB130:01C277FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> ..
> kernel/timer.c's main data structures desperately want to be per-cpu
> or allocated at boot time also.  It, as has been noted often on this
> list, is actually more bloat than the ipv4 statistics stuff. :-)

I have a bunch of patches under test which do that.

The tricky bit is that at present, the per-cpu data for all 32
CPUs is always allocated.  We had to change that to only allocate
the secondary CPU's memory when the CPU is coming up.

This means that:

	for (i = 0; i < NR_CPUS; i++)
		play_with(per_cpu(something, i));

becomes a bug.  Because the per-cpu memory for not-possible
CPUs is not allocated.  I created a `for_each_possible_cpu(i)'
helper macro for that.

Another issue:

	/* this is basically for_each_possible_cpu() */
	for (i = 0; i < NR_CPUS; i++) {
		if (cpu_possible(i)) {
			play_with(per_cpu(something, i));
		}
	}

the above code will fail if it is run before smp_init(), because
smp_init() sets up cpu_callout_map() and the per-cpu memory.
We (Dipanker and I) fixed up all the callers.

The code works OK, on ia32.  But we think ia64 needs more work.

That's 128k saved.  There's another 128k-odd in a huge hashtable
in kernel/pid.c (even on uniprocessor) which needs a diet.  Also
80k or so in runqueues.  The runqueues are set up before smp_init(),
but I expect a cpu notifier and some reorg there will work.  Haven't
done sched.c yet.

I suspect we waste more memory than this in dynamically allocated
hashtables and mempools though.
