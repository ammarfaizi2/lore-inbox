Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWIFOEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWIFOEj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 10:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWIFOEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 10:04:39 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:37822 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751087AbWIFOEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 10:04:37 -0400
Date: Wed, 6 Sep 2006 18:03:32 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Chase Venters <chase.venters@clientec.com>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Johann Borck <johann.borck@densedata.com>
Subject: Re: [take16 1/4] kevent: Core files.
Message-ID: <20060906140330.GA24057@2ka.mipt.ru>
References: <1157543723488@2ka.mipt.ru> <Pine.LNX.4.64.0609060824090.18512@turbotaz.ourhouse>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609060824090.18512@turbotaz.ourhouse>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 06 Sep 2006 18:03:36 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 08:40:21AM -0500, Chase Venters (chase.venters@clientec.com) wrote:
> Evgeniy,
> 	Sorry about the radio silence later. Some reviewer commentary 
> follows.


> >+struct kevent
> >+{
> >+	/* Used for kevent freeing.*/
> >+	struct rcu_head		rcu_head;
> >+	struct ukevent		event;
> >+	/* This lock protects ukevent manipulations, e.g. ret_flags changes. 
> >*/
> >+	spinlock_t		ulock;
> >+
> >+	/* Entry of user's queue. */
> >+	struct list_head	kevent_entry;
> >+	/* Entry of origin's queue. */
> >+	struct list_head	storage_entry;
> >+	/* Entry of user's ready. */
> >+	struct list_head	ready_entry;
> >+
> >+	u32			flags;
> >+
> >+	/* User who requested this kevent. */
> >+	struct kevent_user	*user;
> >+	/* Kevent container. */
> >+	struct kevent_storage	*st;
> >+
> >+	struct kevent_callbacks	callbacks;
> >+
> >+	/* Private data for different storages.
> >+	 * poll()/select storage has a list of wait_queue_t containers
> >+	 * for each ->poll() { poll_wait()' } here.
> >+	 */
> >+	void			*priv;
> >+};
> >+
> >+#define KEVENT_HASH_MASK	0xff
> >+
> >+struct kevent_user
> >+{
> 
> These structure names get a little dicey (kevent, kevent_user, ukevent, 
> mukevent)... might there be slightly different names that could be 
> selected to better distinguish the purpose of each?

Like what?
ukevent means userspace_kevent, but ukevent is much smaller.
mukevent is mapped userspace kevent, mukevent is again much smaller.

> >+	struct list_head	kevent_list[KEVENT_HASH_MASK+1];
> >+	spinlock_t		kevent_lock;
> >+	/* Number of queued kevents. */
> >+	unsigned int		kevent_num;
> >+
> >+	/* List of ready kevents. */
> >+	struct list_head	ready_list;
> >+	/* Number of ready kevents. */
> >+	unsigned int		ready_num;
> >+	/* Protects all manipulations with ready queue. */
> >+	spinlock_t 		ready_lock;
> >+
> >+	/* Protects against simultaneous kevent_user control manipulations. 
> >*/
> >+	struct mutex		ctl_mutex;
> >+	/* Wait until some events are ready. */
> >+	wait_queue_head_t	wait;
> >+
> >+	/* Reference counter, increased for each new kevent. */
> >+	atomic_t		refcnt;
> >+
> >+	unsigned int		pages_in_use;
> >+	/* Array of pages forming mapped ring buffer */
> >+	struct kevent_mring	**pring;
> >+
> >+#ifdef CONFIG_KEVENT_USER_STAT
> >+	unsigned long		im_num;
> >+	unsigned long		wait_num;
> >+	unsigned long		total;
> >+#endif
> >+};
> >+#define KEVENT_MAX_EVENTS	4096
> >+
> 
> This limit governs how many simultaneous kevents you can be waiting on / 
> for at once, correct? Would it be possible to drop the hard limit and 
> limit instead, say, the maximum number of kevents you can have pending in 
> the mmap ring-buffer? After the number is exceeded, additional events 
> could get dropped, or some magic number could be put in the 
> kevent_mring->index field to let the process know that it must hit another 
> syscall to drain the rest of the events.

I decided to use queue length for mmaped buffer, using size of the
mmapped buffer as queue length is possible too.
But in any case it is very broken behaviour to introduce any kind of
overflow and special marking for that - rt signals already have it, no
need to create additional headache.


> >+static struct kevent_callbacks kevent_registered_callbacks[KEVENT_MAX];
> 
> __read_mostly?

Yep, I was told already that some structures can be marked as such.
Such change is not 100% requirement though.

