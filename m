Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTJJLOX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 07:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbTJJLOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 07:14:23 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:60305 "EHLO
	pasta.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262033AbTJJLOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 07:14:21 -0400
Message-Id: <200310101118.h9ABImIk026992@pasta.boston.redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Mika Penttila <mika.penttila@kolumbus.fi>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BUG() in exec_mmap()
In-Reply-To: Your message of "Fri, 10 Oct 2003 07:57:16 -0300."
Date: Fri, 10 Oct 2003 07:18:48 -0400
From: Ernie Petrides <petrides@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 10-Oct-2003 at 7:57 -0300, Marcelo Tosatti wrote:

> On Thu, 9 Oct 2003, Ernie Petrides wrote:
>
> > On Thursday, 9-Oct-2003 at 17:47 -0300, Marcelo Tosatti wrote:
> >
> > > On Thu, 9 Oct 2003, Mika Penttilä wrote:
> > >
> > > > Hmm.. you still need to mmput(old_mm) etc, just remove the mm_users == 1
> > > > optimization from the beginning of exec_mmap, so this patch is wrong!
> > >
> > > Right. Ill fix it up by hand.
> >
> > Mika is correct that the exit_mmap(old_mm) still needs to happen on the
> > last use of the "mm_struct".  But whether it's called directly from
> > exec_mmap() or indirectly from mmput() still needs to depend on the
> > value of "mm_users".
> >
> > The original logic avoided the mmdrop(active_mm) call if there was an
> > old_mm, so I'd infer that the mm_struct reference count is not bumped
> > twice for both references from the task_struct (mm and active_mm).  So
> > the patch would need to be reworked to avoid the double decrement, too.
>
> I dont get you, sorry (I'm not a real expert on that piece of code,
> so...).
>
> From what I understand the "if (old_mm && mm_users == 1)" if case is just
> an optimization to avoid the allocation of a new mm structure.
>
> The functionality will be the same without that piece of code, it will
> just be slower.

I've checked your -pre7 patch now, and I see that the 2nd block of code
was added back in.  So what you've got now should work fine.


> > Is it possible to just use down_read(&old_mm->mmap_sem) and
> > up_read(&old_mm->mmap_sem) inside exec_mmap() around the optimized call
> > to exit_mmap() instead?
>
> Doing that locking inside exit_mmap() not feasible IMO... it might be too
> expensive.

Okay, sounds good.  Thanks for the follow-up.


Cheers.  -ernie
