Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbVLKIoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbVLKIoO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 03:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbVLKIoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 03:44:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:1216 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751346AbVLKIoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 03:44:13 -0500
Subject: Re: allowed pages in the block later, was Re: [Ext2-devel] [PATCH]
	ext3: avoid sending down non-refcounted pages
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       open-iscsi@googlegroups.com, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org, michaelc@cs.wisc.edu,
       fujita.tomonori@lab.ntt.co.jp, Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20051210164736.6e4eaa3f.akpm@osdl.org>
References: <20051208180900T.fujita.tomonori@lab.ntt.co.jp>
	 <20051208101833.GM14509@schatzie.adilger.int>
	 <20051208134239.GA13376@infradead.org>
	 <20051210164736.6e4eaa3f.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 11 Dec 2005 09:44:04 +0100
Message-Id: <1134290645.2878.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-10 at 16:47 -0800, Andrew Morton wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> >
> > The problem we're trying to solve here is how do implement network block
> >  devices (nbd, iscsi) efficiently.  The zero copy codepath in the networking
> >  layer does need to grab additional references to pages.  So to use sendpage
> >  we need a refcountable page.  pages used by the slab allocator are not
> >  normally refcounted so try to do get_page/pub_page on them will break.
> 
> I don't get it.  Doing get_page/put_page on a slab-allocated page should do
> the right thing?

but it doesn't stop the kfree from freeing the memory; zero copy needs
the content of the memory to stay around afterwards, eg it wants to
delay the kfree until the data is over the wire, which is an
asynchronous event versus the actual send command in a zero-copy
situation. 

