Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751792AbWCMG5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbWCMG5H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 01:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbWCMG5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 01:57:07 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:35459
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751792AbWCMG5G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 01:57:06 -0500
Message-ID: <441517B8.6030607@tglx.de>
Date: Mon, 13 Mar 2006 07:56:56 +0100
From: Jan Altenberg <tb10alj@tglx.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: [PATCH] 2.6.16-rc6-rt1: Fix redefinition and unknown symbol
References: <20060312220218.GA3469@elte.hu>
In-Reply-To: <20060312220218.GA3469@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch should fix some simple issues with 2.6.16-rc6-rt1:

- Remove redefinition of rt_mutex_debug_check_no_locks_held
- Add EXPORT_SYMBOL for rt_read_lock and rt_rw_unlock


Signed-off-by: Jan Altenberg <tb10alj@tglx.de>

----------------------

--- linux-2.6.16-rc6-rt1/include/linux/rtmutex.h        2006-03-13 07:21:56.000000000 +0100
+++ linux-2.6.16-rc6-rt1-hacked/include/linux/rtmutex.h 2006-03-13 07:18:55.000000000 +0100
@@ -79,12 +79,10 @@ struct rt_mutex_waiter {
        , .name = #mutexname, .file = __FILE__, .line = __LINE__
 # define rt_mutex_init(mutex)                  __rt_mutex_init(mutex, __FUNCTION__)
  extern void rt_mutex_debug_task_free(struct task_struct *tsk);
- extern void rt_mutex_debug_check_no_locks_held(struct task_struct *tsk);
 #else
 # define __DEBUG_RT_MUTEX_INITIALIZER(mutexname)
 # define rt_mutex_init(mutex)                  __rt_mutex_init(mutex, NULL)
 # define rt_mutex_debug_task_free(t)                   do { } while (0)
-# define rt_mutex_debug_check_no_locks_held(tsk)       do { } while (0)
 #endif

 #define __RT_MUTEX_INITIALIZER(mutexname) \
diff -uprN -X linux-2.6.16-rc6-rt1/Documentation/dontdiff linux-2.6.16-rc6-rt1/kernel/rt.c linux-2.6.16-rc6-rt1-hacked/kernel/rt.c
--- linux-2.6.16-rc6-rt1/kernel/rt.c    2006-03-13 07:21:56.000000000 +0100
+++ linux-2.6.16-rc6-rt1-hacked/kernel/rt.c     2006-03-13 07:34:09.000000000 +0100
@@ -191,6 +191,7 @@ void __lockfunc rt_read_lock(rwlock_t *r
        _raw_spin_unlock_irqrestore(&rwsem->lock.wait_lock, flags);
        rt_rw_lock(rwsem __RET_IP__);
 }
+EXPORT_SYMBOL(rt_read_lock);

 static inline void rt_rw_unlock(struct rw_semaphore *rwsem __IP_DECL__)
 {
@@ -201,6 +202,7 @@ static inline void rt_rw_unlock(struct r
 */
        rt_unlock(&rwsem->lock);
 }
+EXPORT_SYMBOL(rt_rw_unlock);

 void __lockfunc rt_write_unlock(rwlock_t *rwlock)
 {
