Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbWHIWWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWHIWWf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 18:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWHIWWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 18:22:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7824 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751409AbWHIWWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 18:22:32 -0400
Date: Wed, 9 Aug 2006 15:21:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: Re: [take6 1/3] kevent: Core files.
Message-Id: <20060809152127.481fb346.akpm@osdl.org>
In-Reply-To: <11551105602734@2ka.mipt.ru>
References: <11551105592821@2ka.mipt.ru>
	<11551105602734@2ka.mipt.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2006 12:02:40 +0400
Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:

> 
> Core files.
> 
> This patch includes core kevent files:
>  - userspace controlling
>  - kernelspace interfaces
>  - initialization
>  - notification state machines
> 
> It might also inlclude parts from other subsystem (like network related
> syscalls, so it is possible that it will not compile without other
> patches applied).

Summary:

- has serious bugs which indicate that much better testing is needed.

- All -EFOO return values need to be reviewed for appropriateness

- needs much better commenting before I can do more than a local-level review.


> --- /dev/null
> +++ b/include/linux/kevent.h
> ...
>
> +/*
> + * Poll events.
> + */
> +#define	KEVENT_POLL_POLLIN	0x0001
> +#define	KEVENT_POLL_POLLPRI	0x0002
> +#define	KEVENT_POLL_POLLOUT	0x0004
> +#define	KEVENT_POLL_POLLERR	0x0008
> +#define	KEVENT_POLL_POLLHUP	0x0010
> +#define	KEVENT_POLL_POLLNVAL	0x0020
> +
> +#define	KEVENT_POLL_POLLRDNORM	0x0040
> +#define	KEVENT_POLL_POLLRDBAND	0x0080
> +#define	KEVENT_POLL_POLLWRNORM	0x0100
> +#define	KEVENT_POLL_POLLWRBAND	0x0200
> +#define	KEVENT_POLL_POLLMSG	0x0400
> +#define	KEVENT_POLL_POLLREMOVE	0x1000

0x0800 got lost.

> +struct ukevent
> +{
> +	struct kevent_id	id;			/* Id of this request, e.g. socket number, file descriptor and so on... */
> +	__u32			type;			/* Event type, e.g. KEVENT_SOCK, KEVENT_INODE, KEVENT_TIMER and so on... */
> +	__u32			event;			/* Event itself, e.g. SOCK_ACCEPT, INODE_CREATED, TIMER_FIRED... */
> +	__u32			req_flags;		/* Per-event request flags */
> +	__u32			ret_flags;		/* Per-event return flags */
> +	__u32			ret_data[2];		/* Event return data. Event originator fills it with anything it likes. */
> +	union {
> +		__u32		user[2];		/* User's data. It is not used, just copied to/from user. */
> +		void		*ptr;
> +	};
> +};

What is this union for?

`ptr' needs a __user tag, does it not?

`ptr' will be 64-bit in-kernel and 64-bit for 64-bit userspace, but 32-bit
for 32-bit userspace.  I guess that's why user[] is there.

On big-endian machines, this pointer will appear to be word-swapped as far
as a 64-bit kernel is concerned.  Or something.

IOW: What's going on here??

> +#ifdef CONFIG_KEVENT_INODE
> +void kevent_inode_notify(struct inode *inode, u32 event);
> +void kevent_inode_notify_parent(struct dentry *dentry, u32 event);
> +void kevent_inode_remove(struct inode *inode);
> +#else
> +static inline void kevent_inode_notify(struct inode *inode, u32 event)
> +{
> +}
> +static inline void kevent_inode_notify_parent(struct dentry *dentry, u32 event)
> +{
> +}
> +static inline void kevent_inode_remove(struct inode *inode)
> +{
> +}
> +#endif /* CONFIG_KEVENT_INODE */
> +#ifdef CONFIG_KEVENT_SOCKET
> +#ifdef CONFIG_LOCKDEP
> +void kevent_socket_reinit(struct socket *sock);
> +void kevent_sk_reinit(struct sock *sk);
> +#else
> +static inline void kevent_socket_reinit(struct socket *sock)
> +{
> +}
> +static inline void kevent_sk_reinit(struct sock *sk)
> +{
> +}
> +#endif
> +void kevent_socket_notify(struct sock *sock, u32 event);
> +int kevent_socket_dequeue(struct kevent *k);
> +int kevent_socket_enqueue(struct kevent *k);
> +#define sock_async(__sk) sock_flag(__sk, SOCK_ASYNC)

