Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261276AbSJYFx3>; Fri, 25 Oct 2002 01:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261283AbSJYFx3>; Fri, 25 Oct 2002 01:53:29 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:5061 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261276AbSJYFx0>;
	Fri, 25 Oct 2002 01:53:26 -0400
Message-ID: <3DB8DC72.6A08C74F@us.ibm.com>
Date: Thu, 24 Oct 2002 22:53:54 -0700
From: mingming cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Andrew Morton <akpm@digeo.com>, hugh@veritas.com, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       lse-tech@lists.sourceforge.net
Subject: Re: [PATCH]updated ipc lock patch
References: <3DB87458.F5C7DABA@digeo.com>
		<Pine.LNX.4.44.0210242342460.1169-100000@localhost.localdomain>
		<3DB88298.735FD044@digeo.com> <20021025141829.063a4e66.rusty@rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> 
> Here's my brief audit:
> 
> >+      int max_id = ids->max_id;
> >
> >-      for (id = 0; id <= ids->max_id; id++) {
> >+      read_barrier_depends();
> >+      for (id = 0; id <= max_id; id++) {
> 
> That needs to be a rmb(), not a read_barrier_depends().  

Thanks for spending some time reviewing the barriers for me. While I was
thinking the reason why a rmb is needed here, I found that maybe we
don't need a barrier here at all. Since ipc_findkey()(the code above)
and the grow_ary() are both protected by ipc_ids.sem(there missing
document for this), so both the max_id and the the entries array seen by
ipc_findkey should be the latest one.

Also I think it's safe to remove the rmb() in ipc_get() for the same
reason. ipc_get() is only used by shm_get_stat() through shm_get() and
is called with the shm_ids.sem protected. (Maybe ipc_get should be
removed totally?)

> And like all
> barriers, it *requires* a comment:
>         /* We must read max_id before reading any entries */
>
Sure.  I will add such comments on all places where barriers are being
used.  I will do as much as I can to add more comments in the code about
what lock/sem are hold before/after the funtion is called.:-)
 
> I can't see the following in the patch posted, but:
> > void ipc_rcu_free(void* ptr, int size)
> > {
> >         struct rcu_ipc_free* arg;
> >
> >         arg = (struct rcu_ipc_free *) kmalloc(sizeof(*arg), GFP_KERNEL);
> >         if (arg == NULL)
> >                 return;
> >         arg->ptr = ptr;
> >         arg->size = size;
> >         call_rcu(&arg->rcu_head, ipc_free_callback, arg);
> > }
> 
> This is unacceptable crap, sorry.  You *must* allocate the resources
> required to free the object *at the time you allocate the object*,
> since freeing must not fail.
> 
> > Even better: is it possible to embed the rcu_ipc_free inside the
> > object-to-be-freed?  Perhaps not?
> 
> Yes, this must be done.
> 
I thought about embed rcu_ipc_free inside the ipc_ids structure before. 
But there could be a problem if grow_ary() is called again before the
old array associated with the previous grow_ary() has not scheduled to
be freed yet.  I see a need to do that now, as you made very good point.
I will make the changes tomorrow.

Thanks a lot for your comments.

Mingming
