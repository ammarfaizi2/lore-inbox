Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbVANDuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbVANDuG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 22:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbVANDqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 22:46:48 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:36699 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261906AbVANDmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 22:42:23 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [Evms-devel] dm snapshot problem
Date: Thu, 13 Jan 2005 21:42:26 -0600
User-Agent: KMail/1.5.4
Cc: evms-devel@lists.sourceforge.net, rajesh_ghanekar@persistent.co.in,
       dm-devel@redhat.com, linux-kernel@vger.kernel.org
References: <41E35950.9040201@persistent.co.in> <200501131526.59220.kevcorry@us.ibm.com> <20050113143443.56bd4977.akpm@osdl.org>
In-Reply-To: <20050113143443.56bd4977.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501132142.26663.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 January 2005 16:34, Andrew Morton wrote:
> Kevin Corry <kevcorry@us.ibm.com> wrote:
> > > It would be better if dm could use highmem pages for this operation.
> >
> > What's the appropriate mechanism for telling the kernel to use highmem
> > for these structures? Each of these slabs (dm_io and dm_tio) are created
> > with kmem_cache_create(), and I don't see any corresponding flags in
> > slab.h that mention anything about highmem. Items are allocated from this
> > slab through mempool_alloc() with GFP_NOIO, since we're in the middle of
> > processing I/O requests and don't want to start new I/O in order to get
> > memory. Would it be proper to call mempool_alloc(pool,
> > GFP_NOIO|__GFP_HIGHMEM)?
>
> Oh.  slab structures can only be in lowmem.  I thought that you were saying
> that the actual I/O data was being copied, and only into lowmem pages.

Now that you mention it, the memory pages to hold the copied data is allocated 
at the time the snapshot device is activated, and uses 
alloc_page(GFP_KERNEL). Should we switch this to alloc_page(GFP_HIGHUSER)? I 
don't see many other places in the kernel tree that use this flag.

Of course, the number of these pages is currently a fixed limit per snapshot 
device (as I mentioned in an earlier reply), so it's kind of unlikely that 
these pages are a significant source of the memory usage that we're seeing in 
this test.

I'll see if I can start working on some improved congestion handling in DM. 
Hopefully that will make a noticeable difference.

Thanks for the help!
-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net

