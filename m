Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261273AbSJYEQa>; Fri, 25 Oct 2002 00:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261276AbSJYEQ3>; Fri, 25 Oct 2002 00:16:29 -0400
Received: from dp.samba.org ([66.70.73.150]:8117 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261273AbSJYEQ3>;
	Fri, 25 Oct 2002 00:16:29 -0400
Date: Fri, 25 Oct 2002 14:18:29 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@digeo.com>
Cc: hugh@veritas.com, cmm@us.ibm.com, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       lse-tech@lists.sourceforge.net
Subject: Re: [PATCH]updated ipc lock patch
Message-Id: <20021025141829.063a4e66.rusty@rustcorp.com.au>
In-Reply-To: <3DB88298.735FD044@digeo.com>
References: <3DB87458.F5C7DABA@digeo.com>
	<Pine.LNX.4.44.0210242342460.1169-100000@localhost.localdomain>
	<3DB88298.735FD044@digeo.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2002 16:30:32 -0700
Andrew Morton <akpm@digeo.com> wrote:

> Hugh Dickins wrote:
> > 
> > ...
> > Manfred and I have both reviewed the patch (or the 2.5.44 version)
> > and we both recommend it highly (well, let Manfred speak for himself).
> > 
> 
> OK, thanks.
> 
> So I took a look.  Wish I hadn't :(  The locking rules in there
> are outrageously uncommented.  You must be brave people.

Agreed.  Here's my brief audit:

>+	int max_id = ids->max_id;
> 
>-	for (id = 0; id <= ids->max_id; id++) {
>+	read_barrier_depends();
>+	for (id = 0; id <= max_id; id++) {

That needs to be a rmb(), not a read_barrier_depends().  And like all
barriers, it *requires* a comment:
	/* We must read max_id before reading any entries */

I can't see the following in the patch posted, but:
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

This is unacceptable crap, sorry.  You *must* allocate the resources
required to free the object *at the time you allocate the object*,
since freeing must not fail.

> Even better: is it possible to embed the rcu_ipc_free inside the
> object-to-be-freed?  Perhaps not?

Yes, this must be done.

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
