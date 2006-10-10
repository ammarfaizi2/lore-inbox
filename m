Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbWJJTbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWJJTbw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 15:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbWJJTbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 15:31:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32732 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030224AbWJJTbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 15:31:50 -0400
Date: Tue, 10 Oct 2006 12:30:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, torvalds@osdl.org,
       Greg KH <gregkh@suse.de>, Justin Forbes <jmforbes@linuxtx.org>,
       linux-kernel@vger.kernel.org, Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Randy Dunlap <rdunlap@xenotime.net>,
       Michael Krufky <mkrufky@linuxtv.org>, Dave Jones <davej@redhat.com>,
       Chuck Wolber <chuckw@quantumlinux.com>, stable@kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] [patch 07/19] invalidate_complete_page() race fix
Message-Id: <20061010123027.f37fe3bb.akpm@osdl.org>
In-Reply-To: <20061010191418.GB11171@kroah.com>
References: <20061010165621.394703368@quad.kroah.org>
	<20061010171451.GH6339@kroah.com>
	<Pine.LNX.4.64.0610101909450.18380@blonde.wat.veritas.com>
	<20061010191418.GB11171@kroah.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 12:14:18 -0700
Greg KH <greg@kroah.com> wrote:

> On Tue, Oct 10, 2006 at 07:12:54PM +0100, Hugh Dickins wrote:
> > On Tue, 10 Oct 2006, Greg KH wrote:
> > 
> > > -stable review patch.  If anyone has any objections, please let us know.
> > > 
> > > ------------------
> > > From: Andrew Morton <akpm@osdl.org>
> > > 
> > > If a CPU faults this page into pagetables after invalidate_mapping_pages()
> > > checked page_mapped(), invalidate_complete_page() will still proceed to remove
> > > the page from pagecache.  This leaves the page-faulting process with a
> > > detached page.  If it was MAP_SHARED then file data loss will ensue.
> > > 
> > > Fix that up by checking the page's refcount after taking tree_lock.
> > 
> > I may have lost the plot, but I think this patch has already proved
> > to cause problems for NFS in 2.6.18: not good to put it into 2.6.17
> > stable while it's awaiting refinement for 2.6.18 stable.
> 
> Ok, I've dropped it now.
> 

It needs invalidate_inode_pages2-ignore-page-refcounts.patch as well.

This patch (invalidate_complete_page() race fix) fixes a cramfs unmount
race and, iirc, a pagefault-vs-invalidate race which Nick was seeing.
So applying both patches would make 2.6.17 a better place, but we could live
without them.
