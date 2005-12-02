Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932695AbVLBBJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbVLBBJi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 20:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbVLBBJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 20:09:37 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:25295 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932691AbVLBBJg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 20:09:36 -0500
Subject: Re: [PATCH] ext3 getblocks() support for read
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: ext2-devel <Ext2-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, akpm@osdl.org, sct@redhat.com,
       hch@lst.de
In-Reply-To: <438F9C66.6040209@us.ibm.com>
References: <1133368019.27824.55.camel@localhost.localdomain>
	 <438F9C66.6040209@us.ibm.com>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 17:09:45 -0800
Message-Id: <1133485785.21429.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-01 at 16:59 -0800, Mingming Cao wrote:
> Badari Pulavarty wrote:
> > Hi,
> > 
> > Here is the patch to support ext3 getblocks() for non allocation
> > cases. (for reads & re-writes). This is useful with DIO reads,
> > DIO re-writes and to go with Christoph's getblocks() for readpages()
> > work.
> > 
> > Mingming is working on adding multiblock allocation support using
> > reservation (which can be incrementally added later).
> > 
> > Comments ? 
> > 
> 
> My ext3 multiple block allocation patch posted a while ago
> includes the multiple blocks map as well. Looks mostly the same way you 
> did here, but I like the way that how the # of mapped(or allocated) 
> blocks are returned.
> 
> My plan is to break the whole ext3 multiple block allocation(also does 
> map) patch into small patches, and re-send soon.

Cool. Can you handle this one too then ?

> 
> > @@ -681,9 +683,10 @@ ext3_get_block_handle(handle_t *handle, 
> >  	Indirect *partial;
> >  	unsigned long goal;
> >  	int left;
> > -	int boundary = 0;
> > -	const int depth = ext3_block_to_path(inode, iblock, offsets, &boundary);
> > +	int blks_boundary = 0;
> > +	const int depth = ext3_block_to_path(inode, iblock, offsets, &blks_boundary);
> >  	struct ext3_inode_info *ei = EXT3_I(inode);
> > +	int count = 1;
> >  
> >  	J_ASSERT(handle != NULL || create == 0);
> >  
> > @@ -694,7 +697,18 @@ ext3_get_block_handle(handle_t *handle, 
> >  
> >  	/* Simplest case - block found, no allocation needed */
> >  	if (!partial) {
> > +		unsigned long first_block = le32_to_cpu(chain[depth-1].key);
> > +
> >  		clear_buffer_new(bh_result);
> > +
> > +		/*
> > +		 * Find all the contiguous blocks and return at once.
> > +		 */
> > +		while (count < max_blocks && count <= blks_boundary &&
> > +			(le32_to_cpu(*(chain[depth-1].p+count)) == 
> > +				(first_block + count))) {
> > +			count++;
> > +		}
> >  		goto got_it;
> >  	}
> > 
> Here we need to be careful about the branch we just read, since we are 
> looking up multiple blocks (they are on the same branch) at the same 
> time, it is possible that during the look up, another threads is 
> trucating the same branch we are trying to map.  Before since we are 
> doing only one look up, a simple verify_chain() should be safe.
> 
> The simple way is, for the non-allocation case,  take the truncate_sem 
> before the ext3_get_branch, like for the allocation-case, even for the 
> simple case -- but that probably will slow down the non-allocation, 
> probably a bad option.  But we could re-check(calling 
> verify_chain())inside the while loop.

I don't think we can slowdown non-allocation read case, may be re-check
is a better idea ?

Thanks,
Badari

