Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288993AbSAQPEr>; Thu, 17 Jan 2002 10:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289029AbSAQPEh>; Thu, 17 Jan 2002 10:04:37 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:51470 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288993AbSAQPEW>;
	Thu, 17 Jan 2002 10:04:22 -0500
Date: Thu, 17 Jan 2002 13:04:07 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Diego Calleja <grundig@teleline.es>, <linux-kernel@vger.kernel.org>
Subject: Re: bugfix backed out
In-Reply-To: <20020117153504.J4847@athlon.random>
Message-ID: <Pine.LNX.4.33L.0201171300271.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2002, Andrea Arcangeli wrote:

> hmm, is this the bugfix you mean? that shouldn't really matter to me as
> far I can tell, I did it in an alternate way since the first place.

It matters a lot since without this change max_mapped
will always be larger than max_scan and swap_out() will
NEVER be called.

If this is fixed in another way in -aa I must have missed
that piece of code, I only stared at the patch for about
10 minutes before writing this email.

> diff -urN 2.4.17pre8/mm/vmscan.c 2.4.17/mm/vmscan.c
> --- 2.4.17pre8/mm/vmscan.c      Fri Nov 23 08:21:05 2001
> +++ 2.4.17/mm/vmscan.c  Fri Dec 21 20:06:55 2001
> @@ -338,7 +338,7 @@
>  {
>         struct list_head * entry;
>         int max_scan = nr_inactive_pages / priority;
> -       int max_mapped = nr_pages << (9 - priority);
> +       int max_mapped = min((nr_pages << (10 - priority)), max_scan / 10);
>
>         spin_lock(&pagemap_lru_lock);
>         while (--max_scan >= 0 && (entry = inactive_list.prev) != &inactive_list) {
>
> furthmore I hate those "10" hardwirded magic numbers that you keep
> adding. The less of them the better. At least I put those magics in
> sysctl.

Absolutely agreed ... if it helps you, it was marcelo who
changed the 9 to 10 ;)

Ideally we'd have a VM which runs ok without magic numbers,
or at least one where changing the magic numbers has extremely
little influence, the defaults work and the sysctl switches
don't require you to learn how all the VM internals work.

> see what my max_mapped is:
>
> 	int orig_max_mapped = SWAP_CLUSTER_MAX * vm_mapped_ratio,
>
> It is controlled by the vm_mapped_ratio and by the swap-cluster. So we
> unmap one swap cluster at every vm_mapped_ratio of pages scanned that
> were mapped. This ensure we unmap when there's some relevant work to do.
> The lower the vm_mapped_ratio, the earlier the kernel will start
> swapping/paging. (ah, and of course also the SWAP_CLUSTER_MAX would
> better be a sysctl but it isn't yet)

Yes, but what happens when orig_max_mapped gets larger than
max_scan ?  How does the -aa VM protect against that ?

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