Is this header the correct place to be implementing sock_async()?

> --- /dev/null
> +++ b/kernel/kevent/Kconfig
> @@ -0,0 +1,50 @@
> +config KEVENT
> +	bool "Kernel event notification mechanism"
> +	help
> +	  This option enables event queue mechanism.
> +	  It can be used as replacement for poll()/select(), AIO callback invocations,
> +	  advanced timer notifications and other kernel object status changes.

Please squeeze all the help text into 80-columns.  Or at least check that
it looks OK in menuconfig in an 80-col xterm,

> --- /dev/null
> +++ b/kernel/kevent/kevent.c
> @@ -0,0 +1,238 @@
> +/*
> + * 	kevent.c
> + * 
> + * 2006 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> + * All rights reserved.
> + * 
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/list.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/mempool.h>
> +#include <linux/sched.h>
> +#include <linux/wait.h>
> +#include <linux/kevent.h>
> +
> +kmem_cache_t *kevent_cache;
> +
> +/*
> + * Attempts to add an event into appropriate origin's queue.
> + * Returns positive value if this event is ready immediately,
> + * negative value in case of error and zero if event has been queued.
> + * ->enqueue() callback must increase origin's reference counter.
> + */
> +int kevent_enqueue(struct kevent *k)
> +{
> +	if (k->event.type >= KEVENT_MAX)
> +		return -E2BIG;

E2BIG is "Argument list too long".  EINVAL is appropriate here.

> +	if (!k->callbacks.enqueue) {
> +		kevent_break(k);
> +		return -EINVAL;
> +	}
> +	
> +	return k->callbacks.enqueue(k);
> +}
> +
> +/*
> + * Remove event from the appropriate queue.
> + * ->dequeue() callback must decrease origin's reference counter.
> + */
> +int kevent_dequeue(struct kevent *k)
> +{
> +	if (k->event.type >= KEVENT_MAX)
> +		return -E2BIG;
> +	
> +	if (!k->callbacks.dequeue) {
> +		kevent_break(k);
> +		return -EINVAL;
> +	}
> +
> +	return k->callbacks.dequeue(k);
> +}
> +
> +int kevent_break(struct kevent *k)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&k->ulock, flags);
> +	k->event.ret_flags |= KEVENT_RET_BROKEN;
> +	spin_unlock_irqrestore(&k->ulock, flags);
> +	return 0;
> +}
> +
> +struct kevent_callbacks kevent_registered_callbacks[KEVENT_MAX];
> +
> +/*
> + * Must be called before event is going to be added into some origin's queue.
> + * Initializes ->enqueue(), ->dequeue() and ->callback() callbacks.
> + * If failed, kevent should not be used or kevent_enqueue() will fail to add
> + * this kevent into origin's queue with setting
> + * KEVENT_RET_BROKEN flag in kevent->event.ret_flags.
> + */
> +int kevent_init(struct kevent *k)
> +{
> +	spin_lock_init(&k->ulock);
> +	k->kevent_entry.next = LIST_POISON1;
> +	k->storage_entry.prev = LIST_POISON2;
> +	k->ready_entry.next = LIST_POISON1;

Nope ;)

