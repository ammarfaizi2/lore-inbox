Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWHJHTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWHJHTM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 03:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWHJHTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 03:19:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49319 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751381AbWHJHTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 03:19:09 -0400
Date: Thu, 10 Aug 2006 00:18:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: Re: [take6 1/3] kevent: Core files.
Message-Id: <20060810001844.ff5e7429.akpm@osdl.org>
In-Reply-To: <20060810061433.GA4689@2ka.mipt.ru>
References: <11551105592821@2ka.mipt.ru>
	<11551105602734@2ka.mipt.ru>
	<20060809152127.481fb346.akpm@osdl.org>
	<20060810061433.GA4689@2ka.mipt.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 10:14:33 +0400
Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:

> > > +	union {
> > > +		__u32		user[2];		/* User's data. It is not used, just copied to/from user. */
> > > +		void		*ptr;
> > > +	};
> > > +};
> > 
> > What is this union for?
> > 
> > `ptr' needs a __user tag, does it not?
> 
> Not, it is never touched by kernel.

hrm, if you say so.

> > > +/*
> > > + * Must be called before event is going to be added into some origin's queue.
> > > + * Initializes ->enqueue(), ->dequeue() and ->callback() callbacks.
> > > + * If failed, kevent should not be used or kevent_enqueue() will fail to add
> > > + * this kevent into origin's queue with setting
> > > + * KEVENT_RET_BROKEN flag in kevent->event.ret_flags.
> > > + */
> > > +int kevent_init(struct kevent *k)
> > > +{
> > > +	spin_lock_init(&k->ulock);
> > > +	k->kevent_entry.next = LIST_POISON1;
> > > +	k->storage_entry.prev = LIST_POISON2;
> > > +	k->ready_entry.next = LIST_POISON1;
> > 
> > Nope ;)
> 
> I use pointer checks to determine if entry is in the list or not, why it
> is frowned upon here?
> Please do not say about poisoning which takes a lot of cpu cycles to get
> new cachelines and so on - everything in that entry is in the cache,
> since entry was added/deleted/accessed through list walk macro.

"poisoning which takes a lot of cpu cycles".  So there ;)

I assure you, that poisoning code might disappear at any time.

If you want to be able to determine whether a list_head has been detached
you can detach it with list_del_init() and then use list_empty() on it.

> > > +}
> > > +
> > > +late_initcall(kevent_sys_init);
> > 
> > Why is it late_initcall?  (A comment is needed)
> 
> Why not?

Why?

There must have been some reason for having made this a late_initcall() and
that reason is 100% concealed from the reader of this code.

IOW, it needs a comment.

> > > +static inline void kevent_user_ring_set(struct kevent_user *u, unsigned int num)
> > > +{
> > > +	unsigned int *idx;
> > > +	
> > > +	idx = (unsigned int *)u->pring[0];
> > 
> > This is a bit ugly.
> 
> I specially use first 4 bytes in the first page to store index there,
> since it must be accessed from userspace and kernelspace.

Sure, but the C language is the preferred way in which we communicate and
calcuate pointer offsets.

> > > +	idx[0] = num;
> > > +}
> > > +
> > > +/*
> > > + * Note that kevents does not exactly fill the page (each ukevent is 40 bytes),
> > > + * so we reuse 4 bytes at the begining of the first page to store index.
> > > + * Take that into account if you want to change size of struct ukevent.
> > > + */
> > > +#define KEVENTS_ON_PAGE (PAGE_SIZE/sizeof(struct ukevent))
> > 
> > How about doing
> > 
> > 	struct ukevent_ring {
> > 		unsigned int index;
> > 		struct ukevent[0];
> > 	}
> > 
> > and removing all those nasty typeasting and offsetting games?
> > 
> > In fact you can even do
> > 
> > 	struct ukevent_ring {
> > 		struct ukevent[(PAGE_SIZE - sizeof(unsigned int)) /
> > 				sizeof(struct ukevent)];
> > 		unsigned int index;
> > 	};
> > 
> > if you're careful ;)
> 
> Ring takes more than one page, so it will be 
> struct ukevent_ring_0 and struct ukevent_ring_other.
> Does it really needed?
> Not a big problem, if you do thing it worse it.

Well, I've given a couple of prototype-style suggestions.  Please take a
look, see if all this open-coded offsetting magic can be done by the
compiler in some reliable and readable fashion.  It might not work out, but
I suspect it will.

> > > +	u->pring = kmalloc(pnum * sizeof(unsigned long), GFP_KERNEL);
> > > +	if (!u->pring)
> > > +		return -ENOMEM;
> > > +
> > > +	for (i=0; i<pnum; ++i) {
> > > +		u->pring[i] = __get_free_page(GFP_KERNEL);
> > > +		if (!u->pring)
> > 
> > bug: this is testing the wrong thing.
> 
> HOw come?

Take a closer look ;)

> __get_free_page() can return 0 if page was not allocated.

And that 0 is copied to u->pring[0], not to u->pring.

> > The function name is mistyped.

Did you miss an "OK"?  It needs s/kevnet_user_mmap/kevent_user_mmap/g

> > This code doesn't have many comments, does it?  What are we mapping here,
> > and why would an application want to map it?
> 
> That code waits comments from people who requested it.
> It is ring of the ready events, which can be read by userspace instead
> of calling syscall, so syscall just becomes "wait until there is a
> place" or something like that.

hm.  Well, please fully comment code prior to sending it out for review.  I
do go on about this, but trust me, it makes the review much more effective.

Afaict this mmap function gives a user a free way of getting pinned memory. 
What is the upper bound on the amount of memory which a user can thus
obtain?

> > > +static int kevent_modify(struct ukevent *uk, struct kevent_user *u)
> > 
> > <wonders what this function does>
> 
> Let me guess... It modifies kevent? :)
> I will add comments.
> 
> > > +{
> > > +	struct kevent *k;
> > > +	unsigned int hash = kevent_user_hash(uk);
> > > +	int err = -ENODEV;
> > > +	unsigned long flags;
> > > +	
> > > +	spin_lock_irqsave(&u->kevent_lock, flags);
> > > +	k = __kevent_search(&u->kevent_list[hash], uk, u);
> > > +	if (k) {
> > > +		spin_lock(&k->ulock);
> > > +		k->event.event = uk->event;
> > > +		k->event.req_flags = uk->req_flags;
> > > +		k->event.ret_flags = 0;
> > > +		spin_unlock(&k->ulock);
> > > +		kevent_requeue(k);
> > > +		err = 0;
> > > +	}
> > > +	spin_unlock_irqrestore(&u->kevent_lock, flags);
> > > +	
> > > +	return err;
> > > +}
> > 
> > ENODEV: "No such device".  Doesn't sound appropriate.
> 
> ENOKEVENT? I expect ENODEV means "there is no requested thing".

yes, it is hard to map standard errnos onto new and complex non-standard
features.

I don't have a good answer to this, sorry.

Perhaps we should do

#define EPER_SYSCALL_BASE 0x10000

and then each syscall is free to implement new, syscall-specific errnos
starting at this base.  But that might be a stupid idea - I don't know. 
I'm sure the implementor of strerror() would think so ;)

> > 
> > EFAULT (all over the place).
> 
> Ok, I will return EFAULT when copy*user fails.

If that makes sense, fine.  Sometimes it makes sense to return the number
of bytes transferred up to the point of the fault.  Please have a careful
think and decide which behaviour is best in each of these cases.

> > > +	int err, cerr = 0, knum = 0, rnum = 0, i;
> > > +	void __user *orig = arg;
> > > +	struct ukevent uk;
> > > +
> > > +	mutex_lock(&u->ctl_mutex);
> > > +
> > > +	err = -ENFILE;
> > > +	if (u->kevent_num + num >= KEVENT_MAX_EVENTS)
> > 
> > Can a malicious user force an arithmetic overflow here?
> 
> All numbers here are unsigned and are compared against 4096.

Are they?  I only see a comparison of a _sum_ against KEVENT_MAX_EVENTS. 
So if the user passes 0x0800,0xfffffff0, for example?

> So, answer is no.
> 
> > > +		goto out_remove;
> > > +
> > > +	if (num > KEVENT_MIN_BUFFS_ALLOC) {
> > > +		struct ukevent *ukev;
> > > +
> > > +		ukev = kevent_get_user(num, arg);
> > > +		if (ukev) {
> > > +			for (i=0; i<num; ++i) {
> > > +				err = kevent_user_add_ukevent(&ukev[i], u);
> > > +				if (err) {
> > > +					kevent_user_stat_increase_im(u);
> > > +					if (i != rnum)
> > > +						memcpy(&ukev[rnum], &ukev[i], sizeof(struct ukevent));
> > > +					rnum++;
> > 
> > What's happening here?  The games with `rnum' and comparing it with `i'??
> > 
> > Perhaps these are not the best-chosen identifiers..
> 
> When kevent is ready immediately it is copied into the same buffer into
> previous (rnum ready num) position. kevent at "rpos" was not ready
> immediately (otherwise it would be copied and rnum increased) and thus
> it is copied into the queue and can be overwritten here.

