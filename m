Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWCDRdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWCDRdN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 12:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWCDRdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 12:33:13 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:58093 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932240AbWCDRdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 12:33:12 -0500
Message-ID: <4409CE9B.E9117FC5@tv-sign.ru>
Date: Sat, 04 Mar 2006 20:30:03 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/23] tref: Implement task references.
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
			<m1k6bmhxze.fsf@ebiederm.dsl.xmission.com>
			<m1mzgidnr0.fsf@ebiederm.dsl.xmission.com>
			<44074479.15D306EB@tv-sign.ru>
			<m14q2gjxqo.fsf@ebiederm.dsl.xmission.com>
			<4408753B.52E3B003@tv-sign.ru> <m1mzg6cvek.fsf@ebiederm.dsl.xmission.com> <4409888C.71720720@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> 
> "Eric W. Biederman" wrote:
> >
> > Oleg Nesterov <oleg@tv-sign.ru> writes:
> >
> > > fastcall void free_pidmap(int pid)
> > > {
> > >       pidmap_t *map = pidmap_array + pid / BITS_PER_PAGE;
> > >       int offset = pid & BITS_PER_PAGE_MASK;
> > >       struct pid_ref *ref;
> > >
> > >       clear_bit(offset, map->page);
> > >       atomic_inc(&map->nr_free);
> > >
> > >       ref = find_pid_ref(pid);
> > >       if (unlikely(ref != NULL)) {
> > >               hlist_del_init(&ref->chain);
> > >               ref->pid = 0;
> > >       }
> > > }
> >
> > Ouch!  I believe free_pidmap now needs the tasklist_lock so
> > we can free the pid and kill the pid_ref atomically.  Otherwise
> > the pid could potentially get reused before we free the pid reference.
> > I think that means ensuring all of the callers take tasklist_lock.
> 
> Yes, you are right. And do_fork() does free_pidmap() lockless in
> the error path. This path is not performance critical, so may be
> it is ok to add wrie_lock(tasklist) here.

Even better: don't use tasklist_lock at all. We can use pidmap_lock
instead, see the patch below.

I have added a simple find_task_by_pid_ref() helper, note that it
doesn't need pidmap_lock, and it doesn't need to check ref->pid != 0.

If the caller does read_lock(tasklist), then this helper can't return
unhashed task_struct, otherwise it is possible anyway.

Oleg.

(for review only)

--- 2.6.16-rc5/include/linux/sched.h~1_REF	2006-03-01 22:00:30.000000000 +0300
+++ 2.6.16-rc5/include/linux/sched.h	2006-03-04 22:56:44.000000000 +0300
@@ -1012,8 +1012,6 @@ extern struct task_struct init_task;
 
 extern struct   mm_struct init_mm;
 
-#define find_task_by_pid(nr)	find_task_by_pid_type(PIDTYPE_PID, nr)
-extern struct task_struct *find_task_by_pid_type(int type, int pid);
 extern void set_special_pids(pid_t session, pid_t pgrp);
 extern void __set_special_pids(pid_t session, pid_t pgrp);
 
--- 2.6.16-rc5/include/linux/pid.h~1_REF	2006-03-01 22:00:29.000000000 +0300
+++ 2.6.16-rc5/include/linux/pid.h	2006-03-04 23:02:51.000000000 +0300
@@ -35,6 +35,9 @@ extern void FASTCALL(detach_pid(struct t
  * held.
  */
 extern struct pid *FASTCALL(find_pid(enum pid_type, int));
+extern struct task_struct *find_task_by_pid_type(int type, int pid);
+
+#define find_task_by_pid(nr)	find_task_by_pid_type(PIDTYPE_PID, nr)
 
 extern int alloc_pidmap(void);
 extern void FASTCALL(free_pidmap(int));
@@ -51,4 +54,23 @@ extern void FASTCALL(free_pidmap(int));
 			hlist_unhashed(&(task)->pids[type].pid_chain));	\
 	}								\
 
+struct pid_ref
+{
+	pid_t			pid;
+	int			count;
+	struct hlist_node	chain;
+};
+
+extern struct pid_ref *alloc_pid_ref(pid_t pid);
+extern void put_pid_ref(struct pid_ref *ref);
+
+static inline struct task_struct *find_task_by_pid_ref(struct pid_ref *ref,
+							enum pid_type type)
+{
+	if (!ref)
+		return NULL;
+
+	return find_task_by_pid_type(type, ref->pid);
+}
+
 #endif /* _LINUX_PID_H */