> +	if (k->event.type >= KEVENT_MAX)
> +		return -E2BIG;
> +
> +	k->callbacks = kevent_registered_callbacks[k->event.type];
> +	if (!k->callbacks.callback) {
> +		kevent_break(k);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Called from ->enqueue() callback when reference counter for given
> + * origin (socket, inode...) has been increased.
> + */
> +int kevent_storage_enqueue(struct kevent_storage *st, struct kevent *k)
> +{
> +	unsigned long flags;
> +
> +	k->st = st;
> +	spin_lock_irqsave(&st->lock, flags);
> +	list_add_tail_rcu(&k->storage_entry, &st->list);
> +	st->qlen++;
> +	spin_unlock_irqrestore(&st->lock, flags);
> +	return 0;
> +}

Is the _rcu variant needed here?

> +/*
> + * Dequeue kevent from origin's queue. 
> + * It does not decrease origin's reference counter in any way 
> + * and must be called before it, so storage itself must be valid.
> + * It is called from ->dequeue() callback.
> + */
> +void kevent_storage_dequeue(struct kevent_storage *st, struct kevent *k)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&st->lock, flags);
> +	if (k->storage_entry.prev != LIST_POISON2) {

Nope, as discussed earlier.

> +		list_del_rcu(&k->storage_entry);
> +		st->qlen--;
> +	}
> +	spin_unlock_irqrestore(&st->lock, flags);
> +}
> +
> +static void __kevent_requeue(struct kevent *k, u32 event)
> +{
> +	int err, rem = 0;
> +	unsigned long flags;
> +
> +	err = k->callbacks.callback(k);
> +
> +	spin_lock_irqsave(&k->ulock, flags);
> +	if (err > 0) {
> +		k->event.ret_flags |= KEVENT_RET_DONE;
> +	} else if (err < 0) {
> +		k->event.ret_flags |= KEVENT_RET_BROKEN;
> +		k->event.ret_flags |= KEVENT_RET_DONE;
> +	}
> +	rem = (k->event.req_flags & KEVENT_REQ_ONESHOT);
> +	if (!err)
> +		err = (k->event.ret_flags & (KEVENT_RET_BROKEN|KEVENT_RET_DONE));
> +	spin_unlock_irqrestore(&k->ulock, flags);

Local variable `err' no longer actually indicates an error, does it?

If not, a differently-named local would be appropriate here.

> +	if (err) {
> +		if ((rem || err < 0) && k->storage_entry.prev != LIST_POISON2) {
> +			list_del_rcu(&k->storage_entry);
> +			k->st->qlen--;

->qlen was previously modified under spinlock.  Here it is not.

> +		}
> +		
> +		spin_lock_irqsave(&k->user->ready_lock, flags);
> +		if (k->ready_entry.next == LIST_POISON1) {
> +			kevent_user_ring_add_event(k);
> +			list_add_tail(&k->ready_entry, &k->user->ready_list);
> +			k->user->ready_num++;
> +		}
> +		spin_unlock_irqrestore(&k->user->ready_lock, flags);
> +		wake_up(&k->user->wait);
> +	}
> +}
> +
> +void kevent_requeue(struct kevent *k)
> +{
> +	unsigned long flags;
> +	
> +	spin_lock_irqsave(&k->st->lock, flags);
> +	__kevent_requeue(k, 0);
> +	spin_unlock_irqrestore(&k->st->lock, flags);
> +}
> +
> +/*
> + * Called each time some activity in origin (socket, inode...) is noticed.
> + */
> +void kevent_storage_ready(struct kevent_storage *st, 
> +		kevent_callback_t ready_callback, u32 event)
> +{
> +	struct kevent *k;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(k, &st->list, storage_entry) {
> +		if (ready_callback)
> +			ready_callback(k);

For readability reasons I prefer the old-style

		(*ready_callback)(k);

so the reader knows not to go off hunting for the function "ready_callback".
Minor point.

So the kevent_callback_t handlers are not allowed to sleep.

> +		if (event & k->event.event)
> +			__kevent_requeue(k, event);
> +	}

Under what circumstances will `event' be zero??

> +	rcu_read_unlock();
> +}
> +
> +int kevent_storage_init(void *origin, struct kevent_storage *st)
> +{
> +	spin_lock_init(&st->lock);
> +	st->origin = origin;
> +	st->qlen = 0;
> +	INIT_LIST_HEAD(&st->list);
> +	return 0;
> +}
> +
> +void kevent_storage_fini(struct kevent_storage *st)
> +{
> +	kevent_storage_ready(st, kevent_break, KEVENT_MASK_ALL);
> +}
> +
> +static int __init kevent_sys_init(void)
> +{
> +	int i;
> +
> +	kevent_cache = kmem_cache_create("kevent_cache", 
> +			sizeof(struct kevent), 0, 0, NULL, NULL);
> +	if (!kevent_cache)
> +		panic("kevent: Unable to create a cache.\n");

Can use SLAB_PANIC (a silly thing I added to avoid code duplication).

> +	for (i=0; i<ARRAY_SIZE(kevent_registered_callbacks); ++i) {
> +		struct kevent_callbacks *c = &kevent_registered_callbacks[i];
> +
> +		c->callback = c->enqueue = c->dequeue = NULL;
> +	}

This zeroing is redundant.

> +	return 0;
> +}
> +
> +late_initcall(kevent_sys_init);

Why is it late_initcall?  (A comment is needed)

