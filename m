Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262844AbVDASh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbVDASh2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 13:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262847AbVDASaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 13:30:07 -0500
Received: from mail3.utc.com ([192.249.46.192]:63478 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S262844AbVDAS1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 13:27:23 -0500
Message-ID: <424D927F.2020601@cybsft.com>
Date: Fri, 01 Apr 2005 12:27:11 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
References: <20050325145908.GA7146@elte.hu> <20050331085541.GA21306@elte.hu> <20050401104724.GA31971@elte.hu> <200504011231.55717.gene.heskett@verizon.net>
In-Reply-To: <200504011231.55717.gene.heskett@verizon.net>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030205080607080701020705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030205080607080701020705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Gene Heskett wrote:
<snip>
> It was up to 43-04 by the time I got there.
> 
> This one didn't go in cleanly Ingo.  From my build-src scripts output:
> -------------------
> Applying patch realtime-preempt-2.6.12-rc1-V0.7.43-04
> [...]
> patching file lib/rwsem-spinlock.c
> Hunk #5 FAILED at 133.
> Hunk #6 FAILED at 160.
> Hunk #7 FAILED at 179.
> Hunk #8 FAILED at 194.
> Hunk #9 FAILED at 204.
> Hunk #10 FAILED at 231.
> Hunk #11 FAILED at 250.
> Hunk #12 FAILED at 265.
> Hunk #13 FAILED at 274.
> Hunk #14 FAILED at 293.
> Hunk #15 FAILED at 314.
> 11 out of 15 hunks FAILED -- saving rejects to file 
> lib/rwsem-spinlock.c.rej
> -----------
> I doubt it would run, so I haven't built it.  Should I?
> 

Adding the attached patch on top of the above should resolve the 
failures, at least in the patching. Still working on building it.

-- 
    kr

--------------030205080607080701020705
Content-Type: text/x-patch;
 name="rwsem-spinlock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rwsem-spinlock.patch"

--- linux-2.6.12/lib/rwsem-spinlock.c.orig	2005-04-01 12:00:21.000000000 -0600
+++ linux-2.6.12/lib/rwsem-spinlock.c	2005-04-01 12:19:06.000000000 -0600
@@ -18,7 +18,7 @@ struct rwsem_waiter {
 };
 
 #if RWSEM_DEBUG
-void rwsemtrace(struct rw_semaphore *sem, const char *str)
+void rwsemtrace(struct compat_rw_semaphore *sem, const char *str)
 {
 	if (sem->debug)
 		printk("[%d] %s({%d,%d})\n",
@@ -30,7 +30,7 @@ void rwsemtrace(struct rw_semaphore *sem
 /*
  * initialise the semaphore
  */
-void fastcall init_rwsem(struct rw_semaphore *sem)
+void fastcall compat_init_rwsem(struct compat_rw_semaphore *sem)
 {
 	sem->activity = 0;
 	spin_lock_init(&sem->wait_lock);
@@ -49,8 +49,8 @@ void fastcall init_rwsem(struct rw_semap
  * - woken process blocks are discarded from the list after having task zeroed
  * - writers are only woken if wakewrite is non-zero
  */
-static inline struct rw_semaphore *
-__rwsem_do_wake(struct rw_semaphore *sem, int wakewrite)
+static inline struct compat_rw_semaphore *
+__rwsem_do_wake(struct compat_rw_semaphore *sem, int wakewrite)
 {
 	struct rwsem_waiter *waiter;
 	struct task_struct *tsk;
@@ -111,8 +111,8 @@ __rwsem_do_wake(struct rw_semaphore *sem
 /*
  * wake a single writer
  */
-static inline struct rw_semaphore *
-__rwsem_wake_one_writer(struct rw_semaphore *sem)
+static inline struct compat_rw_semaphore *
+__rwsem_wake_one_writer(struct compat_rw_semaphore *sem)
 {
 	struct rwsem_waiter *waiter;
 	struct task_struct *tsk;
@@ -133,7 +133,8 @@ __rwsem_wake_one_writer(struct rw_semaph
 /*
  * get a read lock on the semaphore
  */
-void fastcall __sched __down_read(struct rw_semaphore *sem)
+void fastcall __sched __down_read(struct compat_rw_semaphore *sem)
+
 {
 	struct rwsem_waiter waiter;
 	struct task_struct *tsk;
@@ -179,7 +180,8 @@ void fastcall __sched __down_read(struct
 /*
  * trylock for reading -- returns 1 if successful, 0 if contention
  */
-int fastcall __down_read_trylock(struct rw_semaphore *sem)
+int fastcall __down_read_trylock(struct compat_rw_semaphore *sem)
+
 {
 	unsigned long flags;
 	int ret = 0;
@@ -204,7 +206,8 @@ int fastcall __down_read_trylock(struct 
  * get a write lock on the semaphore
  * - we increment the waiting count anyway to indicate an exclusive lock
  */
-void fastcall __sched __down_write(struct rw_semaphore *sem)
+void fastcall __sched __down_write(struct compat_rw_semaphore *sem)
+
 {
 	struct rwsem_waiter waiter;
 	struct task_struct *tsk;
@@ -250,7 +253,8 @@ void fastcall __sched __down_write(struc
 /*
  * trylock for writing -- returns 1 if successful, 0 if contention
  */
-int fastcall __down_write_trylock(struct rw_semaphore *sem)
+int fastcall __down_write_trylock(struct compat_rw_semaphore *sem)
+
 {
 	unsigned long flags;
 	int ret = 0;
@@ -274,7 +278,8 @@ int fastcall __down_write_trylock(struct
 /*
  * release a read lock on the semaphore
  */
-void fastcall __up_read(struct rw_semaphore *sem)
+void fastcall __up_read(struct compat_rw_semaphore *sem)
+
 {
 	unsigned long flags;
 
@@ -293,7 +298,7 @@ void fastcall __up_read(struct rw_semaph
 /*
  * release a write lock on the semaphore
  */
-void fastcall __up_write(struct rw_semaphore *sem)
+void fastcall __up_write(struct compat_rw_semaphore *sem)
 {
 	unsigned long flags;
 
@@ -314,7 +319,7 @@ void fastcall __up_write(struct rw_semap
  * downgrade a write lock into a read lock
  * - just wake up any readers at the front of the queue
  */
-void fastcall __downgrade_write(struct rw_semaphore *sem)
+void fastcall __downgrade_write(struct compat_rw_semaphore *sem)
 {
 	unsigned long flags;
 
@@ -331,7 +336,7 @@ void fastcall __downgrade_write(struct r
 	rwsemtrace(sem, "Leaving __downgrade_write");
 }
 
-EXPORT_SYMBOL(init_rwsem);
+EXPORT_SYMBOL(compat_init_rwsem);
 EXPORT_SYMBOL(__down_read);
 EXPORT_SYMBOL(__down_read_trylock);
 EXPORT_SYMBOL(__down_write);

--------------030205080607080701020705--
