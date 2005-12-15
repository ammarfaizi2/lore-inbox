Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbVLOTAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbVLOTAp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 14:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbVLOTAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 14:00:45 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:27381 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1750929AbVLOTAp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 14:00:45 -0500
Message-ID: <43A1BD61.5070409@mvista.com>
Date: Thu, 15 Dec 2005 11:00:49 -0800
From: David Singleton <dsingleton@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dino@in.ibm.com
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       robustmutexes@lists.osdl.org
Subject: Re: Recursion bug in -rt
References: <20051214223912.GA4716@in.ibm.com>
In-Reply-To: <20051214223912.GA4716@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar,
     after further testing and investigation I believe you original 
assessment was correct.
The problem you are seeing is not a library problem.
The changes to down_futex need to be reverted.  There is a new patch at

http://source.mvista.com/~dsingleton/patch-2.6.15-rc5-rt2-rf2.

that reverts the changes to down_futex.

Thanks for testing this.

David




Dinakar Guniguntala wrote:

>Hi David,
>
>I hit this bug with -rt22-rf11
>
>==========================================
>[ BUG: lock recursion deadlock detected! |
>------------------------------------------
>already locked:  [f7abbc94] {futex}
>.. held by:          testpi-3: 4595 [f7becdd0,  59]
>... acquired at:               futex_wait_robust+0x142/0x1f3
>------------------------------
>| showing all locks held by: |  (testpi-3/4595 [f7becdd0,  59]):
>------------------------------
>
>#001:             [f7abbc94] {futex}
>... acquired at:               futex_wait_robust+0x142/0x1f3
>
>-{current task's backtrace}----------------->
> [<c0103e04>] dump_stack+0x1e/0x20 (20)
> [<c0136bc2>] check_deadlock+0x2d7/0x334 (44)
> [<c01379bc>] task_blocks_on_lock+0x2c/0x224 (36)
> [<c03f29c5>] __down_interruptible+0x37c/0x95d (160)
> [<c013aebf>] down_futex+0xa3/0xe7 (40)
> [<c013ebc5>] futex_wait_robust+0x142/0x1f3 (72)
> [<c013f35c>] do_futex+0x9a/0x109 (40)
> [<c013f4dd>] sys_futex+0x112/0x11e (68)
> [<c0102f03>] sysenter_past_esp+0x54/0x75 (-8116)
>------------------------------
>| showing all locks held by: |  (testpi-3/4595 [f7becdd0,  59]):
>------------------------------
>
>#001:             [f7abbc94] {futex}
>... acquired at:               futex_wait_robust+0x142/0x1f3
>
>---------------------------------------------------------------------
>
>futex.c -> futex_wait_robust
>
>        if ((curval & FUTEX_PID) == current->pid) {
>                ret = -EAGAIN;
>                goto out_unlock;
>        }
>
>rt.c    -> down_futex
>
>        if (!owner_task || owner_task == current) {
>                up(sem);
>                up_read(&current->mm->mmap_sem);
>                return -EAGAIN;
>        }
>
>I noticed that both the above checks below have been removed in your
>patch. I do understand that the futex_wait_robust path has been
>made similar to the futex_wait path, but I think we are not taking
>PI into consideration. Basically it looks like we still need to check
>if the current task has become owner. or are we missing a lock somewhere ?
>
>I added the down_futex check above and my test has been
>running for hours without the oops. Without this check it
>used to oops within minutes.
>
>Patch that works for me attached below.  Thoughts?
>
>        -Dinakar
>
>
>  
>
>------------------------------------------------------------------------
>
>Index: linux-2.6.14-rt22-rayrt5/kernel/rt.c
>===================================================================
>--- linux-2.6.14-rt22-rayrt5.orig/kernel/rt.c	2005-12-15 02:15:13.000000000 +0530
>+++ linux-2.6.14-rt22-rayrt5/kernel/rt.c	2005-12-15 02:18:29.000000000 +0530
>@@ -3001,7 +3001,7 @@
> 	 * if the owner can't be found return try again.
> 	 */
> 
>-	if (!owner_task) {
>+	if (!owner_task || owner_task == current) {
> 		up(sem);
> 		up_read(&current->mm->mmap_sem);
> 		return -EAGAIN;
>  
>