If you say so ;)

Please bear in mind that Michael Kerrisk <mtk-manpages@gmx.net> will want
to be writing manpages for all this stuff.

And I must say that Michael repeatedly and correctly dragged me across the
coals for something as simple and stupid as sys_sync_file_range().  Based
on that experience, I wouldn't consider a new syscall like this to be
settled until Michael has fully understood it.  And I suspect he doesn't
fully understand it until he has fully documented it.

> > > +/*
> > > + * In nonblocking mode it returns as many events as possible, but not more than @max_nr.
> > > + * In blocking mode it waits until timeout or if at least @min_nr events are ready.
> > > + */
> > > +static int kevent_user_wait(struct file *file, struct kevent_user *u, 
> > > +		unsigned int min_nr, unsigned int max_nr, unsigned int timeout, 
> > > +		void __user *buf)
> > > +{
> > > +	struct kevent *k;
> > > +	int cerr = 0, num = 0;
> > > +
> > > +	if (!(file->f_flags & O_NONBLOCK)) {
> > > +		wait_event_interruptible_timeout(u->wait, 
> > > +			u->ready_num >= min_nr, msecs_to_jiffies(timeout));
> > > +	}
> > > +	
> > > +	while (num < max_nr && ((k = kqueue_dequeue_ready(u)) != NULL)) {
> > > +		if (copy_to_user(buf + num*sizeof(struct ukevent), 
> > > +					&k->event, sizeof(struct ukevent))) {
> > > +			cerr = -EINVAL;
> > > +			break;
> > > +		}
> > > +
> > > +		/*
> > > +		 * If it is one-shot kevent, it has been removed already from
> > > +		 * origin's queue, so we can easily free it here.
> > > +		 */
> > > +		if (k->event.req_flags & KEVENT_REQ_ONESHOT)
> > > +			kevent_finish_user(k, 1);
> > > +		++num;
> > > +		kevent_user_stat_increase_wait(u);
> > > +	}
> > > +
> > > +	return (cerr)?cerr:num;
> > > +}
> > 
> > So if this returns an error, the user doesn't know how many events were
> > actually completed?   That doesn't seem good.
> 
> What is the alternative?
> read() work the same way - either error or number of bytes read.