> diff --git a/kernel/kevent/kevent_user.c b/kernel/kevent/kevent_user.c
> new file mode 100644
> index 0000000..7b6374b
> --- /dev/null
> +++ b/kernel/kevent/kevent_user.c
> @@ -0,0 +1,857 @@
> +/*
> + * 	kevent_user.c
> + * 
> + * 2006 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> + * All rights reserved.
> + * 
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/list.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/fs.h>
> +#include <linux/file.h>
> +#include <linux/mount.h>
> +#include <linux/device.h>
> +#include <linux/poll.h>
> +#include <linux/kevent.h>
> +#include <linux/jhash.h>
> +#include <linux/miscdevice.h>
> +#include <asm/io.h>
> +
> +static char kevent_name[] = "kevent";
> +
> +static int kevent_user_open(struct inode *, struct file *);
> +static int kevent_user_release(struct inode *, struct file *);
> +static unsigned int kevent_user_poll(struct file *, struct poll_table_struct *);
> +static int kevnet_user_mmap(struct file *, struct vm_area_struct *);
> +
> +static struct file_operations kevent_user_fops = {
> +	.mmap		= kevnet_user_mmap,
> +	.open		= kevent_user_open,
> +	.release	= kevent_user_release,
> +	.poll		= kevent_user_poll,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static struct miscdevice kevent_miscdev = {
> +	.minor = MISC_DYNAMIC_MINOR,
> +	.name = kevent_name,
> +	.fops = &kevent_user_fops,
> +};
> +
> +static int kevent_get_sb(struct file_system_type *fs_type, 
> +		int flags, const char *dev_name, void *data, struct vfsmount *mnt)
> +{
> +	/* So original magic... */
> +	return get_sb_pseudo(fs_type, kevent_name, NULL, 0xabcdef, mnt);	
> +}

That doesn't look like a well-chosen magic number...

> +static struct file_system_type kevent_fs_type = {
> +	.name		= kevent_name,
> +	.get_sb		= kevent_get_sb,
> +	.kill_sb	= kill_anon_super,
> +};
> +
> +static struct vfsmount *kevent_mnt;
> +
> +static unsigned int kevent_user_poll(struct file *file, struct poll_table_struct *wait)
> +{
> +	struct kevent_user *u = file->private_data;
> +	unsigned int mask;
> +	
> +	poll_wait(file, &u->wait, wait);
> +	mask = 0;
> +
> +	if (u->ready_num)
> +		mask |= POLLIN | POLLRDNORM;
> +
> +	return mask;
> +}
> +
> +static inline void kevent_user_ring_set(struct kevent_user *u, unsigned int num)
> +{
> +	unsigned int *idx;
> +	
> +	idx = (unsigned int *)u->pring[0];

This is a bit ugly.


> +	idx[0] = num;
> +}
> +
> +/*
> + * Note that kevents does not exactly fill the page (each ukevent is 40 bytes),
> + * so we reuse 4 bytes at the begining of the first page to store index.
> + * Take that into account if you want to change size of struct ukevent.
> + */
> +#define KEVENTS_ON_PAGE (PAGE_SIZE/sizeof(struct ukevent))

How about doing

	struct ukevent_ring {
		unsigned int index;
		struct ukevent[0];
	}

and removing all those nasty typeasting and offsetting games?

In fact you can even do

	struct ukevent_ring {
		struct ukevent[(PAGE_SIZE - sizeof(unsigned int)) /
				sizeof(struct ukevent)];
		unsigned int index;
	};

if you're careful ;)

