Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbVLLUNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbVLLUNo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 15:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbVLLUNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 15:13:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58517 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932163AbVLLUNm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 15:13:42 -0500
Date: Mon, 12 Dec 2005 12:12:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: hch@infradead.org, fujita.tomonori@lab.ntt.co.jp, michaelc@cs.wisc.edu,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       open-iscsi@googlegroups.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: allowed pages in the block later, was Re: [Ext2-devel] [PATCH]
 ext3: avoid sending down non-refcounted pages
Message-Id: <20051212121208.4c7421ce.akpm@osdl.org>
In-Reply-To: <20051212172552.GA28652@infradead.org>
References: <20051208180900T.fujita.tomonori@lab.ntt.co.jp>
	<20051208101833.GM14509@schatzie.adilger.int>
	<20051208134239.GA13376@infradead.org>
	<20051210164736.6e4eaa3f.akpm@osdl.org>
	<20051212172552.GA28652@infradead.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, Dec 10, 2005 at 04:47:36PM -0800, Andrew Morton wrote:
> > Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > The problem we're trying to solve here is how do implement network block
> > >  devices (nbd, iscsi) efficiently.  The zero copy codepath in the networking
> > >  layer does need to grab additional references to pages.  So to use sendpage
> > >  we need a refcountable page.  pages used by the slab allocator are not
> > >  normally refcounted so try to do get_page/pub_page on them will break.
> > 
> > I don't get it.  Doing get_page/put_page on a slab-allocated page should do
> > the right thing?
> 
> As Arjan mentioned, what would be the right thing?  Delaying returning the
> page to the page pool and disallow reuse until page count reaches zero?

Yes, that's what'll happen.  slab will put its final ref to the page, so
whoever did that intervening get_page() ends up owning the page.

> All this seems highly impractical.

Well, as Arjan points out, doing get_page() won't prevent slab from
"freeing" a part of the page and reusing it for another object of the same
type.

