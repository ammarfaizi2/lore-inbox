Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162129AbWLAWeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162129AbWLAWeq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 17:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162130AbWLAWeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 17:34:46 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:54548 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1162129AbWLAWeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 17:34:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=srjWeVt1XpZzZJdAeX4+Jv80GZwSZUqZjEKqvvQjfaT7Syx/lVTHKyZmuGgD0bMd7ngAHuVpEUK5AavVQZGbxOpx6UjARRS1eiwzlfv3+2J7tmO97MeO+h9MG2TAsfyueFNtQOUCqWhGDpE0cvemBe+HtlT6IkkCG3CFus8kujI=
Message-ID: <feed8cdd0612011434n4c025fcbvd9997485d8b35149@mail.gmail.com>
Date: Fri, 1 Dec 2006 14:34:42 -0800
From: "Stephen Pollei" <stephen.pollei@gmail.com>
To: "Mike Mattie" <codermattie@gmail.com>
Subject: Re: "BUG: held lock freed!" lock validator tripped by kswapd & xfs
Cc: "linux-kernel @ vger. kernel. org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20061201095349.2a92c997@reforged>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061201095349.2a92c997@reforged>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/06, Mike Mattie <codermattie@gmail.com> wrote:

> In an attempt to debug another kernel issue I turned on the lock validator and
> managed to generate this report.
>
> As a side note the first attempt to boot with the lock validator failed with
> a message indicating I had exceeded MAX_LOCK_DEPTH. To get this trace
> I patched sched.h: MAX_LOCK_DEPTH to 60.
>
> Dec  1 08:35:41 reforged [ 3052.513931] =========================
> Dec  1 08:35:41 reforged [ 3052.513937] [ BUG: held lock freed! ]
> Dec  1 08:35:41 reforged [ 3052.513939] -------------------------
> Dec  1 08:35:41 reforged [ 3052.513943] kswapd0/183 is freeing memory
> c3458000-c3458fff, with a lock still held there! Dec  1 08:35:41
> reforged [ 3052.513947]  (&(&ip->i_iolock)->mr_lock){....}, at:
> [<c0222289>] xfs_ilock+0x20/0x75 Dec  1 08:35:41 reforged
> [ 3052.513959] 28 locks held by kswapd0/183: Dec  1 08:35:41 reforged
> [ 3052.513961]  #0:  (&(&ip->i_iolock)->mr_lock){....}, at:
> [<c0222289>] xfs_ilock+0x20/0x75 Dec  1 08:35:41 reforged
> [ 3052.513968]  #1:  (&(&ip->i_lock)->mr_lock){....}, at: [<c02222bb>]
> xfs_ilock+0x52/0x75 Dec  1 08:35:41 reforged [ 3052.513975]

seems to alternate between same two locks. But both c0222289 and
c02222bb are not between the page(oxfff=4095 or about 4k) which kswapd
is trying to get rid of.
I think this trace is on crack somehow.

> [ 3052.514136] stack backtrace: Dec  1 08:35:41 reforged
> [ 3052.514139]  [<c0103cb9>] show_trace+0x16/0x19 Dec  1 08:35:41
> reforged [ 3052.514146]  [<c01040f7>] dump_stack+0x1a/0x1f Dec  1
> 08:35:41 reforged [ 3052.514150]  [<c012be74>]
> debug_check_no_locks_freed+0xe0/0xff Dec  1 08:35:41 reforged
> [ 3052.514159]  [<c014122d>] free_hot_cold_page+0x96/0x109 Dec  1
> 08:35:41 reforged [ 3052.514166]  [<c01412bc>] __pagevec_free+0x1c/0x27
> Dec  1 08:35:41 reforged [ 3052.514170]  [<c01435dc>]
> __pagevec_release_nonlru+0x65/0x71 Dec  1 08:35:41 reforged
> [ 3052.514176]  [<c0144702>] shrink_inactive_list+0x4b1/0x722 Dec  1
> 08:35:41 reforged [ 3052.514181]  [<c0144a2d>] shrink_zone+0xba/0xd9
> Dec  1 08:35:41 reforged [ 3052.514185]  [<c0144e9e>]
> kswapd+0x26a/0x361 Dec  1 08:35:41 reforged [ 3052.514189]
> [<c012742b>] kthread+0xb0/0xe1 Dec  1 08:35:41 reforged [ 3052.514192]
> [<c0101005>] kernel_thread_helper+0x5/0xb reforged log #

>
> Linux reforged 2.6.18.3 #4 PREEMPT Fri Dec 1 06:15:05 PST 2006 i686 AMD Athlon(tm) XP 3000+ AuthenticAMD GNU/Linux

I know you are running preempt on up machine. I'd try running 2.6.18.4
with a small patch like this and see if you can't cause it to recrash
for you. print_freed_lock_bug uses printk which in theory might be
causing a preempt .

diff -urp linux-2.6.18.4/include/linux/sched.h linux-debug/include/linux/sched.h
--- linux-2.6.18.4/include/linux/sched.h        2006-11-29
11:28:40.000000000 -0800
+++ linux-debug/include/linux/sched.h   2006-12-01 13:25:23.000000000 -0800
@@ -936,7 +936,7 @@ struct task_struct {
        int softirq_context;
 #endif
 #ifdef CONFIG_LOCKDEP
-# define MAX_LOCK_DEPTH 30UL
+# define MAX_LOCK_DEPTH (60UL)
        u64 curr_chain_key;
        int lockdep_depth;
        struct held_lock held_locks[MAX_LOCK_DEPTH];
diff -urp linux-2.6.18.4/kernel/lockdep.c linux-debug/kernel/lockdep.c
--- linux-2.6.18.4/kernel/lockdep.c     2006-11-29 11:28:40.000000000 -0800
+++ linux-debug/kernel/lockdep.c        2006-12-01 14:22:14.000000000 -0800
@@ -2608,6 +2608,7 @@ void debug_check_no_locks_freed(const vo
                return;

        local_irq_save(flags);
+       preempt_disable();
        for (i = 0; i < curr->lockdep_depth; i++) {
                hlock = curr->held_locks + i;

@@ -2621,6 +2622,7 @@ void debug_check_no_locks_freed(const vo
                print_freed_lock_bug(curr, mem_from, mem_to, hlock);
                break;
        }
+       preempt_enable();
        local_irq_restore(flags);
 }


-- 
http://dmoz.org/profiles/pollei.html
http://sourceforge.net/users/stephen_pollei/
http://www.orkut.com/Profile.aspx?uid=2455954990164098214
http://stephen_pollei.home.comcast.net/
