Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965248AbWFINER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965248AbWFINER (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 09:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965251AbWFINER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 09:04:17 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:15800 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S965248AbWFINEQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 09:04:16 -0400
Date: Fri, 9 Jun 2006 18:44:09 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] Fix for Bug in PI exit code
Message-ID: <20060609131409.GA4962@in.ibm.com>
Reply-To: dino@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ingo,

We were seeing oopses like below a lot when using PI mutexes

===============================================================================
j9/3939[CPU#1]: BUG in free_pi_state at kernel/futex.c:361
 [<c011dd92>] __WARN_ON+0x41/0x57 (8)
 [<c0130e41>] free_pi_state+0x2d/0xb1 (48)
 [<c0131a31>] unqueue_me_pi+0x5c/0x75 (12)
 [<c0132236>] futex_lock_pi+0x50a/0x5b5 (16)
 [<c014bab0>] do_wp_page+0x325/0x340 (36)
 [<c03121a3>] do_page_fault+0x202/0x528 (156)
 [<c01328d9>] do_futex+0x85/0x8b (20)
 [<c0132966>] sys_futex+0x87/0x94 (24)
 [<c01027c7>] sysenter_past_esp+0x54/0x75 (40)
j9/3939[CPU#2]: BUG in free_pi_state at kernel/futex.c:362
 [<c011dd92>] __WARN_ON+0x41/0x57 (8)
 [<c0130e5e>] free_pi_state+0x4a/0xb1 (48)
 [<c0131a31>] unqueue_me_pi+0x5c/0x75 (12)
 [<c0132236>] futex_lock_pi+0x50a/0x5b5 (16)
 [<c014bab0>] do_wp_page+0x325/0x340 (36)
 [<c03121a3>] do_page_fault+0x202/0x528 (156)
 [<c01328d9>] do_futex+0x85/0x8b (20)
 [<c0132966>] sys_futex+0x87/0x94 (24)
 [<c01027c7>] sysenter_past_esp+0x54/0x75 (40)
BUG: Unable to handle kernel NULL pointer dereference at virtual address 00000514
 printing eip:
c0311096
*pde = 2cd36001
Oops: 0002 [#1]
PREEMPT SMP
Modules linked in: loop ipv6 i2c_dev i2c_core nfs lockd sunrpc dm_mirror
dm_multipath dm_mod joydev button battery ac ohci_hcd hw_random shpchp tg3 ext3
jbd sd_mod
CPU:    2
EIP:    0060:[<c0311096>]    Not tainted VLI
EFLAGS: 00010002   (2.6.16-rayrt12.1.1smp #1)
EIP is at _raw_spin_lock_irq+0xb/0x1a
eax: 00000514   ebx: d61349c0   ecx: c038511c   edx: ed040000
esi: d61349c8   edi: c0475d30   ebp: 08054638   esp: ed041e88
ds: 007b   es: 007b   ss: 0068   preempt: 00000002
Process j9 (pid: 3939, threadinfo=ed040000 task=d0951300 stack_left=7764
worst_left=-1)
Stack: <0>c0130e6b ed041f08 ed041f0c c0131a31 ed041f08 ed040000 fffffffc c0132236
       c80c70b0 c0475d30 00000001 00000f67 c0475d30 00000000 00000000 d0951300
       c014bab0 49e7e067 00000000 49e7e025 00000000 ffa20448 ffa52000 ffa51000
Call Trace:
 [<c0130e6b>] free_pi_state+0x57/0xb1 (4)
 [<c0131a31>] unqueue_me_pi+0x5c/0x75 (12)
 [<c0132236>] futex_lock_pi+0x50a/0x5b5 (16)
 [<c014bab0>] do_wp_page+0x325/0x340 (36)
 [<c03121a3>] do_page_fault+0x202/0x528 (156)
 [<c01328d9>] do_futex+0x85/0x8b (20)
 [<c0132966>] sys_futex+0x87/0x94 (24)

===============================================================================
After a lot of debugging we found that this is caused due to the following race.
PM is a PI mutex, A and B are RT threads

        Thread A (RT)                  Thread B (RT)
            |
            v
    pthread_mutex_lock (PM)                 |
    (glibc) got mutex                       v
         do work                   pthread_mutex_lock (PM)
                                   rt_mutex_timed_lock

          EINTR                    EINTR (Process gets aborted)

         do_exit                   lock(pi_mutex->lock->wait_lock)
    exit_pi_state_list             clear_waiters
    lock(hb->lock)
    pi_state->owner = NULL         unlock(pi_mutex->lock->wait_lock)
    rt_mutex_unlock(pi_mutex)      lock(hb->lock) (blocks)
    unlock(hb->lock)               unblock -> free_pi_state
    continue exit processing       doesn't expect pi_state->owner to be NULL
                                   Panic

The patch attached below seems to make this problem go away. This has been
stress tested quite a bit in the past 24 hours.
Does it look sane to you ??

        -Dinakar

Signed-off-by: Dinakar Guniguntala <dino@in.ibm.com>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fix-24135.patch"

Index: linux-2.6.16/kernel/futex.c
===================================================================
--- linux-2.6.16.orig/kernel/futex.c	2006-06-09 01:15:28.000000000 +0530
+++ linux-2.6.16/kernel/futex.c	2006-06-09 01:18:07.000000000 +0530
@@ -358,14 +358,17 @@
 	if (!atomic_dec_and_test(&pi_state->refcount))
 		return;
 
-	WARN_ON(!pi_state->owner);
-	WARN_ON(!rt_mutex_is_locked(&pi_state->pi_mutex));
-
-	spin_lock_irq(&pi_state->owner->pi_lock);
-	list_del_init(&pi_state->list);
-	spin_unlock_irq(&pi_state->owner->pi_lock);
+	/*
+	 * If pi_state->owner is NULL, the owner is most probably dying
+	 * and has cleaned up the pi_state already
+	 */
+	if (pi_state->owner) {
+		spin_lock_irq(&pi_state->owner->pi_lock);
+		list_del_init(&pi_state->list);
+		spin_unlock_irq(&pi_state->owner->pi_lock);
 
-	rt_mutex_proxy_unlock(&pi_state->pi_mutex, pi_state->owner);
+		rt_mutex_proxy_unlock(&pi_state->pi_mutex, pi_state->owner);
+	}
 
 	if (current->pi_state_cache)
 		kfree(pi_state);

--tKW2IUtsqtDRztdT--
