Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVCTXbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVCTXbj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 18:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbVCTX3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 18:29:44 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:16105 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261352AbVCTXYB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 18:24:01 -0500
Date: Mon, 21 Mar 2005 00:23:22 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, dipankar@in.ibm.com, shemminger@osdl.org,
       akpm@osdl.org, torvalds@osdl.org, rusty@au1.ibm.com, tgall@us.ibm.com,
       jim.houston@comcast.net, manfred@colorfullife.com, gh@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
In-Reply-To: <20050320223832.GA1298@us.ibm.com>
Message-Id: <Pine.OSF.4.05.10503210004340.5287-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Mar 2005, Paul E. McKenney wrote:

> On Sun, Mar 20, 2005 at 02:29:17PM +0100, Esben Nielsen wrote:
> > On Fri, 18 Mar 2005, Ingo Molnar wrote:
> > 
> > > [...]
> > 
> > I think it can be deterministic (on the long timescale of memory management) 
> > anyway: Boost any non-RT task entering an RCU region to the lowest RT priority.
> > This way only all the RT tasks + one non-RT task can be within those
> > regions. The RT-tasks are supposed to have some kind of upper bound to
> > their CPU-usage. The non-RT task will also finish "soon" as it is
> > boosted. If the RCU batches are also at the lowest RT-priority they can be
> > run immediately after the non-RT task is done.
> 
> Hmmm...  Sort of a preemptive-first-strike priority boost.  Cute!  ;-)
> 
Well, I was actually thinking of an API like
 preempt_by_nonrt_disable()
 preempt_by_nonrt_enable()
working like the old preempt_disable()/preempt_enable() but still
allowing RT tasks (as well as priority inheriting non-RT tasks) to be
scheduled. That would kind of help "split" the kernel into two halfs: the
RT part and the non-RT part. The non-RT part would in many ways work as it
has always done.

