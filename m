Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbWCBTT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWCBTT0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 14:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbWCBTTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 14:19:25 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:57291 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932481AbWCBTTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 14:19:23 -0500
Message-ID: <44074479.15D306EB@tv-sign.ru>
Date: Thu, 02 Mar 2006 22:16:09 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/23] tref: Implement task references.
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
		<m1k6bmhxze.fsf@ebiederm.dsl.xmission.com> <m1mzgidnr0.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
>
> Holding a reference to a task_struct pins about 10K of low memory even after
> that task has exited.  Which seems to be at 1 or 2 orders of mangnitude more
> memory than any other data structure in the kernel.  Not holding a reference
> to a task_struct and you risk problems with pid wrap around.

I think there is another, much simpler solution. We can make a "reference" to the
pid itself to protect it against free_pidmap(), so that this pid can't be reused.

	struct pid_ref
	{
		pid_t			pid;
		atomic_t		count;
		struct hlist_node	chain;
	};

	// allocated in pidhash_init()
	static struct hlist_head *ref_hash;

	struct pid_ref *find_pid_ref(pid_t pid)
	{
		struct hlist_node *elem;
		struct pid_ref *ref;

		hlist_for_each_entry(ref, elem, &ref_hash[pid_hashfn(pid)], chain)
			if (ref->pid == pid)
				return ref;

		return NULL;
	}

	// just s/free_pidmap/__free_pidmap/
	static void __free_pidmap(int pid)
	{
		pidmap_t *map = pidmap_array + pid / BITS_PER_PAGE;
		int offset = pid & BITS_PER_PAGE_MASK;

		clear_bit(offset, map->page);
		atomic_inc(&map->nr_free);
	}

	fastcall void free_pidmap(int pid)
	{
		if (!find_pid_ref(pid))
			__free_pidmap(pid);
	}


	static int pid_inuse(pid_t pid)
	{
		int type;

		for (type = 0; type < PIDTYPE_MAX; ++type)
			if (find_pid(type, pid))
				return 1;

		return 0;
	}

	// simple, non-optimized version
	struct pid_ref *mk_pid_ref(pid_t pid)
	{
		struct pid_ref *ref;

		write_lock_irq(&tasklist_lock);
		ref = find_pid_ref(pid);
		if (ref)
			atomic_inc(&ref->count);
		else if (pid_inuse(pid)) {
			ref = kmalloc(sizeof(*ref), GFP_ATOMIC);
			if (ref) {
				ref->pid = pid;
				atomic_set(&ref->count, 1);
				hlist_add_head(&ref->chain,
					&ref_hash[pid_hashfn(pid)]);
			}
		}
		write_unlock_irq(&tasklist_lock);

		return ref;
	}

	void put_pid_ref(struct pid_ref *ref)
	{
		if (!ref || !atomic_dec_and_test(&ref->count))
			return;

		write_lock_irq(&tasklist_lock);
		if (!atomic_read(&ref->count)) {
			if (!pid_inuse(ref->pid))
				__free_pidmap(ref->pid);
			hlist_del(&ref->chain);
			kfree(ref);
		}
		write_unlock_irq(&tasklist_lock);
	}

That's all. The only modified function is free_pidmap(), and the change is
trivial. Example of usage:

	 struct fown_struct {
		...
	-	int pid;
	+	struct pid_ref *ref;
	+	enum pid_type	type;
		...
	 }

	 void file_free(struct file *f)
	 {
	+	put_pid_ref(f->f_owner->ref);
		...
	 }

	void f_modown(struct file *filp, int pid, uid_t uid, uid_t euid, int force)
	{
		struct pid_ref *old, *ref;
		enum pid_type type = PIDTYPE_PID;

		if (pid < 0) {
			pid = -pid;
			type = PIDTYPE_PGID;
		}
		ref = mk_pid_ref(pid);

		write_lock_irq(&filp->f_owner.lock);
		old = ref;
		if (force || !filp->f_owner.ref) {
			old = filp->f_owner.ref;
			filp->f_owner.ref = ref;
			filp->f_owner.type = type;
			filp->f_owner.uid = uid;
			filp->f_owner.euid = euid;
		}
		write_unlock_irq(&filp->f_owner.lock);

		put_pid_ref(old);
	}

	void send_sigio(struct fown_struct *fown, int fd, int band)
	{
		struct task_struct *p;

		read_lock(&fown->lock);
		if (!fown->ref)
			goto out_unlock_fown;

		read_lock(&tasklist_lock);

		do_each_task_pid(fown->ref->pid, fown->type, p)
			send_sigio_to_task(p, fown, fd, band);
		while_each_task_pid(fown->ref->pid, fown->type, p);

		read_unlock(&tasklist_lock);
	out_unlock_fown:
		read_unlock(&fown->lock);
	}

What do you think?

Oleg.