--- 2.6.16-rc5/kernel/pid.c~1_REF	2006-03-01 22:03:25.000000000 +0300
+++ 2.6.16-rc5/kernel/pid.c	2006-03-04 22:27:51.000000000 +0300
@@ -28,9 +28,12 @@
 #include <linux/hash.h>
 
 #define pid_hashfn(nr) hash_long((unsigned long)nr, pidhash_shift)
-static struct hlist_head *pid_hash[PIDTYPE_MAX];
+static struct hlist_head *pid_hash[PIDTYPE_MAX + 1];
 static int pidhash_shift;
 
+#define ref_hashfn(pid)		pid_hashfn(pid)
+#define ref_hash		pid_hash[PIDTYPE_MAX]
+
 int pid_max = PID_MAX_DEFAULT;
 int last_pid;
 
@@ -62,13 +65,35 @@ static pidmap_t pidmap_array[PIDMAP_ENTR
 
 static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(pidmap_lock);
 
+static struct pid_ref *find_pid_ref(pid_t pid)
+{
+	struct hlist_node *elem;
+	struct pid_ref *ref;
+
+	hlist_for_each_entry(ref, elem, &ref_hash[ref_hashfn(pid)], chain)
+		if (ref->pid == pid)
+			return ref;
+
+	return NULL;
+}
+
 fastcall void free_pidmap(int pid)
 {
 	pidmap_t *map = pidmap_array + pid / BITS_PER_PAGE;
 	int offset = pid & BITS_PER_PAGE_MASK;
+	struct pid_ref *ref;
+	unsigned long flags;
 
 	clear_bit(offset, map->page);
 	atomic_inc(&map->nr_free);
+
+	spin_lock_irqsave(&pidmap_lock, flags);
+	ref = find_pid_ref(pid);
+	if (unlikely(ref != NULL)) {
+		hlist_del_init(&ref->chain);
+		ref->pid = 0;
+	}
+	spin_unlock_irqrestore(&pidmap_lock, flags);
 }
 
 int alloc_pidmap(void)
@@ -217,6 +242,48 @@ task_t *find_task_by_pid_type(int type, 
 
 EXPORT_SYMBOL(find_task_by_pid_type);
 
+static inline int pid_inuse(pid_t pid)
+{
+	pidmap_t *map = pidmap_array + pid / BITS_PER_PAGE;
+	int offset = pid & BITS_PER_PAGE_MASK;
+
+	return likely(map->page) && test_bit(offset, map->page);
+}
+
+struct pid_ref *alloc_pid_ref(pid_t pid)
+{
+	struct pid_ref *ref;
+
+	spin_lock_irq(&pidmap_lock);
+	ref = find_pid_ref(pid);
+	if (ref)
+		ref->count++;
+	else if (pid_inuse(pid)) {
+		ref = kmalloc(sizeof(*ref), GFP_ATOMIC);
+		if (ref) {
+			ref->pid = pid;
+			ref->count = 1;
+			hlist_add_head(&ref->chain,
+				&ref_hash[ref_hashfn(pid)]);
+		}
+	}
+	spin_unlock_irq(&pidmap_lock);
+
+	return ref;
+}
+
+void free_pid_ref(struct pid_ref *ref)
+{
+	if (!ref)
+		return;
+
+	spin_lock_irq(&pidmap_lock);
+	if (!--ref->count) {
+		hlist_del_init(&ref->chain);
+		kfree(ref);
+	}
+	spin_lock_irq(&pidmap_lock);
+}
 /*
  * The pid hash table is scaled according to the amount of memory in the
  * machine.  From a minimum of 16 slots up to 4096 slots at one gigabyte or
@@ -233,9 +300,9 @@ void __init pidhash_init(void)
 
 	printk("PID hash table entries: %d (order: %d, %Zd bytes)\n",
 		pidhash_size, pidhash_shift,
-		PIDTYPE_MAX * pidhash_size * sizeof(struct hlist_head));
+		(PIDTYPE_MAX + 1) * pidhash_size * sizeof(struct hlist_head));
 
-	for (i = 0; i < PIDTYPE_MAX; i++) {
+	for (i = 0; i < PIDTYPE_MAX + 1; i++) {
 		pid_hash[i] = alloc_bootmem(pidhash_size *
 					sizeof(*(pid_hash[i])));
 		if (!pid_hash[i])