No.  If read() hits an IO error or EFAULT partway through, read() will
return the number-of-bytes-trasferred.  read() will only return a -ve
errno if it transferred zero bytes.  This way, there is no lost
information.

However kevent_user_wait() will return a -ve errno even if it has reaped
some events.  That's lost information and this might make it hard for a
robust userspace client to implement error recovery?

> So let me quote your first words about kevent:
> 
> > Summary:
> > 
> > - has serious bugs which indicate that much better testing is needed.
> > 
> > - All -EFOO return values need to be reviewed for appropriateness
> > 
> > - needs much better commenting before I can do more than a local-level review.
> 
> As far as I can see there are no serious bugs except absence of two
> checks for and typo in function order, which abviously will be fixed.

Thus far I have found at least two bugs in this patchset which provide at
least a local DoS and possibly a privilege escalation (aka a roothole) to
local users.  We hit a similar one in the epoll() implementation a while
back.

This is serious stuff.  So experience tells us to be fanatical in the
checking of incoming syscall args.  Check all the arguments to death for
correct values.  Look out for overflows in additions and multiplications. 
Look out for opportunities for excessive resource consumption. 
Exhaustively test your new syscalls with many combinations of values when
the kernel is in various states.

> All EFOO will be changed according to comments and better comments will
> be added.

Thanks.
