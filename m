Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130669AbQKPRbp>; Thu, 16 Nov 2000 12:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130373AbQKPRbf>; Thu, 16 Nov 2000 12:31:35 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:28173 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130669AbQKPRbZ>; Thu, 16 Nov 2000 12:31:25 -0500
Date: Thu, 16 Nov 2000 09:01:07 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: schwidefsky@de.ibm.com
cc: mingo@chiara.elte.hu, linux-kernel@vger.kernel.org
Subject: Re: Memory management bug
In-Reply-To: <C1256999.005B8F06.00@d12mta07.de.ibm.com>
Message-ID: <Pine.LNX.4.10.10011160856010.2184-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Nov 2000 schwidefsky@de.ibm.com wrote:
> 
> Ok, the BUG() hit in get_pmd_slow:
> 
> pmd_t *
> get_pmd_slow(pgd_t *pgd, unsigned long offset)
> {
>         pmd_t *pmd;
>         int i;
> 
>         pmd = (pmd_t *) __get_free_pages(GFP_KERNEL,2);

You really need 4 pages?

There's no way to reliably get 4 consecutive pages when you're even close
to being low on memory. I would suggest just failing with a NULL return
here.

What is the architecture setup for this machine? I have no clue about
S/390 memory management. Maybe you can modify the pmd layout?

One potential fix for this is to just make the page size bigger. Make
"Linux pages" be _two_ hardware pages, and make a Linux pte contain two
"hardware pte's". That way the pmd would be an order-1 allocation instead
of an order-2 one. Which is statistically _much_ more likely to be around
(exponential distribution).

		Linus


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
