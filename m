Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVCVNLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVCVNLK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 08:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVCVNLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 08:11:10 -0500
Received: from mx1.elte.hu ([157.181.1.137]:23752 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261186AbVCVNKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 08:10:49 -0500
Date: Tue, 22 Mar 2005 14:10:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, dipankar@in.ibm.com,
       shemminger@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       rusty@au1.ibm.com, tgall@us.ibm.com, jim.houston@comcast.net,
       manfred@colorfullife.com, gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
Message-ID: <20050322131016.GA2674@elte.hu>
References: <20050322105640.GA28861@elte.hu> <Pine.OSF.4.05.10503221220500.25802-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10503221220500.25802-100000@da410.phys.au.dk>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Esben Nielsen <simlo@phys.au.dk> wrote:

> > > +static inline void rcu_read_lock(void)
> > > +{	
> > > +	preempt_disable(); 
> > > +	__get_cpu_var(rcu_data).active_readers++;
> > > +	preempt_enable();
> > > +}
> > 
> > this is buggy. Nothing guarantees that we'll do the rcu_read_unlock() on
> > the same CPU, and hence ->active_readers can get out of sync.
> > 
> 
> Ok, this have to be handled in the mitigration code somehow. I have already 
> added an 
>   current->rcu_read_depth++
> so it ought to be painless. A simple solution would be not to
> mititagrate threads with rcu_read_depth!=0.

could you elaborate?

In any case, see the new PREEMPT_RCU code in the -40-07 patch (and
upwards). I've also attached a separate patch, it should apply cleanly
to 2.6.12-rc1.

	Ingo

--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="preempt-rcu-2.6.12-rc1-A0"

--- linux/kernel/rcupdate.c.orig
+++ linux/kernel/rcupdate.c
@@ -468,3 +468,36 @@ module_param(maxbatch, int, 0);
 EXPORT_SYMBOL(call_rcu);
 EXPORT_SYMBOL(call_rcu_bh);
 EXPORT_SYMBOL(synchronize_kernel);
+
+#ifdef CONFIG_PREEMPT_RCU
+
+void rcu_read_lock(void)
+{
+	if (current->rcu_read_lock_nesting++ == 0) {
+		current->rcu_data = &get_cpu_var(rcu_data);
+		atomic_inc(&current->rcu_data->active_readers);
+		put_cpu_var(rcu_data);
+	}
+}
+EXPORT_SYMBOL(rcu_read_lock);
+
+void rcu_read_unlock(void)
+{
+	int cpu;
+
+	if (--current->rcu_read_lock_nesting == 0) {
+		atomic_dec(&current->rcu_data->active_readers);
+		/*
+		 * Check whether we have reached quiescent state.
+		 * Note! This is only for the local CPU, not for
+		 * current->rcu_data's CPU [which typically is the
+		 * current CPU, but may also be another CPU].
+		 */
+		cpu = get_cpu();
+		rcu_qsctr_inc(cpu);
+		put_cpu();
+	}
+}
+EXPORT_SYMBOL(rcu_read_unlock);
+
+#endif
--- linux/include/linux/rcupdate.h.orig
+++ linux/include/linux/rcupdate.h
@@ -99,6 +99,9 @@ struct rcu_data {
 	struct rcu_head *donelist;
 	struct rcu_head **donetail;
 	int cpu;
+#ifdef CONFIG_PREEMPT_RCU
+	atomic_t	active_readers;
+#endif
 };
 
 DECLARE_PER_CPU(struct rcu_data, rcu_data);
@@ -115,12 +118,18 @@ extern struct rcu_ctrlblk rcu_bh_ctrlblk
 static inline void rcu_qsctr_inc(int cpu)
 {
 	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
-	rdp->passed_quiesc = 1;
+#ifdef CONFIG_PREEMPT_RCU
+	if (!atomic_read(&rdp->active_readers))
+#endif
+		rdp->passed_quiesc = 1;
 }
 static inline void rcu_bh_qsctr_inc(int cpu)
 {
 	struct rcu_data *rdp = &per_cpu(rcu_bh_data, cpu);
-	rdp->passed_quiesc = 1;
+#ifdef CONFIG_PREEMPT_RCU
+	if (!atomic_read(&rdp->active_readers))
+#endif
+		rdp->passed_quiesc = 1;
 }
 
 static inline int __rcu_pending(struct rcu_ctrlblk *rcp,
@@ -183,14 +192,22 @@ static inline int rcu_pending(int cpu)
  *
  * It is illegal to block while in an RCU read-side critical section.
  */
-#define rcu_read_lock()		preempt_disable()
+#ifdef CONFIG_PREEMPT_RCU
+  extern void rcu_read_lock(void);
+#else
+# define rcu_read_lock preempt_disable()
+#endif
 
 /**
  * rcu_read_unlock - marks the end of an RCU read-side critical section.
  *
  * See rcu_read_lock() for more information.
  */
-#define rcu_read_unlock()	preempt_enable()
+#ifdef CONFIG_PREEMPT_RCU
+  extern void rcu_read_unlock(void);
+#else
+# define rcu_read_unlock preempt_enable()
+#endif
 
 /*
  * So where is rcu_write_lock()?  It does not exist, as there is no
@@ -213,14 +230,16 @@ static inline int rcu_pending(int cpu)
  * can use just rcu_read_lock().
  *
  */
-#define rcu_read_lock_bh()	local_bh_disable()
+//#define rcu_read_lock_bh()	local_bh_disable()
+#define rcu_read_lock_bh()	{ rcu_read_lock(); local_bh_disable(); }
 
 /*
  * rcu_read_unlock_bh - marks the end of a softirq-only RCU critical section
  *
  * See rcu_read_lock_bh() for more information.
  */
-#define rcu_read_unlock_bh()	local_bh_enable()
+//#define rcu_read_unlock_bh()	local_bh_enable()
+#define rcu_read_unlock_bh()	{ local_bh_enable(); rcu_read_unlock(); }
 
 /**
  * rcu_dereference - fetch an RCU-protected pointer in an
--- linux/include/linux/sched.h.orig
+++ linux/include/linux/sched.h
@@ -727,6 +872,10 @@ struct task_struct {
 	nodemask_t mems_allowed;
 	int cpuset_mems_generation;
 #endif
+#ifdef CONFIG_PREEMPT_RCU
+	int rcu_read_lock_nesting;
+	struct rcu_data *rcu_data;
+#endif
 };
 
 static inline pid_t process_group(struct task_struct *tsk)

--T4sUOijqQbZv57TR--
