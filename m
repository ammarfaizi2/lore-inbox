Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263072AbTJOMqJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 08:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263073AbTJOMqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 08:46:09 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:30852
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S263072AbTJOMqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 08:46:05 -0400
Date: Wed, 15 Oct 2003 14:46:11 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ernie Petrides <petrides@redhat.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.4.23-pre7] alternate fix for BUG() in exec_mmap()
Message-ID: <20031015124610.GB1735@velociraptor.random>
References: <200310140111.h9E1BR6a015812@pasta.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310140111.h9E1BR6a015812@pasta.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 13, 2003 at 09:11:27PM -0400, Ernie Petrides wrote:
> Yes, this in fact necessary.  I have retested with the locking sequence
> shown above and verified that the problem is still fixed.
> 
> Further, I've discovered that in my original version, with the mmap_sem
> held across mm_release() and exit_aio(), there are potential deadlocks
> in at least the following hypothetical calling trees:
> 
> 	mm_release()
> 	  put_user()
> 	    direct_put_user()
> 	      __put_user_check()
> 	        __put_user_size()
> 	          __put_user_asm()
> 	            [page fault]
> 	                do_page_fault()
> 	                  down_read(&mm->mmap_sem)
> 
> 	exit_aio()
> 	  aio_cancel_all()
> 	    async_poll_cancel()
> 	      aio_put_req()
> 	        put_ioctx()
> 	          __put_ioctx()
> 	            aio_free_ring()
> 	              down_write(&ctx->mm->mmap_sem)
> 
> The corrected patch against 2.4.23-pre7, which restores the fast path in
> exec_mmap() and adds the holding of "mmap_sem" across only the exit_mmap()
> call, is attached below.  Since "mmap_sem" locking is conceptually higher
> than file system locks in the locking hierarchy, the whole calling tree
> from exit_mmap() on down (including potential fput() calls) should be
> safe to run with "mmap_sem" owned.
> 
> Thanks for the help.
> 
> Cheers.  -ernie
> 
> 
> 
> --- linux-2.4.23-pre7/fs/exec.c.orig
> +++ linux-2.4.23-pre7/fs/exec.c
> @@ -426,6 +426,13 @@ static int exec_mmap(void)
>  	struct mm_struct * mm, * old_mm;
>  
>  	old_mm = current->mm;
> +	if (old_mm && atomic_read(&old_mm->mm_users) == 1) {
> +		mm_release();
> +		down_write(&old_mm->mmap_sem);
> +		exit_mmap(old_mm);
> +		up_write(&old_mm->mmap_sem);
> +		return 0;
> +	}
>  
>  	mm = mm_alloc();
>  	if (mm) {

looks fine thanks.

Andrea
