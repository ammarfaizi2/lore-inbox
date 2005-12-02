Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932588AbVLBA7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbVLBA7W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 19:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbVLBA7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 19:59:21 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:14510 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932588AbVLBA7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 19:59:21 -0500
Message-ID: <438F9C66.6040209@us.ibm.com>
Date: Thu, 01 Dec 2005 16:59:18 -0800
From: Mingming Cao <cmm@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: ext2-devel <Ext2-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, akpm@osdl.org, sct@redhat.com,
       hch@lst.de
Subject: Re: [PATCH] ext3 getblocks() support for read
References: <1133368019.27824.55.camel@localhost.localdomain>
In-Reply-To: <1133368019.27824.55.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> Hi,
> 
> Here is the patch to support ext3 getblocks() for non allocation
> cases. (for reads & re-writes). This is useful with DIO reads,
> DIO re-writes and to go with Christoph's getblocks() for readpages()
> work.
> 
> Mingming is working on adding multiblock allocation support using
> reservation (which can be incrementally added later).
> 
> Comments ? 
> 

My ext3 multiple block allocation patch posted a while ago
includes the multiple blocks map as well. Looks mostly the same way you 
did here, but I like the way that how the # of mapped(or allocated) 
blocks are returned.

My plan is to break the whole ext3 multiple block allocation(also does 
map) patch into small patches, and re-send soon.

> @@ -681,9 +683,10 @@ ext3_get_block_handle(handle_t *handle, 
>  	Indirect *partial;
>  	unsigned long goal;
>  	int left;
> -	int boundary = 0;
> -	const int depth = ext3_block_to_path(inode, iblock, offsets, &boundary);
> +	int blks_boundary = 0;
> +	const int depth = ext3_block_to_path(inode, iblock, offsets, &blks_boundary);
>  	struct ext3_inode_info *ei = EXT3_I(inode);
> +	int count = 1;
>  
>  	J_ASSERT(handle != NULL || create == 0);
>  
> @@ -694,7 +697,18 @@ ext3_get_block_handle(handle_t *handle, 
>  
>  	/* Simplest case - block found, no allocation needed */
>  	if (!partial) {
> +		unsigned long first_block = le32_to_cpu(chain[depth-1].key);
> +
>  		clear_buffer_new(bh_result);
> +
> +		/*
> +		 * Find all the contiguous blocks and return at once.
> +		 */
> +		while (count < max_blocks && count <= blks_boundary &&
> +			(le32_to_cpu(*(chain[depth-1].p+count)) == 
> +				(first_block + count))) {
> +			count++;
> +		}
>  		goto got_it;
>  	}
> 
Here we need to be careful about the branch we just read, since we are 
looking up multiple blocks (they are on the same branch) at the same 
time, it is possible that during the look up, another threads is 
trucating the same branch we are trying to map.  Before since we are 
doing only one look up, a simple verify_chain() should be safe.

The simple way is, for the non-allocation case,  take the truncate_sem 
before the ext3_get_branch, like for the allocation-case, even for the 
simple case -- but that probably will slow down the non-allocation, 
probably a bad option.  But we could re-check(calling 
verify_chain())inside the while loop.


Mingming

