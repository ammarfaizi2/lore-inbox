Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbWH2L6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbWH2L6G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 07:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWH2L6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 07:58:06 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:63896 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964964AbWH2L6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 07:58:05 -0400
Date: Tue, 29 Aug 2006 12:57:37 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: David Howells <dhowells@redhat.com>, axboe@kernel.dk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/18] [PATCH] BLOCK: Don't call block_sync_page() from AFS [try #4]
Message-ID: <20060829115737.GB32714@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chris Wedgwood <cw@f00f.org>, David Howells <dhowells@redhat.com>,
	axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060825193658.11384.8349.stgit@warthog.cambridge.redhat.com> <20060825193709.11384.79794.stgit@warthog.cambridge.redhat.com> <20060827212136.GA12710@tuatara.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060827212136.GA12710@tuatara.stupidest.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2006 at 02:21:36PM -0700, Chris Wedgwood wrote:
> On Fri, Aug 25, 2006 at 08:37:10PM +0100, David Howells wrote:
> 
> > The AFS filesystem specifies block_sync_page() as its sync_page
> > address op, which needs to be checked, and so is commented out for
> > the moment.
> 
> Wouldn't it be better to just let the link/build fail so someone who
> groks AFS internals can look into this?

David wrote most of this code.  But in fact one doesn't need AFS knowledge
to see that it's not needed.

Take a look at block_sync_page:

void block_sync_page(struct page *page)
{
	struct address_space *mapping;

	smp_mb();
	mapping = page_mapping(page);
	if (mapping)
		blk_run_backing_dev(mapping->backing_dev_info, page);
}

so it's a wrapper around blk_run_backing_dev:

static inline void blk_run_backing_dev(struct backing_dev_info *bdi,
				       struct page *page)
{
	if (bdi && bdi->unplug_io_fn)
		bdi->unplug_io_fn(bdi, page);
}

AFS never sets a backing_dev_info on it's own and thus uses
&default_backing_dev_info which sets the unplug_io_fn to
default_unplug_io_fn.  default_unplug_io_fn is a no-op, and thus
block_sync_page does nothing for AFS.

It thus can be safely removed, even without the #if 0

