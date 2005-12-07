Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751779AbVLGTPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbVLGTPe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 14:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbVLGTPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 14:15:34 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:16261 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751779AbVLGTPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 14:15:32 -0500
Date: Thu, 8 Dec 2005 01:04:29 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, David Singleton <dsingleton@mvista.com>
Subject: [PATCH] Fix timeout in robust path
Message-ID: <20051207193429.GD4897@in.ibm.com>
Reply-To: dino@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ingo,

I hit the following BUG when exercising the robust futex path

testpi-1/4920[CPU#0]: BUG in FREE_WAITER at kernel/rt.c:1368
 [<c011f180>] __WARN_ON+0x60/0x80 (8)
 [<c03f6581>] __down_mutex+0x601/0x844 (48)
 [<c013813a>] pi_setprio+0xa1/0x632 (104)
 [<c0127386>] lock_timer_base+0x19/0x33 (8)
 [<c03f884d>] _spin_lock_irqsave+0x1d/0x46 (12)
 [<c0127386>] lock_timer_base+0x19/0x33 (8)
 [<c0127386>] lock_timer_base+0x19/0x33 (16)
 [<c01273d8>] __mod_timer+0x38/0xdf (16)
 [<c013fb9b>] sub_preempt_count+0x1a/0x1e (12)
 [<c03f81e1>] __down_interruptible+0x922/0xaf7 (20)
 [<c01411f5>] futex_wait_robust+0x14c/0x216 (16)
 [<c01394e8>] process_timeout+0x0/0x9 (48)
 [<c01411f5>] futex_wait_robust+0x14c/0x216 (64)
 [<c013d042>] down_futex+0x7d/0xe2 (12)
 [<c01411f5>] futex_wait_robust+0x14c/0x216 (12)
 [<c013d066>] down_futex+0xa1/0xe2 (8)
 [<c01411f5>] futex_wait_robust+0x14c/0x216 (12)
 [<c01411f5>] futex_wait_robust+0x14c/0x216 (24)
 [<c01419de>] do_futex+0x92/0xf8 (72)
 [<c0141b3c>] sys_futex+0xf8/0x104 (40)
 [<c0103017>] sysenter_past_esp+0x54/0x75 (60)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c013fb00>] .... add_preempt_count+0x1a/0x1e
.....[<00000000>] ..   ( <= stext+0x3feffd68/0x8)

------------------------------
| showing all locks held by: |  (testpi-1/4920 [f6326120,  59]):
------------------------------

When calling futex_wait_robust, we need to ensure that the timeout
is reset to zero, incase userspace timeout is NULL.
Please consider applying

        -Dinakar

Signed-off-by: Dinakar Guniguntala <dino@in.ibm.com>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rt22-timeout.patch"

Index: linux-2.6.14/kernel/futex.c
===================================================================
--- linux-2.6.14.orig/kernel/futex.c	2005-12-08 00:31:29.000000000 +0530
+++ linux-2.6.14/kernel/futex.c	2005-12-08 00:33:01.000000000 +0530
@@ -1535,6 +1535,8 @@
 			return -EFAULT;
 		timeout = timespec_to_jiffies(&t) + 1;
 	}
+	if (op == FUTEX_WAIT_ROBUST && utime == NULL)
+		timeout = 0;
 	/*
 	 * requeue parameter in 'utime' if op == FUTEX_REQUEUE.
 	 */

--fdj2RfSjLxBAspz7--