> +/*
> + * Called under kevent_user->ready_lock, so updates are always protected.
> + */
> +void kevent_user_ring_add_event(struct kevent *k)
> +{
> +	unsigned int *idx_ptr, idx, pidx, off;
> +	struct ukevent *ukev;
> +	
> +	idx_ptr = (unsigned int *)k->user->pring[0];
> +	idx = idx_ptr[0];
> +
> +	pidx = idx/KEVENTS_ON_PAGE;
> +	off = idx%KEVENTS_ON_PAGE;
> +
> +	if (pidx == 0)
> +		ukev = (struct ukevent *)(k->user->pring[pidx] + sizeof(unsigned int));
> +	else
> +		ukev = (struct ukevent *)(k->user->pring[pidx]);

Such as these.

> +	memcpy(&ukev[off], &k->event, sizeof(struct ukevent));
> +
> +	idx++;
> +	if (idx >= KEVENT_MAX_EVENTS)
> +		idx = 0;
> +
> +	idx_ptr[0] = idx;
> +}
> +
> +static int kevent_user_ring_init(struct kevent_user *u)
> +{
> +	int i, pnum;
> +
> +	pnum = ALIGN(KEVENT_MAX_EVENTS*sizeof(struct ukevent) + sizeof(unsigned int), PAGE_SIZE)/PAGE_SIZE;

And these.

> +	u->pring = kmalloc(pnum * sizeof(unsigned long), GFP_KERNEL);
> +	if (!u->pring)
> +		return -ENOMEM;
> +
> +	for (i=0; i<pnum; ++i) {
> +		u->pring[i] = __get_free_page(GFP_KERNEL);
> +		if (!u->pring)

bug: this is testing the wrong thing.

> +			break;
> +	}
> +
> +	if (i != pnum) {
> +		pnum = i;
> +		goto err_out_free;
> +	}

Move this logic into the `if (!u->pring)' logic, above.

> +	kevent_user_ring_set(u, 0);
> +
> +	return 0;
> +
> +err_out_free:
> +	for (i=0; i<pnum; ++i)
> +		free_page(u->pring[i]);
> +
> +	kfree(u->pring);
> +
> +	return -ENOMEM;
> +}
> +
> +static void kevent_user_ring_fini(struct kevent_user *u)
> +{
> +	int i, pnum;
> +
> +	pnum = ALIGN(KEVENT_MAX_EVENTS*sizeof(struct ukevent) + sizeof(unsigned int), PAGE_SIZE)/PAGE_SIZE;
> +	
> +	for (i=0; i<pnum; ++i)
> +		free_page(u->pring[i]);
> +
> +	kfree(u->pring);
> +}
> +
> +static struct kevent_user *kevent_user_alloc(void)
> +{
> +	struct kevent_user *u;
> +	int i;
> +
> +	u = kzalloc(sizeof(struct kevent_user), GFP_KERNEL);
> +	if (!u)
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&u->ready_list);
> +	spin_lock_init(&u->ready_lock);
> +	u->ready_num = 0;
> +	kevent_user_stat_init(u);
> +	spin_lock_init(&u->kevent_lock);
> +	for (i=0; i<ARRAY_SIZE(u->kevent_list); ++i)
> +		INIT_LIST_HEAD(&u->kevent_list[i]);
> +	u->kevent_num = 0;
> +	
> +	mutex_init(&u->ctl_mutex);
> +	init_waitqueue_head(&u->wait);
> +	u->max_ready_num = 0;

The above zeroes out a bunch of known-to-already-be-zero things.

> +static int kevnet_user_mmap(struct file *file, struct vm_area_struct *vma)

The function name is mistyped.

This code doesn't have many comments, does it?  What are we mapping here,
and why would an application want to map it?

And what are the portability implications?  Does userspace need to know the
64-bitness of its kernel to be able to work out the alignment of things? 
If so, what happens if a later/different compiler aligns things
differently?

> +{
> +	size_t size = vma->vm_end - vma->vm_start, psize;
> +	int pnum = size/PAGE_SIZE, i;
> +	unsigned long start = vma->vm_start;
> +	struct kevent_user *u = file->private_data;
> +
> +	psize = ALIGN(KEVENT_MAX_EVENTS*sizeof(struct ukevent) + sizeof(unsigned int), PAGE_SIZE);
> +
> +	if (size + vma->vm_pgoff*PAGE_SIZE != psize)
> +		return -EINVAL;
> +
> +	if (vma->vm_flags & VM_WRITE)
> +		return -EPERM;
> +
> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +
> +	for (i=0; i<pnum; ++i) {
> +		if (remap_pfn_range(vma, start, virt_to_phys((void *)u->pring[i+vma->vm_pgoff]), PAGE_SIZE,
> +					vma->vm_page_prot))
> +			return -EAGAIN;
> +		start += PAGE_SIZE;
> +	}
> +
> +	return 0;
> +}

Is EAGAIN an appropriate return value?

If this function had a decent comment we could ask Hugh to review it.

> +#if 0
> +static inline unsigned int kevent_user_hash(struct ukevent *uk)
> +{
> +	unsigned int h = (uk->user[0] ^ uk->user[1]) ^ (uk->id.raw[0] ^ uk->id.raw[1]);
> +	
> +	h = (((h >> 16) & 0xffff) ^ (h & 0xffff)) & 0xffff;
> +	h = (((h >> 8) & 0xff) ^ (h & 0xff)) & KEVENT_HASH_MASK;
> +
> +	return h;
> +}
> +#else
> +static inline unsigned int kevent_user_hash(struct ukevent *uk)
> +{
> +	return jhash_1word(uk->id.raw[0], 0) & KEVENT_HASH_MASK;
> +}
> +#endif
> +
> +static void kevent_free_rcu(struct rcu_head *rcu)
> +{
> +	struct kevent *kevent = container_of(rcu, struct kevent, rcu_head);
> +	kmem_cache_free(kevent_cache, kevent);
> +}
> +
> +static void kevent_finish_user_complete(struct kevent *k, int deq)
> +{
> +	struct kevent_user *u = k->user;
> +	unsigned long flags;
> +
> +	if (deq)
> +		kevent_dequeue(k);
> +
> +	spin_lock_irqsave(&u->ready_lock, flags);
> +	if (k->ready_entry.next != LIST_POISON1) {
> +		list_del(&k->ready_entry);

list_del_rcu()?

> +		u->ready_num--;
> +	}
> +	spin_unlock_irqrestore(&u->ready_lock, flags);
> +
> +	kevent_user_put(u);
> +	call_rcu(&k->rcu_head, kevent_free_rcu);
> +}
> +
> +static void __kevent_finish_user(struct kevent *k, int deq)
> +{
> +	struct kevent_user *u = k->user;
> +
> +	list_del(&k->kevent_entry);
> +	u->kevent_num--;
> +	kevent_finish_user_complete(k, deq);
> +}

No locking needed?

It's hard to review uncommented code.  And the review is less useful if the
reviewer cannot determine what the developer was attempting to do.

> +/*
> + * Remove kevent from user's list of all events, 
> + * dequeue it from storage and decrease user's reference counter,
> + * since this kevent does not exist anymore. That is why it is freed here.
> + */

That's nice.

> +static void kevent_finish_user(struct kevent *k, int deq)
> +{
> +	struct kevent_user *u = k->user;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&u->kevent_lock, flags);
> +	list_del(&k->kevent_entry);

list_del_rcu()?

> +	u->kevent_num--;
> +	spin_unlock_irqrestore(&u->kevent_lock, flags);
> +	kevent_finish_user_complete(k, deq);
> +}
> +
> +/*
> + * Dequeue one entry from user's ready queue.
> + */
> +
> +static struct kevent *kqueue_dequeue_ready(struct kevent_user *u)
> +{
> +	unsigned long flags;
> +	struct kevent *k = NULL;
> +
> +	spin_lock_irqsave(&u->ready_lock, flags);
> +	if (u->ready_num && !list_empty(&u->ready_list)) {
> +		k = list_entry(u->ready_list.next, struct kevent, ready_entry);
> +		list_del(&k->ready_entry);
> +		u->ready_num--;
> +	}
> +	spin_unlock_irqrestore(&u->ready_lock, flags);
> +
> +	return k;
> +}
> +
> +static struct kevent *__kevent_search(struct list_head *head, struct ukevent *uk, 
> +		struct kevent_user *u)
> +{
> +	struct kevent *k;
> +	int found = 0;
> +	
> +	list_for_each_entry(k, head, kevent_entry) {
> +		spin_lock(&k->ulock);
> +		if (k->event.user[0] == uk->user[0] && k->event.user[1] == uk->user[1] &&
> +				k->event.id.raw[0] == uk->id.raw[0] && 
> +				k->event.id.raw[1] == uk->id.raw[1]) {
> +			found = 1;
> +			spin_unlock(&k->ulock);
> +			break;
> +		}
> +		spin_unlock(&k->ulock);
> +	}
> +
> +	return (found)?k:NULL;
> +}

Remove `found', do

	struct kevent *ret = NULL;

	...
		ret = k;
		break;
	...
	return ret;


> +static int kevent_modify(struct ukevent *uk, struct kevent_user *u)

<wonders what this function does>

> +{
> +	struct kevent *k;
> +	unsigned int hash = kevent_user_hash(uk);
> +	int err = -ENODEV;
> +	unsigned long flags;
> +	
> +	spin_lock_irqsave(&u->kevent_lock, flags);
> +	k = __kevent_search(&u->kevent_list[hash], uk, u);
> +	if (k) {
> +		spin_lock(&k->ulock);
> +		k->event.event = uk->event;
> +		k->event.req_flags = uk->req_flags;
> +		k->event.ret_flags = 0;
> +		spin_unlock(&k->ulock);
> +		kevent_requeue(k);
> +		err = 0;
> +	}
> +	spin_unlock_irqrestore(&u->kevent_lock, flags);
> +	
> +	return err;
> +}

ENODEV: "No such device".  Doesn't sound appropriate.

> +static int kevent_remove(struct ukevent *uk, struct kevent_user *u)
> +{
> +	int err = -ENODEV;
> +	struct kevent *k;
> +	unsigned int hash = kevent_user_hash(uk);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&u->kevent_lock, flags);
> +	k = __kevent_search(&u->kevent_list[hash], uk, u);
> +	if (k) {
> +		__kevent_finish_user(k, 1);
> +		err = 0;
> +	}
> +	spin_unlock_irqrestore(&u->kevent_lock, flags);
> +
> +	return err;
> +}
> +
> +/*
> + * No new entry can be added or removed from any list at this point.
> + * It is not permitted to call ->ioctl() and ->release() in parallel.
> + */
> +static int kevent_user_release(struct inode *inode, struct file *file)
> +{
> +	struct kevent_user *u = file->private_data;
> +	struct kevent *k, *n;
> +	int i;
> +
> +	for (i=0; i<KEVENT_HASH_MASK+1; ++i) {

ARRAY_SIZE

> +		list_for_each_entry_safe(k, n, &u->kevent_list[i], kevent_entry)
> +			kevent_finish_user(k, 1);
> +	}
> +
> +	kevent_user_put(u);
> +	file->private_data = NULL;
> +
> +	return 0;
> +}
> +
> +static struct ukevent *kevent_get_user(unsigned int num, void __user *arg)
> +{
> +	struct ukevent *ukev;
> +
> +	ukev = kmalloc(sizeof(struct ukevent) * num, GFP_KERNEL);
> +	if (!ukev)
> +		return NULL;
> +
> +	if (copy_from_user(arg, ukev, sizeof(struct ukevent) * num)) {
> +		kfree(ukev);
> +		return NULL;
> +	}
> +
> +	return ukev;
> +}

