Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314204AbSDVOJE>; Mon, 22 Apr 2002 10:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314206AbSDVOJD>; Mon, 22 Apr 2002 10:09:03 -0400
Received: from dsl-213-023-039-131.arcor-ip.net ([213.23.39.131]:11931 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314204AbSDVOJC>;
	Mon, 22 Apr 2002 10:09:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Mel <mel@csn.ul.ie>, linux-kernel@vger.kernel.org
Subject: Re: vmalloc comments patch
Date: Sun, 21 Apr 2002 16:09:11 +0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.44.0204201740480.3995-100000@skynet>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16zI1f-0001F9-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 April 2002 20:37, Mel wrote:
> This patch against 2.4.19pre7 is a first cut effort at commenting how
> vmalloc does its work for allocation of pages that are not linear in
> physical memory only in virtual memory. No code is changed, it's only
> commentry.

Very nice.  A few nits noted below.

> +	/* A PMD can be bad if it's either read only or the accessed or dirty
> +	 * bits are not cleared
> +	 */

Classic 'Linus' multi-line comment style looks like this:

/*
 * The comment goes here
 * and so on
 */

Just goes to show, there's not way to make /* bracket comments */ look nice ;-)

> +	/* Treat the address as if it starts from 0 relative to the beginning
> +	 * of the PMD*/

IOW, it's an offset.  This is a (minor) flaw in the api.  Address should be passed
as (void *) and we should have:

	ulong offset = address &= ~PMD_MASK;

Granted, such cleanupd are not the goal of your patch.


>+	/* If this free would need to go to the next PGD, make sure we
>+	* exit out at the end of this PGD
>+	*/

Whitespace glitch here.

> +		/* The page table is unlocked because we don't need to traverse
> +		 * the page tables while a page is been allocated. As
> +		 * alloc_page could block for a long time, let go the lock
> +		 */
>  		spin_unlock(&init_mm.page_table_lock);
>  		page = alloc_page(gfp_mask);
>  		spin_lock(&init_mm.page_table_lock);

Actually, the spinlock is dropped because alloc_page can sleep, which is a
bug if you are holding a spinlock.

> +		/* QUERY: If this is true, it means someone allocated took this

Typo here.

> +	/* This is a bit subtle
> +	 * The PGD bits of the address are masked out so it's like the first
> +	 * PMD is now at address 0 and end will be size. This way we know not
> +	 * to go beyound the end of the PMD entry
> +	 */

It's not subtle, it's just awkwardly written.  We should have ulong offset and
void *address.  The masking is a meme in Linux mm and does not require a 
comment.

> +		 * QUERY: Again, the return value will be ignored, was it
> +		 *        originally intended to pass this up to the higher
> +		 *        caller functions?

If so, it's a 'fixme'.

> +	/* size reaches the end of the linear address needed for this
> +	 * allocation
> +	 */

This comment is too much like:	x = 1 /* assign 1 to x */

> +		/* Return -ENOMEM if a PMD could not be allocated

Same category as above.

> +		 *
> +		 * NOTE: Doesn't matter what vmalloc_area_pages actually
> +		 *       returns as long as it's non-zero.
> +		 */

But this part is somewhat interesting.

> +		/* QUERY: Dead code? ret was set a few lines ago */
>  		ret = -ENOMEM;

It certainly is.

> +
> +		/* Allocate all the PTE's needed for this PMD and in turn
> +		 * allocate the page frames
> +		 */
>  		if (alloc_area_pmd(pmd, address, end - address, gfp_mask, prot))
>  			break;

Redundant comment.  You can look at the comment on alloc_are_pmd to know that,
and the name says it as well.

Well, I'm only about 20% of the way through the patch and have other work to
attend to.  I suggest that you now try to *remove* as much redundant verbiage
as you can.  You should really assume a somewhat higher level of familiarity
with Linux basics.  Just as a guess, you should end up with less than half
the text you've proposed adding.

That said, I found some of your comments to be informative even though I'm
familiar with this particular piece of code.  For someone not familiar with
it but familiar with Linux in general, your additional comments will save
time in reading the code.

IMHO, with some more work this will be a useful contribution.

-- 
Daniel
