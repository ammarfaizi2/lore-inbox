Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751604AbWB0Sxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbWB0Sxs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 13:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbWB0Sxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 13:53:48 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:51560 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751604AbWB0Sxr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 13:53:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DdHkM8PFzdQAPSPVCuR2XrWMra0G/t5XzhzP0YuxjJja4RAhZHFCFnYR7tvlDgE16P0NscrSPjgJtgd+QOHkl/ugLyGPCktAoZucC/yzpCJXWFd1l01OVMufIqlWNkvYTXBAMuyJIfgvFKZ70jyZ755ClYqxzAIv0MEAkWqGPkw=
Message-ID: <9a8748490602271053q6c92a844ied947fba859201d1@mail.gmail.com>
Date: Mon, 27 Feb 2006 19:53:47 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 1/2] mm: make shrink_all_memory overflow-resistant
Cc: "Pavel Machek" <pavel@suse.cz>, "Andrew Morton" <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200602271928.22791.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602271926.20294.rjw@sisk.pl> <200602271928.22791.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/06, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Make shrink_all_memory() overflow-resistant.
>
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  include/linux/swap.h |    2 +-
>  mm/vmscan.c          |    9 +++++----
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> Index: linux-2.6.16-rc4-mm2/mm/vmscan.c
> ===================================================================
> --- linux-2.6.16-rc4-mm2.orig/mm/vmscan.c
> +++ linux-2.6.16-rc4-mm2/mm/vmscan.c
> @@ -1785,18 +1785,19 @@ void wakeup_kswapd(struct zone *zone, in
>   * Try to free `nr_pages' of memory, system-wide.  Returns the number of freed
>   * pages.
>   */
> -int shrink_all_memory(unsigned long nr_pages)
> +unsigned long shrink_all_memory(unsigned int nr_pages)

What about the callers of shrink_all_memory() who currently expect it
to return an int, have you checked how they will react to you changing
the return type (and signedness) ?

>  {
>         pg_data_t *pgdat;
> -       unsigned long nr_to_free = nr_pages;
> -       int ret = 0;
> +       long long nr_to_free = nr_pages;

'nr_pages' passed to the function is an unsigned int, why this change?
also, nr_to_free is later passed to balance_pgdat() as the second
argument and balance_pgdat() expects to be passed an int.


> +       unsigned long ret = 0;
>         struct reclaim_state reclaim_state = {
>                 .reclaimed_slab = 0,
>         };
>
>         current->reclaim_state = &reclaim_state;
>         for_each_pgdat(pgdat) {
> -               int freed;
> +               unsigned long freed;

balance_pgdat() returns a plain int, so what's the point of making
'freed' an unsigned long?


> +
>                 freed = balance_pgdat(pgdat, nr_to_free, 0);
>                 ret += freed;
>                 nr_to_free -= freed;
> Index: linux-2.6.16-rc4-mm2/include/linux/swap.h
> ===================================================================
> --- linux-2.6.16-rc4-mm2.orig/include/linux/swap.h
> +++ linux-2.6.16-rc4-mm2/include/linux/swap.h
> @@ -173,7 +173,7 @@ extern void swap_setup(void);
>
>  /* linux/mm/vmscan.c */
>  extern unsigned long try_to_free_pages(struct zone **, gfp_t);
> -extern int shrink_all_memory(unsigned long nr_pages);
> +extern unsigned long shrink_all_memory(unsigned int nr_pages);
>  extern int vm_swappiness;
>
>  #ifdef CONFIG_NUMA
>


This patch may be correct or it may be wrong, I've not spend enough
time staring at it and follow the code it calls and gets called by to
say which, but I for one would like an explanation of why these
changes are made and why they are correct.
There's a distinct lack of a changelog/explanation with this patch.
Or maybe I'm just dense and can't see the obvious correctness, but if
that's the case I'd still like to be enlightened :)


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
