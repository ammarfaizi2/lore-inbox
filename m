Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965111AbWDNH1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965111AbWDNH1q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 03:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965117AbWDNH1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 03:27:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10658 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965111AbWDNH1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 03:27:45 -0400
Date: Fri, 14 Apr 2006 00:26:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Peterson <dsp@llnl.gov>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, riel@surriel.com
Subject: Re: [PATCH 2/2] mm: fix mm_struct reference counting bugs in
 mm/oom_kill.c
Message-Id: <20060414002654.76d1a6bc.akpm@osdl.org>
In-Reply-To: <200604131744.02114.dsp@llnl.gov>
References: <200604131452.08292.dsp@llnl.gov>
	<20060413162432.41892d3a.akpm@osdl.org>
	<200604131744.02114.dsp@llnl.gov>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Peterson <dsp@llnl.gov> wrote:
>
> On Thursday 13 April 2006 16:24, Andrew Morton wrote:
> > Dave Peterson <dsp@llnl.gov> wrote:
> > > The patch below fixes some mm_struct reference counting bugs in
> > > badness().
> >
> > hm, OK, afaict the code _is_ racy.
> >
> > But you're now calling mmput() inside read_lock(&tasklist_lock), and
> > mmput() can sleep in exit_aio() or in exit_mmap()->unmap_vmas().  So
> > sterner stuff will be needed.
> >
> > I'll put a might_sleep() into mmput - it's a bit unexpected.
> 
> Hmm... fixing this looks rather tricky.  If get_task_mm()/mmput() was
> only being done on a single mm_struct then I suppose badness() could
> do something a bit ugly like passing the reference back to its caller
> and letting the caller do the mmput() once tasklist_lock is no longer
> held.  However here we are iterating over a bunch of child tasks,
> potentially doing a get_task_mm()/mmput() for a number of them.
> 
> I have a suggestion for a possible solution.  Currently mmput() is
> implemented as follows:
> 
>     01 void mmput(struct mm_struct *mm)
>     02 {
>     03         if (atomic_dec_and_lock(&mm->mm_users, &mmlist_lock)) {
>     04                 list_del(&mm->mmlist);
>     05                 mmlist_nr--;
>     06                 spin_unlock(&mmlist_lock);
>     07                 exit_aio(mm);
>     08                 exit_mmap(mm);
>     09                 put_swap_token(mm);
>     10                 mmdrop(mm);
>     11         }
>     12 }
> 
> Suppose we replace lines 07-10 with a little piece of code that adds
> the mm_struct to a list.  Then a kernel thread empties the list
> (perhaps via the work queue mechanism), doing the stuff in lines
> 07-10 for each mm_struct.  This would eliminate the possibility of
> mmput() sleeping, potentially making things easier for other callers
> of mmput() and causing fewer surprises.  Any comments?

task_lock() can be used to pin a task's ->mm.  To use task_lock() in
badness() we'd need to either

a) nest task_lock()s.  I don't know if we're doing that anywhere else,
   but the parent->child ordering is a natural one.  or

b) take a ref on the parent's mm_struct, drop the parent's task_lock()
   while we walk the children, then do mmput() on the parent's mm outside
   tasklist_lock.  This is probably better.
