Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWCCQ7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWCCQ7g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 11:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWCCQ7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 11:59:36 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:32984 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932337AbWCCQ7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 11:59:35 -0500
Message-ID: <4408753B.52E3B003@tv-sign.ru>
Date: Fri, 03 Mar 2006 19:56:27 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/23] tref: Implement task references.
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
		<m1k6bmhxze.fsf@ebiederm.dsl.xmission.com>
		<m1mzgidnr0.fsf@ebiederm.dsl.xmission.com>
		<44074479.15D306EB@tv-sign.ru> <m14q2gjxqo.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@tv-sign.ru> writes:
>
> > I think there is another, much simpler solution. We can make a "reference" to
> > the
> > pid itself to protect it against free_pidmap(), so that this pid can't be
> > reused.
>
> However with my trivial hostile program I can with 32 or 33 living processes
> each with 1000 references to dead processes I can completely saturate the
> default pid map.  And it won't be obvious why alloc_pidmap is failing.

Yes, this is a problem. Please see the new version below. Instead of delaying
pid releasing, free_pidmap() just invalidates pid_ref. The code becomes even
simpler.

> Your resource consumption with the extra hash table is higher than
> mine at until very high process counts.

The size of ref_array[] could be arbitrary low (we can't use pid_hashfn() in
this case, of course). And tref adds 4 * sizeof(void*) to every task, and it
is much more complicated.

> In addition it doesn't really help with the problem that inspired
> this work.  That of having multiple pid spaces.  I could make it work
> by throwing a pspace reference in struct pid_ref, but without some
> fancy footwork it would prevent cleanup until all of the outside
> references are gone.
>
> So I kind of like it but I don't feel it does as good a job solving
> the problems I am solving.

Ok. I missed the virtualization/pspace discussion completely, so you are
very probably right.

Oleg.

struct pid_ref
{
	pid_t			pid;
	int			count;
	struct hlist_node	chain;
};

// allocated in pidhash_init()
static struct hlist_head *ref_hash;

static struct pid_ref *find_pid_ref(pid_t pid)
{
	struct hlist_node *elem;
	struct pid_ref *ref;

	hlist_for_each_entry(ref, elem, &ref_hash[pid_hashfn(pid)], chain)
		if (ref->pid == pid)
			return ref;

	return NULL;
}

// This is the only function modified.
fastcall void free_pidmap(int pid)
{
	pidmap_t *map = pidmap_array + pid / BITS_PER_PAGE;
	int offset = pid & BITS_PER_PAGE_MASK;
	struct pid_ref *ref;

	clear_bit(offset, map->page);
	atomic_inc(&map->nr_free);

	ref = find_pid_ref(pid);
	if (unlikely(ref != NULL)) {
		hlist_del_init(&ref->chain);
		ref->pid = 0;
	}
}

static inline int pid_inuse(pid_t pid)
{
	pidmap_t *map = pidmap_array + pid / BITS_PER_PAGE;
	int offset = pid & BITS_PER_PAGE_MASK;

	return test_bit(offset, map->page);
}

struct pid_ref *alloc_pid_ref(pid_t pid)
{
	struct pid_ref *ref;

	write_lock_irq(&tasklist_lock);
	ref = find_pid_ref(pid);
	if (ref)
		ref->count++;
	else if (pid_inuse(pid)) {
		ref = kmalloc(sizeof(*ref), GFP_ATOMIC);
		if (ref) {
			ref->pid = pid;
			ref->count = 1;
			hlist_add_head(&ref->chain,
				&ref_hash[pid_hashfn(pid)]);
		}
	}
	write_unlock_irq(&tasklist_lock);

	return ref;
}

void free_pid_ref(struct pid_ref *ref)
{
	if (!ref)
		return;

	write_lock_irq(&tasklist_lock);
	if (!--ref->count) {
		hlist_del_init(&ref->chain);
		kfree(ref);
	}
	write_unlock_irq(&tasklist_lock);
}
