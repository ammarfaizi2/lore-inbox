Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUCRGDS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 01:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbUCRGDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 01:03:18 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:21445
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262406AbUCRGDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 01:03:12 -0500
Date: Thu, 18 Mar 2004 07:03:58 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Marinos J. Yannikos" <mjy@geizhals.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-ID: <20040318060358.GC29530@dualathlon.random>
References: <40591EC1.1060204@geizhals.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40591EC1.1060204@geizhals.at>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 05:00:01AM +0100, Marinos J. Yannikos wrote:
> Hi,
> 
> we upgraded a few production boxes from 2.4.x to 2.6.4 recently and the 
> default .config setting was CONFIG_PREEMPT=y. To get straight to the 
> point: according to our measurements, this results in severe performance 
> degradation with our typical and some artificial workload. By "severe" I 
> mean this:

this is expected (see the below email, I predicted it on Mar 2000), keep
preempt turned off always, it's useless. Worst of all we're now taking
spinlocks earlier than needed, and the preempt_count stuff isn't
optmized away by PREEMPT=n, once those bits will be fixed too it'll go
even faster.

preempt just wastes cpu with tons of branches in fast paths that should
take one cycle instead.

Takashi Iwai did lots of research on the preempt vs lowlatency and
he found that preempt buys nothing and he confirmed my old theories (I
always advocated against preempt, infact I still advocate for "enabling"
preempt on demand during the copy-user only, so to enable preempt on
demand, not to disable it on demand like it happens now with the bloats
it generates), infact 2.4-aa has a lower max latency than 2.6 stock with
preempt enabled. About my old idea of enabling preempt on demand (i.e.
the opposite of preempt) in the copy-user we've to check for reschedule
anyways, so we can as well enable preempt, and that would still keep the
kernel simple and efficient. This way we would dominate the latency
during the bulk work (especially important with bigger page size or with
page clustering).

These fixes from Takashi Iwai brings 2.6 back in line with 2.4, I
suggested to use EIP dumps from interrupts to get the hotspots, he
promptly used the RTC for that and he could fixup all the spots, great
job he did since now we've a very low worst case sched latency in 2.6
too:

--- linux/fs/mpage.c-dist	2004-03-10 16:26:54.293647478 +0100
+++ linux/fs/mpage.c	2004-03-10 16:27:07.405673634 +0100
@@ -695,6 +695,7 @@ mpage_writepages(struct address_space *m
 			unlock_page(page);
 		}
 		page_cache_release(page);
+		cond_resched();
 		spin_lock(&mapping->page_lock);
 	}
 	/*
--- linux/fs/super.c-dist	2004-03-09 19:28:58.482270871 +0100
+++ linux/fs/super.c	2004-03-09 19:29:05.000792950 +0100
@@ -356,6 +356,7 @@ void sync_supers(void)
 {
 	struct super_block * sb;
 restart:
+	cond_resched();
 	spin_lock(&sb_lock);
 	sb = sb_entry(super_blocks.next);
 	while (sb != sb_entry(&super_blocks))
--- linux/fs/fs-writeback.c-dist	2004-03-09 19:15:25.237752504 +0100
+++ linux/fs/fs-writeback.c	2004-03-09 19:16:37.630330614 +0100
@@ -360,6 +360,7 @@ writeback_inodes(struct writeback_contro
 	}
 	spin_unlock(&sb_lock);
 	spin_unlock(&inode_lock);
+	cond_resched();
 }
 
 /*


I'm actually for dropping preempt from the kernel and to try to
implement my old idea of enabling preempt on demand in a few latency
critical spots. So instead of worrying about taking spinlocks too early
and calling preempt_disable, the only thing the kernel will do w.r.t.
preempt is:

enter_kernel:
	preempt_enable()
	copy_user()
	preempt_disable()
exit_kernel:

I think it's perfectly acceable to do the above (i.e. the opposite of
preempt). While I think preempt is overkill.

More details on this in the old posts (I recall I even did a quick hack
to try if it worked, I'm surprised how old this email is but it's still
very actual apparently):

	http://www.ussg.iu.edu/hypermail/linux/kernel/0003.1/0998.html

"With the fact we'll have to bloat the fast path (a fast lock like the
above one and all the spinlocks will need an additional
forbid_preempt(smp_processor_id()) the preemtable kernel it's not likely
to be a win. 

The latency will decrease without drpping throughtput only in code that
runs for long time with none lock held like the copy_user stuff. That
stuff will run at the same speed as now but with zero scheduler latency. 

The _lose_ instead will happen in _all_ the code that grabs any kind of
spinlock because spin_lock/spin_unlock will be slower and the latency
won't decrease for that stuff. 

But now by thinking at that stuff I have an idea! Why instead of making
the kernel preemtable we take the other way around? So why instead of
having to forbid scheduling in locked regions, we don't simply allow
rescheduling in some piece of code that we know that will benefit by the
preemtable thing? 

The kernel won't be preemtable this way (so we'll keep throughtput in
the locking fast path) but we could mark special section of kernel like
the copy user as preemtable. 
 

It will be quite easy: 
 
static atomic_t cpu_preemtable[NR_CPUS] = { [0..NR_CPUS] =
ATOMIC_INIT(0), }; 

#define preemtable_copy_user(...) \ 
 do { \ 
         atomic_inc(&cpu_preemtable[smp_processor_id()]); \ 
         copy_user(...); \ 
         atomic_dec(&cpu_preemtable[smp_processor_id()]); \ 
 } while (0) 
[..]
"

I still think after 4 years that such idea is more appealing then
preempt, and numbers start to prove me right.
