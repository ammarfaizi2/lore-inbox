Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266211AbUG0BV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266211AbUG0BV7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 21:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266198AbUG0BSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 21:18:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4746 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266210AbUG0BQx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 21:16:53 -0400
Date: Mon, 26 Jul 2004 20:57:00 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Martins Krikis <mkrikis@yahoo.com>, arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] ataraid_end_request hides errors (all? 2.4 kernels)
Message-ID: <20040726235659.GA17761@logos.cnet>
References: <87d62i9w9q.fsf@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d62i9w9q.fsf@yahoo.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 07:36:01PM -0400, Martins Krikis wrote:
> Marcelo,
> 
> I had already written the subject off as "nobody cares"; I'm very 
> glad you responded. Some more comments are below and I'm attaching
> a new patch.

:)

> > The correct thing seems to pass IO error ("!uptodate") to the upper 
> > ->b_end_io callback only in case both components of an IO operation
> > have 
> > failed. As long as at least one of the mirrors have successfully 
> > finished the IO, we should continue operation, providing reliability,
> > AFAICS. 

Note, I'm really ignorant about ataraid, so I might miss something, 
as you just pointed out that I have :) 

Anyway, lets keep going...

> I think you are talking about the RAID-1 read case. In this case
> the ataraid subdrivers just pick one disk among all the possible
> mirrors and submit the request to that. ataraid_end_request() is
> not involved. The fact that most ataraid subdrivers won't resubmit
> the IO to a different mirror if it fails is a very small problem
> compared to what I'm picking on here.
> 
> And that is the following. For RAID1 writes, the IOs have to be
> submitted to all the mirrors. If the IO for _any_ of them fails,
> the upper levels should be notified of the error, because the
> data integrity is broken across mirrors. (With the exception of
> those few subdrivers that are capable of keeping working with the
> volume in "degraded" mode.) 

I supposed all of them would be able to work in degraded mode? No?

> Ataraid_end_request() is widely used
> for the RAID1 write case and thus carries the danger of never
> notifying the upper levels that anything went wrong. 
> 
> Furthermore, for RAID0 reads and writes, the ataraid subdrivers
> widely employ the ataraid_split_request() function in order to 
> get the IO size to fit in just one strip and thus be applicable
> to just one disk. The ataraid_split_request() just splits the 
> request in halves and may get invoked again on each part if they
> still don't fit. Each pair of new IOs that are produced this way 
> are tied together through the use of ataraid_end_request(). Thus, 
> in theory there could be a whole binary tree of requests formed 
> from the "original request". And again, the trouble from using
> ataraid_end_request() is that most of these IOs in the tree could
> go wrong, but as long as the last one succeeds, a chain of
> ataraid_end_request()-s will happily report a successful IO
> completion to each other and eventually back to the upper levels.
> The userland application may never learn about the massive data
> corruption that has just occured. Again, it is my strong belief
> that if _any_ "component IO" fails, the whole "original IO" should
> be failed. 
> 
> Therefore, the patch keeps track of cumulative IO status by using
> an otherwise unused bit from the b_state field in each IO's "parent
> buffer_head". Other solutions exist and I mentioned it before, but I
> think this is the least intrusive and does not require extra memory.
> 
> > About error reporting, indeed the current scheme is very bad and
> > doesnt
> > correctly report errors. We should at least print some warning on 
> > ataraid_end_request() informing of IO errors. 
> 
> I added a printk to the patch to follow your suggestion,
> but I think the main thing is to let the upper levels know.
> 
> > Its not OK to mess with BH_PrivateStart, no, jbd/xfs use it
> > for their own purposes.
> 
> That's very unfortunate, because the comments in fs.h for 2.4 kernels
> and in buffer_head.h for 2.6 kernels make it look like all the bits
> starting with BH_PrivateStart are fair game. Any chance of replacing
> the inviting comment with a big warning, or better yet, officially
> incorporating all the bits used in jbd.h into the b_state?

Well, the comment says

        BH_PrivateStart,/* not a state bit, but the first bit available
                         * for private allocation by other entities
                         */

And "other entities" are some of the journalling filesystems.

When I read the comment, I can't figure out that using it 
freely from anywhere is "fair game". But you seem to understand
otherwise.

Yes, we could stick a stronger indication of "journalling fs'es for instance 
use this". Incorporating the bits in jbd.h into b_state doesnt seem right
because BH_PrivateStart is a generic thing, and not a JBD only thing. 
Does that make sense?

> Best regards,
> 
>   Martins Krikis
> 
> P.S. The patch is untested. I don't have a setup to do this easily.


The "#define BH_IOFailure (BH_PrivateStart + 5) /* jbd.h uses +0 to +4 */" 
is not the cleanest thing in the world, but...

Lets ask the guy who wrote this. Arjan, what you think of this patch?

>From my POV, better to report IO errors than not at all.

> --- linux/drivers/ide/raid/ataraid.c.orig	2004-07-13 23:45:21.000000000 -0400
> +++ linux/drivers/ide/raid/ataraid.c	2004-07-26 18:52:21.000000000 -0400
> @@ -34,7 +34,8 @@
>  
>  #include "ataraid.h"
>  
> -                                        
> +#define BH_IOFailure (BH_PrivateStart + 5) /* jbd.h uses +0 to +4 */
> +
>  static int ataraid_hardsect_size[256];
>  static int ataraid_blksize_size[256];
>  
> @@ -153,7 +154,17 @@ void ataraid_end_request(struct buffer_h
>  	if (private==NULL)
>  		BUG();
>  
> +	if (!uptodate) { 
> +		set_bit(BH_IOFailure, &private->parent->b_state);
> +		printk(KERN_ERR "ataraid: IO error on major %d minor %d\n",
> +		       MAJOR(bh->b_rdev), MINOR(bh->b_rdev));
> +	}		       
> +	
>  	if (atomic_dec_and_test(&private->count)) {
> +		if (test_bit(BH_IOFailure, &private->parent->b_state)) {
> +			uptodate = 0; /* fail the completed original I/O */
> +			clear_bit(BH_IOFailure, &private->parent->b_state);
> +		}
>  		private->parent->b_end_io(private->parent,uptodate);
>  		private->parent = NULL;
>  		kfree(private);
> @@ -194,6 +205,8 @@ static void ataraid_split_request(reques
>  
>  	bh2->b_data +=  bh->b_size/2;
>  
> +	clear_bit(BH_IOFailure, &bh->b_state); /* this bit tracks success */
> +
>  	generic_make_request(rw,bh1);
>  	generic_make_request(rw,bh2);
>  }

