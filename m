Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbUDCXqY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 18:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbUDCXqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 18:46:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:44005 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262060AbUDCXqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 18:46:22 -0500
Date: Sat, 3 Apr 2004 15:46:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: hch@infradead.org, hugh@veritas.com, vrajesh@umich.edu,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap
 complexity fix
Message-Id: <20040403154608.78e98877.akpm@osdl.org>
In-Reply-To: <20040403232717.GO2307@dualathlon.random>
References: <20040402001535.GG18585@dualathlon.random>
	<Pine.LNX.4.44.0404020145490.2423-100000@localhost.localdomain>
	<20040402011627.GK18585@dualathlon.random>
	<20040401173649.22f734cd.akpm@osdl.org>
	<20040402020022.GN18585@dualathlon.random>
	<20040402104334.A871@infradead.org>
	<20040402164634.GF21341@dualathlon.random>
	<20040403174043.GK2307@dualathlon.random>
	<20040403120227.398268aa.akpm@osdl.org>
	<20040403232717.GO2307@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Sat, Apr 03, 2004 at 12:02:27PM -0800, Andrew Morton wrote:
> > It might be better to switch over to address masking in get_user_pages()
> > and just dump all the compound page logic.  I don't immediately see how the
> 
> I'm all for it, this is how the 2.4 get_user_pages deals with bigpages
> too, I've never enjoyed the compound thing.
> 
> > get_user_pages() caller can subsequently do put_page() against the correct
> > pageframe, but I assume you worked that out?
> 
> see this patch:
> 
> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.23aa2/9910_shm-largepage-18.gz
> 
> it's a two liner fix in follow_page:
> 
> @@ -439,6 +457,8 @@ static struct page * follow_page(struct
>         pmd = pmd_offset(pgd, address);
>         if (pmd_none(*pmd))
>                 goto out;
> +       if (pmd_bigpage(*pmd))
> +               return __pmd_page(*pmd) + (address & BIGPAGE_MASK) / PAGE_SIZE;

OK, that's an x86 solution.  But this addresses the easy part - the messy
part happens where we want to unpin the pages at I/O completion in
bio_release_pages() when the page may not even be in a vma any more..


