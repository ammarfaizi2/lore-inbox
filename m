Return-Path: <linux-kernel-owner+w=401wt.eu-S932066AbXAKVqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbXAKVqe (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 16:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbXAKVqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 16:46:34 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:49691 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932066AbXAKVqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 16:46:33 -0500
Date: Thu, 11 Jan 2007 13:44:59 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, "Michael Reed" <mdr@sgi.com>,
       "'Zach Brown'" <zach.brown@oracle.com>,
       "'Chris Mason'" <chris.mason@oracle.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Jeremy Higdon" <jeremy@sgi.com>, "David Chinner" <dgc@sgi.com>
Subject: Re: [patch] optimize o_direct on block device - v3
Message-Id: <20070111134459.4b43330d.randy.dunlap@oracle.com>
In-Reply-To: <000001c735c8$8dc1ad00$eb34030a@amr.corp.intel.com>
References: <20070111112901.28085adf.akpm@osdl.org>
	<000001c735c8$8dc1ad00$eb34030a@amr.corp.intel.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Brightmail-Tracker: AAAAAQAAAAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2007 13:36:28 -0800 Chen, Kenneth W wrote:

> Andrew Morton wrote on Thursday, January 11, 2007 11:29 AM
> > On Thu, 11 Jan 2007 13:21:57 -0600
> > Michael Reed <mdr@sgi.com> wrote:
> > > Testing on my ia64 system reveals that this patch introduces a
> > > data integrity error for direct i/o to a block device.  Device
> > > errors which result in i/o failure do not propagate to the
> > > process issuing direct i/o to the device.
> > > 
> > > This can be reproduced by doing writes to a fibre channel block
> > > device and then disabling the switch port connecting the host
> > > adapter to the switch.
> > > 
> > 
> > Does this fix it?
> > 
> > <thwaps Ken>
> 
> 
> Darn, kicking myself in the butt.  Thank you Andrew for fixing this.
> We've also running DIO stress test almost non-stop over the last 30
> days or so and we did uncover another bug in that patch.
> 
> Andrew, would you please take the follow bug fix patch as well.  It
> is critical because it also affects data integrity.
> 
> 
> [patch] fix blk_direct_IO bio preparation.
> 
> For large size DIO that needs multiple bio, one full page worth of data
> was lost at the boundary of bio's maximum sector or segment limits.
> After a bio is full and got submitted.  The outer while (nbytes) { ... }
> loop will allocate a new bio and just march on to index into next page.
> It just forget about the page that bio_add_page() rejected when previous
> bio is full.  Fix it by put the rejected page back to pvec so we pick it
> up again for the next bio.
> 
> 
> Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>
> 
> diff -Nurp linux-2.6.20-rc4/fs/block_dev.c linux-2.6.20.ken/fs/block_dev.c
> --- linux-2.6.20-rc4/fs/block_dev.c	2007-01-06 21:45:51.000000000 -0800
> +++ linux-2.6.20.ken/fs/block_dev.c	2007-01-10 19:54:53.000000000 -0800
> @@ -190,6 +190,12 @@ static struct page *blk_get_page(unsigne
>  	return pvec->page[pvec->idx++];
>  }
>  
> +/* return a pge back to pvec array */

is pge just a typo or some other tla that i don't know?
(not portland general electric or pacific gas & electric)

> +static void blk_unget_page(struct page *page, struct pvec *pvec)
> +{
> +	pvec->page[--pvec->idx] = page;
> +}
> +
>  static ssize_t
>  blkdev_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,
>  		 loff_t pos, unsigned long nr_segs)
> @@ -278,6 +284,8 @@ same_bio:
>  				count = min(count, nbytes);
>  				goto same_bio;
>  			}
> +		} else {
> +			blk_unget_page(page, &pvec);
>  		}
>  
>  		/* bio is ready, submit it */
> -


---
~Randy
