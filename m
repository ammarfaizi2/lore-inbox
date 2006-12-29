Return-Path: <linux-kernel-owner+w=401wt.eu-S1755045AbWL2Cun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755045AbWL2Cun (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 21:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755046AbWL2Cun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 21:50:43 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:50925 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753902AbWL2Cum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 21:50:42 -0500
Date: Fri, 29 Dec 2006 13:50:06 +1100
From: David Chinner <dgc@sgi.com>
To: Christoph Hellwig <hch@infradead.org>, David Chinner <dgc@sgi.com>,
       Alex Tomas <alex@clusterfs.com>, linux-ext4@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] delayed allocation for ext4
Message-ID: <20061229025006.GN44411608@melbourne.sgi.com>
References: <m37iwjwumf.fsf@bzzz.home.net> <20061223033123.GL44411608@melbourne.sgi.com> <20061223092718.GA26276@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061223092718.GA26276@infradead.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 23, 2006 at 09:27:18AM +0000, Christoph Hellwig wrote:
> On Sat, Dec 23, 2006 at 02:31:23PM +1100, David Chinner wrote:
> > >  - ext4-delayed-allocation.patch
> > >    delayed allocation itself, enabled by "delalloc" mount option.
> > >    extents support is also required. currently it works only
> > >    with blocksize=pagesize.
> > 
> > Ah, that's why you can get away with a page flag - you've ignored
> > the partial page delay state problem. Any plans to use the
> > existing method in the future so we will be able to use ext4 delalloc
> > on machines with a page size larger than 4k?
> 
> I think fixing this up for blocksize < pagesize is an absolute requirement
> to get things merged.  We don't need more filesystems that are crippled
> on half of our platforms.
> 
> Note that recording delayed alloc state at a page granularity in addition
> to just the buffer heads has a lot of advantages aswell and would help
> xfs, too.  But I think it makes a lot more sense to record it as a radix
> tree tag to speed up the gang lookups for delalloc conversion.

I'm not sure it will make that much difference, really.  Looking up
by delalloc tag is only going to save a few tail pages in pagevec we
use for the look up and could be more expensive if delalloc pages
are sparsely distributed through the file.

We'd still have to keep the bufferheads around for partial page
state, and that becomes an interesting exercise in keeping things
coherent between the radix tree and the buffer heads.

Of course, then there's the unwritten state that XFS also carries
around per block (bufferhead) which has all the same issues as the
delalloc state.  I'd hate to have a generic method for handling
delalloc state which is different from the handling of the unwritten
state and needing two different sets of code to handle what is
essentially the same thing....

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
