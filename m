Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWEHPBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWEHPBD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 11:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWEHPBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 11:01:03 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56496 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932365AbWEHPBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 11:01:00 -0400
Message-ID: <445F5D10.3090401@torque.net>
Date: Mon, 08 May 2006 11:00:32 -0400
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
CC: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] make kernel ignore bogus partitions
References: <20060503210055.GB31048@beardog.cca.cpqcorp.net> <20060508072701.GB15941@apps.cwi.nl>
In-Reply-To: <20060508072701.GB15941@apps.cwi.nl>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> On Wed, May 03, 2006 at 04:00:55PM -0500, Mike Miller (OS Dev) wrote:
> 
>>Patch 1/1
>>Sometimes partitions claim to be larger than the reported capacity of a
>>disk device. This patch makes the kernel ignore those partitions.
>>
>>Signed-off-by: Mike Miller <mike.miller@hp.com>
>>Signed-off-by: Stephen Cameron <steve.cameron@hp.com>
> 
> 
>>+		if (from+size-1 > get_capacity(disk)) {
>>+			printk(" %s: p%d exceeds device capacity, ignoring.\n", 
>>+				disk->disk_name, p);
>>+			continue;
>>+		}
> 
> 
> I debated for a while with myself whether I should like or dislike
> such a patch. On the one hand, this partition stuff is rather messy,
> and if you invent strict rules that partitions should satisfy then
> during the transition lots of people will be unhappy, but afterwards
> the stuff may be less messy.
> 
> On the other hand, such changes do indeed make people unhappy.
> Indeed, with this change one of my systems does not boot anymore.
> 
> There can be reasons, or there can have been reasons, for partitions
> larger than the disk. Maybe the disk has a jumper clipping the capacity
> while in other machines such a jumper is unnecessary, or while soon
> after booting the setmax utility is called to set the disk to full
> capacity again.
> Or, while doing forensics on a disk one copies the start to some
> other disk, and that other disk may be smaller.
> Etc.

Andries,
With the creative use of the MODE SELECT SCSI command
one can "short stroke" a disk, making subsequent READ
CAPACITY commands report less than is actually available.
READ and WRITE commands also would be crimped. For
example a 300 GB SCSI disk could be made to report
a capacity of 1 sector. [see sg_format in sg3_utils]

More practically RAID replacement disks may use this
facility if the firmware wants all disks the same
size and a smaller size disk (e.g. 18 GB SCSI disk) is
no longer available.

Without a product manual in which a manufacturer states
what the number of sectors should be, it may not be
obvious short stroking has occurred.


There are other situations I have come across, that can
be made to work if you know what is happening. When I
put a 160 GB PATA disk in an external USB enclosure that
doesn't support 48 bit lba, then I can't access anything
above the 137 (?) GB mark. By arranging my partitions
accordingly (e.g. 3 under, 1 over) the lower partitions
are still useable in the USB enclosure.

> So, it seems that Linux loses a little bit of its power when such things
> are made impossible.

Doug Gilbert
