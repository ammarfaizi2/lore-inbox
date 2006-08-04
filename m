Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161202AbWHDPTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161202AbWHDPTL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 11:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161204AbWHDPTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 11:19:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29118 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161202AbWHDPTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 11:19:09 -0400
Date: Fri, 4 Aug 2006 08:18:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: hch@infradead.org, gregkh@suse.de, linux-kernel@vger.kernel.org,
       stable@kernel.org, torvalds@osdl.org, jmforbes@linuxtx.org,
       zwane@arm.linux.org.uk, tytso@mit.edu, rdunlap@xenotime.net,
       davej@redhat.com, chuckw@quantumlinux.com, reviews@ml.cw.f00f.org,
       alan@lxorguk.ukuu.org.uk, jes@trained-monkey.org, jes@sgi.com
Subject: Re: [patch 12/23] invalidate_bdev() speedup
Message-Id: <20060804081806.3c06d101.akpm@osdl.org>
In-Reply-To: <1154696949.2996.25.camel@laptopd505.fenrus.org>
References: <20060804053258.391158155@quad.kroah.org>
	<20060804053942.GM769@kroah.com>
	<20060804085012.GA20026@infradead.org>
	<20060804020422.09b32164.akpm@osdl.org>
	<1154696949.2996.25.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Aug 2006 15:08:49 +0200
Arjan van de Ven <arjan@infradead.org> wrote:

> On Fri, 2006-08-04 at 02:04 -0700, Andrew Morton wrote:
> > On Fri, 4 Aug 2006 09:50:13 +0100
> > Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > > On Thu, Aug 03, 2006 at 10:39:42PM -0700, Greg KH wrote:
> > > > -stable review patch.  If anyone has any objections, please let us know.
> > > 
> > > This is a feature.  Definitly not -stable material.
> > 
> > Apparently that regular IPI storm is causing the SGI machines some
> > significant problems. 
> 
> a tiny performance drop :) If that meets the stable policy.. open
> question :)

The interrupt holdoff problem is one which is important to Altix users (for
reasons which I've never understood).  Apparently, quite important - this
is I think the third time we've fixed problems in this area for Altix.

> > It's not the biggest problem we've ever had, but if this patch is wrong,
> > the pagecache/buffer_head layer is utterly busted.  And it isn't.
> 
> 
> are you sure?
> 
> +       struct address_space *mapping = bdev->bd_inode->i_mapping;
> +
> +       if (mapping->nrpages == 0)
> +               return;
> +
>         invalidate_bh_lrus();
> 
> what happens if a bdev used to have pagecache and at some point stops
> having that due to page reclaim... will that page reclaim call
> invalidate_bh_lrus() ? If not, who will ? If the answer is "nobody", is
> that really the right answer?

invalidate_bdev() calls invalidate_bh_lrus() to release any references
which the bh lru has against the the bdev's pagecache, so that
invalidate_inode_pages() can take down the bdev's pagecache.

If the bdev has no pagecache then there's no need to call
invalidate_bh_lrus(). (or invalidate_inode_pages, or truncate_inode_pages, btw)

(In fact, even if the inode _does_ have pagecache, we still don't need to
call invalidate_bh_lrus(): both invalidate_inodes_pages() and
truncate_inode_pages() will still remove this page from the inode.  The bh
lru is left holding the last reference to the now-anonymous page, and this
will later expire, finally freeing the page).


