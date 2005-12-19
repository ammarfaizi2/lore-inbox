Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbVLSLjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbVLSLjW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 06:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932726AbVLSLjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 06:39:22 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:41093 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932106AbVLSLjV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 06:39:21 -0500
Date: Mon, 19 Dec 2005 17:26:11 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: David Singleton <dsingleton@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       robustmutexes@lists.osdl.org
Subject: Re: Recursion bug in -rt
Message-ID: <20051219115611.GA3945@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20051214223912.GA4716@in.ibm.com> <9175126B-6D06-11DA-AA1B-000A959BB91E@mvista.com> <20051215194434.GA4741@in.ibm.com> <43F8915C-6DC7-11DA-A45A-000A959BB91E@mvista.com> <20051216184209.GD4732@in.ibm.com> <43A33114.6060701@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <43A33114.6060701@mvista.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 16, 2005 at 01:26:44PM -0800, David Singleton wrote:
> Dinakar,
> 
>     I believe this patch will give you the behavior you expect.
> 
>    http://source.mvista.com/~dsingleton/patch-2.6.15-rc5-rt2-rf3

Not really, the reason, quoting from my previous mail

   So IMO the above check is not right. However removing this check
   is not the end of story.  This time it gets to task_blocks_on_lock
   and tries to grab the task->pi_lock of the owvner which is itself
   and results in a system hang. (Assuming CONFIG_DEBUG_DEADLOCKS
   is not set). So it looks like we need to add some check to
   prevent this below in case lock_owner happens to be current.

    _raw_spin_lock(&lock_owner(lock)->task->pi_lock);

The patch that works for me is attached below

	-Dinakar



--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="check_current.patch"

Index: linux-2.6.14-rt22-rayrt5/kernel/rt.c
===================================================================
--- linux-2.6.14-rt22-rayrt5.orig/kernel/rt.c	2005-12-15 02:15:13.000000000 +0530
+++ linux-2.6.14-rt22-rayrt5/kernel/rt.c	2005-12-19 15:51:26.000000000 +0530
@@ -1042,7 +1042,8 @@
 		return;
 	}
 #endif
-	_raw_spin_lock(&lock_owner(lock)->task->pi_lock);
+	if (current != lock_owner(lock)->task)
+		_raw_spin_lock(&lock_owner(lock)->task->pi_lock);
 	plist_add(&waiter->pi_list, &lock_owner(lock)->task->pi_waiters);
 	/*
 	 * Add RT tasks to the head:
@@ -1055,7 +1056,8 @@
 	 */
 	if (task->prio < lock_owner(lock)->task->prio)
 		pi_setprio(lock, lock_owner(lock)->task, task->prio);
-	_raw_spin_unlock(&lock_owner(lock)->task->pi_lock);
+	if (current != lock_owner(lock)->task)
+		_raw_spin_unlock(&lock_owner(lock)->task->pi_lock);
 }
 
 /*
@@ -3016,8 +3018,7 @@
 	 * the first waiter and we'll just block on the down_interruptible.
 	 */
 
-	if (owner_task != current)
-		down_try_futex(lock, owner_task->thread_info __EIP__);
+	down_try_futex(lock, owner_task->thread_info __EIP__);
 
 	/*
 	 * we can now drop the locks because the rt_mutex is held.

--Q68bSM7Ycu6FN28Q--
