Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbVJDUnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbVJDUnw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 16:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbVJDUnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 16:43:52 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:23947
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S964965AbVJDUnv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 16:43:51 -0400
Subject: Re: 2.6.14-rc3-rt2
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Mark Knecht <markknecht@gmail.com>
Cc: Steven Rostedt <rostedt@kihontech.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <5bdc1c8b0510041158m3620f5dcy2dafda545ad3cd5e@mail.gmail.com>
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com>
	 <20051004130009.GB31466@elte.hu>
	 <5bdc1c8b0510040944q233f14e6g17d53963a4496c1f@mail.gmail.com>
	 <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com>
	 <1128450029.13057.60.camel@tglx.tec.linutronix.de>
	 <5bdc1c8b0510041158m3620f5dcy2dafda545ad3cd5e@mail.gmail.com>
Content-Type: text/plain
Organization: linutronix
Date: Tue, 04 Oct 2005 22:45:07 +0200
Message-Id: <1128458707.13057.68.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-04 at 11:58 -0700, Mark Knecht wrote:
> > I guess its related to the priority leak I'm tracking down right now.
> > Can you please set following config options and check if you get a bug
> > similar to this ?
> >
> > BUG: init/1: leaked RT prio 98 (116)?
> >
> > Steven, it goes away when deadlock detection is enabled. Any pointers 

Thats actually a red hering caused by asymetric accounting which only
happens when

CONFIG_DEBUG_PREEMPT=y 
and 
# CONFIG_RT_DEADLOCK_DETECT is not set

tglx


Index: linux-2.6.14-rc3-rt8-ep/kernel/rt.c
===================================================================
--- linux-2.6.14-rc3-rt8-ep.orig/kernel/rt.c
+++ linux-2.6.14-rc3-rt8-ep/kernel/rt.c
@@ -295,6 +295,21 @@ void check_preempt_wakeup(struct task_st
 			dump_stack();
 		}
 }
+
+static inline void account_mutex_owner_down(struct rt_mutex *lock)
+{
+	current->owned_lock[current->lock_count] = lock;
+	current->lock_count++;
+}
+
+static inline void account_mutex_owner_up(struct rt_mutex *lock)
+{
+	current->lock_count--;
+	current->owned_lock[current->lock_count] = NULL;
+}
+
+#else
+#define account_mutex_owner(l) do { } while(0)
 #endif
 
 #ifdef CONFIG_RT_DEADLOCK_DETECT
@@ -1241,13 +1256,13 @@ static int __grab_lock(struct rt_mutex *
 	list_del_init(&lock->held_list);
 #endif
 #if defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_PREEMPT_RT)
+	owner->lock_count--;
 	if (owner->lock_count < 0 || owner->lock_count >= MAX_LOCK_STACK) {
 		TRACE_OFF();
 		printk("BUG: %s/%d: lock count of %u\n",
 			owner->comm, owner->pid, owner->lock_count);
 		dump_stack();
 	}
-	owner->lock_count--;
 	owner->owned_lock[owner->lock_count] = NULL;
 #endif
 	return 1;
@@ -1579,13 +1594,13 @@ ____up_mutex(struct rt_mutex *lock, int 
 		lock->owner = NULL;
 	_raw_spin_unlock(&lock->wait_lock);
 #if defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_PREEMPT_RT)
+	current->lock_count--;
 	if (current->lock_count < 0 || current->lock_count >= MAX_LOCK_STACK) {
 		TRACE_OFF();
 		printk("BUG: %s/%d: lock count of %u\n",
 			current->comm, current->pid, current->lock_count);
 		dump_stack();
 	}
-	current->lock_count--;
 	current->owned_lock[current->lock_count] = NULL;
 	if (!current->lock_count && !rt_prio(current->normal_prio) &&
 					rt_prio(current->prio)) {
@@ -1638,6 +1653,8 @@ static inline void __down_mutex_inline(s
 
 	if (unlikely(cmpxchg(&lock->owner, NULL, ti)))
 		___down_mutex(lock __EIP__);
+	else
+		account_mutex_owner_down(lock);
 }
 
 static inline void __down_inline(struct rt_mutex *lock __EIP_DECL__)
@@ -1646,6 +1663,8 @@ static inline void __down_inline(struct 
 
 	if (unlikely(cmpxchg(&lock->owner, NULL, ti)))
 		___down(lock __EIP__);
+	else
+		account_mutex_owner_down(lock);
 }
 
 void __sched __down_mutex(struct rt_mutex *lock __EIP_DECL__)
@@ -1697,6 +1716,8 @@ static inline void
 
 	if (unlikely(cmpxchg(&lock->owner, ti, NULL) != ti))
 		___up_mutex_savestate(lock __EIP__);
+	else
+		account_mutex_owner_up(lock);
 }
 
 void __sched __up_mutex_savestate(struct rt_mutex *lock __EIP_DECL__)
@@ -1711,6 +1732,8 @@ __up_mutex_nosavestate_inline(struct rt_
 
 	if (unlikely(cmpxchg(&lock->owner, ti, NULL) != ti))
 		___up_mutex_nosavestate(lock __EIP__);
+	else
+		account_mutex_owner_up(lock);
 }
 
 void __sched __up_mutex_nosavestate(struct rt_mutex *lock __EIP_DECL__)
@@ -2869,6 +2892,9 @@ void fastcall rt_mutex_set_owner(struct 
 	 */
 #ifdef CONFIG_DEBUG_PREEMPT
 	current->lock_count--;
+	current->owned_lock[current->lock_count] = NULL;
+	t->task->owned_lock[t->task->lock_count] = lock;
+	t->task->lock_count++;
 #endif
 	lock->owner = t;
 }



