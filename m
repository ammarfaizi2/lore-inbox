Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262544AbUKEA7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbUKEA7x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 19:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbUKEA5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 19:57:35 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:32961 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S262529AbUKEAyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 19:54:03 -0500
Date: Fri, 5 Nov 2004 01:53:44 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64)
Message-ID: <20041105005344.GG8229@dualathlon.random>
References: <20041102220720.GV3571@dualathlon.random> <41880E0A.3000805@us.ibm.com> <4188118A.5050300@us.ibm.com> <20041103013511.GC3571@dualathlon.random> <418837D1.402@us.ibm.com> <20041103022606.GI3571@dualathlon.random> <418846E9.1060906@us.ibm.com> <20041103030558.GK3571@dualathlon.random> <1099612923.1022.10.camel@localhost> <1099615248.5819.0.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099615248.5819.0.camel@localhost>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 04:40:48PM -0800, Dave Hansen wrote:
> I attached the wrong patch.
> 
> Here's what I meant to send.
> 
> -- Dave

> 
> 
> ---
> 
>  memhotplug1-dave/arch/i386/mm/pageattr.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN arch/i386/mm/pageattr.c~Z0-leaks_only_on_negative arch/i386/mm/pageattr.c
> --- memhotplug1/arch/i386/mm/pageattr.c~Z0-leaks_only_on_negative	2004-11-04 15:57:28.000000000 -0800
> +++ memhotplug1-dave/arch/i386/mm/pageattr.c	2004-11-04 15:58:50.000000000 -0800
> @@ -135,7 +135,7 @@ __change_page_attr(struct page *page, pg
>  		BUG();
>  
>  	/* memleak and potential failed 2M page regeneration */
> -	BUG_ON(!page_count(kpte_page));
> +	BUG_ON(page_count(kpte_page) < 0);
>  
>  	if (cpu_has_pse && (page_count(kpte_page) == 1)) {
>  		list_add(&kpte_page->lru, &df_list);
> _

that will hide the memleak again. Furthermore page_count cannot be < 0
unless we get a _double_ memleak.

The only chance for kpte_page to be freed, is to be == 1 in that place.
If kpte_page is == 1, it will be freed via list_add and the master page
will be regenerated giving it a chance to get performance back. If it's
0, it means we leaked memory as far as I can tell.

It's impossible a pte had a 0 page_count() and not to be in the freelist
already. There is no put_page at all in that whole path, there's only a
__put_page, so it's a memleak to get == 0 in there on any pte or pmd or
whatever else we cannot have put in the freelist already.

something else is still wrong, but knowing the above fixes it at least
tells us it's not a double leak.