The copy_fom_user() args are reversed.

This is serious breakage and raises concerns about the amount of testing
which has been performed.

AFAICT there is no bounds checking on `num', so the user can force a
deliberate multiplication overflow and cause havoc here.

> +static int kevent_user_ctl_modify(struct kevent_user *u, unsigned int num, void __user *arg)
> +{
> +	int err = 0, i;
> +	struct ukevent uk;
> +
> +	mutex_lock(&u->ctl_mutex);
> +	
> +	if (num > KEVENT_MIN_BUFFS_ALLOC) {
> +		struct ukevent *ukev;
> +
> +		ukev = kevent_get_user(num, arg);
> +		if (ukev) {
> +			for (i=0; i<num; ++i) {
> +				if (kevent_modify(&ukev[i], u))
> +					ukev[i].ret_flags |= KEVENT_RET_BROKEN;
> +				ukev[i].ret_flags |= KEVENT_RET_DONE;
> +			}
> +			if (copy_to_user(arg, ukev, num*sizeof(struct ukevent)))
> +				err = -EINVAL;

EFAULT

> +			kfree(ukev);
> +			goto out;
> +		}
> +	}
> +
> +	for (i=0; i<num; ++i) {
> +		if (copy_from_user(&uk, arg, sizeof(struct ukevent))) {
> +			err = -EINVAL;

EFAULT

> +			break;
> +		}
> +
> +		if (kevent_modify(&uk, u))
> +			uk.ret_flags |= KEVENT_RET_BROKEN;
> +		uk.ret_flags |= KEVENT_RET_DONE;
> +
> +		if (copy_to_user(arg, &uk, sizeof(struct ukevent))) {
> +			err = -EINVAL;

EFAULT.

> +		if (copy_from_user(&uk, arg, sizeof(struct ukevent))) {
> +			err = -EINVAL;

EFAULT (all over the place).

> +static void kevent_user_enqueue(struct kevent_user *u, struct kevent *k)
> +{
> +	unsigned long flags;
> +	unsigned int hash = kevent_user_hash(&k->event);
> +
> +	spin_lock_irqsave(&u->kevent_lock, flags);
> +	list_add_tail(&k->kevent_entry, &u->kevent_list[hash]);
> +	u->kevent_num++;
> +	kevent_user_get(u);
> +	spin_unlock_irqrestore(&u->kevent_lock, flags);
> +}

kevent_user_get() can be moved outside the lock?

> +/*
> + * Copy all ukevents from userspace, allocate kevent for each one 
> + * and add them into appropriate kevent_storages, 
> + * e.g. sockets, inodes and so on...
> + * If something goes wrong, all events will be dequeued and 
> + * negative error will be returned. 
> + * On success number of finished events is returned and 
> + * Array of finished events (struct ukevent) will be placed behind 
> + * kevent_user_control structure. User must run through that array and check 
> + * ret_flags field of each ukevent structure to determine if it is fired or failed event.
> + */
> +static int kevent_user_ctl_add(struct kevent_user *u, unsigned int num, void __user *arg)
> +{
> +	int err, cerr = 0, knum = 0, rnum = 0, i;
> +	void __user *orig = arg;
> +	struct ukevent uk;
> +
> +	mutex_lock(&u->ctl_mutex);
> +
> +	err = -ENFILE;
> +	if (u->kevent_num + num >= KEVENT_MAX_EVENTS)

Can a malicious user force an arithmetic overflow here?

> +		goto out_remove;
> +
> +	if (num > KEVENT_MIN_BUFFS_ALLOC) {
> +		struct ukevent *ukev;
> +
> +		ukev = kevent_get_user(num, arg);
> +		if (ukev) {
> +			for (i=0; i<num; ++i) {
> +				err = kevent_user_add_ukevent(&ukev[i], u);
> +				if (err) {
> +					kevent_user_stat_increase_im(u);
> +					if (i != rnum)
> +						memcpy(&ukev[rnum], &ukev[i], sizeof(struct ukevent));
> +					rnum++;

What's happening here?  The games with `rnum' and comparing it with `i'??

