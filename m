Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbTFBHOf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 03:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbTFBHOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 03:14:35 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:28299 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261985AbTFBHOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 03:14:31 -0400
Date: Mon, 2 Jun 2003 09:27:56 +0200
From: Jens Axboe <axboe@suse.de>
To: Douglas Gilbert <dougg@torque.net>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] SG_IO readcd and various bugs
Message-ID: <20030602072756.GC2832@suse.de>
References: <3ED86687.6000805@torque.net> <20030531105742.GC9561@suse.de> <3ED9ADC5.7060006@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ED9ADC5.7060006@torque.net>
User-Agent: Mutt/1.4i
X-OS: Linux 2.4.21-pre6-axboe i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 01 2003, Douglas Gilbert wrote:
> Jens Axboe wrote:
> >On Sat, May 31 2003, Douglas Gilbert wrote:
> 
> >>With the latest changes from Jens (mainly dropping the
> >>artificial 64 KB per operation limit) the maximum
> >>element size in the block layer SG_IO is:
> >> - 128 KB when direct I/O is not used (i.e. the user
> >>   space buffer does not meet bio_map_user()'s
> >>   requirements). This seems to be the largest buffer
> >>   kmalloc() will allow (in my tests)
> >
> >
> >Correct.
> >
> >
> >> - (sg_tablesize * page_size) when direct I/O is used.
> >>   My test was with the sym53c8xx_2 driver in which
> >>   sg_tablesize==96 so my largest element size was 384 KB
> >
> >
> >Or ->max_sectors << 9, whichever is smallest. Really, the limits are in
> >the queue. Don't confuse SCSI with block.
> 
> The block layer SG_IO ioctl passes through the SCSI
> command set to a device that understands it
> (i.e. not necessarily a "SCSI" device in the traditional
> sense). Other pass throughs exist (or may be needed) for
> ATA's task file interface and SAS's management protocol.
> 
> Even though my tests, shown earlier in this thread, indicated
> that the SG_IO ioctl might be a shade faster than O_DIRECT,
> the main reason for having it is to pass through "non-block"
> commands to a device. Some examples:
>   - special writes (e.g. formating a disk, writing a CD/DVD)
>   - uploading firmware
>   - reading the defect table from a disk
>   - reading and writing special areas on a disk
>     (e.g. application client log page)
> 
> The reason for choosing this list is that all these
> operations potentially move large amounts of data in a
> single operation. For such data transfers to be constrained
> by max_sectors is questionable. Putting a block paradigm
> bypass in the block layer is an interesting design :-)

I think this is nonsense. The block layer will not accept commands
that it cannot handle in one go, what would the point of that be?
There's no way for us to break down a single command into pieces,
we have no idea how to do that. max_sectors _is_ the natural
constraint, it's the hardware limit not something I impose through
policy. For SCSI it could be bigger in some cases, that's up to the
lldd to set though.

> With these patches in place cdrecord (in RH 9) works via
> /dev/hdb (using ide-cd). Cdrecord fails on the same ATAPI
> writer via /dev/scd0 because ide-scsi does not set max_sectors
> high enough [and the SG_SET_RESERVED_SIZE ioctl reacts
> differently in this case to the sg driver].

ide-scsi bug.

> In summary, I see no reason to constrain the SG_IO ioctl
> by max_sectors. SG_IO is a "one shot" with no command
> merging or retries. If the HBA driver doesn't like a command,
> then it can reject it. [However, currently there is no
> mechanism to convey host or HBA driver errors back through
> the request queue, only the device (response) status.]

It breaks existing applications too, which is at least a very
good reason in my book. I think your position is naive. The
driver explicitly asked not to get request bigger than a certain
size, and know you want to rely on the correct handling of that
case? Won't happen.

BTW, if you want me to read emails somewhat reliably, cc me.

Jens

