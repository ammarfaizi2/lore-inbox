Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbUKKC12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbUKKC12 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 21:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbUKKC12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 21:27:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:55736 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262082AbUKKC1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 21:27:23 -0500
Date: Wed, 10 Nov 2004 18:26:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: dhowells@redhat.com, hch@infradead.org, torvalds@osdl.org,
       davidm@snapgear.com, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org,
       Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH] VM routine fixes
Message-Id: <20041110182659.3f8138d6.akpm@osdl.org>
In-Reply-To: <1100135833.4631.10.camel@localhost.localdomain>
References: <20041109140122.GA5388@infradead.org>
	<20041109125539.GA4867@infradead.org>
	<200411081432.iA8EWfmh023432@warthog.cambridge.redhat.com>
	<15068.1100008386@redhat.com>
	<4530.1100093877@redhat.com>
	<20041110110145.3751ae17.akpm@osdl.org>
	<1100135833.4631.10.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Wed, 2004-11-10 at 11:01 -0800, Andrew Morton wrote:
> > Why _does_ !CONFIG_MMU futz around with page counts in such weird ways
> > anyway?  Why does it have requirements for higher-order pages which differ
> > from !CONFIG_MMU?
> 
> Because in the absence of an MMU, an mmap of a large region (like an
> executable) has to be satisfied by a large enough allocation followed by
> a read.

That's currently implemented via this:

	/*
	 * We need to reference all the pages for this order, otherwise if
	 * anyone accesses one of the pages with (get/put) it will be freed.
	 */
	for (i = 0; i < (1 << order); i++)
		set_page_count(page+i, 1);

I assume the CONFIG_MMU logic assumes that it's legal to physically free a
single page from inside the middle of a higher-order page.  I wonder if the
no-buddy-bitmap patches allow that?  And if they've been tested with that?

See, if we enable the compound page logic if !CONFIG_MMU then all this
stuff just goes away and the page refcounting is controlled purely by the
head page.  A get_page() or a put_page() against any of the constituent
pages will manipulate the head page's refcount.

> > If someone could explain the reasoning behind the current code, and the FRV
> > enhancements then perhaps we could work something out.
> 
> I think these parts aren't FRV-specific; they're the fixes required to
> do proper shared readable mmap with !CONFIG_MMU. That was a prerequisite
> for the ELF-FDPIC executable format, which allows real shared libraries
> on uClinux.
> 

OK.
