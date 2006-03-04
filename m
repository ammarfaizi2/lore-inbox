Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWCDLQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWCDLQs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 06:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWCDLQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 06:16:48 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18086 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751242AbWCDLQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 06:16:48 -0500
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/23] tref: Implement task references.
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
	<m1k6bmhxze.fsf@ebiederm.dsl.xmission.com>
	<m1mzgidnr0.fsf@ebiederm.dsl.xmission.com>
	<44074479.15D306EB@tv-sign.ru>
	<m14q2gjxqo.fsf@ebiederm.dsl.xmission.com>
	<4408753B.52E3B003@tv-sign.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 04 Mar 2006 04:16:19 -0700
In-Reply-To: <4408753B.52E3B003@tv-sign.ru> (Oleg Nesterov's message of
 "Fri, 03 Mar 2006 19:56:27 +0300")
Message-ID: <m1mzg6cvek.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> Ok. I missed the virtualization/pspace discussion completely, so you are
> very probably right.

So I think the pid_ref could is likely still short several helper functions,
but is probably usable.  Using it is slightly more costly but I doubt the
pid hash table has any significant performance penalties.

The important property to preserve from a maintenance standpoint is
that the helper functions take enough information that when I go back
and implement pid spaces I will need to at most tweak the pid_ref
implementation, and the pid_ref helper functions and not need to
go back through and change all of the users (again).

> Oleg.
>
> struct pid_ref
> {
> 	pid_t			pid;
> 	int			count;
> 	struct hlist_node	chain;
> };
>
> // allocated in pidhash_init()
> static struct hlist_head *ref_hash;
>
> static struct pid_ref *find_pid_ref(pid_t pid)
> {
> 	struct hlist_node *elem;
> 	struct pid_ref *ref;
>
> 	hlist_for_each_entry(ref, elem, &ref_hash[pid_hashfn(pid)], chain)
> 		if (ref->pid == pid)
> 			return ref;
>
> 	return NULL;
> }
>
> // This is the only function modified.
> fastcall void free_pidmap(int pid)
> {
> 	pidmap_t *map = pidmap_array + pid / BITS_PER_PAGE;
> 	int offset = pid & BITS_PER_PAGE_MASK;
> 	struct pid_ref *ref;
>
> 	clear_bit(offset, map->page);
> 	atomic_inc(&map->nr_free);
>
> 	ref = find_pid_ref(pid);
> 	if (unlikely(ref != NULL)) {
> 		hlist_del_init(&ref->chain);
> 		ref->pid = 0;
> 	}
> }

Ouch!  I believe free_pidmap now needs the tasklist_lock so
we can free the pid and kill the pid_ref atomically.  Otherwise
the pid could potentially get reused before we free the pid reference.
I think that means ensuring all of the callers take tasklist_lock.

> static inline int pid_inuse(pid_t pid)
> {
> 	pidmap_t *map = pidmap_array + pid / BITS_PER_PAGE;
> 	int offset = pid & BITS_PER_PAGE_MASK;
>
> 	return test_bit(offset, map->page);
> }
>
> struct pid_ref *alloc_pid_ref(pid_t pid)
> {
> 	struct pid_ref *ref;
>
> 	write_lock_irq(&tasklist_lock);
> 	ref = find_pid_ref(pid);
> 	if (ref)
> 		ref->count++;
> 	else if (pid_inuse(pid)) {
> 		ref = kmalloc(sizeof(*ref), GFP_ATOMIC);
> 		if (ref) {
> 			ref->pid = pid;
> 			ref->count = 1;
> 			hlist_add_head(&ref->chain,
> 				&ref_hash[pid_hashfn(pid)]);
> 		}
> 	}
> 	write_unlock_irq(&tasklist_lock);
>
> 	return ref;
> }

I need a helper that does this from a task structure but that
is simple enough. 

> void free_pid_ref(struct pid_ref *ref)
> {
> 	if (!ref)
> 		return;
>
> 	write_lock_irq(&tasklist_lock);
> 	if (!--ref->count) {
> 		hlist_del_init(&ref->chain);
> 		kfree(ref);
> 	}
> 	write_unlock_irq(&tasklist_lock);
> }

I think calling this put_pid_ref instead of free_pid_ref
is more accurate.  The whole alloc/free _pid_ref instead
of the more traditional get/put kind of throws me.  Since
an allocation/free is possible I can see where this comes from 
but I don't feel right about those names.

Eric