> >+
> >+int kevent_add_callbacks(const struct kevent_callbacks *cb, int pos)
> >+{
> >+	struct kevent_callbacks *p;
> >+
> >+	if (pos >= KEVENT_MAX)
> >+		return -EINVAL;
> >+
> >+	p = &kevent_registered_callbacks[pos];
> >+
> >+	p->enqueue = (cb->enqueue) ? cb->enqueue : kevent_break;
> >+	p->dequeue = (cb->dequeue) ? cb->dequeue : kevent_break;
> >+	p->callback = (cb->callback) ? cb->callback : kevent_break;
> 
> Curious... why are these callbacks copied, rather than just retaining a 
> pointer to a const/static "ops" structure?

It simplifies callers of that callbacks to just call a function instead
of dereferencing and check for various pointers.

> >+
> >+	printk(KERN_INFO "KEVENT: Added callbacks for type %d.\n", pos);
> 
> Is this printk() chatter necessary?

As any other information printk in kernel it is not neccessary, but it
allows user to know which kevent kernel users are enabled.

> >+static char kevent_name[] = "kevent";
> 
> const?

Yep.

> >+/*
> >+ * Initialize mmap ring buffer.
> >+ * It will store ready kevents, so userspace could get them directly 
> >instead
> >+ * of using syscall. Esentially syscall becomes just a waiting point.
> >+ */
> >+static int kevent_user_ring_init(struct kevent_user *u)
> >+{
> >+	int pnum;
> >+
> >+	pnum = ALIGN(KEVENT_MAX_EVENTS*sizeof(struct mukevent) + 
> >sizeof(unsigned int), PAGE_SIZE)/PAGE_SIZE;
> 
> This calculation works with the current constants, but it comes up a page 
> short if, say, KEVENT_MAX_EVENTS were 4095. It also looks incorrect 
> visually since the 'sizeof(unsigned int)' is only factored in once (rather 
> than once per page). I suggest a static / inline __max_kevent_pages() 
> function that either does:
> 
> return KEVENT_MAX_EVENTS / KEVENTS_ON_PAGE + 1;
> 
> or
> 
> int pnum = KEVENT_MAX_EVENTS / KEVENTS_ON_PAGE;
> if (KEVENT_MAX_EVENTS % KEVENTS_ON_PAGE)
> 	pnum++;
> return pnum;
> 
> Both should be optimized away by the compiler and will give correct 
> answers regardless of the constant values.

Above pnum calculation aligns number of mukevents to pages size with
appropriate check for (unsigned int), although it is not stated in that
comment (more clear commant can be found around KEVENTS_ON_PAGE). 
You propose esentially the same calcualtion in the seconds case, while
first one requires additional page in some cases.

> >+static struct file_operations kevent_user_fops = {
> >+	.mmap		= kevent_user_mmap,
> >+	.open		= kevent_user_open,
> >+	.release	= kevent_user_release,
> >+	.poll		= kevent_user_poll,
> >+	.owner		= THIS_MODULE,
> >+};
> 
> const?
> 
> >+
> >+static struct miscdevice kevent_miscdev = {
> >+	.minor = MISC_DYNAMIC_MINOR,
> >+	.name = kevent_name,
> >+	.fops = &kevent_user_fops,
> >+};
> 
> const?


Yep, bot structures can be const.

> >+/*
> >+ * Used to get ready kevents from queue.
> >+ * @ctl_fd - kevent control descriptor which must be obtained through 
> >kevent_ctl(KEVENT_CTL_INIT).
> 
> Isn't this obtained through open(chardev) now?

Comment is old, you are correct.

> >+ * @min_nr - minimum number of ready kevents.
> >+ * @max_nr - maximum number of ready kevents.
> >+ * @timeout - timeout in nanoseconds to wait until some events are ready.
> >+ * @buf - buffer to place ready events.
> >+ * @flags - ununsed for now (will be used for mmap implementation).
> 
> There is currently an mmap implementation. Is flags still used?

It is unused, but I'm still waiting on comments if we need
kevent_get_events() at all - some people wanted to completely eliminate
that function in favour of total mmap domination.

> >+asmlinkage long sys_kevent_wait(int ctl_fd, unsigned int start, unsigned 
> >int num, __u64 timeout)
> >+{
> >+	int err = -EINVAL, found;
> >+	struct file *file;
> >+	struct kevent_user *u;
> >+	struct kevent *k, *n;
> >+	struct mukevent *muk;
> >+	unsigned int idx, off, hash;
> >+	unsigned long flags;
> >+
> >+	if (start + num >= KEVENT_MAX_EVENTS ||
> >+			start >= KEVENT_MAX_EVENTS ||
> >+			num >= KEVENT_MAX_EVENTS)
> 
> Since start and num are unsigned, the last two checks are redundant. If 
> start or num is individually >= KEVENT_MAX_EVENTS, start + num must be.

No, consider the case when start is -1U and num is 1, without both checks
start+num will not fail in this condition.

> >+/*
> >+ * Kevent subsystem initialization - create kevent cache and register
> >+ * filesystem to get control file descriptors from.
> >+ */
> >+static int __devinit kevent_user_init(void)
> >+{
> >+	int err = 0;
> >+
> >+	kevent_cache = kmem_cache_create("kevent_cache",
> >+			sizeof(struct kevent), 0, SLAB_PANIC, NULL, NULL);
> >+
> >+	err = misc_register(&kevent_miscdev);
> >+	if (err) {
> >+		printk(KERN_ERR "Failed to register kevent miscdev: 
> >err=%d.\n", err);
> 
> Are we leaving the slab cache for kevents around in this failure case for 
> a reason? Why is a slab creation failure panic()-worthy fatal when a 
> chardev allocation failure is not?

I have no strong opinion on how to behave in this situation.
kevent can panic, can free cache, can go to infinite loop or screw up 
the hard drive. Everything is (almost) the same.

> Looking pretty good. This is my first pass of comments, and I'll probably 
> have questions that follow, but I'm trying to get a really good picture of 
> what is going on here for documentation purposes.

Thank you, Chase.
I will definitely get your comments into account and change related
bits.

> Thanks,
> Chase

-- 
	Evgeniy Polyakov
