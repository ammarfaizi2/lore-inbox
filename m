Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268505AbUJUNrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268505AbUJUNrU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 09:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265331AbUJUNoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 09:44:19 -0400
Received: from fep02fe.ttnet.net.tr ([212.156.4.132]:35801 "EHLO
	fep02.ttnet.net.tr") by vger.kernel.org with ESMTP id S270350AbUJUNk5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 09:40:57 -0400
Message-ID: <4177BBFD.5090300@ttnet.net.tr>
Date: Thu, 21 Oct 2004 16:39:09 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.3) Gecko/20041003
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: andrea@novell.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Memory leak in 2.4.27 kernel, using mmap raw packet sockets
Content-Type: multipart/mixed;
	boundary="------------040109060707070505020407"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040109060707070505020407
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit

Andrea Arcangeli  wrote:
>> > > That isnt sufficient. Consider anything else taking a reference to the
>> > > page and the refcount going negative. 
>> > 
>> > You mean not going negative? The problem here as I understand here is 
>> > we dont release the count if the PageReserved is set, but we should.
>> 
>> Drivers like the OSS audio drivers move page between Reserved and 
>> unreserved. The count can thus be corrupted.
> 
> the PG_reserved goes away after VM_IO, so forbidding pages with
> PG_reserved of vmas with VM_IO isn't any different as far as I can tell,
> and since PG_reserved is the real offender sure we shouldn't leave a
> check in get_user_pages that explicitly do something if the page is
> reserved, since if the page is reserved at that point we'd need to
> return -EFAULT or BUG_ON.
> 
> Adding the VM_IO patch on top of this is sure a good idea.
> 
> --- sles/mm/memory.c.~1~	2004-10-19 19:34:10.264335488 +0200
> +++ sles/mm/memory.c	2004-10-19 19:58:47.403776160 +0200
> @@ -806,7 +806,7 @@ int get_user_pages(struct task_struct *t
>  			}
>  			if (pages) {
>  				pages[i] = get_page_map(map);
> -				if (!pages[i]) {
> +				if (!pages[i] || PageReserved(pages[i])) {
>  					spin_unlock(&mm->page_table_lock);
>  					while (i--)
>  						page_cache_release(pages[i]);
> @@ -814,8 +814,7 @@ int get_user_pages(struct task_struct *t
>  					goto out;
>  				}
>  				flush_dcache_page(pages[i]);
> -				if (!PageReserved(pages[i]))
> -					page_cache_get(pages[i]);
> +				page_cache_get(pages[i]);
>  			}
>  			if (vmas)
>  				vmas[i] = vma;
> 
> My version of the fix for 2.4 is this, but this fixes as well an issue
> with the zeropage and it's on top of some other fix for COW corruption
> in 2.4 not yet fixed in mainline 2.4. Since 2.4 never checked
> PageReserved like 2.6 does in get_user_pages, 2.4 as worse can suffer a
> memleak.
> 
> --- sles/include/linux/mm.h.~1~	2004-10-18 10:20:53.391823696 +0200
> +++ sles/include/linux/mm.h	2004-10-18 10:47:10.861011928 +0200
> @@ -533,9 +533,8 @@ extern void unpin_pte_page(struct page *
>  
>  static inline void put_user_page_pte_pin(struct page * page)
>  {
> -	if (PagePinned(page))
> -		/* must run before put_page, put_page may free the page */
> -		unpin_pte_page(page);
> +	/* must run before put_page, put_page may free the page */
> +	unpin_pte_page(page);
>  
>  	put_page(page);
>  }
> --- sles/mm/memory.c.~1~	2004-10-18 10:20:54.947587184 +0200
> +++ sles/mm/memory.c	2004-10-18 10:47:49.822088944 +0200
> @@ -530,7 +530,11 @@ void __wait_on_pte_pinned_page(struct pa
>  
>  void unpin_pte_page(struct page *page)
>  {
> -	wait_queue_head_t *waitqueue = page_waitqueue(page);
> +	wait_queue_head_t *waitqueue;
> +
> +	if (!PagePinned(page))
> +		return;
> +	waitqueue = page_waitqueue(page);
>  	if (unlikely(!TestClearPagePinned(page)))
>  		BUG();
>  	smp_mb__after_clear_bit(); 
> @@ -598,17 +602,21 @@ int __get_user_pages(struct task_struct 
>  				 */
>  				if (!map)
>  					goto bad_page;
> -				page_cache_get(map);
> -				if (pte_pin && unlikely(TestSetPagePinned(map))) {
> -					/* fail if this is a duplicate physical page in this kiovec */
> -					int i2 = i;
> -					while (i2--)
> -						if (map == pages[i2]) {
> -							put_page(map);
> -							goto bad_page;
> -						}
> -					/* hold a reference on "map" so we can wait on it */
> -					goto pte_pin_collision;
> +				if (map != ZERO_PAGE(start)) {
> +					if (PageReserved(map))
> +						goto bad_page;
> +					page_cache_get(map);
> +					if (pte_pin && unlikely(TestSetPagePinned(map))) {
> +						/* fail if this is a duplicate physical page in this kiovec */
> +						int i2 = i;
> +						while (i2--)
> +							if (map == pages[i2]) {
> +								put_page(map);
> +								goto bad_page;
> +							}
> +						/* hold a reference on "map" so we can wait on it */
> +						goto pte_pin_collision;
> +					}
>  				}
>  				pages[i] = map;
>  			}

I can't find to which suse kernel these patch(es) apply. I assume
your first one comes down to the attached one-liner for vanilla-2.4,
can you confirm?
For your second: I think it needs your 9999_z-get_user_pages_pte_pin-1
patch applied beforehand?. Without that patch, are there any problems
to be fixed? Can you post patches for vanilla kernels, please?

Regards,
Ozkan Sezer


--------------040109060707070505020407
Content-Type: text/plain;
	name="2.4_memory.c-PageReserved.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="2.4_memory.c-PageReserved.diff"

--- 2.4/mm/memory.c.BAK	2004-10-20 11:49:35.000000000 +0300
+++ 2.4/mm/memory.c	2004-10-21 10:43:01.000000000 +0300
@@ -499,7 +499,7 @@
 				/* FIXME: call the correct function,
 				 * depending on the type of the found page
 				 */
-				if (!pages[i])
+				if (!pages[i] || PageReserved(pages[i]))
 					goto bad_page;
 				page_cache_get(pages[i]);
 			}


--------------040109060707070505020407--
