Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWCDMe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWCDMe1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 07:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWCDMe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 07:34:27 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:16858 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751219AbWCDMe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 07:34:26 -0500
Message-ID: <4409888C.71720720@tv-sign.ru>
Date: Sat, 04 Mar 2006 15:31:08 +0300
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
		<44074479.15D306EB@tv-sign.ru>
		<m14q2gjxqo.fsf@ebiederm.dsl.xmission.com>
		<4408753B.52E3B003@tv-sign.ru> <m1mzg6cvek.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
> Oleg Nesterov <oleg@tv-sign.ru> writes:
> 
> > fastcall void free_pidmap(int pid)
> > {
> >       pidmap_t *map = pidmap_array + pid / BITS_PER_PAGE;
> >       int offset = pid & BITS_PER_PAGE_MASK;
> >       struct pid_ref *ref;
> >
> >       clear_bit(offset, map->page);
> >       atomic_inc(&map->nr_free);
> >
> >       ref = find_pid_ref(pid);
> >       if (unlikely(ref != NULL)) {
> >               hlist_del_init(&ref->chain);
> >               ref->pid = 0;
> >       }
> > }
> 
> Ouch!  I believe free_pidmap now needs the tasklist_lock so
> we can free the pid and kill the pid_ref atomically.  Otherwise
> the pid could potentially get reused before we free the pid reference.
> I think that means ensuring all of the callers take tasklist_lock.

Yes, you are right. And do_fork() does free_pidmap() lockless in
the error path. This path is not performance critical, so may be
it is ok to add wrie_lock(tasklist) here.
 
> > void free_pid_ref(struct pid_ref *ref)
> > {
> >       if (!ref)
> >               return;
> >
> >       write_lock_irq(&tasklist_lock);
> >       if (!--ref->count) {
> >               hlist_del_init(&ref->chain);
> >               kfree(ref);
> >       }
> >       write_unlock_irq(&tasklist_lock);
> > }
> 
> I think calling this put_pid_ref instead of free_pid_ref
> is more accurate.  The whole alloc/free _pid_ref instead
> of the more traditional get/put kind of throws me.  Since
> an allocation/free is possible I can see where this comes from
> but I don't feel right about those names.

Agree.

Oleg.
