Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284754AbRLEW0s>; Wed, 5 Dec 2001 17:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284773AbRLEW0h>; Wed, 5 Dec 2001 17:26:37 -0500
Received: from mg01.austin.ibm.com ([192.35.232.18]:42238 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S284768AbRLEW0E>; Wed, 5 Dec 2001 17:26:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Christoph Hellwig <hch@caldera.de>
Subject: Re: gendisk list access (was: [Evms-devel] Unresolved symbols)
Date: Wed, 5 Dec 2001 16:18:33 -0600
X-Mailer: KMail [version 1.2]
Cc: evms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <OFCE7B6713.9A6E1AF1-ON85256B02.004FB1C4@raleigh.ibm.com> <01120514525902.13647@boiler> <20011205225346.A7313@caldera.de>
In-Reply-To: <20011205225346.A7313@caldera.de>
MIME-Version: 1.0
Message-Id: <01120516183303.13647@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 December 2001 15:53, Christoph Hellwig wrote:
> On Wed, Dec 05, 2001 at 02:52:59PM -0600, Kevin Corry wrote:
> > So one of my questions is: what is in store for the gendisk list in 2.5?
> > There is a comment in add_gendisk() about some part of that code going
> > away in 2.5 (although it's vague as to what the comment refers to),
>
> There are two comments, first
>
> * XXX: you should _never_ access this directly.
> *      the only reason this is exported is source compatiblity.
>
> over the declaration of gendisk_head - since 2.5.1-pre2 gendisk_head
> is static and the comment is gone.

Yes, I noticed that. This is why we are trying to find a different method for 
walking the gendisk list. :)

> The second is
>
> *      In 2.5 this will go away. Fix the drivers who rely on
> *      old behaviour.
>
> This is in add_gendisk and means that we currently work around callers
> trying to do add_gendisk on the same structure twice.  This will go away
> as soon as the 'sd' driver is fixed.

Ok.

> > but no
> > corresponding comment in del_gendisk(). Are these two APIs coming or
> > going? I've also noticed get_start_sect() and get_nr_sects() in genhd.c
> > in the latest 2.5 patches. Are there any more new APIs that will be
> > coming?
>
> For early 2.5 the above API will remain - for mid to late 2.5 I plan to
> get rid of per-major gendisk completly.  My design on a replacement is not
> yet written down, but the details are:
>
>  - the minor_shift member moves into the block queue
>  - each block queue gets a pointer to be used for partitioning, this will
>    be opaque to the drivers.
>  - a per-queue 'struct gendisk' equivalent (minus the fields that aren't
> used) will go into above pointer.
>  - partitions will be registered as normal block devices, to the layers
>    outside the partitioning handling there will be no difference between
>    a block device and a partition.
>
> Hope this helps..

Sounds good. Any chance you could just leave out the partitioning stuff and 
let EVMS handle it?

> > In order for EVMS to run this list correctly during volume discovery, and
> > to sufficiently abstract access to the gendisk list variables, and to
> > keep everything SMP safe, it seems we would need APIs such as
> > lock_gendisk_list(), unlock_gendisk_list(), get_gendisk_first(), and
> > get_gendisk_next(). I've included a patch below (against 2.4.16) for
> > genhd.c with examples of these APIs. EVMS could then use these to lock
> > the list, traverse the list and process all entries, and then unlock.
>
> This API looks really ugly to me.  Did you take a look at my 'walk_gendisk'
> patch I sent to the evms list some time ago?  (attached again).
>
> 	Christoph

Agreed, they are ugly. I didn't really write them to try to get them accepted 
or anything, just to generate some discussion.

I must have missed your walk_gendisk() patch the last time (do you remember 
how long ago you posted that?). It looks like it should accomplish just what 
we need for discovery, and provide the correct locking. Of course, Ram is 
gong to shoot me now, since I believe he suggested something like this 
earlier today. :)

We will go with the walk_gendisk() method, and add your genhd.c and genhd.h 
patches to our set of patches for EVMS.

-Kevin
