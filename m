Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWHBGkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWHBGkL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 02:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWHBGkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 02:40:11 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:33712 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750857AbWHBGkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 02:40:08 -0400
Date: Wed, 2 Aug 2006 10:39:18 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Zach Brown <zach.brown@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>,
       netdev and <netdev@vger.kernel.org>
Subject: Re: [take2 1/4] kevent: core files.
Message-ID: <20060802063918.GB6378@2ka.mipt.ru>
References: <11544248451203@2ka.mipt.ru> <44CFEA4B.3060200@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <44CFEA4B.3060200@oracle.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 02 Aug 2006 10:39:20 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 04:56:59PM -0700, Zach Brown (zach.brown@oracle.com) wrote:
> 
> OK, here's some of my reactions to the core part.

Thanks.

> > +#define KEVENT_SOCKET 		0
> > +#define KEVENT_INODE		1
> > +#define KEVENT_TIMER		2
> > +#define KEVENT_POLL		3
> > +#define KEVENT_NAIO		4
> > +#define KEVENT_AIO		5
> 
> I guess we can't really avoid some form of centralized list of the
> constants in the API if we're going for a flat constant namespace.
> It'll be irritating to manage this list over time, just like it's
> irritating to manage syscall numbers now.
> 
> > +/*
> > + * Socket/network asynchronous IO events.
> > + */
> > +#define	KEVENT_SOCKET_RECV	0x1
> > +#define	KEVENT_SOCKET_ACCEPT	0x2
> > +#define	KEVENT_SOCKET_SEND	0x4
> 
> I wonder if these shouldn't live in the subsystems instead of in kevent.h.

Yes it could, but it requires including those files in kevent.h, which
is exported to userspace, and it is not always possible to publish
included file there.

> > +/*
> > + * Poll events.
> > + */
> > +#define	KEVENT_POLL_POLLIN	0x0001
> > +#define	KEVENT_POLL_POLLPRI	0x0002
> > +#define	KEVENT_POLL_POLLOUT	0x0004
> > +#define	KEVENT_POLL_POLLERR	0x0008
> > +#define	KEVENT_POLL_POLLHUP	0x0010
> > +#define	KEVENT_POLL_POLLNVAL	0x0020
> > +
> > +#define	KEVENT_POLL_POLLRDNORM	0x0040
> > +#define	KEVENT_POLL_POLLRDBAND	0x0080
> > +#define	KEVENT_POLL_POLLWRNORM	0x0100
> > +#define	KEVENT_POLL_POLLWRBAND	0x0200
> > +#define	KEVENT_POLL_POLLMSG	0x0400
> > +#define	KEVENT_POLL_POLLREMOVE	0x1000
> 
> And couldn't we just use the existing poll bit definitions for this?

asm/poll.h I expect.
linux/poll.h is too heavy or not?

> > +struct kevent_id
> > +{
> > +	__u32		raw[2];
> > +};
> 
> Why not a simple u64?  Users can play games with packing it into other
> types if they want.
> 
> > +		__u32		user[2];		/* User's data. It is not used, just copied to/from user. */
> > +		void		*ptr;
> > +	};
> 
> Again just a u64 seems like it would be simpler.  userspace library
> wrappers can help massage it, but the kernel is just treating it as an
> opaque data blob.

u64 is not aligned, so I prefer to use u32 as much as possible.

> > +};
> > +
> > +#define	KEVENT_CTL_ADD 		0
> > +#define	KEVENT_CTL_REMOVE	1
> > +#define	KEVENT_CTL_MODIFY	2
> > +#define	KEVENT_CTL_INIT		3
> > +
> > +struct kevent_user_control
> > +{
> > +	unsigned int		cmd;			/* Control command, e.g. KEVENT_ADD, KEVENT_REMOVE... */
> > +	unsigned int		num;			/* Number of ukevents this strucutre controls. */
> > +	unsigned int		timeout;		/* Timeout in milliseconds waiting for "num" events to become ready. */
> > +};
> 
> Even if we only have one syscall with a cmd multiplexer (which I'm not
> thrilled with), we should at least make these arguments explicit in the
> system call.  It's weird to hide them in a struct.  We could also think
> about making them u32 or u64 so that we don't need compat wrappers, but
> maybe that's overkill.

Ok.

> Also, can we please use a struct timespec for the timeout?  Then the
> kernel will have the luxury of using whatever mechanism it wants to
> satisfy the user's precision desires.  Just like sys_nanosleep() uses
> timespec and so can be implemented with hrtimers.

It has variable size, I strongly against such things between kernel and
userspace.

