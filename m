Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280372AbRJaSJW>; Wed, 31 Oct 2001 13:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280374AbRJaSJM>; Wed, 31 Oct 2001 13:09:12 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50701 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280372AbRJaSI5>; Wed, 31 Oct 2001 13:08:57 -0500
Date: Wed, 31 Oct 2001 10:06:52 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Lorenzo Allegrucci <lenstra@tiscalinet.it>
cc: Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: new OOM heuristic failure  (was: Re: VM: qsbench)
In-Reply-To: <3.0.6.32.20011031185529.01fc4310@pop.tiscalinet.it>
Message-ID: <Pine.LNX.4.33.0110311002560.32505-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 31 Oct 2001, Lorenzo Allegrucci wrote:
>
> Until swpd is "139968" everything is fine and I have about 60M of
> free swap (I have 256M RAM + 200M of swap and qsbench uses about 343M).

Ok, that's the problem. The swap free on swap-in logic got removed, try
this simple patch, and I bet it ends up working ok for you

You should see better performance with a bigger swapspace, though. Linux
would prefer to keep the swap cache allocated as long as possible, and not
drop the pages just because swap is smaller than the working set.

(Ie the best setup is not when "RAM + SWAP > working set", but when you
have "SWAP > working set").

Can you re-do the numbers with this one on top of pre6?

Thanks,

		Linus

-----
diff -u --recursive pre6/linux/mm/memory.c linux/mm/memory.c
--- pre6/linux/mm/memory.c	Wed Oct 31 10:04:11 2001
+++ linux/mm/memory.c	Wed Oct 31 10:02:33 2001
@@ -1158,6 +1158,8 @@
 	pte = mk_pte(page, vma->vm_page_prot);

 	swap_free(entry);
+	if (vm_swap_full())
+		remove_exclusive_swap_page(page);

 	flush_page_to_ram(page);
 	flush_icache_page(vma, page);

