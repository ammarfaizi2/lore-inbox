Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbUDPEj1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 00:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUDPEj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 00:39:27 -0400
Received: from ozlabs.org ([203.10.76.45]:61336 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262022AbUDPEjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 00:39:25 -0400
Date: Fri, 16 Apr 2004 14:37:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: kenneth.w.chen@intel.com, linux-kernel@vger.kernel.org,
       linuxppc64-dev@lists.linuxppc.org
Subject: Re: Fix bogus get_page() calls in hugepage code
Message-ID: <20040416043726.GA26707@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, kenneth.w.chen@intel.com,
	linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
References: <20040416041231.GB13552@zax> <20040415213011.09748d77.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040415213011.09748d77.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 09:30:11PM -0700, Andrew Morton wrote:
> David Gibson <david@gibson.dropbear.id.au> wrote:
> >
> > On some archs the functions used to implement follow_page() for
> >  hugepages do a get_page().  This is unlike the normal-page path for
> >  follow_page(), so presumably a bug.  This patch fixes it.
> 
> get_user_pages() is supposed to pin the pages which it placed into the
> callers pages[] array.
> 
> And the caller of get_user_pages() is supposed to unpin those pages when
> they are finished with.
> 
> So follow_hugetlb_page() is currently doing the right thing.  The asymmetry
> with follow_page() is awkward, but the overall intent was to minimise the
> amount of impact which the hugepage code has on core MM.

Yes, but I'm not talking about follow_hugetlb_page() (my patch doesn't
touch it).  I'm talking about follow_huge_addr() and
follow_huge_pmd().  These are called to implement follow_page().  In
get_user_pages(), follow_pages() is bypassed bu the call to
follow_hugetlb_page(), but these extra get_pages() are presumably a
bug if follow_page() is called on a hugepage from somewhere other than
get_user_pages().

So I think my patch is correct.

> Aside: note that get_user_pages() doesn't hold page_table_lock while
> walking the pagetables, whereas it does hold that lock while walking the
> regular pages' pagetables.  This is because the caller of get_user_pages()
> holds down_read(mmap_sem), whereas hugetlb pagetable setup and teardown
> always happens under down_write(mmap_sem).

Ah, that's useful to know.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