> > +struct kevent
> > +{
> 
> (trivial nit, "struct kevent {" is the preferred form.)

Ok.

> > +	struct ukevent		event;
> > +	spinlock_t		lock;			/* This lock protects ukevent manipulations, e.g. ret_flags changes. */
> 
> 
> It'd be great if these struct members could get a prefix (ala: inode ->
> i_, socket -> sk_) so that it's less painful getting tags helpers to
> look up instances for us.  Asking for 'lock' is hilarious.

But it requires much less typing :)
Will update.

> > +struct kevent_list
> > +{
> > +	struct list_head	kevent_list;		/* List of all kevents. */
> > +	spinlock_t 		kevent_lock;		/* Protects all manipulations with queue of kevents. */
> > +};
> > +
> > +struct kevent_user
> > +{
> > +	struct kevent_list	kqueue[KEVENT_HASH_MASK+1];
> 
> Hmm.  I think the current preference is not to have a lock per bucket.
> It doesn't scale nearly as well as it seems like it should as the cache
> footprint is higher and as cacheline contention hits as there are
> multiple buckets per cacheline.  For now I'd simplify the hash into a
> single lock and an array of struct hlist_head.  In the future it could
> be another user of some kind of relatively-generic hash implementation
> based on rcu that has been talked about for a while.

Well, it scales better than one lock per the whole queue, but we can
see how it looks with one lock.

I used RCU hash table in kevents, but it scales very bad for things like
inode removal, which can not be done (at least when kevent was initially
created) in rcu callback context, so it required sycnhronize)rcu() which
broke latencies to unacceptible level.

> > +#define KEVENT_MAX_REQUESTS		PAGE_SIZE/sizeof(struct kevent)
> 
> This is unused?

As David mentioned, I expect it to be base for mapped ring, although it
should be PAGE_SIZE/sizeof(struct ukevent). I will remove for now.

> > +#define list_for_each_entry_reverse_safe(pos, n, head, member)		\
> > +	for (pos = list_entry((head)->prev, typeof(*pos), member),	\
> > +		n = list_entry(pos->member.prev, typeof(*pos), member);	\
> > +	     prefetch(pos->member.prev), &pos->member != (head); 	\
> > +	     pos = n, n = list_entry(pos->member.prev, typeof(*pos), member))
> 
> If anyone was calling this they could use
> list_for_each_entry_safe_reverse() in list.h but nothing is calling it?
>  Either way, it should be removed :).

It is from the past life, I will remove it.

> > +#define sock_async(__sk)	0
> 
> It's a minor complaint, but these kinds of ifdefs that drop arguments
> can cause unused argument warnings if they're the only user of the given
> argument.  It'd be nicer to do something like ({ (void)_sk; 0; }) .

Ok.