> > > clearly the simplest solution is to go with the single-reader locks for
> > > now - a separate experiment could be done with a new type of rwlock that
> > > can only be used by the RCU code. (I'm not quite sure whether we could
> > > guarantee a minimum rate of RCU callback processing under such a scheme
> > > though. It's an eventual memory DoS otherwise.)
> > > 
> > 
> > Why are a lock needed at all? If it is doable without locking for an
> > non-preemptable SMP kernel it must be doable for an preemptable kernel as
> > well.I am convinced some kind of per-CPU rcu_read_count as I specified in
> > my previous mail can work some way or the other. call_rcu() might need to
> > do more complicated stuff and thus use CPU but call_rcu() is supposed to
> > be an relative rare event not worth optimizing for.  Such an
> > implementation will work for any preemptable kernel, not only PREEMPT_RT. 
> > For performance is considered it is important not to acquire any locks in
> > the rcu-read regions. 
> 
> You definitely don't need a lock -- you can just suppress preemption
> on the read side instead.  But that potentially makes for long scheduling
> latencies.

Well, in my patch I do not leave preemption off - only while doing the
simple ++/--. In effect, I let rcu_qsctr_inc know that some RCU reader
might be active, i.e. preempted, on the current CPU such that this isn't
and quiescent point after all.
(To others: Paul nicely unfolded my attachment below - I left it in
the mail such you can read it.)
The problem with this approach is ofcourse that user space programs might
preempt an RCU reader for a very long time such that RCU batches are never
really run. The boosting of non-RT tasks mentioned above would help a
lot.
A plus(?) in it: You can actually sleep while having the rcu_read_lock !!

> 
> The counter approach might work, and is also what the implementation #5
> does -- check out rcu_read_lock() in Ingo's most recent patch.
> 

Do you refer to your original mail with implementing it in 5 steps?
In #5 in that one (-V0.7.41-00, right?) you use a lock and as you say that
forces syncronization between the CPUs - bad for scaling. It does make the
RCU batches somewhat deterministic, as the RCU task can boost the readers
to the rcu-task's priority.
The problem about this approach is that everybody calling into RCU code
have a worst case behaviour of the systemwide worst case RCU reader 
section - which can be pretty large (in principle infinite if somebody.)
So if somebody uses a call to a function in the code containing a RCU read
area the worst case behavious would be the same as teh worst case latency
in the simple world where preempt_disable()/preempt_enable() was used.

> 						Thanx, Paul
> 
> > I tried this approach. My UP labtop did boot on it, but I haven't testet
> > it further. I have included the very small patch as an attachment.
> > 
> > > 	Ingo
> > 
> > I have not yet looked at -V0.7.41-00...
> > 
> > Esben
> > 
> 
> > diff -Naur --exclude-from diff_exclude linux-2.6.11-final-V0.7.40-00/include/linux/rcupdate.h linux-2.6.11-final-V0.7.40-00-RCU/include/linux/rcupdate.h
> > --- linux-2.6.11-final-V0.7.40-00/include/linux/rcupdate.h	2005-03-11 23:40:13.000000000 +0100
> > +++ linux-2.6.11-final-V0.7.40-00-RCU/include/linux/rcupdate.h	2005-03-19 12:47:09.000000000 +0100
> > @@ -85,6 +85,7 @@
> >   * curlist - current batch for which quiescent cycle started if any
> >   */
> >  struct rcu_data {
> > +	long            active_readers;
> >  	/* 1) quiescent state handling : */
> >  	long		quiescbatch;     /* Batch # for grace period */
> >  	int		passed_quiesc;	 /* User-mode/idle loop etc. */
> > @@ -115,12 +116,14 @@
> >  static inline void rcu_qsctr_inc(int cpu)
> >  {
> >  	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
> > -	rdp->passed_quiesc = 1;
> > +	if(rdp->active_readers==0)
> > +		rdp->passed_quiesc = 1;
> >  }
> >  static inline void rcu_bh_qsctr_inc(int cpu)
> >  {
> >  	struct rcu_data *rdp = &per_cpu(rcu_bh_data, cpu);
> > -	rdp->passed_quiesc = 1;
> > +	if(rdp->active_readers==0)
> > +		rdp->passed_quiesc = 1;
> >  }
> >  
> >  static inline int __rcu_pending(struct rcu_ctrlblk *rcp,
> > @@ -183,29 +186,27 @@
> >   *
> >   * It is illegal to block while in an RCU read-side critical section.
> >   */
> > -#define rcu_read_lock()		preempt_disable()
> > +static inline void rcu_read_lock(void)
> > +{	
> > +	preempt_disable(); 
> > +	__get_cpu_var(rcu_data).active_readers++;
> > +	preempt_enable();
> > +}
> >  
> >  /**
> >   * rcu_read_unlock - marks the end of an RCU read-side critical section.
> >   *
> >   * See rcu_read_lock() for more information.
> >   */
> > -#define rcu_read_unlock()	preempt_enable()
> > +static inline void rcu_read_unlock(void)
> > +{	
> > +	preempt_disable(); 
> > +	__get_cpu_var(rcu_data).active_readers--;
> > +	preempt_enable();
> > +}
> >  
> >  #define IGNORE_LOCK(op, lock)	do { (void)(lock); op(); } while (0)
> >  
> > -#ifdef CONFIG_PREEMPT_RT
> > -# define rcu_read_lock_spin(lock)	spin_lock(lock)
> > -# define rcu_read_unlock_spin(lock)	spin_unlock(lock)
> > -# define rcu_read_lock_read(lock)	read_lock(lock)
> > -# define rcu_read_unlock_read(lock)	read_unlock(lock)
> > -# define rcu_read_lock_bh_read(lock)	read_lock_bh(lock)
> > -# define rcu_read_unlock_bh_read(lock)	read_unlock_bh(lock)
> > -# define rcu_read_lock_down_read(rwsem)	down_read(rwsem)
> > -# define rcu_read_unlock_up_read(rwsem)	up_read(rwsem)
> > -# define rcu_read_lock_nort()		do { } while (0)
> > -# define rcu_read_unlock_nort()		do { } while (0)
> > -#else
> >  # define rcu_read_lock_spin(lock)	IGNORE_LOCK(rcu_read_lock, lock)
> >  # define rcu_read_unlock_spin(lock)	IGNORE_LOCK(rcu_read_unlock, lock)
> >  # define rcu_read_lock_read(lock)	IGNORE_LOCK(rcu_read_lock, lock)
> > @@ -216,15 +217,10 @@
> >  # define rcu_read_unlock_nort()		rcu_read_unlock()
> >  # define rcu_read_lock_bh_read(lock)	IGNORE_LOCK(rcu_read_lock_bh, lock)
> >  # define rcu_read_unlock_bh_read(lock)	IGNORE_LOCK(rcu_read_unlock_bh, lock)
> > -#endif
> >  
> > -#ifdef CONFIG_PREEMPT_RT
> > -# define rcu_read_lock_sem(lock)	down(lock)
> > -# define rcu_read_unlock_sem(lock)	up(lock)
> > -#else
> >  # define rcu_read_lock_sem(lock)	IGNORE_LOCK(rcu_read_lock, lock)
> >  # define rcu_read_unlock_sem(lock)	IGNORE_LOCK(rcu_read_unlock, lock)
> > -#endif
> > +
> >  /*
> >   * So where is rcu_write_lock()?  It does not exist, as there is no
> >   * way for writers to lock out RCU readers.  This is a feature, not
> > diff -Naur --exclude-from diff_exclude linux-2.6.11-final-V0.7.40-00/Makefile linux-2.6.11-final-V0.7.40-00-RCU/Makefile
> > --- linux-2.6.11-final-V0.7.40-00/Makefile	2005-03-11 23:40:13.000000000 +0100
> > +++ linux-2.6.11-final-V0.7.40-00-RCU/Makefile	2005-03-19 12:41:09.000000000 +0100
> > @@ -1,7 +1,7 @@
> >  VERSION = 2
> >  PATCHLEVEL = 6
> >  SUBLEVEL = 11
> > -EXTRAVERSION = -RT-V0.7.40-00
> > +EXTRAVERSION = -RT-V0.7.40-00-RCU
> >  NAME=Woozy Numbat
> >  
> >  # *DOCUMENTATION*
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

