Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315374AbSGION4>; Tue, 9 Jul 2002 10:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315388AbSGIONz>; Tue, 9 Jul 2002 10:13:55 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:40466 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S315374AbSGIONy>; Tue, 9 Jul 2002 10:13:54 -0400
Date: Tue, 9 Jul 2002 15:16:33 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Andi Kleen <ak@muc.de>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix iounmap for non page aligned addresses
In-Reply-To: <20020709135534.A1155@averell>
Message-ID: <Pine.LNX.4.21.0207091457220.1640-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2002, Andi Kleen wrote:
> 
> This fixes a problem introduced by the pageattr ioremap/unmap patches.
> iounmap lost the ability to free non page aligned addresses, which
> are e.g. used by the bootflag code.  This patch fixes this.

Good.

> Also fix a potential off by one bug.

Niggle: changing "< high_memory" to "<= high_memory"?  I think that
change is wrong (though admittedly no wronger than what's in 2.4).

So long as VMALLOC_OFFSET enforces an arbitrary gap of at least 8MB
between high_memory and the vmalloc address area, it doesn't matter.
But one day someone may remove that gap (why not?) to make a few
more addresses available, then "<= high_memory" test could go wrong.

Hugh

> --- linux-work/arch/i386/mm/ioremap.c.~2~	Tue Jun 18 02:13:09 2002
> +++ linux/arch/i386/mm/ioremap.c	Fri Jun 21 14:42:23 2002
> @@ -213,9 +213,9 @@
>  void iounmap(void *addr)
>  { 
>  	struct vm_struct *p;
> -	if (addr < high_memory) 
> +	if (addr <= high_memory) 
>  		return; 
> -	p = remove_kernel_area(addr); 
> +	p = remove_kernel_area(PAGE_MASK & (unsigned long) addr); 
>  	if (!p) { 
>  		printk("__iounmap: bad address %p\n", addr);
>  		return;

