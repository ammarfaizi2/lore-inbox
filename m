Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265696AbSJYAFx>; Thu, 24 Oct 2002 20:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265714AbSJYAFx>; Thu, 24 Oct 2002 20:05:53 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:33010 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265696AbSJYAFv>;
	Thu, 24 Oct 2002 20:05:51 -0400
Message-ID: <3DB88B2F.640EA4E@us.ibm.com>
Date: Thu, 24 Oct 2002 17:07:11 -0700
From: mingming cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Hugh Dickins <hugh@veritas.com>, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       lse-tech@lists.sourceforge.net
Subject: Re: [PATCH]updated ipc lock patch
References: <3DB87458.F5C7DABA@digeo.com> <Pine.LNX.4.44.0210242342460.1169-100000@localhost.localdomain> <3DB88298.735FD044@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> What about this code?
> 
> void ipc_rcu_free(void* ptr, int size)
> {
>         struct rcu_ipc_free* arg;
> 
>         arg = (struct rcu_ipc_free *) kmalloc(sizeof(*arg), GFP_KERNEL);
>         if (arg == NULL)
>                 return;
>         arg->ptr = ptr;
>         arg->size = size;
>         call_rcu(&arg->rcu_head, ipc_free_callback, arg);
> }
> 
> Are we sure that it's never called under locks?
Did you see any place where this is called with lock(s) hold? Maybe
there is, but I could not see here.  They are called from the functions
which are used by IPC code only. Inside IPC there is only spin_lock per
ID and sem_undo lock. Both of them are not hold when ipc_rcu_free is
called.

> 
> And it seems that if the kmalloc fails, we decide to leak some
> memory, yes?
>

yes.
 
> If so it would be better to use GFP_ATOMIC there.  Avoids any
> locking problems and also increases the chance of the allocation
> succeeding.  (With an explanatory comment, naturally :)).
>

Good point. I agree GFP_ATOMIC fits better here.
 
> Even better: is it possible to embed the rcu_ipc_free inside the
> object-to-be-freed?  Perhaps not?

Are you saying that have a static RCU header structure in the
object-to-be-freed?  I think it's possible.  It fits well in the rmid
case, where the object to be freed is an kern_ipc_perm structure. But
for the  grow_ary() case, the object to be freed is a array of struct
ipc_id, so it need a little bit more changes there. Maybe add a new
structure ipc_entries, which include the RCU header structure and the
pointer to the entries array.  Then have the ipc_ids->entries point to
ipc_entries.  Just a little concern that this way we added a reference
when looking up the IPC ID from the array.
