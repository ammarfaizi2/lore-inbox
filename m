Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265486AbSJSCrt>; Fri, 18 Oct 2002 22:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265487AbSJSCrt>; Fri, 18 Oct 2002 22:47:49 -0400
Received: from h00e098094f32.ne.client2.attbi.com ([24.60.61.209]:28803 "EHLO
	linux.local") by vger.kernel.org with ESMTP id <S265486AbSJSCrX>;
	Fri, 18 Oct 2002 22:47:23 -0400
Date: Fri, 18 Oct 2002 22:52:56 -0400
Message-Id: <200210190252.g9J2quf16153@linux.local>
From: Jim Houston <jim.houston@attbi.com>
To: george@mvista.com, high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, jim.houston@ccur.com,
       Ulrich.Windl@rz.uni-regensburg.de
Subject: POSIX clocks & timers - more choices
Reply-to: jim.houston@attbi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Everyone,

The attached files are an experimental implementation of the
Posix timers.  If you want to play with it, you need to install
George Anzinger's latest patch and layer these files on top.

I have been working with George's patch since March, and I'm
quite happy with it.  I would like to see it in the 2.5 tree!

Of course that doesn't stop me from wanting to play with
some variation on the theme.  Linus complained about the 
partial ticks but has not said what would make the patch
acceptable.  Perhaps some new code and an enthusiastic
discussion would help?

The attached files include:

     -	A new queue just for Posix timers and code to
	handle expiring timers.  This supports high resolution
	without having to change the existing jiffie
	based timers.

	I implemented this priority queue as a sort list
	with a rbtree to index the list.  It is deterministic
	and fast. 
	
     -	Change to use the slab allocator.  This removes
	the CONFIG option for the maximum number of timers.

     -	A new id allocator/lookup mechanism based on a
	radix tree.  It includes  a bitmap to summarize the portion
	of the tree which is in use.  Currently the Posix
	timers patch reuses the id immediately.
	
     -	I keep the timers in seconds and nano-seconds.
	I'm hoping that the system time keeping will sort 
	itself out and the Posix timers can just be a consumer.
	Posix timers need two clocks - the time since boot and
	the wall clock time.   

Most of this code are experiments I have been playing with in user
space.  I pulled this together in the last couple days, and it passes
some of the tests in George's support package.  I have it wired into
the normal timers with an add_timer


Jim Houston - Concurrent Computer Corp.


NOTE!! The attached "patch" is not realy a patch its complete files.
It was created by diff'ing against an empty directory.

diff -urN empty/include/linux/id.h new/include/linux/id.h
--- empty/include/linux/id.h	Wed Dec 31 19:00:00 1969
+++ new/include/linux/id.h	Fri Oct 18 21:11:51 2002
@@ -0,0 +1,46 @@
+/*
+ * include/linux/id.h
+ * 
+ * 2002-10-18  written by Jim Houston jim.houston@ccur.com
+ *	Copyright (C) 2002 by Concurrent Computer Corporation
+ *	Distributed under the GNU GPL license version 2.
+ *
+ * Small id to pointer translation service avoiding fixed sized
+ * tables.
+ */
+
+#define ID_BITS 5
+#define ID_MASK ((1 << ID_BITS)-1)
+#define ID_FULL ((1 << (1 << ID_BITS))-1)
+
+/* Number of id_layer structs to leave in free list */
+#define ID_FREE_MAX 6
+
+struct id_layer {
+	unsigned int	bitmap: (1<<ID_BITS);
+	struct id_layer	*ary[1<<ID_BITS];
+};
+
+struct id {
+	int		layers;
+	int		last;
+	int		count;
+	int		min_wrap;
+	struct id_layer *top;
+};
+
+void *id_lookup(struct id *idp, int id);
+int id_new(struct id *idp, void *ptr);
+void id_remove(struct id *idp, int id);
+void id_init(struct id *idp, int min_wrap);
+
+static inline void update_bitmap(struct id_layer *p, int bit)
+{
+	if (p->ary[bit] && p->ary[bit]->bitmap == (typeof(p->bitmap))-1)
+		p->bitmap |= 1<<bit;
+	else
+		p->bitmap &= ~(1<<bit);
+}
+
+extern kmem_cache_t *id_layer_cache;
+
diff -urN empty/kernel/id.c new/kernel/id.c
--- empty/kernel/id.c	Wed Dec 31 19:00:00 1969
+++ new/kernel/id.c	Fri Oct 18 21:07:34 2002
@@ -0,0 +1,214 @@
+/*
+ * linux/kernel/id.c
+ *
+ * 2002-10-18  written by Jim Houston jim.houston@ccur.com
+ *	Copyright (C) 2002 by Concurrent Computer Corporation
+ *	Distributed under the GNU GPL license version 2.
+ *
+ * Small id to pointer translation service.  
+ *
+ * It uses a radix tree like structure as a sparse array indexed 
+ * by the id to obtain the pointer.  The bitmap makes allocating
+ * an new id quick.  
+ */
+
+
+#include <linux/slab.h>
+#include <linux/id.h>
+#include <linux/init.h>
+#include <linux/string.h>
+
+static kmem_cache_t *id_layer_cache;
+spinlock_t id_lock = SPIN_LOCK_UNLOCKED;
+
+/*
+ * Since we can't allocate memory with spinlock held and dropping the
+ * lock to allocate gets ugly keep a free list which will satisfy the
+ * worst case allocation.
+ */
+
+struct id_layer *id_free;
+int id_free_cnt;
+
+static inline struct id_layer *alloc_layer(void)
+{
+	struct id_layer *p;
+
+	if (!(p = id_free))
+		BUG();
+	id_free = p->ary[0];
+	id_free_cnt--;
+	p->ary[0] = 0;
+	return(p);
+}
+
+static inline void free_layer(struct id_layer *p)
+{
+	p->ary[0] = id_free;
+	id_free = p;
+	id_free_cnt++;
+}
+
+void *id_lookup(struct id *idp, int id)
+{
+	int n;
+	struct id_layer *p;
+
+	if (id <= 0)
+		return(NULL);
+	id--;
+	spin_lock_irq(&id_lock);
+	n = idp->layers * ID_BITS;
+	p = idp->top;
+	if (id >= (1 << n)) {
+		spin_unlock_irq(&id_lock);
+		return(NULL);
+	}
+
+	while (n > 0 && p) {
+		n -= ID_BITS;
+		p = p->ary[(id >> n) & ID_MASK];
+	}
+	spin_unlock_irq(&id_lock);
+	return((void *)p);
+}
+
+static int sub_alloc(struct id_layer *p, int shift, int id, void *ptr)
+{
+	int n = (id >> shift) & ID_MASK;
+	int bitmap = p->bitmap;
+	int id_base = id & ~((1 << (shift+ID_BITS))-1);
+	int v;
+	
+	for ( ; n <= ID_MASK; n++, id = id_base + (n << shift)) {
+		if (bitmap & (1 << n))
+			continue;
+		if (shift == 0) {
+			p->ary[n] = (struct id_layer *)ptr;
+			p->bitmap |= 1<<n;
+			return(id);
+		}
+		if (!p->ary[n])
+			p->ary[n] = alloc_layer();
+		if ((v = sub_alloc(p->ary[n], shift-ID_BITS, id, ptr))) {
+			update_bitmap(p, n);
+			return(v);
+		}
+	}
+	return(0);
+}
+
+int id_new(struct id *idp, void *ptr)
+{
+	int n, last, id, v;
+	struct id_layer *new;
+	
+	spin_lock_irq(&id_lock);
+	n = idp->layers * ID_BITS;
+	last = idp->last;
+	while (id_free_cnt < n+1) {
+		spin_unlock_irq(&id_lock);
+		new = kmem_cache_alloc(id_layer_cache, GFP_KERNEL);
+		memset(new, 0, sizeof(struct id_layer));
+		spin_lock_irq(&id_lock);
+		free_layer(new);
+	}
+	/*
+	 * Add a new layer if the array is full or the last id
+	 * was at the limit and we don't want to wrap.
+	 */
+	if ((last == ((1 << n)-1) && last < idp->min_wrap) ||
+		idp->count == (1 << n)) {
+		++idp->layers;
+		n += ID_BITS;
+		new = alloc_layer();
+		new->ary[0] = idp->top;
+		idp->top = new;
+		update_bitmap(new, 0);
+	}
+	if (last >= ((1 << n)-1))
+		last = 0;
+
+	/*
+	 * Search for a free id starting after last id allocated.
+	 * If that fails wrap back to start.
+	 */
+	id = last+1;
+	if (!(v = sub_alloc(idp->top, n-ID_BITS, id, ptr)))
+		v = sub_alloc(idp->top, n-ID_BITS, 1, ptr);
+	idp->last = v;
+	idp->count++;
+	spin_unlock_irq(&id_lock);
+	return(v+1);
+}
+
+
+static int sub_remove(struct id_layer *p, int shift, int id)
+{
+	int n = (id >> shift) & ID_MASK;
+	int i, bitmap, rv;
+	
+if (!p) {
+printk("in sub_remove for id=%d called with null pointer.\n", id);
+return(0);
+}
+	rv = 0;
+	bitmap = p->bitmap & ~(1<<n);
+	p->bitmap = bitmap;
+	if (shift == 0) {
+		p->ary[n] = NULL;
+		rv = !bitmap;
+	} else {
+		if (sub_remove(p->ary[n], shift-ID_BITS, id)) {
+			free_layer(p->ary[n]);
+			p->ary[n] = 0;
+			for (i = 0; i < (1 << ID_BITS); i++)
+				if (p->ary[i])
+					break;
+			if (i == (1 << ID_BITS))
+				rv = 1;
+		}
+	}
+	return(rv);
+}
+
+void id_remove(struct id *idp, int id)
+{
+	struct id_layer *p;
+
+	if (id <= 0)
+		return;
+	id--;
+	spin_lock_irq(&id_lock);
+	sub_remove(idp->top, (idp->layers-1)*ID_BITS, id);
+	idp->count--;
+	if (id_free_cnt >= ID_FREE_MAX) {
+		
+		p = alloc_layer();
+		spin_unlock_irq(&id_lock);
+		kmem_cache_free(id_layer_cache, p);
+		return;
+	}
+	spin_unlock_irq(&id_lock);
+}
+
+void init_id_cache(void)
+{
+	if (!id_layer_cache)
+		id_layer_cache = kmem_cache_create("id_layer_cache", 
+			sizeof(struct id_layer), 0, 0, 0, 0);
+}
+
+void id_init(struct id *idp, int min_wrap)
+{
+	init_id_cache();
+	idp->count = 1;
+	idp->last = 0;
+	idp->layers = 1;
+	idp->top = kmem_cache_alloc(id_layer_cache, GFP_KERNEL);
+	memset(idp->top, 0, sizeof(struct id_layer));
+	idp->top->bitmap = 0;
+	idp->min_wrap = min_wrap;
+}
+
+__initcall(init_id_cache);
diff -urN empty/kernel/posix-timers.c new/kernel/posix-timers.c
--- empty/kernel/posix-timers.c	Wed Dec 31 19:00:00 1969
+++ new/kernel/posix-timers.c	Fri Oct 18 21:08:04 2002
@@ -0,0 +1,1268 @@
+/*
+ * linux/kernel/posix_timers.c
+ *
+ * 
+ * 2002-10-15  Posix Clocks & timers by George Anzinger
+ *			     Copyright (C) 2002 by MontaVista Software.
+ *
+ * 2002-10-18  changes by Jim Houston jim.houston@attbi.com
+ *	Copyright (C) 2002 by Concurrent Computer Corp.
+ *	
+ *
+ *	     -	Add a separate queue for posix timers.  Its a 
+ *		priority queue implemented as a sorted doubly
+ * 		linked list & a rbtree as an index into the list.
+ *	     -	Use a slab cache to allocate the timer structures.
+ *	     -	Allocate timer ids using my new id allocator.
+ *		This avoids the immediate reuse of timer ids.
+ *	     -  Uses seconds and nano-seconds rather than
+ *		jiffies and sub_jiffies.
+ *
+ * 	This is an experimental change.  I'm sending it out to
+ *	the mailing list in the hope that it will stimulate 
+ *	discussion.
+ */
+
+/* These are all the functions necessary to implement 
+ * POSIX clocks & timers
+ */
+
+#include <linux/mm.h>
+#include <linux/smp_lock.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/time.h>
+
+#include <asm/uaccess.h>
+#include <asm/semaphore.h>
+#include <linux/list.h>
+#include <linux/init.h>
+#include <linux/nmi.h>
+#include <linux/compiler.h>
+#include <linux/id.h>
+#include <linux/rbtree.h>
+
+
+#ifndef div_long_long_rem
+#include <asm/div64.h>
+
+#define div_long_long_rem(dividend,divisor,remainder) ({ \
+		       u64 result = dividend;		\
+		       *remainder = do_div(result,divisor); \
+		       result; })
+
+#endif	 /* ifndef div_long_long_rem */
+
+
+/* This should be in posix-timers.h - but this is easier now. */
+
+enum timer_type {
+	TIMER,
+	NANOSLEEP
+};
+
+struct k_itimer {
+	struct list_head it_pq_list;	/* fields for timer priority queue. */
+	struct rb_node it_pq_node;	
+	int it_queued;
+
+	struct list_head it_task_list;	/* list for exit_itimers */
+	spinlock_t it_lock;
+	clockid_t it_clock;		/* which timer type */
+	timer_t it_id;			/* timer id */
+	int it_overrun;			/* overrun on pending signal  */
+	int it_overrun_last;		 /* overrun on last delivered signal */
+	int it_overrun_deferred;	 /* overrun on pending timer interrupt */
+	int it_sigev_notify;		 /* notify word of sigevent struct */
+	int it_sigev_signo;		 /* signo word of sigevent struct */
+	sigval_t it_sigev_value;	 /* value word of sigevent struct */
+	struct task_struct *it_process;	/* process to send signal to */
+	struct itimerspec it_v;		/* expiry time & interval */
+	enum timer_type it_type;
+};
+
+/*
+ * The priority queue is a sorted doubly linked list ordered by
+ * expiry time.  A rbtree is used as an index in to this list
+ * so that inserts are O(log2(n)).
+ */
+
+struct timer_pq {
+	struct rb_root		rb_root;
+	struct list_head	head;
+	spinlock_t		lock;
+};
+
+#define TIMER_PQ_INIT(name)	{ \
+	.rb_root = RB_ROOT, \
+	.head = LIST_HEAD_INIT(name.head), \
+	.lock = SPIN_LOCK_UNLOCKED \
+}
+
+
+#if 0
+#include <linux/posix-timers.h>
+#endif
+
+struct k_clock {
+	struct timer_pq	pq;
+	int  res;			/* in nano seconds */
+	int ( *clock_set)(struct timespec *tp);
+	int ( *clock_get)(struct timespec *tp);
+	int ( *nsleep)(   int flags, 
+			   struct timespec*new_setting,
+			   struct itimerspec *old_setting);
+	int ( *timer_set)(struct k_itimer *timr, int flags,
+			   struct itimerspec *new_setting,
+			   struct itimerspec *old_setting);
+	int  ( *timer_del)(struct k_itimer *timr);
+	void ( *timer_get)(struct k_itimer *timr,
+			   struct itimerspec *cur_setting);
+};
+
+int do_posix_clock_monotonic_gettime(struct timespec *tp);
+int do_posix_clock_monotonic_settime(struct timespec *tp);
+asmlinkage int sys_timer_delete(timer_t timer_id);
+
+/*
+ * Lets keep our timers in a slab cache :-)
+ */
+static kmem_cache_t *posix_timers_cache;
+struct id posix_timers_id;
+
+/*
+ * Kluge until I can wire into the timer interrupt.
+ */
+int poll_timer_running;
+void run_posix_timers(unsigned long dummy);
+static struct timer_list poll_posix_timers = {
+	.function = &run_posix_timers,
+};
+
+struct k_clock clock_realtime = {
+	.pq = TIMER_PQ_INIT(clock_realtime.pq),
+	.res = NSEC_PER_SEC/HZ,
+};
+
+struct k_clock clock_monotonic = {
+	.pq = TIMER_PQ_INIT(clock_monotonic.pq),
+	.res= NSEC_PER_SEC/HZ,
+	.clock_get = do_posix_clock_monotonic_gettime, 
+	.clock_set = do_posix_clock_monotonic_settime
+};
+
+static int timer_insert_nolock(struct timer_pq *pq, struct k_itimer *t)
+{
+	struct rb_node ** p = &pq->rb_root.rb_node;
+	struct rb_node * parent = NULL;
+	struct k_itimer *cur;
+	struct list_head *prev;
+	prev = &pq->head;
+
+	if (t->it_queued)
+		BUG();
+	t->it_queued = 1;
+	while (*p)
+	{
+		parent = *p;
+		cur = rb_entry(parent, struct k_itimer , it_pq_node);
+
+		/*
+		 * We allow non unique entries does it work if
+		 * I ignore the == case and just go right?
+		 */
+		if (t->it_v.it_value.tv_sec < cur->it_v.it_value.tv_sec  ||
+			(t->it_v.it_value.tv_sec == cur->it_v.it_value.tv_sec &&
+			 t->it_v.it_value.tv_nsec < cur->it_v.it_value.tv_nsec))
+			p = &(*p)->rb_left;
+		else {
+			prev = &cur->it_pq_list;
+			p = &(*p)->rb_right;
+		}
+	}
+	/* link into rbtree. */
+	rb_link_node(&t->it_pq_node, parent, p);
+	rb_insert_color(&t->it_pq_node, &pq->rb_root);
+	/* link it into the list */
+	list_add(&t->it_pq_list, prev);
+	/*
+	 * We need to setup a timer interrupt if the new timer is
+	 * at the head of the queue.
+	 */
+	return(pq->head.next == &t->it_pq_list);
+}
+
+static inline void timer_remove_nolock(struct timer_pq *pq, struct k_itimer *t)
+{
+	if (!t->it_queued)
+		return;
+	rb_erase(&t->it_pq_node, &pq->rb_root);
+	list_del(&t->it_pq_list);
+	t->it_queued = 0;
+}
+
+static void timer_remove(struct timer_pq *pq, struct k_itimer *t)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pq->lock, flags);
+	timer_remove_nolock(pq, t);
+	spin_unlock_irqrestore(&pq->lock, flags);
+}
+
+
+static int timer_insert(struct timer_pq *pq, struct k_itimer *t)
+{
+	unsigned long flags;
+	int rv;
+
+	spin_lock_irqsave(&pq->lock, flags);
+	rv = timer_insert_nolock(pq, t);
+	spin_unlock_irqrestore(&pq->lock, flags);
+	if (!poll_timer_running) {
+		poll_timer_running = 1;
+		poll_posix_timers.expires = jiffies + 1;
+		add_timer(&poll_posix_timers);
+	}
+	return(rv);
+}
+
+/*
+ * If we are late delivering a periodic timer we may 
+ * have missed several expiries.  We want to calculate the 
+ * number we have missed both as the overrun count but also
+ * so that we can pick next expiry.
+ *
+ * You really need this if you schedule a high frequency timer
+ * and then make a big change to the current time.
+ */
+
+int handle_overrun(struct k_itimer *t, struct timespec dt)
+{
+	int ovr;
+#if 0
+	long long ldt, in;
+	long sec, nsec;
+
+	in =  (long long)t->it_v.it_interval.tv_sec*1000000000 +
+		t->it_v.it_interval.tv_nsec;
+	ldt = (long long)dt.tv_sec * 1000000000 + dt.tv_nsec;
+	ovr = ldt/in + 1;
+	ldt = (long long)t->it_v.it_interval.tv_nsec * ovr;
+	nsec = ldt % 1000000000;
+	sec = ldt / 1000000000;
+	sec += ovr * t->it_v.it_interval.tv_sec;
+	nsec += t->it_v.it_value.tv_nsec;
+	sec +=  t->it_v.it_value.tv_sec;
+	if (nsec > 1000000000) {
+		sec++;
+		nsec -= 1000000000;
+	}
+	t->it_v.it_value.tv_sec = sec;
+	t->it_v.it_value.tv_nsec = nsec;
+#else
+	ovr = 0;
+	while (dt.tv_sec > t->it_v.it_interval.tv_sec ||
+		(dt.tv_sec == t->it_v.it_interval.tv_sec && 
+		dt.tv_nsec > t->it_v.it_interval.tv_nsec)) {
+		dt.tv_sec -= t->it_v.it_interval.tv_sec;
+		dt.tv_nsec -= t->it_v.it_interval.tv_nsec;
+		if (dt.tv_nsec < 0) {
+			 dt.tv_sec--;
+			 dt.tv_nsec += 1000000000;
+		}
+		t->it_v.it_value.tv_sec += t->it_v.it_interval.tv_sec;
+		t->it_v.it_value.tv_nsec += t->it_v.it_interval.tv_nsec;
+		if (t->it_v.it_value.tv_nsec >= 1000000000) {
+			t->it_v.it_value.tv_sec++;
+			t->it_v.it_value.tv_nsec -= 1000000000;
+		}
+		ovr++;
+	}
+#endif
+	return(ovr);
+}
+
+/* PRECONDITION:
+ * timr->it_lock must be locked
+ */
+
+/*
+ * JIM - ovr is a count of over-runs when the processing of the 
+ * expiry has been delayed more than the timer interval.  
+ * Normally it has the value 1 meaning a single expiry.
+ */
+static void timer_notify_task(struct k_itimer *timr, int ovr)
+{
+	struct siginfo info;
+	int ret;
+
+	if (! (timr->it_sigev_notify & SIGEV_NONE)) {
+
+		memset(&info, 0, sizeof(info));
+
+		/* Send signal to the process that owns this timer. */
+		info.si_signo = timr->it_sigev_signo;
+		info.si_errno = 0;
+		info.si_code = SI_TIMER;
+		info.si_tid = timr->it_id;
+		info.si_value = timr->it_sigev_value;
+		info.si_overrun = timr->it_overrun_deferred;
+		ret = send_sig_info(info.si_signo, &info, timr->it_process);
+		switch (ret) {
+		case 0:		/* all's well new signal queued */
+			timr->it_overrun_last = timr->it_overrun;
+			timr->it_overrun = timr->it_overrun_deferred;
+			break;
+		case 1:	/* signal from this timer was already in the queue */
+			timr->it_overrun += timr->it_overrun_deferred + 1;
+			break;
+		default:
+			printk(KERN_WARNING "sending signal failed: %d\n", ret);
+			break;
+		}
+	}
+}
+
+void do_expiry(struct k_itimer *t, int ovr)
+{
+	switch (t->it_type) {
+	case TIMER:
+		timer_notify_task(t, ovr);
+		return;
+	case NANOSLEEP:
+		wake_up_process(t->it_process);
+		return;
+	}
+}
+/*
+ * Check if the timer at the head of the priority queue has 
+ * expired and handle the expiry.  Return time in nsec till
+ * the next expiry.  We only really care about expiries
+ * before the next clock tick so we use a 32 bit int here.
+ */
+
+static int check_expiry(struct timer_pq *pq, struct timespec *tv)
+{
+	struct k_itimer *t;
+	struct timespec dt;
+	int ovr;
+	long sec, nsec;
+	unsigned long flags;
+	
+	ovr = 1;
+	spin_lock_irqsave(&pq->lock, flags);
+	while (!list_empty(&pq->head)) {
+		t = list_entry(pq->head.next, struct k_itimer, it_pq_list);
+		dt.tv_sec = tv->tv_sec - t->it_v.it_value.tv_sec;
+		dt.tv_nsec = tv->tv_sec - t->it_v.it_value.tv_sec;
+		if (dt.tv_sec < 0 || (dt.tv_sec == 0 && dt.tv_nsec < 0)) {
+			/*
+			 * It has not expired yet.  Return nano-seconds
+			 * remaining if its less than a second.
+			 */
+			if (dt.tv_sec < -1)
+				return(-1);
+			nsec = dt.tv_sec ? 1000000000-dt.tv_nsec : -dt.tv_nsec;
+			spin_unlock_irqrestore(&pq->lock, flags);
+			return(nsec);
+		}
+		/*
+		 * Its expired.  If this is a periodic timer we need to
+		 * setup for the next expiry.  We also check for overrun
+		 * here.  If the timer has already missed an expiry we want
+		 * deliver the overrun information and get back on schedule.
+		 */
+		if (dt.tv_nsec < 0) {
+			dt.tv_sec--;
+			dt.tv_nsec += 1000000000;
+		}
+		timer_remove_nolock(pq, t);
+		if (t->it_v.it_interval.tv_sec || t->it_v.it_interval.tv_nsec) {
+			if (dt.tv_sec > t->it_v.it_interval.tv_sec ||
+			   (dt.tv_sec == t->it_v.it_interval.tv_sec && 
+			    dt.tv_nsec > t->it_v.it_interval.tv_nsec)) {
+				ovr = handle_overrun(t, dt);
+			} else {
+				nsec = t->it_v.it_value.tv_nsec +
+					t->it_v.it_interval.tv_nsec;
+				sec = t->it_v.it_value.tv_sec +
+					t->it_v.it_interval.tv_sec;
+				if (nsec > 1000000000) {
+					nsec -= 1000000000;
+					sec++;
+				}
+				t->it_v.it_value.tv_sec = sec;
+				t->it_v.it_value.tv_nsec = nsec;
+			}
+			/*
+			 * It might make sense to leave the timer queue and
+			 * avoid the remove/insert for timers which stay
+			 * at the front of the queue.
+			 */
+			timer_insert_nolock(pq, t);
+		}
+		spin_unlock_irqrestore(&pq->lock, flags);
+		do_expiry(t, ovr);
+		spin_lock_irqsave(&pq->lock, flags);
+	}
+	spin_unlock_irqrestore(&pq->lock, flags);
+	return(-1);
+}
+
+/*
+ * kluge?  We should know the offset between clock_realtime and
+ * clock_monotonic so we don't need to get the time twice.
+ */
+
+void run_posix_timers(unsigned long dummy)
+{
+	struct timespec now;
+	int ns, ret;
+
+	ns = 0x7fffffff;
+	do_posix_clock_monotonic_gettime(&now);
+	ret = check_expiry(&clock_monotonic.pq, &now);
+	if (ret > 0 && ret < ns)
+		ns = ret;
+
+	do_gettimeofday((struct timeval*)&now);
+	now.tv_nsec *= NSEC_PER_USEC;
+	ret = check_expiry(&clock_realtime.pq, &now);
+	if (ret > 0 && ret < ns)
+		ns = ret;
+	poll_posix_timers.expires = jiffies + 1;
+	add_timer(&poll_posix_timers);
+}
+	
+
+extern rwlock_t xtime_lock;
+
+/* 
+ * CLOCKs: The POSIX standard calls for a couple of clocks and allows us
+ *	    to implement others.  This structure defines the various
+ *	    clocks and allows the possibility of adding others.	 We
+ *	    provide an interface to add clocks to the table and expect
+ *	    the "arch" code to add at least one clock that is high
+ *	    resolution.	 Here we define the standard CLOCK_REALTIME as a
+ *	    1/HZ resolution clock.
+
+ * CPUTIME & THREAD_CPUTIME: We are not, at this time, definding these
+ *	    two clocks (and the other process related clocks (Std
+ *	    1003.1d-1999).  The way these should be supported, we think,
+ *	    is to use large negative numbers for the two clocks that are
+ *	    pinned to the executing process and to use -pid for clocks
+ *	    pinned to particular pids.	Calls which supported these clock
+ *	    ids would split early in the function.
+ 
+ * RESOLUTION: Clock resolution is used to round up timer and interval
+ *	    times, NOT to report clock times, which are reported with as
+ *	    much resolution as the system can muster.  In some cases this
+ *	    resolution may depend on the underlaying clock hardware and
+ *	    may not be quantifiable until run time, and only then is the
+ *	    necessary code is written.	The standard says we should say
+ *	    something about this issue in the documentation...
+
+ * FUNCTIONS: The CLOCKs structure defines possible functions to handle
+ *	    various clock functions.  For clocks that use the standard
+ *	    system timer code these entries should be NULL.  This will
+ *	    allow dispatch without the overhead of indirect function
+ *	    calls.  CLOCKS that depend on other sources (e.g. WWV or GPS)
+ *	    must supply functions here, even if the function just returns
+ *	    ENOSYS.  The standard POSIX timer management code assumes the
+ *	    following: 1.) The k_itimer struct (sched.h) is used for the
+ *	    timer.  2.) The list, it_lock, it_clock, it_id and it_process
+ *	    fields are not modified by timer code. 
+ *
+ * Permissions: It is assumed that the clock_settime() function defined
+ *	    for each clock will take care of permission checks.	 Some
+ *	    clocks may be set able by any user (i.e. local process
+ *	    clocks) others not.	 Currently the only set able clock we
+ *	    have is CLOCK_REALTIME and its high res counter part, both of
+ *	    which we beg off on and pass to do_sys_settimeofday().
+ */
+
+struct k_clock posix_clocks[MAX_CLOCKS];
+
+#define if_clock_do(clock_fun, alt_fun,parms)	(! clock_fun)? alt_fun parms :\
+							      clock_fun parms
+
+#define p_timer_get( clock,a,b) if_clock_do((clock)->timer_get, \
+					     do_timer_gettime,	 \
+					     (a,b))
+
+#define p_nsleep( clock,a,b,c) if_clock_do((clock)->nsleep,   \
+					    do_nsleep,	       \
+					    (a,b,c))
+
+#define p_timer_del( clock,a) if_clock_do((clock)->timer_del, \
+					   do_timer_delete,    \
+					   (a))
+
+void register_posix_clock(int clock_id, struct k_clock * new_clock);
+
+static int do_posix_gettime(struct k_clock *clock, struct timespec *tp);
+
+
+void register_posix_clock(int clock_id,struct k_clock * new_clock)
+{
+	if ( (unsigned)clock_id >= MAX_CLOCKS){
+		printk("POSIX clock register failed for clock_id %d\n",clock_id);
+		return;
+	}
+	posix_clocks[clock_id] = *new_clock;
+}
+
+static	 __init int init_posix_timers(void)
+{
+
+	posix_timers_cache = kmem_cache_create("posix_timers_cache",
+		sizeof(struct k_itimer), 0, 0, 0, 0);
+	id_init(&posix_timers_id, 1000);
+
+	register_posix_clock(CLOCK_REALTIME,&clock_realtime);
+	register_posix_clock(CLOCK_MONOTONIC,&clock_monotonic);
+#if 0
+	poll_posix_timers.expires = 1;
+	add_timer(&poll_posix_timers);
+#endif
+	return 0;
+}
+
+__initcall(init_posix_timers);
+
+/*
+ * For some reason mips/mips64 define the SIGEV constants plus 128.  
+ * Here we define a mask to get rid of the common bits.	 The 
+ * optimizer should make this costless to all but mips.
+ */
+#if (ARCH == mips) || (ARCH == mips64)
+#define MIPS_SIGEV ~(SIGEV_NONE & \
+		      SIGEV_SIGNAL & \
+		      SIGEV_THREAD &  \
+		      SIGEV_THREAD_ID)
+#else
+#define MIPS_SIGEV (int)-1
+#endif
+
+static inline struct task_struct * good_sigevent(sigevent_t *event)
+{
+	struct task_struct * rtn = current;
+
+	if (event->sigev_notify & SIGEV_THREAD_ID & MIPS_SIGEV ) {
+		if ( !(rtn = 
+		       find_task_by_pid(event->sigev_notify_thread_id)) ||
+		     rtn->tgid != current->tgid){
+			return NULL;
+		}
+	}
+	if (event->sigev_notify & SIGEV_SIGNAL & MIPS_SIGEV) {
+		if ((unsigned)(event->sigev_signo > SIGRTMAX))
+			return NULL;
+	}
+	if (event->sigev_notify & ~(SIGEV_SIGNAL | SIGEV_THREAD_ID )) {
+		return NULL;
+	}
+	return rtn;
+}
+
+
+
+static struct k_itimer * alloc_posix_timer(void)
+{
+	struct k_itimer *tmr;
+	tmr = kmem_cache_alloc(posix_timers_cache, GFP_KERNEL);
+	memset(tmr, 0, sizeof(struct k_itimer));
+	return(tmr);
+}
+
+static void release_posix_timer(struct k_itimer *tmr)
+{
+	if (tmr->it_id > 0)
+		id_remove(&posix_timers_id, tmr->it_id);
+	kmem_cache_free(posix_timers_cache, tmr);
+}
+			 
+/* Create a POSIX.1b interval timer. */
+
+asmlinkage int sys_timer_create(clockid_t which_clock,
+				struct sigevent *timer_event_spec,
+				timer_t *created_timer_id)
+{
+	int error = 0;
+	struct k_itimer *new_timer = NULL;
+	int new_timer_id;
+	struct task_struct * process = current;
+	sigevent_t event;
+
+	/* Right now, we only support CLOCK_REALTIME for timers. */
+	if ((unsigned)which_clock >= MAX_CLOCKS || 
+	    ! posix_clocks[which_clock].res) return -EINVAL;
+
+	new_timer = alloc_posix_timer();
+	if (new_timer == NULL) return -EAGAIN;
+
+	spin_lock_init(&new_timer->it_lock);
+	if (timer_event_spec) {
+		if (copy_from_user(&event, timer_event_spec,
+				   sizeof(event))) {
+			error = -EFAULT;
+			goto out;
+		}
+		if ((process = good_sigevent(&event)) == NULL) {
+			error = -EINVAL;
+			goto out;
+		}
+		new_timer->it_sigev_notify = event.sigev_notify;
+		new_timer->it_sigev_signo = event.sigev_signo;
+		new_timer->it_sigev_value = event.sigev_value;
+	}
+	else {
+		new_timer->it_sigev_notify = SIGEV_SIGNAL;
+		new_timer->it_sigev_signo = SIGALRM;
+		new_timer->it_sigev_value.sival_int = new_timer->it_id;
+	}
+
+	new_timer->it_clock = which_clock;
+	new_timer->it_overrun = 0;
+
+	new_timer_id = (timer_t)id_new(&posix_timers_id, (void *)new_timer);
+	new_timer->it_id = new_timer_id;
+
+	if (copy_to_user(created_timer_id, 
+			 &new_timer_id, 
+			 sizeof(new_timer_id))) {
+		error = -EFAULT;
+		goto out;
+	}
+	spin_lock(&process->alloc_lock);
+	list_add(&new_timer->it_task_list, &process->posix_timers);
+	spin_unlock(&process->alloc_lock);
+	/*
+	 * Once we set the process, it can be found so do it last...
+	 */
+	new_timer->it_process = process;
+
+ out:
+	if (error) {
+		release_posix_timer(new_timer);
+	}
+	return error;
+}
+
+/*
+ * return  timer owned by the process, used by exit and exec
+ */
+void itimer_delete(struct k_itimer *timer)
+{
+	if (sys_timer_delete(timer->it_id)){
+		BUG();
+	}
+}
+
+void exit_itimers(struct task_struct *tsk)
+{
+	struct	k_itimer *tmr;
+
+	while (tsk->posix_timers.next != &tsk->posix_timers){
+		 tmr = list_entry(tsk->posix_timers.next,
+			struct k_itimer,it_task_list);
+		itimer_delete(tmr);
+	}
+}
+
+/* good_timespec
+ *
+ * This function checks the elements of a timespec structure.
+ *
+ * Arguments:
+ * ts	     : Pointer to the timespec structure to check
+ *
+ * Return value:
+ * If a NULL pointer was passed in, or the tv_nsec field was less than 0 or
+ * greater than NSEC_PER_SEC, or the tv_sec field was less than 0, this
+ * function returns 0. Otherwise it returns 1.
+ */
+
+static int good_timespec(const struct timespec *ts)
+{
+	if ((ts == NULL) || 
+	    (ts->tv_sec < 0) ||
+	    ((unsigned)ts->tv_nsec >= NSEC_PER_SEC))
+		return 0;
+	return 1;
+}
+
+static inline void unlock_timer(struct k_itimer *timr)
+{
+	spin_unlock_irq(&timr->it_lock);
+}
+
+static struct k_itimer* lock_timer( timer_t timer_id)
+{
+	struct  k_itimer *timr;
+
+	timr = (struct  k_itimer *)id_lookup(&posix_timers_id, (int)timer_id);
+	if (timr)
+		spin_lock_irq(&timr->it_lock);
+	return(timr);
+}
+
+/* 
+ * Get the time remaining on a POSIX.1b interval timer.
+ * This function is ALWAYS called with spin_lock_irq on the timer, thus
+ * it must not mess with irq.
+ */
+void inline do_timer_gettime(struct k_itimer *timr,
+			     struct itimerspec *cur_setting)
+{
+	struct timespec ts;
+
+	do_posix_gettime(&posix_clocks[timr->it_clock], &ts);
+	ts.tv_sec = timr->it_v.it_value.tv_sec - ts.tv_sec;
+	ts.tv_nsec = timr->it_v.it_value.tv_nsec - ts.tv_nsec;
+	if (ts.tv_nsec < 0) {
+		ts.tv_nsec += 1000000000;
+		ts.tv_sec--;
+	}
+	if (ts.tv_sec < 0)
+		ts.tv_sec = ts.tv_nsec = 0;
+	cur_setting->it_value = ts;
+	cur_setting->it_interval = timr->it_v.it_interval;
+}
+
+/* Get the time remaining on a POSIX.1b interval timer. */
+asmlinkage int sys_timer_gettime(timer_t timer_id, struct itimerspec *setting)
+{
+	struct k_itimer *timr;
+	struct itimerspec cur_setting;
+
+	timr = lock_timer(timer_id);
+	if (!timr) return -EINVAL;
+
+	p_timer_get(&posix_clocks[timr->it_clock],timr, &cur_setting);
+
+	unlock_timer(timr);
+	
+	if (copy_to_user(setting, &cur_setting, sizeof(cur_setting)))
+		return -EFAULT;
+
+	return 0;
+}
+/*
+ * Get the number of overruns of a POSIX.1b interval timer
+ * This is a bit messy as we don't easily know where he is in the delivery
+ * of possible multiple signals.  We are to give him the overrun on the
+ * last delivery.  If we have another pending, we want to make sure we
+ * use the last and not the current.  If there is not another pending
+ * then he is current and gets the current overrun.  We search both the
+ * shared and local queue.
+ */
+
+asmlinkage int sys_timer_getoverrun(timer_t timer_id)
+{
+	struct k_itimer *timr;
+	int overrun, i;
+	struct sigqueue *q;
+	struct sigpending *sig_queue;
+	struct task_struct * t;
+
+	timr = lock_timer( timer_id);
+	if (!timr) return -EINVAL;
+
+	t = timr->it_process;
+	overrun = timr->it_overrun;
+	spin_lock_irq(&t->sig->siglock);
+	for (sig_queue = &t->sig->shared_pending, i = 2; i; 
+	     sig_queue = &t->pending, i--){
+		for (q = sig_queue->head; q; q = q->next) {
+			if ((q->info.si_code == SI_TIMER) &&
+			    (q->info.si_tid == timr->it_id)) {
+
+				overrun = timr->it_overrun_last;
+				goto out;
+			}
+		}
+	}
+ out:
+	spin_unlock_irq(&t->sig->siglock);
+	
+	unlock_timer(timr);
+
+	return overrun;
+}
+/* Adjust for absolute time */
+/*
+ * If absolute time is given and it is not CLOCK_MONOTONIC, we need to
+ * adjust for the offset between the timer clock (CLOCK_MONOTONIC) and
+ * what ever clock he is using.
+ *
+ * If it is relative time, we need to add the current (CLOCK_MONOTONIC)
+ * time to it to get the proper time for the timer.
+ */
+static int  adjust_abs_time(struct k_clock *clock,struct timespec *tp, int abs)
+{
+	struct timespec now;
+	struct timespec oc;
+	do_posix_clock_monotonic_gettime(&now);
+
+	if ( abs &&
+	     (posix_clocks[CLOCK_MONOTONIC].clock_get == clock->clock_get)){ 
+	}else{
+
+		if (abs){
+			do_posix_gettime(clock,&oc);
+		}else{
+			oc.tv_nsec = oc.tv_sec =0;
+		}
+		tp->tv_sec += now.tv_sec - oc.tv_sec;
+		tp->tv_nsec += now.tv_nsec - oc.tv_nsec;
+
+		/* 
+		 * Normalize...
+		 */
+		if (( tp->tv_nsec - NSEC_PER_SEC) >= 0){
+			tp->tv_nsec -= NSEC_PER_SEC;
+			tp->tv_sec++;
+		}
+		if (( tp->tv_nsec ) < 0){
+			tp->tv_nsec += NSEC_PER_SEC;
+			tp->tv_sec--;
+		}
+	}
+	/*
+	 * Check if the requested time is prior to now (if so set now) or
+	 * is more than the timer code can handle (if so we error out).
+	 * The (unsigned) catches the case of prior to "now" with the same
+	 * test.  Only on failure do we sort out what happened, and then
+	 * we use the (unsigned) to error out negative seconds.
+	 */
+	if ((unsigned)(tp->tv_sec - now.tv_sec) > (MAX_JIFFY_OFFSET / HZ)){
+		if ( (unsigned)tp->tv_sec < now.tv_sec){
+			tp->tv_sec = now.tv_sec;
+			tp->tv_nsec = now.tv_nsec;
+		}else{
+			// tp->tv_sec = now.tv_sec + (MAX_JIFFY_OFFSET / HZ);
+			/*
+			 * This is a considered response, not exactly in
+			 * line with the standard (in fact it is silent on
+			 * possible overflows).  We assume such a large 
+			 * value ALMOST always is a programming error and
+			 * try not to compound it by setting a really dumb
+			 * value.
+			 */ 
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+/* Set a POSIX.1b interval timer. */
+/* timr->it_lock is taken. */
+static inline int do_timer_settime(struct k_itimer *timr, int flags,
+				   struct itimerspec *new_setting,
+				   struct itimerspec *old_setting)
+{
+	struct k_clock * clock = &posix_clocks[timr->it_clock];
+
+	timer_remove(&clock->pq, timr);
+	if (old_setting) {
+		do_timer_gettime(timr, old_setting);
+	}
+	
+	
+	/* switch off the timer when it_value is zero */
+	if ((new_setting->it_value.tv_sec == 0) &&
+		(new_setting->it_value.tv_nsec == 0)) {
+		timr->it_v = *new_setting;
+		return 0;
+	}
+
+	if( adjust_abs_time(clock, &new_setting->it_value,
+			    flags & TIMER_ABSTIME)){
+		return -EINVAL;
+	}
+	timr->it_v = *new_setting;
+	timr->it_overrun_deferred = 
+		timr->it_overrun_last = 
+		timr->it_overrun = 0;
+	timer_insert(&clock->pq, timr);
+	return 0;
+}
+
+
+/* Set a POSIX.1b interval timer */
+asmlinkage int sys_timer_settime(timer_t timer_id, int flags,
+				 const struct itimerspec *new_setting,
+				 struct itimerspec *old_setting)
+{
+	struct k_itimer *timr;
+	struct itimerspec new_spec, old_spec;
+	int error = 0;
+	struct itimerspec *rtn = old_setting ? &old_spec : NULL;
+
+
+	if (new_setting == NULL) {
+		return -EINVAL;
+	}
+
+	if (copy_from_user(&new_spec, new_setting, sizeof(new_spec))) {
+		return -EFAULT;
+	}
+
+	if ((!good_timespec(&new_spec.it_interval)) ||
+	    (!good_timespec(&new_spec.it_value))) {
+		return -EINVAL;
+	}
+
+	timr = lock_timer( timer_id);
+	if (!timr)
+		return -EINVAL;
+
+	if (! posix_clocks[timr->it_clock].timer_set) {
+		error = do_timer_settime(timr, flags, &new_spec, rtn );
+	}else{
+		error = posix_clocks[timr->it_clock].timer_set(timr, 
+							       flags, 
+							       &new_spec, 
+							       rtn );
+	}
+	unlock_timer(timr);
+
+	if (old_setting && ! error) {
+		if (copy_to_user(old_setting, &old_spec, sizeof(old_spec))) {
+			error = -EFAULT;
+		}
+	}
+
+	return error;
+}
+
+static inline int do_timer_delete(struct k_itimer  *timer)
+{
+	struct k_clock * clock = &posix_clocks[timer->it_clock];
+
+	timer_remove(&clock->pq, timer);
+	return 0;
+}
+
+/* Delete a POSIX.1b interval timer. */
+asmlinkage int sys_timer_delete(timer_t timer_id)
+{
+	struct k_itimer *timer;
+
+	timer = lock_timer( timer_id);
+	if (!timer)
+		return -EINVAL;
+
+	p_timer_del(&posix_clocks[timer->it_clock],timer);
+
+	spin_lock(&timer->it_process->alloc_lock);
+	list_del(&timer->it_task_list);
+	spin_unlock(&timer->it_process->alloc_lock);
+
+	/*
+	 * This keeps any tasks waiting on the spin lock from thinking
+	 * they got something (see the lock code above).
+	 */
+	timer->it_process = NULL;
+	unlock_timer(timer);
+	release_posix_timer(timer);
+	return 0;
+}
+/*
+ * And now for the "clock" calls
+
+ * These functions are called both from timer functions (with the timer
+ * spin_lock_irq() held and from clock calls with no locking.	They must
+ * use the save flags versions of locks.
+ */
+static int do_posix_gettime(struct k_clock *clock, struct timespec *tp)
+{
+
+	if (clock->clock_get){
+		return clock->clock_get(tp);
+	}
+
+	do_gettimeofday((struct timeval*)tp);
+	tp->tv_nsec *= NSEC_PER_USEC;
+	return 0;
+}
+
+/*
+ * We do ticks here to avoid the irq lock ( they take sooo long)
+ * Note also that the while loop assures that the sub_jiff_offset
+ * will be less than a jiffie, thus no need to normalize the result.
+ * Well, not really, if called with ints off :(
+ */
+
+int do_posix_clock_monotonic_gettime(struct timespec *tp)
+{
+	long sub_sec;
+	u64 jiffies_64_f;
+
+#if (BITS_PER_LONG > 32) 
+
+	jiffies_64_f = jiffies_64;
+
+#elif defined(CONFIG_SMP)
+
+	/* Tricks don't work here, must take the lock.	 Remember, called
+	 * above from both timer and clock system calls => save flags.
+	 */
+	{
+		unsigned long flags;
+		read_lock_irqsave(&xtime_lock, flags);
+		jiffies_64_f = jiffies_64;
+
+
+		read_unlock_irqrestore(&xtime_lock, flags);
+	}
+#elif ! defined(CONFIG_SMP) && (BITS_PER_LONG < 64)
+	unsigned long jiffies_f;
+	do {
+		jiffies_f = jiffies;
+		barrier();
+		jiffies_64_f = jiffies_64;
+	} while (unlikely(jiffies_f != jiffies));
+
+
+#endif
+	tp->tv_sec = div_long_long_rem(jiffies_64_f,HZ,&sub_sec);
+
+	tp->tv_nsec = sub_sec * (NSEC_PER_SEC / HZ);
+	return 0;
+}
+
+int do_posix_clock_monotonic_settime(struct timespec *tp)
+{
+	return -EINVAL;
+}
+
+asmlinkage int sys_clock_settime(clockid_t which_clock,const struct timespec *tp)
+{
+	struct timespec new_tp;
+
+	if ((unsigned)which_clock >= MAX_CLOCKS || 
+	    ! posix_clocks[which_clock].res) return -EINVAL;
+	if (copy_from_user(&new_tp, tp, sizeof(*tp)))
+		return -EFAULT;
+	if ( posix_clocks[which_clock].clock_set){
+		return posix_clocks[which_clock].clock_set(&new_tp);
+	}
+	new_tp.tv_nsec /= NSEC_PER_USEC;
+	return do_sys_settimeofday((struct timeval*)&new_tp,NULL);
+}
+asmlinkage int sys_clock_gettime(clockid_t which_clock, struct timespec *tp)
+{
+	struct timespec rtn_tp;
+	int error = 0;
+	
+	if ((unsigned)which_clock >= MAX_CLOCKS || 
+	    ! posix_clocks[which_clock].res) return -EINVAL;
+
+	error = do_posix_gettime(&posix_clocks[which_clock],&rtn_tp);
+	 
+	if ( ! error) {
+		if (copy_to_user(tp, &rtn_tp, sizeof(rtn_tp))) {
+			error = -EFAULT;
+		}
+	}
+	return error;
+		 
+}
+asmlinkage int	 sys_clock_getres(clockid_t which_clock, struct timespec *tp)
+{
+	struct timespec rtn_tp;
+
+	if ((unsigned)which_clock >= MAX_CLOCKS || 
+	    ! posix_clocks[which_clock].res) return -EINVAL;
+
+	rtn_tp.tv_sec = 0;
+	rtn_tp.tv_nsec = posix_clocks[which_clock].res;
+	if ( tp){
+		if (copy_to_user(tp, &rtn_tp, sizeof(rtn_tp))) {
+			return -EFAULT;
+		}
+	}
+	return 0;
+	 
+}
+static void nanosleep_wake_up(unsigned long __data)
+{
+	struct task_struct * p = (struct task_struct *) __data;
+
+	wake_up_process(p);
+}
+/*
+ * The standard says that an absolute nanosleep call MUST wake up at
+ * the requested time in spite of clock settings.  Here is what we do:
+ * For each nanosleep call that needs it (only absolute and not on 
+ * CLOCK_MONOTONIC* (as it can not be set)) we thread a little structure
+ * into the "nanosleep_abs_list".  All we need is the task_struct pointer.
+ * When ever the clock is set we just wake up all those tasks.	 The rest
+ * is done by the while loop in clock_nanosleep().
+
+ * On locking, clock_was_set() is called from update_wall_clock which 
+ * holds (or has held for it) a write_lock_irq( xtime_lock) and is 
+ * called from the timer bh code.  Thus we need the irq save locks.
+ */
+spinlock_t nanosleep_abs_list_lock = SPIN_LOCK_UNLOCKED;
+
+struct list_head nanosleep_abs_list =	LIST_HEAD_INIT(nanosleep_abs_list);
+
+struct abs_struct {
+	struct list_head list;
+	struct task_struct *t;
+};
+
+void clock_was_set(void)
+{
+	struct list_head *pos;
+	unsigned long flags;
+
+	spin_lock_irqsave(&nanosleep_abs_list_lock, flags);
+	list_for_each(pos, &nanosleep_abs_list){
+		wake_up_process(list_entry(pos,struct abs_struct,list)->t);
+	}
+	spin_unlock_irqrestore(&nanosleep_abs_list_lock, flags);
+}
+
+static inline int tstojiffie(struct timespec *tp, 
+			     int res,
+			     unsigned long *jiff)
+{
+	unsigned long sec = tp->tv_sec;
+	long nsec = tp->tv_nsec + res - 1;
+
+	/*
+	 * A note on jiffy overflow: It is possible for the system to
+	 * have been up long enough for the jiffies quanity to overflow.
+	 * In order for correct timer evaluations we require that the
+	 * specified time be somewhere between now and now + (max
+	 * unsigned int/2).  Times beyond this will be truncated back to
+	 * this value.	 This is done in the absolute adjustment code,
+	 * below.  Here it is enough to just discard the high order
+	 * bits.  
+	 */
+	*jiff = HZ * sec;
+	/*
+	 * Do the res thing. (Don't forget the add in the declaration of nsec) 
+	 */
+	nsec -= nsec % res;
+	/*
+	 * Split to jiffie and sub jiffie
+	 */
+	*jiff += nsec / (NSEC_PER_SEC / HZ);
+	/*
+	 * We trust that the optimizer will use the remainder from the 
+	 * above div in the following operation as long as they are close. 
+	 */
+	return	0;
+}
+
+#if 0	
+// This #if 0 is to keep the pretty printer/ formatter happy so the indents will
+// correct below.
+  
+// The NANOSLEEP_ENTRY macro is defined in  asm/signal.h and
+// is structured to allow code as well as entry definitions, so that when
+// we get control back here the entry parameters will be available as expected.
+// Some systems may find these paramerts in other ways than as entry parms, 
+// for example, struct pt_regs *regs is defined in i386 as the address of the
+// first parameter, where as other archs pass it as one of the paramerters.
+
+asmlinkage long sys_clock_nanosleep(void)
+{
+#endif
+	CLOCK_NANOSLEEP_ENTRY(	struct timespec t;
+				struct timespec tsave;
+				struct timer_list new_timer;
+				struct abs_struct abs_struct = {list: {next :0}};
+				int abs; 
+				int rtn = 0;
+				int active;)
+
+		//asmlinkage int  sys_clock_nanosleep(clockid_t which_clock, 
+		//			   int flags,
+		//			   const struct timespec *rqtp,
+		//			   struct timespec *rmtp)
+		//{
+		if ((unsigned)which_clock >= MAX_CLOCKS || 
+		    ! posix_clocks[which_clock].res) return -EINVAL;
+
+	if(copy_from_user(&tsave, rqtp, sizeof(struct timespec)))
+		return -EFAULT;
+
+	if ((unsigned)tsave.tv_nsec >= NSEC_PER_SEC || tsave.tv_sec < 0)
+		return -EINVAL;
+	
+	init_timer(&new_timer);
+	new_timer.expires = 0;
+	new_timer.data = (unsigned long)current;
+	new_timer.function = nanosleep_wake_up;
+	abs = flags & TIMER_ABSTIME;
+
+	if ( abs && (posix_clocks[which_clock].clock_get != 
+		     posix_clocks[CLOCK_MONOTONIC].clock_get) ){
+		spin_lock_irq(&nanosleep_abs_list_lock);
+		list_add(&abs_struct.list, &nanosleep_abs_list);
+		abs_struct.t = current;
+		spin_unlock_irq(&nanosleep_abs_list_lock);
+	}
+	do {
+		t = tsave;
+		if ( (abs || !new_timer.expires) &&
+		     !(rtn = adjust_abs_time(&posix_clocks[which_clock],
+					     &t,
+					     abs))){
+			/*
+			 * On error, we don't set up the timer so
+			 * we don't arm the timer so
+			 * del_timer_sync() will return 0, thus
+			 * active is zero... and so it goes.
+			 */
+
+				tstojiffie(&t,
+					   posix_clocks[which_clock].res,
+					   &new_timer.expires);
+		}
+		if (new_timer.expires ){
+			current->state = TASK_INTERRUPTIBLE;
+			add_timer(&new_timer);
+
+			schedule();
+		}
+	}
+	while((active = del_timer_sync(&new_timer)) && !_do_signal());
+	 
+	if ( abs_struct.list.next ){
+		spin_lock_irq(&nanosleep_abs_list_lock);
+		list_del(&abs_struct.list);
+		spin_unlock_irq(&nanosleep_abs_list_lock);
+	}
+	if (active && rmtp ) {
+		unsigned long jiffies_f = jiffies;
+
+		jiffies_to_timespec(new_timer.expires - jiffies_f, &t);
+
+		while (t.tv_nsec < 0){
+			t.tv_nsec += NSEC_PER_SEC;
+			t.tv_sec--;
+		} 
+		if (t.tv_sec < 0){
+			t.tv_sec = 0;
+			t.tv_nsec = 1;
+		}
+	}else{
+		t.tv_sec = 0;
+		t.tv_nsec = 0;
+	}
+	if (!rtn && !abs && rmtp && 
+	    copy_to_user(rmtp, &t, sizeof(struct timespec))){
+		return -EFAULT;
+	}
+	if (active) return -EINTR;
+
+	return rtn;
+}