> > +struct kevent_storage
> > +{
> > +	void			*origin;		/* Originator's pointer, e.g. struct sock or struct file. Can be NULL. */
> 
> Do we really need this pointer?  When the kevent_storage is embedded in
> the origin, like struct inode in your patch sets, you can use
> container_of() to get back to the inode.  For sources that aren't built
> like that, like the timer_list, you could introduce a parent structure
> that has the timer_list and the _storage embedded in it.

Well, the idea was to be able not only to embed kevent_storage, but to
have a pointer to it, so some users can allocate it as addon.
If we strongly decide, that it will not used that way, this pointer can
be removed.

> > +obj-$(CONFIG_KEVENT_SOCKET) += kevent_socket.o
> > +obj-$(CONFIG_KEVENT_INODE) += kevent_inode.o
> > +obj-$(CONFIG_KEVENT_TIMER) += kevent_timer.o
> > +obj-$(CONFIG_KEVENT_POLL) += kevent_poll.o
> > +obj-$(CONFIG_KEVENT_NAIO) += kevent_naio.o
> > +obj-$(CONFIG_KEVENT_AIO) += kevent_aio.o
> 
> I suspect that we won't want this configurable if it gets merged, but I
> could be wrong and don't feel strongly about it.

For example epoll is configurable for embedded systems, so it might be a
good ide to be possible to remove something that will not be 100% in
use.

> > +	switch (k->event.type) {
> > +		case KEVENT_NAIO:
> > +			err = kevent_init_naio(k);
> > +			break;
> > +		case KEVENT_SOCKET:
> > +			err = kevent_init_socket(k);
> > +			break;
> 
> I wonder if it wouldn't be less noisy to have something like
> 
> struct kevent_callbacks {
> 	kevent_callback_t	callback, enqueue, dequeue;
> } kev_callbacks[] = {
> 	[ KEVENT_NAIO ] = &kevent_naio_callbacks,
> };
> 
> 	k->callbacks = kev_callbacks[k->event.type];
> 
> Then you'd also have one pointer per kevent instead of three.

Ok, I will create such table.

> > +void kevent_storage_dequeue(struct kevent_storage *st, struct kevent *k)
> > +{
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&st->lock, flags);
> > +	if (k->storage_entry.next != LIST_POISON1) {
> > +		list_del(&k->storage_entry);
> > +		st->qlen--;
> > +	}
> 
> Is this relying on list_del() having set LIST_POISON1?  If so, please
> use list_del_init() and list_empty() instead.

Yes, POISON is a flag, that keven is or is not in the appropriate list.
It could be done by wasting some bits, but I decided to not do it since
list poison is always there.

> > +static void __kevent_requeue(struct kevent *k, u32 event)
> > +{
> 
> A few things here.  First, the event argument isn't used?

Tss, it was used for printk when it was there :)

> > +	err = k->callback(k);
> 
> This is being called while holding both the kevent_list->kevent_lock and
> the k->st->lock.  So ->callback is being called with locks held and
> interrupts blocked which is going to greatly restrict what can be done
> there.  If that's what we want to do we should document the heck out of it.

No, interrupts and bh a not blocked there, when it is called from
origin's state machine.
locking is following:

storage_lock (interrupts and bh are in the state which was in a origin's
state machine, for example socket code has bh disabled, but block layer
has interrupts disabled here)
check if at aleast one event in storage queue is requested for 
	that event
call callback
It is possible to mark event as broken or done in callback, so we need
to check event's flags. It does not actually require irqsave lock, since
the same kevent can not live in several storages.
We hold a lock to protect against userspace which can change that flags.
If it is marked as ready we queue that event into ready list under
ready list lock. That requires irq disabling, since that queue can be
accessed from any context.
So there are maximum 2 embedded locks.

When userspace modifies kevent, it must protect against access from the
origin, so it disables interrupt.

> > +	spin_lock_irqsave(&k->lock, flags);
> 
> > +		spin_lock_irqsave(&k->user->ready_lock, flags);
> 
> It also now creates lock nesting three deep, which starts to feel
> uncomfortable.  Have you run this under lockdep?  It might be fine, but
> this kind of depth means those of us auditing have to stare very very
> closely at the locks that paths acquire.  The fewer locks that are held
> at a time, the better.

Above sequence is only possible when userspace modifies kevent which was
not fired yet, and that modification ends up in immediat fire.
When it is called from origin's state machine irqs are disabled only
when kevent is moved into the ready queue, since that queue can be
accessed from different CPU or from irq on the same one.

> > +void kevent_storage_ready(struct kevent_storage *st, 
> > +		kevent_callback_t ready_callback, u32 event)
> 
> Hmm, the only caller that provides a callback is using it to call
> kevent_break() on each event.  Could that not be done by the helper
> itself if the caller provides the right event?  Is there some more
> complicated use of the callback on the horizon?  Not a big deal, but
> there are those who prefer to avoid code paths that nest lots of
> callbacks in sequence.

kevent users can call any callback they want here, for example it can
mark all events as ready, not only broken, or all mark as one-shot if
origin is going to be removed and so on.

> > +	struct kevent *k, *n;
> 
> In general, it's nicer to user longer names please.  You'll notice
> throughout the kernel that we use things like dentry, inode, page, sock,
> etc, instead of d, i, p, and s.

But we have 'sk' :)

> > +struct kevent *kevent_alloc(gfp_t mask)
> > +{
> > +	return kmem_cache_alloc(kevent_cache, mask);
> > +}
> > +
> > +void kevent_free(struct kevent *k)
> > +{
> > +	kmem_cache_free(kevent_cache, k);
> > +}
> 
> We probably don't need these wrappers, just call the kmem_cache_*
> functions directly.

Ok.

> > +static unsigned int kevent_user_poll(struct file *file, struct poll_table_struct *wait)
> > +{
> > +	struct kevent_user *u = file->private_data;
> > +	unsigned int mask;
> > +	
> > +	poll_wait(file, &u->wait, wait);
> > +	mask = 0;
> > +
> > +	if (u->ready_num)
> > +		mask |= POLLIN | POLLRDNORM;
> 
> Shouldn't this be testing ready_num while holding the ready_lock?

Integer read is atomic, so no need to wrap a lock around it.

> > +	for (i=0; i<KEVENT_HASH_MASK+1; ++i) {
> > +		INIT_LIST_HEAD(&u->kqueue[i].kevent_list);
> > +		spin_lock_init(&u->kqueue[i].kevent_lock);
> > +	}
> 
> ARRAY_SIZE(u->kqueue) should probably be used instead of trying to keep
> (KEVENT_HASH_MASK + 1) in sync with the kqueue definition.

Ok.

> > +static inline void kevent_user_put(struct kevent_user *u)
> > +{
> > +	if (atomic_dec_and_test(&u->refcnt)) {
> > +#ifdef CONFIG_KEVENT_USER_STAT
> > +		printk("%s: u=%p, wait=%lu, immediately=%lu, total=%lu.\n", 
> > +				__func__, u, u->wait_num, u->im_num, u->total);
> > +#endif
> 
> printk() seems like a poor choice if this is meant to be a more formal
> functionality.  If it's just a debugging aid then pr_debug() and DEBUG
> might be nicer.

Yes, I will wrap it into some nice function.

> > +/*
> > + * Remove kevent from user's list of all events, 
> > + * dequeue it from storage and decrease user's reference counter,
> > + * since this kevent does not exist anymore. That is why it is freed here.
> > + */
> > +static void kevent_finish_user(struct kevent *k, int lock, int deq)
> 
> How about providing locked and unlocked prototypes instead of an
> argument that says whether to lock or not?  You know, the usual:
> 
> void __thingy() {
> 	doit();
> }
> 
> void thingy() {
> 	lock();
> 	__thingy();
> 	unlock();
> }

Ok.

> > +		list_del(&k->kevent_entry);
> > +		u->kevent_num--;
> 
> I wonder if these shouldn't get micro helpers that then have BUG_ON()s
> to test bad conditions.  like BUG_ON(list_empty() && kevent_num), that
> sort of thing.

Well, if list is empty that means that kevent_entry has a broken links,
which will will fire on list_del.
And having a lot of BUGs is not a good sign.
But I do not care much actually about it, let's have couple...

> > +static struct kevent *__kqueue_dequeue_one_ready(struct list_head *q, 
> > +		unsigned int *qlen)
> > +{
> > +	struct kevent *k = NULL;
> > +	unsigned int len = *qlen;
> > +	
> > +	if (len && !list_empty(q)) {
> > +		k = list_entry(q->next, struct kevent, ready_entry);
> > +		list_del(&k->ready_entry);
> > +		*qlen = len - 1;
> > +	}
> > +	
> > +	return k;
> > +}
> 
> Hmm, this is only called in one place?  I'd either make the list_head
> and lock into one struct (like struct sk_buff_head) or hoist the code
> into the caller.

No problem.

> > +	list_for_each_entry(k, &l->kevent_list, kevent_entry) {
> > +		spin_lock(&k->lock);
> > +		if (k->event.user[0] == uk->user[0] && k->event.user[1] == uk->user[1] &&
> > +				k->event.id.raw[0] == uk->id.raw[0] && 
> > +				k->event.id.raw[1] == uk->id.raw[1]) {
> > +			found = 1;
> > +			spin_unlock(&k->lock);
> 
> Ahhh, it's fs/aio.c:lookup_kiocb() all over again :) :).  I guess we'll
> get this in a hash, or something, before merging.

Please note that it is searching inside hash bucket :)

> > +	mutex_lock(&u->ctl_mutex);
> > +
> > +	for (i=0; i<ctl->num; ++i) {
> > +		if (copy_from_user(&uk, arg, sizeof(struct ukevent))) {
> > +			err = -EINVAL;
> > +			break;
> > +		}
> > +
> > +		if (kevent_modify(&uk, u))
> 
> So there are a bunch of these.  The internal list and kevents and such
> have their own locks.  What are the mutexes serializing?  Why can't we
> rely on the finger-grained object locking to make sure that concurrent
> operations behave resonably?  One can imagine wanting to modify two
> kevents in a context that have nothing to do with each other and not
> wanting to serialize them at the context.

Each lock is hosted inside a bucket, but kevent itself is protected by
that mutex. lock is being held for relatively small operations, but
mutex protects against the whole sequence of them (select bucket,
search, hash and so on).

> > +int kevent_user_add_ukevent(struct ukevent *uk, struct kevent_user *u)
> > +{
> > +	struct kevent *k;
> > +	int err;
> > +
> > +	k = kevent_alloc(GFP_KERNEL);
> > +	if (!k) {
> > +		err = -ENOMEM;
> > +		goto err_out_exit;
> > +	}
> > +
> > +	memcpy(&k->event, uk, sizeof(struct ukevent));
> 
> This path is copying the ukevents twice.  First from userspace back up
> in kevent_user_ctl_add() and then here into the kevent.  We should
> rework things a bit so that we only copy it once.

struct ukevent here can be allocated in stack and filled by naio or aio.
I would not allow them to allocate and link kevents by itself, so I
created this function.

> > +#ifdef CONFIG_KEVENT_USER_STAT
> > +	u->total++;
> > +#endif
> 
> FWIW, this could hide behind some kevent_user_stat_inc(u) that could be
> ifdefed away in the header.

Ok.

> > +	{
> > +		unsigned long flags;
> > +		unsigned int hash = kevent_user_hash(&k->event);
> > +		struct kevent_list *l = &u->kqueue[hash];
> > +		
> > +		spin_lock_irqsave(&l->kevent_lock, flags);
> > +		list_add_tail(&k->kevent_entry, &l->kevent_list);
> > +		u->kevent_num++;
> > +		kevent_user_get(u);
> > +		spin_unlock_irqrestore(&l->kevent_lock, flags);
> > +	}
> 
> Hmm, please don't indent things like this.  Add a little helper function
> or hoist the locals up into the main function and lose the braces.

Ok.

> > +static int kevent_user_ctl_add(struct kevent_user *u, 
> > +		struct kevent_user_control *ctl, void __user *arg)
> > +{
> 
> > +	orig = arg;
> > +	ctl_addr = arg - sizeof(struct kevent_user_control);
> 
> Ugh.  This is more awkwardness that comes from packing the system call
> arguments in neighbouring structs behind a void *.  We should really
> have explicit typed args.

kevent_user_control will be replaced with explicit syscall parameters,
so it will be removed.

> > +	for (i=0; i<ctl->num; ++i) {
> > +		if (copy_from_user(&uk, arg, sizeof(struct ukevent))) {
> > +			cerr = -EINVAL;
> > +			break;
> > +		}
> > +		arg += sizeof(struct ukevent);
> > +
> > +		err = kevent_user_add_ukevent(&uk, u);
> 
> There are some users that will want to add thousands of events at a
> time.  (Like, say, a certain database writing back lots of cached
> dirtied database blocks.)  I wonder if we should arrange this so that we
> can get some batching done and reduce the amount of lock traffic per
> event added.

Well, it is possible with additional GPF_KERNEL allocation of the buffer, 
do we want that cost?

> > +/*
> > + * In nonblocking mode it returns as many events as possible, but not more than @max_nr.
> > + * In blocking mode it waits until timeout or if at least @min_nr events are ready,
> > + * if timeout is zero, than it waits no more than 1 second or if at least one event
> > + * is ready.
> 
> That's odd.  Why not have a timeout of 0 mean a timeout of 0?  Where did
> 1 second come from? :)  It seems pretty crazy to require programmers to
> check that their timer math didn't just end up at 0 and magically tell
> the kernel to wait a second.

Zero timeout means that we want as much as we have, but not less than one kevent.
So we sleep one second for them :)
I will use min_nr for that, i.e. if it is zero, than it meanst at least
onee and less than max_nr.

> > +	mutex_lock(&u->ctl_mutex);
> > +	while (num < max_nr && ((k = kqueue_dequeue_ready(u)) != NULL)) {
> > +		if (copy_to_user(buf + num*sizeof(struct ukevent), 
> > +					&k->event, sizeof(struct ukevent))) {
> > +			cerr = -EINVAL;
> > +			break;
> > +		}
> 
> Again, this a great opportunity to copy more than one at a time with
> some refactoring.

If we are going to remove ability to get events by ssycall it will be
pure memcpy without additional overhead.

> > +asmlinkage long sys_kevent_ctl(int fd, void __user *arg)
> > +{
> > +	int err = -EINVAL, fput_needed;
> > +	struct kevent_user_control ctl;
> > +	struct file *file;
> > +
> > +	if (copy_from_user(&ctl, arg, sizeof(struct kevent_user_control)))
> > +		return -EINVAL;
> > +
> > +	if (ctl.cmd == KEVENT_CTL_INIT)
> > +		return kevent_ctl_init();
> 
> Hmm.  So we can get one of these fds both by opening the device file or
> by calling _CTL_INIT (which then magically ignores the fd argument?).
> That seems confusing.

So we want additional syscall? :)

> Anyway, that's enough for now.  I hope this helps.

Thanks Zach.

> - z

-- 
	Evgeniy Polyakov
