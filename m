Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285133AbRLRVBN>; Tue, 18 Dec 2001 16:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285160AbRLRVBE>; Tue, 18 Dec 2001 16:01:04 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:41487 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S285133AbRLRVAv>; Tue, 18 Dec 2001 16:00:51 -0500
Date: Tue, 18 Dec 2001 17:46:00 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Momchil Velikov <velco@fadata.bg>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Copying to loop device hangs up everything
In-Reply-To: <871yhu25p3.fsf@fadata.bg>
Message-ID: <Pine.LNX.4.21.0112181745240.4473-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Momchil, 

Your fix does not look right. We _have_ to sync pages at
sync_page_buffers(), we cannot "ignore" them.

On 16 Dec 2001, Momchil Velikov wrote:

> >>>>> "Momchil" == Momchil Velikov <velco@fadata.bg> writes:
> 
> >>>>> "David" == David Gomez <davidge@jazzfree.com> writes:
> David> On 16 Dec 2001, Momchil Velikov wrote:
> 
> >>> [...]
> >>> 
> David> Thanks ;), this patch solves the problem and copying a lot of data to the
> David> loop device now doesn't hang the computer.
> >>> 
> David> Is this patch going to be applied to the stable kernel ? Marcelo ?
> >>> 
> >>> I've had exactly the same hangups with or without the patch.
> 
> David> I've tested several times after applying the loop-deadlock patch and the
> David> bug seems to be fixed. No more hangups while copying a lot of data to
> David> loopback devices. Post more info about your hangups, maybe is another
> David> different loop device deadlock.
> 
> Momchil> Maybe it's different I don't know. Looks like I've found a fix and in
> Momchil> a minute I'll test _without_ the Andrea's patch and post whatever
> Momchil> comes out of it.
> 
> It turned out that Andrea's patch is needed and it needs to be
> augmented slightly.  The loop_thread can do the following:
> 
> loop_thread
> -> do_bh_filebacked
> -> lo_send
> -> ...
> ->  kmem_cache_alloc
> -> ...
> -> shrink_cache
> -> try_to_release_page
> -> try_to_free_buffers
> -> sync_page_buffers
> -> __wait_on_buffer
> 
> And if the buffer must be flushed to the loopback device we deadlock.
> 
> The following patch is the Andrea's one + one additional change -- we
> don't allow the loop_thread to wait in sync_page_buffers.
> 
> Regards,
> -velco
> 
> diff -Nru a/drivers/block/loop.c b/drivers/block/loop.c
> --- a/drivers/block/loop.c	Sun Dec 16 23:50:25 2001
> +++ b/drivers/block/loop.c	Sun Dec 16 23:50:25 2001
> @@ -578,6 +578,8 @@
>  	atomic_inc(&lo->lo_pending);
>  	spin_unlock_irq(&lo->lo_lock);
>  
> +	current->flags |= PF_NOIO;
> +
>  	/*
>  	 * up sem, we are running
>  	 */
> diff -Nru a/fs/buffer.c b/fs/buffer.c
> --- a/fs/buffer.c	Sun Dec 16 23:50:25 2001
> +++ b/fs/buffer.c	Sun Dec 16 23:50:25 2001
> @@ -1045,7 +1045,7 @@
>  
>  	/* First, check for the "real" dirty limit. */
>  	if (dirty > soft_dirty_limit) {
> -		if (dirty > hard_dirty_limit)
> +		if (dirty > hard_dirty_limit && !(current->flags & PF_NOIO))
>  			return 1;
>  		return 0;
>  	}
> @@ -2448,6 +2448,8 @@
>  		/* Second time through we start actively writing out.. */
>  		if (test_and_set_bit(BH_Lock, &bh->b_state)) {
>  			if (!test_bit(BH_launder, &bh->b_state))
> +				continue;
> +			if (current->flags & PF_NOIO)
>  				continue;
>  			wait_on_buffer(bh);
>  			tryagain = 1;
> diff -Nru a/include/linux/sched.h b/include/linux/sched.h
> --- a/include/linux/sched.h	Sun Dec 16 23:50:25 2001
> +++ b/include/linux/sched.h	Sun Dec 16 23:50:25 2001
> @@ -426,6 +426,7 @@
>  #define PF_MEMALLOC	0x00000800	/* Allocating memory */
>  #define PF_MEMDIE	0x00001000	/* Killed for out-of-memory */
>  #define PF_FREE_PAGES	0x00002000	/* per process page freeing */
> +#define PF_NOIO		0x00004000	/* avoid generating further I/O */
>  
>  #define PF_USEDFPU	0x00100000	/* task used FPU this quantum (SMP) */
>  
> 

