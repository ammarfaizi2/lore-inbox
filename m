Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbULHROw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbULHROw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 12:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbULHROv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 12:14:51 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:61580 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261270AbULHROW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 12:14:22 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
In-Reply-To: <20041207141123.GA12025@elte.hu>
References: <20041116130946.GA11053@elte.hu>
	 <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu>
	 <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu>
	 <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu>
	 <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu>
	 <20041207132927.GA4846@elte.hu>  <20041207141123.GA12025@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Wed, 08 Dec 2004 12:13:38 -0500
Message-Id: <1102526018.25841.308.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

I found a race condition in slab.c, but I'm still trying to figure out
exactly how it's playing out.  This has to do with dynamic loading and
unloading of caches. I have a small test case that simulates the problem
at http://home.stny.rr.com/rostedt/tests/sillycaches.tgz

This was done on:

# uname -r
2.6.10-rc2-mm3-V0.7.32-9

I have a module that creates a cache to allocate objects from. When you
unload the module, it deallocates the objects and then destroys the
cache.  But with your patched kernel I get the following output, and the
system then goes into an unstable state. That is the system will crash
at a latter time. Usually when dealing with caches.

Here's the output:

slab error in kmem_cache_destroy(): cache `silly_stuff': Can't free all objects
 [<c0103953>] dump_stack+0x23/0x30 (20)
 [<c014929f>] kmem_cache_destroy+0xff/0x1a0 (28)
 [<d081e10d>] mkcache_cleanup+0x1d/0x21 [sillymod] (12)
 [<c013a711>] sys_delete_module+0x161/0x1a0 (100)
 [<c0102a00>] syscall_call+0x7/0xb (-8124)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c01383ed>] .... print_traces+0x1d/0x60
.....[<c0103953>] ..   ( <= dump_stack+0x23/0x30)


I've done some extra testing and found that if I wait between the frees
and the destroying of the cache, everything works fine.  This problem
happens because it seems that the objects in the slab are being freed in
a batch style and they don't get freed on the destroy. I put prints in
to see more information and found that in kmem_cache_destroy, it calls
__cache_shrink, which calls drain_cpu_caches (obvious from code), but
what my prints show, is that when it gets down to drain_array_locked (it
gets in the function) that ac->avail is zero.  I need to read more into
the details of how the slab works, but you can take a look too.

By the way, 2.6.10-rc2-mm3 does not have a problem with this.

Thanks,

-- Steve
