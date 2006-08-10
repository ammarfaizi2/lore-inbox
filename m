Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751499AbWHJT5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbWHJT5r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWHJTzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:55:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20652 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751094AbWHJTyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:54:45 -0400
Date: Thu, 10 Aug 2006 12:54:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 1/5] Forking ext4 filesystem from ext3
 filesystem
Message-Id: <20060810125429.6dded9b6.akpm@osdl.org>
In-Reply-To: <1155238570.12082.11.camel@kleikamp.austin.ibm.com>
References: <1155172622.3161.73.camel@localhost.localdomain>
	<20060809233914.35ab8792.akpm@osdl.org>
	<44DB8036.5020706@us.ibm.com>
	<20060810122340.185b8d8f.akpm@osdl.org>
	<1155238570.12082.11.camel@kleikamp.austin.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 14:36:10 -0500
Dave Kleikamp <shaggy@austin.ibm.com> wrote:

> On Thu, 2006-08-10 at 12:23 -0700, Andrew Morton wrote:
> > On Thu, 10 Aug 2006 11:51:34 -0700
> > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > 
> > > Andrew Morton wrote:
> > > > Also, JBD is presently feeding into submit_bh() buffer_heads which span two
> > > > machine pages, and some device drivers spit the dummy.  It'd be better to
> > > > fix that once, rather than twice..  
> > > >   
> > > Andrew,
> > > 
> > > I looked at this few days ago. I am not sure how we end up having 
> > > multiple pages (especially,
> > > why we end up having buffers with bh_size > pagesize) ? Do you know why ?
> > > 
> > 
> > It's one or both of the jbd_kmalloc(bh->b_size) calls in
> > fs/jbd/transaction.c.  Here we're allocating data to attach to a bh which
> > later gets fed into submit_bh().
> > 
> > Problem is, with CONFIG_DEBUG_SLAB=y, the data which kmalloc() returns can
> > be offset by 4 bytes due to redzoning.
> > 
> > Example: if the fs is using a 1k blocksize and we have a 4k pagesize, the
> > data coming back from kmalloc may have an address of 0xnnnnxc04, so the
> > data which we later feed into submit_bh() will span two pages.
> > 
> > A simple fix would be to replace kmalloc() with a call to alloc_page(). 
> > We'd need to work out how much memory that will worst-case-waste.  If "not
> > much" then OK.
> > 
> > If "quite a lot in the worst case" then we'd need something more elaborate.
> 
> Would some like this be okay:
> 
> #ifdef CONFIG_DEBUG_SLAB
> 	return alloc_page(...
> #else
> 	return kmalloc(...
> #endif
> 
> This keeps it simple, and should be still be efficient in the
> non-DEBUG_SLAB case.
> 

I guess that would work OK.  It does appear that a lot of people build and
distribute CONFIG_DEBUG_SLAB kernels though.  Fedora, for one.
