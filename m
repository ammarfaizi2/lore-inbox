Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbTJNBGW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 21:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTJNBGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 21:06:22 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:53495 "EHLO
	pasta.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262126AbTJNBGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 21:06:19 -0400
Message-Id: <200310140111.h9E1BR6a015812@pasta.boston.redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.4.23-pre7] alternate fix for BUG() in exec_mmap()
In-Reply-To: Your message of "Mon, 13 Oct 2003 14:09:36 +0200."
Date: Mon, 13 Oct 2003 21:11:27 -0400
From: Ernie Petrides <petrides@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 13-Oct-2003 at 14:9 +0200, Andrea Arcangeli wrote:

> On Mon, Oct 13, 2003 at 02:52:44AM -0400, Ernie Petrides wrote:
>
> > --- linux-2.4.21/fs/exec.c.orig
> > +++ linux-2.4.21/fs/exec.c
> > @@ -452,9 +452,11 @@ static int exec_mmap(void)
> > 
> >  	old_mm = current->mm;
> >  	if (old_mm && atomic_read(&old_mm->mm_users) == 1) {
> > +		down_write(&old_mm->mmap_sem);
> >  		mm_release();
> >  		exit_aio(old_mm);
> >  		exit_mmap(old_mm);
> > +		up_write(&old_mm->mmap_sem);
> >  		return 0;
> >  	}
>
> Is there any special reason you take it around mm_release and exit_aio
> too? I don't feel this is needed. exit_aio btw still assumes nobody can
> race, so it doesn't take any spinlock (brlocks actually) to guard
> against other aio threads, I believe that's ok since as worse the other
> tasks can mangle the vm with ptrace, they'll never get to mess with aio,
> only the current task can and the mm_user == 1 check guarantees we've no
> sibiling threads. the mmap_sem shouldn't help exit_aio anyways, if
> something it'll make it deadlock if there's any access to the VM that
> generates a page fault in the cancel() callback.
>
> So I suggest this sequence should be safe:
>
> 	mm_release();
> 	exit_aio(old_mm);
>
> 	down_write(&old_mm->mmap_sem);
> 	exit_mmap(old_mm);
> 	up_write(&old_mm->mmap_sem);
>
> Please double check ;)

Yes, this in fact necessary.  I have retested with the locking sequence
shown above and verified that the problem is still fixed.

Further, I've discovered that in my original version, with the mmap_sem
held across mm_release() and exit_aio(), there are potential deadlocks
in at least the following hypothetical calling trees:

	mm_release()
	  put_user()
	    direct_put_user()
	      __put_user_check()
	        __put_user_size()
	          __put_user_asm()
	            [page fault]
	                do_page_fault()
	                  down_read(&mm->mmap_sem)

	exit_aio()
	  aio_cancel_all()
	    async_poll_cancel()
	      aio_put_req()
	        put_ioctx()
	          __put_ioctx()
	            aio_free_ring()
	              down_write(&ctx->mm->mmap_sem)

The corrected patch against 2.4.23-pre7, which restores the fast path in
exec_mmap() and adds the holding of "mmap_sem" across only the exit_mmap()
call, is attached below.  Since "mmap_sem" locking is conceptually higher
than file system locks in the locking hierarchy, the whole calling tree
from exit_mmap() on down (including potential fput() calls) should be
safe to run with "mmap_sem" owned.

Thanks for the help.

Cheers.  -ernie



--- linux-2.4.23-pre7/fs/exec.c.orig
+++ linux-2.4.23-pre7/fs/exec.c
@@ -426,6 +426,13 @@ static int exec_mmap(void)
 	struct mm_struct * mm, * old_mm;
 
 	old_mm = current->mm;
+	if (old_mm && atomic_read(&old_mm->mm_users) == 1) {
+		mm_release();
+		down_write(&old_mm->mmap_sem);
+		exit_mmap(old_mm);
+		up_write(&old_mm->mmap_sem);
+		return 0;
+	}
 
 	mm = mm_alloc();
 	if (mm) {
