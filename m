Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751737AbWHARqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbWHARqO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 13:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbWHARqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 13:46:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:17637 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751736AbWHARqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 13:46:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:message-id:mime-version:content-type:from;
        b=El65JekweXkysydAP4TlSHrG7XxpYNZCqqo71dnDsUuZkDZqlrZrzk3++a28GuJMt+GDsN3Ue+k9gezdZ5a7oOJKLDC2peRhFttkBmybG/tRmMyLEgnE/jZ8Sgo8kEVfyYDdkIdN837gZqjNCWa2++ruxiQIAAWiqfhfdRJl+Io=
Date: Tue, 1 Aug 2006 19:46:32 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, StevenRostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [-rt] Fix race condition and following BUG in PI-futex
Message-ID: <Pine.LNX.4.64.0608011931560.10605@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran into the bug on 2.6.17-rt8 with the previous posted patches which 
make pthread_timed_lock() work on UP, but the bug is there without the 
patches - I just can't trigger it - and it is also in the mainline kernel.

The problem is that rt_mutex_next_owner() is used unprotected in 
wake_futex_pi(). At least it isn't probably serialiazed against the next 
owner being signalled or getting a timeout. The only lock, which is 
good enough here, is &pi_state->pi_mutex.wait_lock, so I added this 
protection.

Esben

  kernel/futex.c |   12 ++++++++++--
  1 file changed, 10 insertions(+), 2 deletions(-)

Index: linux-2.6.17-rt8/kernel/futex.c
===================================================================
--- linux-2.6.17-rt8.orig/kernel/futex.c
+++ linux-2.6.17-rt8/kernel/futex.c
@@ -565,6 +565,7 @@ static int wake_futex_pi(u32 __user *uad
  	if (!pi_state)
  		return -EINVAL;

+	spin_lock(&pi_state->pi_mutex.wait_lock);
  	new_owner = rt_mutex_next_owner(&pi_state->pi_mutex);

  	/*
@@ -590,15 +591,22 @@ static int wake_futex_pi(u32 __user *uad
  	curval = futex_atomic_cmpxchg_inatomic(uaddr, uval, newval);
  	dec_preempt_count();

-	if (curval == -EFAULT)
+	if (curval == -EFAULT) {
+		spin_unlock(&pi_state->pi_mutex.wait_lock);
  		return -EFAULT;
-	if (curval != uval)
+	}
+	if (curval != uval) {
+		spin_unlock(&pi_state->pi_mutex.wait_lock);
  		return -EINVAL;
+	}

  	list_del_init(&pi_state->owner->pi_state_list);
  	list_add(&pi_state->list, &new_owner->pi_state_list);
  	pi_state->owner = new_owner;
+	atomic_inc(&pi_state->refcount);
+	spin_unlock(&pi_state->pi_mutex.wait_lock);
  	rt_mutex_unlock(&pi_state->pi_mutex);
+	free_pi_state(pi_state);

  	return 0;
  }
