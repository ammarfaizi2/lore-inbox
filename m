Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWHJTtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWHJTtb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWHJTrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:47:41 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:36038 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932681AbWHJTh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:26 -0400
Subject: Re: [Ext2-devel] [PATCH 1/5] Forking ext4 filesystem from ext3
	filesystem
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060810122340.185b8d8f.akpm@osdl.org>
References: <1155172622.3161.73.camel@localhost.localdomain>
	 <20060809233914.35ab8792.akpm@osdl.org> <44DB8036.5020706@us.ibm.com>
	 <20060810122340.185b8d8f.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 14:36:10 -0500
Message-Id: <1155238570.12082.11.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-10 at 12:23 -0700, Andrew Morton wrote:
> On Thu, 10 Aug 2006 11:51:34 -0700
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> 
> > Andrew Morton wrote:
> > > Also, JBD is presently feeding into submit_bh() buffer_heads which span two
> > > machine pages, and some device drivers spit the dummy.  It'd be better to
> > > fix that once, rather than twice..  
> > >   
> > Andrew,
> > 
> > I looked at this few days ago. I am not sure how we end up having 
> > multiple pages (especially,
> > why we end up having buffers with bh_size > pagesize) ? Do you know why ?
> > 
> 
> It's one or both of the jbd_kmalloc(bh->b_size) calls in
> fs/jbd/transaction.c.  Here we're allocating data to attach to a bh which
> later gets fed into submit_bh().
> 
> Problem is, with CONFIG_DEBUG_SLAB=y, the data which kmalloc() returns can
> be offset by 4 bytes due to redzoning.
> 
> Example: if the fs is using a 1k blocksize and we have a 4k pagesize, the
> data coming back from kmalloc may have an address of 0xnnnnxc04, so the
> data which we later feed into submit_bh() will span two pages.
> 
> A simple fix would be to replace kmalloc() with a call to alloc_page(). 
> We'd need to work out how much memory that will worst-case-waste.  If "not
> much" then OK.
> 
> If "quite a lot in the worst case" then we'd need something more elaborate.

Would some like this be okay:

#ifdef CONFIG_DEBUG_SLAB
	return alloc_page(...
#else
	return kmalloc(...
#endif

This keeps it simple, and should be still be efficient in the
non-DEBUG_SLAB case.

>  I'd suggest that ext3 implement ext3-private slab caches of size 1024,
> 2048, 4096 and perhaps 8192.  Those caches should be kmem_cache_create()d
> on-demand at mount-time.  They should be created with appropriate slab
> options to defeat the redzoning.  The transaction.c code should use the
> appropriate slab (based on b_size) rather than using kmalloc().  The
> up-to-four private slab caches should be destroyed on ext3 rmmod.
-- 
David Kleikamp
IBM Linux Technology Center

