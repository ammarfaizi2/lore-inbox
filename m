Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbTIMXK2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 19:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbTIMXK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 19:10:27 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:31194
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262244AbTIMXKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 19:10:25 -0400
Date: Sun, 14 Sep 2003 01:11:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: marcelo.tosatti@cyclades.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.4.23-pre4] page_alloc uninitialised variable bug
Message-ID: <20030913231102.GH21086@dualathlon.random>
References: <200309131939.h8DJdJpj001767@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309131939.h8DJdJpj001767@harpo.it.uu.se>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 09:39:19PM +0200, Mikael Pettersson wrote:
> mm/page_alloc in 2.4.23-pre4 triggers this warning:
> 
> page_alloc.c: In function `balance_classzone':
> page_alloc.c:259: warning: `__freed' might be used uninitialized in this function
> 
> There is a case where balance_classzone() returns NULL and an
> uninitialised value in *freed, and the caller, __alloc_pages(),
> also uses the uninitialised value.
> 
> Changing balance_classzone() to not do "*freed = __freed;" in
> this case is inadequate since __alloc_pages() will still look
> at the bogus value. Someone needs to initialise the damn thing;
> the patch below makes balance_classzone() do it.
> 
> /Mikael
> 
> --- linux-2.4.23-pre4/mm/page_alloc.c.~1~	2003-09-13 19:11:48.000000000 +0200
> +++ linux-2.4.23-pre4/mm/page_alloc.c	2003-09-13 20:58:56.000000000 +0200
> @@ -256,7 +256,7 @@
>  static struct page * balance_classzone(zone_t * classzone, unsigned int gfp_mask, unsigned int order, int * freed)
>  {
>  	struct page * page = NULL;
> -	int __freed;
> +	int __freed = 0;
>  
>  	if (!(gfp_mask & __GFP_WAIT))
>  		goto out;

this wasn't a bug, there is absolutely no need to initialize that, it's
just that gcc is not smart enough to understand that automatically and
it generated a false positive.

the real cleanup is to nuke the !(gfp_mask & __GFP_WAIT) that can't ever
happen if you follow the code. This is exactly what my tree does. Not
sure how this part wasn't merged into mainline.

See my tree:

static struct page * FASTCALL(balance_classzone(zone_t *, unsigned int,
unsigned int, int *));
static struct page * balance_classzone(zone_t * classzone, unsigned int
gfp_mask, unsigned int order, int * freed)
{
	struct page * page = NULL;
	int __freed;

	if (in_interrupt())
		BUG();

	if (current->local_page.page)
		BUG();
	current->local_page.classzone = classzone;
	current->flags |= PF_MEMALLOC | (!order ? PF_FREE_PAGES : 0);

	__freed = try_to_free_pages_zone(classzone, gfp_mask);

no way that __freed is not initialized.

this is the right cleanup for mainline to avoid the harmless compile
time warning. Please test it so Marcelo can apply it. Sorry also for the
delay in the watermark fixes, I finally sorted out a subtle x86-64 bug
yesterday, so I should be able to port the watermark stuff to mainline
early next week.

--- 2.4.23pre4/mm/page_alloc.c.~1~	2003-09-13 00:08:04.000000000 +0200
+++ 2.4.23pre4/mm/page_alloc.c	2003-09-14 01:05:24.000000000 +0200
@@ -258,8 +258,6 @@ static struct page * balance_classzone(z
 	struct page * page = NULL;
 	int __freed;
 
-	if (!(gfp_mask & __GFP_WAIT))
-		goto out;
 	if (in_interrupt())
 		BUG();
 

Thanks,

Andrea

/*
 * If you refuse to depend on closed software for a critical
 * part of your business, these links may be useful:
 *
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.5/
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.4/
 * http://www.cobite.com/cvsps/
 *
 * svn://svn.kernel.org/linux-2.6/trunk
 * svn://svn.kernel.org/linux-2.4/trunk
 */
