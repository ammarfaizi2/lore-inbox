Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264643AbTFCIQy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 04:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264619AbTFCIQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 04:16:54 -0400
Received: from ns.suse.de ([213.95.15.193]:43279 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264609AbTFCIQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 04:16:49 -0400
Date: Tue, 3 Jun 2003 10:29:38 +0200
From: Jens Axboe <axboe@suse.de>
To: Douglas Gilbert <dougg@torque.net>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] SG_IO readcd and various bugs
Message-ID: <20030603082938.GG482@suse.de>
References: <3ED86687.6000805@torque.net> <20030531105742.GC9561@suse.de> <3ED9ADC5.7060006@torque.net> <20030602072756.GC2832@suse.de> <3EDC30C7.5060804@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EDC30C7.5060804@torque.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03 2003, Douglas Gilbert wrote:
> Jens Axboe wrote:
> >On Sun, Jun 01 2003, Douglas Gilbert wrote:
> <snip>
> >>The block layer SG_IO ioctl passes through the SCSI
> >>command set to a device that understands it
> >>(i.e. not necessarily a "SCSI" device in the traditional
> >>sense). Other pass throughs exist (or may be needed) for
> >>ATA's task file interface and SAS's management protocol.
> >>
> >>Even though my tests, shown earlier in this thread, indicated
> >>that the SG_IO ioctl might be a shade faster than O_DIRECT,
> >>the main reason for having it is to pass through "non-block"
> >>commands to a device. Some examples:
> >> - special writes (e.g. formating a disk, writing a CD/DVD)
> >> - uploading firmware
> >> - reading the defect table from a disk
> >> - reading and writing special areas on a disk
> >>   (e.g. application client log page)
> >>
> >>The reason for choosing this list is that all these
> >>operations potentially move large amounts of data in a
> >>single operation. For such data transfers to be constrained
> >>by max_sectors is questionable. Putting a block paradigm
> >>bypass in the block layer is an interesting design :-)
> >
> >
> >I think this is nonsense. The block layer will not accept commands
> >that it cannot handle in one go, what would the point of that be?
> >There's no way for us to break down a single command into pieces,
> >we have no idea how to do that. max_sectors _is_ the natural
> >constraint, it's the hardware limit not something I impose through
> >policy. For SCSI it could be bigger in some cases, that's up to the
> >lldd to set though.
> <snip>
> 
> Jens,
> Reviewing the linix-scsi archives, max_sectors was
> introduced around lk 2.4.7 and you were quite active
> in its promotion. There are also posts about problems
> with qlogic HBAs and their need for a limit to maximum
> transfer length. So there is some hardware justification.
> 
> On 11th April 2002 Justin Gibbs posted this in a mail
> about aic7xxx version 6.2.6:
> "2) Set max_sectors to a sane value.  The aic7xxx driver was not
>    updated when this value was added to the host template structure.
>    In more recent kernels, the default setting for this field, 255,
>    can limit our transaction size to 127K.  This often causes the
>    scsi_merge routines to generate 127k followed by 1k I/Os to complete
>    a client transaction.  The command overhead of such small
>    transactions
>    can severely impact performance.  The driver now sets max_sectors to
>    8192 which equates to the 16MB S/G element limit for these cards as
>    expressed in 2K sectors."
> 
> At the time max_sectors defaulted to 255, later it was
> bumped to 256 and is now 1024 in lk 2.5. However Justin's
> post is saying the hardware limit for a data transfer
> associated with a single SCSI command in the aic7xxx
> driver is:
>   sg_tablesize * (2 ** 24) bytes == 2 GB
> as the aic7xxx driver sets sg_tablesize to 128.
> Taking into account the largest practical kmalloc of 128 KB
> (which is not a hardware limitation) this number comes down
> to 16 MB. The 8192 figure that Justin chose is still in place
> in the aic7xxx driver in lk 2.5 and it limits maximum transfer
> size to 4 MB since the unit of max_sectors is now 512 bytes.
> 
> Various projects have reported to me success in transferring
> 8 and 16 MB individual WRITE commands through the sg driver,
> usually with LSI or Adaptec HBAs. The max_sectors==8192
> set by the aic7xxx is the maximum of any driver in the
> ide or the scsi subsystems (both in lk 2.4 and lk 2.5)
> currently. Most drivers are picking up the default value.
> The definition of "max_sectors" states in
> drivers/scsi/hosts.h:
>   "if the host adapter has limitations beside segment count"
> That could be taken to imply if a LLD does not define
> max_sectors then there is no limit.
> 
> In summary, from a HBA drivers point of view, "max_sectors"
> is misnamed (since they transfer bytes) and not precise
> enough to describe any limitations on data transfers they
> may have.
> 
> Apologies in advance for propagating further nonsense.

Wow, that was a long email. I don't have good connectivity these days,
so mail collisions are bound to happen.

As I wrote in the last email to you, it might make sense to introduce a
hard upper limit and a preferred limit. I think you are missing the
point with the latency requirements. If you allow 16MB sg requests in
the queue, you will both have pinned down a _lot_ of memory (that's one
problem) and build up a huge latency queue. And that's not even
considering that it makes _no_ sense from a performance pov to go as
high as 16MB, zero.

The fact is that for some drivers, max_sectors is a hard limit. There's
no way that scsi_ioctl will pass down requests bigger than this, period.
If 512KB is too small for some operations (your firmware case, it makes
sense), then I'm all for fixing that up.

-- 
Jens Axboe

