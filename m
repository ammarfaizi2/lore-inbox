Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264559AbTFAM0e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 08:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264555AbTFAM0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 08:26:34 -0400
Received: from bunyip.cc.uq.edu.au ([130.102.2.1]:41997 "EHLO
	bunyip.cc.uq.edu.au") by vger.kernel.org with ESMTP id S263376AbTFAM0a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 08:26:30 -0400
Message-ID: <3ED9ADC5.7060006@torque.net>
Date: Sun, 01 Jun 2003 17:39:49 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-scsi@vger.kernel.org
Subject: Re: [PATCH] SG_IO readcd and various bugs
References: <3ED86687.6000805@torque.net> <20030531105742.GC9561@suse.de>
In-Reply-To: <20030531105742.GC9561@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Sat, May 31 2003, Douglas Gilbert wrote:

>>With the latest changes from Jens (mainly dropping the
>>artificial 64 KB per operation limit) the maximum
>>element size in the block layer SG_IO is:
>>  - 128 KB when direct I/O is not used (i.e. the user
>>    space buffer does not meet bio_map_user()'s
>>    requirements). This seems to be the largest buffer
>>    kmalloc() will allow (in my tests)
> 
> 
> Correct.
> 
> 
>>  - (sg_tablesize * page_size) when direct I/O is used.
>>    My test was with the sym53c8xx_2 driver in which
>>    sg_tablesize==96 so my largest element size was 384 KB
> 
> 
> Or ->max_sectors << 9, whichever is smallest. Really, the limits are in
> the queue. Don't confuse SCSI with block.

The block layer SG_IO ioctl passes through the SCSI
command set to a device that understands it
(i.e. not necessarily a "SCSI" device in the traditional
sense). Other pass throughs exist (or may be needed) for
ATA's task file interface and SAS's management protocol.

Even though my tests, shown earlier in this thread, indicated
that the SG_IO ioctl might be a shade faster than O_DIRECT,
the main reason for having it is to pass through "non-block"
commands to a device. Some examples:
   - special writes (e.g. formating a disk, writing a CD/DVD)
   - uploading firmware
   - reading the defect table from a disk
   - reading and writing special areas on a disk
     (e.g. application client log page)

The reason for choosing this list is that all these
operations potentially move large amounts of data in a
single operation. For such data transfers to be constrained
by max_sectors is questionable. Putting a block paradigm
bypass in the block layer is an interesting design :-)

With these patches in place cdrecord (in RH 9) works via
/dev/hdb (using ide-cd). Cdrecord fails on the same ATAPI
writer via /dev/scd0 because ide-scsi does not set max_sectors
high enough [and the SG_SET_RESERVED_SIZE ioctl reacts
differently in this case to the sg driver].

In summary, I see no reason to constrain the SG_IO ioctl
by max_sectors. SG_IO is a "one shot" with no command
merging or retries. If the HBA driver doesn't like a command,
then it can reject it. [However, currently there is no
mechanism to convey host or HBA driver errors back through
the request queue, only the device (response) status.]

Doug Gilbert


