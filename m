Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbULHST2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbULHST2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 13:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbULHST2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 13:19:28 -0500
Received: from smtp4.netcabo.pt ([212.113.174.31]:22288 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261295AbULHSQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 13:16:30 -0500
Message-ID: <32950.192.168.1.5.1102529664.squirrel@192.168.1.5>
In-Reply-To: <1102526018.25841.308.camel@localhost.localdomain>
References: <20041116130946.GA11053@elte.hu> 
    <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> 
    <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> 
    <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> 
    <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> 
    <20041207132927.GA4846@elte.hu>  <20041207141123.GA12025@elte.hu>
    <1102526018.25841.308.camel@localhost.localdomain>
Date: Wed, 8 Dec 2004 18:14:24 -0000 (WET)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: "Ingo Molnar" <mingo@elte.hu>, "LKML" <linux-kernel@vger.kernel.org>,
       "Lee Revell" <rlrevell@joe-job.com>,
       "Mark Johnson" <mark_h_johnson@raytheon.com>,
       "K.R. Foley" <kr@cybsft.com>, "Bill Huey" <bhuey@lnxw.com>,
       "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "Gunther Persoons" <gunther_persoons@spymac.com>, emann@mrv.com,
       "Shane Shrybman" <shrybman@aei.ca>, "Amit Shah" <amit.shah@codito.com>,
       "Esben Nielsen" <simlo@phys.au.dk>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 08 Dec 2004 18:16:26.0875 (UTC) FILETIME=[0840FCB0:01C4DD52]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
>
> I found a race condition in slab.c, but I'm still trying to figure out
> exactly how it's playing out.  This has to do with dynamic loading and
> unloading of caches. I have a small test case that simulates the problem
> at http://home.stny.rr.com/rostedt/tests/sillycaches.tgz
>
> This was done on:
>
> # uname -r
> 2.6.10-rc2-mm3-V0.7.32-9
>
> I have a module that creates a cache to allocate objects from. When you
> unload the module, it deallocates the objects and then destroys the
> cache.  But with your patched kernel I get the following output, and the
> system then goes into an unstable state. That is the system will crash
> at a latter time. Usually when dealing with caches.
>
> Here's the output:
>
> slab error in kmem_cache_destroy(): cache `silly_stuff': Can't free all
> objects
>  [<c0103953>] dump_stack+0x23/0x30 (20)
>  [<c014929f>] kmem_cache_destroy+0xff/0x1a0 (28)
>  [<d081e10d>] mkcache_cleanup+0x1d/0x21 [sillymod] (12)
>  [<c013a711>] sys_delete_module+0x161/0x1a0 (100)
>  [<c0102a00>] syscall_call+0x7/0xb (-8124)
> ---------------------------
> | preempt count: 00000001 ]
> | 1-level deep critical section nesting:
> ----------------------------------------
> .. [<c01383ed>] .... print_traces+0x1d/0x60
> .....[<c0103953>] ..   ( <= dump_stack+0x23/0x30)
>
>
> I've done some extra testing and found that if I wait between the frees
> and the destroying of the cache, everything works fine.  This problem
> happens because it seems that the objects in the slab are being freed in
> a batch style and they don't get freed on the destroy. I put prints in
> to see more information and found that in kmem_cache_destroy, it calls
> __cache_shrink, which calls drain_cpu_caches (obvious from code), but
> what my prints show, is that when it gets down to drain_array_locked (it
> gets in the function) that ac->avail is zero.  I need to read more into
> the details of how the slab works, but you can take a look too.
>
> By the way, 2.6.10-rc2-mm3 does not have a problem with this.
>

AFAICS this seems to be exactly the bug I've reported recently, about when
an usb-storage flashram stick is first time unplugged.

Good show Steven :) Hope it helps.

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

