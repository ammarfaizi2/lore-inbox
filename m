Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131193AbRCRK60>; Sun, 18 Mar 2001 05:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131194AbRCRK6Q>; Sun, 18 Mar 2001 05:58:16 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:51972 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131193AbRCRK6C>; Sun, 18 Mar 2001 05:58:02 -0500
Date: Sun, 18 Mar 2001 07:56:48 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: changing mm->mmap_sem  (was: Re: system call for process
 information?)
In-Reply-To: <001701c0af8e$bd590ac0$5517fea9@local>
Message-ID: <Pine.LNX.4.21.0103180740290.13050-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Mar 2001, Manfred Spraul wrote:

> > The problem is that mmap_sem seems to be protecting the list
> > of VMAs, so taking _only_ the page_table_lock could let a VMA
> > change under us while a page fault is underway ...
> 
> No, that can't happen.
> VMA changes only happen if both the mmap_sem and the page table lock is
> acquired. (check insert_vm() at the end of mm/mmap.c)
> The page fault path uses the map_sem, kswaps uses page_table_lock.

You're right here, I missed this "little detail"...

> << from your patch:
> --- linux-2.4.2-ac20-vm/mm/vmscan.c.orig	Sat Mar 17 11:30:49 2001
> +++ linux-2.4.2-ac20-vm/mm/vmscan.c	Sat Mar 17 20:53:10 2001
> @@ -231,6 +231,7 @@
>  	 * Find the proper vm-area after freezing the vma chain
>  	 * and ptes.
>  	 */
> +	down_read(&mm->mmap_sem);
>                 spin_lock(&mm->page_table_lock);
>  >>>>
> 
> Why do you acquire the mmap semaphore in swapout_mm()? The old rule was
> that kswapd should never sleep on the mmap semaphore. Isn't there a
> deadlock if mmap sem is already acquired? I don't remember the details.

You're right, kswapd shouldn't do this.  I have this removed from
my code right now...

> > The problem is that mmap_sem seems to be protecting the list
> > of VMAs, so taking _only_ the page_table_lock could let a VMA
> > change under us while a page fault is underway ...
> 
> I remember that the pmd_alloc() and pte_alloc() functions need
> additional locking.

Isn't this what the page_table_lock is for ?
(too bad they're not using it...)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/


