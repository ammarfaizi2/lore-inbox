Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262315AbUKBWmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbUKBWmB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 17:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbUKBWhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 17:37:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57549 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262417AbUKBWel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:34:41 -0500
Date: Tue, 2 Nov 2004 17:34:08 -0500 (EST)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-105.boston.redhat.com
To: Dave Hansen <haveblue@us.ibm.com>
cc: andrea@novell.com, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64) 
In-Reply-To: <4187FA6D.3070604@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0411021728460.8117-100000@dhcp83-105.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 2 Nov 2004, Dave Hansen wrote:

> This patch:
> 
> > From: Andrea Arcangeli <andrea@novell.com>
> > 
> > - fix silent memleak in the pageattr code that I found while searching
> >   for the bug Andi fixed in the second patch below (basically reference
> >   counting in split page was done on the pmd instead of the pte).
> > 
> > - Part of this patch is also needed to make the above work on x86 (otherwise
> >   one of my new above BUGS() will trigger signalling the fact a bug was
> >   there).  The below patch creates a subtle dependency that (_PAGE_PCD << 24)
> >   must not be zero.  It's not the cleanest thing ever, but since it's an
> >   hardware bitflag I doubt it's going to break.
> > 
> > Signed-off-by: Andi Kleen <ak@suse.de>
> > Signed-off-by: Andrea Arcangeli <andrea@novell.com>
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> > ---
> > 
> >  25-akpm/arch/i386/mm/ioremap.c    |    4 ++--
> >  25-akpm/arch/i386/mm/pageattr.c   |   13 +++++++------
> >  25-akpm/arch/x86_64/mm/ioremap.c  |   14 +++++++-------
> >  25-akpm/arch/x86_64/mm/pageattr.c |   23 ++++++++++++++---------
> >  4 files changed, 30 insertions(+), 24 deletions(-)
> 
> is hitting this BUG() during bootup:
> 
>         /* memleak and potential failed 2M page regeneration */
>         BUG_ON(!page_count(kpte_page));
> 
> in 2.6.10-rc1-mm2.
> 

I've seen the page_count being -1 (not sure why), for a number of pages in
the identity mapped region...So the BUG() on 0 doesn't seem valid to me.
 
Also, in order to tell if the pages should be merged back to create a huge
page, i don't see how the patch differentiates b/w pages that were split
and those that weren't simply based on the page_count....

-Jason