Perhaps these are not the best-chosen identifiers..

> +/*
> + * In nonblocking mode it returns as many events as possible, but not more than @max_nr.
> + * In blocking mode it waits until timeout or if at least @min_nr events are ready.
> + */
> +static int kevent_user_wait(struct file *file, struct kevent_user *u, 
> +		unsigned int min_nr, unsigned int max_nr, unsigned int timeout, 
> +		void __user *buf)
> +{
> +	struct kevent *k;
> +	int cerr = 0, num = 0;
> +
> +	if (!(file->f_flags & O_NONBLOCK)) {
> +		wait_event_interruptible_timeout(u->wait, 
> +			u->ready_num >= min_nr, msecs_to_jiffies(timeout));
> +	}
> +	
> +	while (num < max_nr && ((k = kqueue_dequeue_ready(u)) != NULL)) {
> +		if (copy_to_user(buf + num*sizeof(struct ukevent), 
> +					&k->event, sizeof(struct ukevent))) {
> +			cerr = -EINVAL;
> +			break;
> +		}
> +
> +		/*
> +		 * If it is one-shot kevent, it has been removed already from
> +		 * origin's queue, so we can easily free it here.
> +		 */
> +		if (k->event.req_flags & KEVENT_REQ_ONESHOT)
> +			kevent_finish_user(k, 1);
> +		++num;
> +		kevent_user_stat_increase_wait(u);
> +	}
> +
> +	return (cerr)?cerr:num;
> +}

So if this returns an error, the user doesn't know how many events were
actually completed?   That doesn't seem good.

> +asmlinkage long sys_kevent_ctl(int fd, unsigned int cmd, unsigned int num, void __user *arg)

At some point Michael will want to be writing the manpages for things like
this.  He'll start out by reading the comment block, poor guy.

> +{
> +	int err = -EINVAL;
> +	struct file *file;
> +
> +	if (cmd == KEVENT_CTL_INIT)
> +		return kevent_ctl_init();
> +
> +	file = fget(fd);
> +	if (!file)
> +		return -ENODEV;
> +
> +	if (file->f_op != &kevent_user_fops)
> +		goto out_fput;
> +
> +	err = kevent_ctl_process(file, cmd, num, arg);
> +
> +out_fput:
> +	fput(file);
> +	return err;
> +}

