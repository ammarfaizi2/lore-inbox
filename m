Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264947AbTFCGlL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 02:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264944AbTFCGlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 02:41:11 -0400
Received: from CPE-203-51-33-237.nsw.bigpond.net.au ([203.51.33.237]:4480 "EHLO
	didi") by vger.kernel.org with ESMTP id S264943AbTFCGlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 02:41:07 -0400
Date: Tue, 3 Jun 2003 15:39:51 +1000
From: Nick Piggin <piggin@cyberone.com.au>
To: Douglas Gilbert <dougg@torque.net>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] SG_IO readcd and various bugs
Message-ID: <20030603053951.GA292@didi>
Mail-Followup-To: Douglas Gilbert <dougg@torque.net>,
	Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <3ED86687.6000805@torque.net> <20030531105742.GC9561@suse.de> <3ED9ADC5.7060006@torque.net> <20030602072756.GC2832@suse.de> <3EDC30C7.5060804@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EDC30C7.5060804@torque.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03, 2003 at 03:23:19PM +1000, Douglas Gilbert wrote:
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
> currently.

I would just like to add my 2c here, and say that 16MB
requests are just a bit too big for a general purpose
installation, and using any of the available IO schedulers.

The grainularity and disparity between large and small
requests is just too large. I know AS wouldn't cope well
with requests that large in a general purpose situation
(general purpose being < 4000 disks :P )

I would be really interested in seeing benchmarks which
showed a significant performance improvement when going
from say 128K requests to say 16MB. Even in the most
favourable conditions for big request sizes, I'd say
128K should be getting toward the point of diminishing
returns.

Nick
