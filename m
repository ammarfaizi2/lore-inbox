Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbUDPEta (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 00:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUDPEta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 00:49:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:18325 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262208AbUDPEt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 00:49:29 -0400
Date: Thu, 15 Apr 2004 21:49:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: kenneth.w.chen@intel.com, linux-kernel@vger.kernel.org,
       linuxppc64-dev@lists.linuxppc.org
Subject: Re: Fix bogus get_page() calls in hugepage code
Message-Id: <20040415214909.4eeb9ea9.akpm@osdl.org>
In-Reply-To: <20040416043726.GA26707@zax>
References: <20040416041231.GB13552@zax>
	<20040415213011.09748d77.akpm@osdl.org>
	<20040416043726.GA26707@zax>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson <david@gibson.dropbear.id.au> wrote:
>
> On Thu, Apr 15, 2004 at 09:30:11PM -0700, Andrew Morton wrote:
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >
> > > On some archs the functions used to implement follow_page() for
> > >  hugepages do a get_page().  This is unlike the normal-page path for
> > >  follow_page(), so presumably a bug.  This patch fixes it.
> > 
> > get_user_pages() is supposed to pin the pages which it placed into the
> > callers pages[] array.
> > 
> > And the caller of get_user_pages() is supposed to unpin those pages when
> > they are finished with.
> > 
> > So follow_hugetlb_page() is currently doing the right thing.  The asymmetry
> > with follow_page() is awkward, but the overall intent was to minimise the
> > amount of impact which the hugepage code has on core MM.
> 
> Yes, but I'm not talking about follow_hugetlb_page() (my patch doesn't
> touch it).  I'm talking about follow_huge_addr() and
> follow_huge_pmd().  These are called to implement follow_page().  In
> get_user_pages(), follow_pages() is bypassed bu the call to
> follow_hugetlb_page(), but these extra get_pages() are presumably a
> bug if follow_page() is called on a hugepage from somewhere other than
> get_user_pages().

Oh, OK.  IIRC that stuff was added to support futexes-in-large-pages.  The
caller holds ->page_table_lock, as does zap_hugepage_range(), so that seems
fine.

> So I think my patch is correct.

yup, thanks.
