Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130570AbRAURFV>; Sun, 21 Jan 2001 12:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130792AbRAURFM>; Sun, 21 Jan 2001 12:05:12 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:41978 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S130570AbRAURE6>;
	Sun, 21 Jan 2001 12:04:58 -0500
Message-Id: <5.0.2.1.2.20010121170306.00ab7ec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Sun, 21 Jan 2001 17:05:07 +0000
To: Andries Brouwer <aeb@veritas.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Getting the number of 512-byte sectors?
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Andries, LKML,
>
>Referring to an old email I was just rereading:
>
>At 01:29 02/10/2000, Andries Brouwer wrote:
>On Mon, Oct 02, 2000 at 02:33:20AM +0200, Daniel Phillips wrote:
>[snip]
>> >unsigned long maxsector = (blk_size[major][MINOR(bh->b_rdev)] << 1) + 1;
>>blk_size[][] gives a block count
>>blk_size[][]<<1 gives a sector count
>>
>>but if the device had an odd number of sectors, the sector count
>>is one larger than twice the block count.
>>
>>(thus, this is not the precisely correct test; the knowledge about
>>the number of sectors lives in the dev->sizes array; here we only
>>have a rough check)
>
>But according to drivers/block/blkpg.c, (direct quote): "hd_struct has the 
>number of 512-byte sectors, g->sizes[] and blk_size[][] have the number of 
>1024-byte blocks". Assuming the "dev" you refer to == the "g" blkpg.c 
>refers to, the dev->sizes array is also not what is needed for the correct 
>test? Looking at blkpg.c, g->sizes is initialized to plength >> 
>(BLOCK_SIZE_BITS - 9) so it is 1024 byte blocks, indeed.
>
>My question is how to get the _real_ number of sectors of a partition from 
>within a file system. I.e. we are starting only with the knowledge of the 
>struct super_block for the partition.
>
>Also, I need to know the starting offset of the data inside the partition. 
>- I am probably explaining this wrong but what I mean is that I want the 
>values "First Sector", "Last Sector" and "Offset" as shown by running
>         cfdisk /dev/hda
>and selecting "Print", "Sectors".
>
>Alternatively, it would suffice to obtain the subtracted values, ie. the 
>data starting sector = "First Sector + Offset" and the number of sectors = 
>"Last Sector" - ("First Sector" + "Offset"). I.e. what is shown by:

I meant number of sectors = "Last Sector" - ("First Sector" + "Offset") + 1 
of course.

Anton

>         fdisk /dev/hda
>and selecting: u (to change to units = sectors), followed by p (to display 
>the partition table) and then the values of interest are "Start" and 
>"End", from which the number of sectors can be calculated from.
>
>Are these "subtracted" values what is present in the "struct hd_struct 
>*part" that can be found inside "struct gendisk"?
>
>Assuming that hd_struct does contain the subtracted values as described 
>above, is the following procedure A) correct? and B) the best way to 
>obtain them?
>
>Locate the correct gendisk structure by performing a walk of gendisk_head 
>as done in drivers/block/blkpg.c::get_gendisk(kdev_t), (Could we make this 
>function to not be private to blkpg.c?), then get the hd_struct for the 
>partition and obtain the values from that. In code:
>
>struct gendisk *g = get_gendisk(my_super_block->s_dev)
>struct hd_struct *hd = &g->part[MINOR(my_super_block->s_dev)];
>
>wanted "subtracted" values:
>         hd->start_sect
>         hd->nr_sects
>
>Am I missing something? Is the meaning of the values in hd_struct 
>different from what I think it is?
>
>Note: I know I can normally get the number of sectors from the boot sector 
>of the partition but in this case please assume that there is no boot 
>sector present or that it is corrupt or that the values in it cannot be 
>relied on due to weird things done by the 'other OS'.
>
>Thanks a lot for your help in advance.
>
>Best regards,
>
>         Anton
>
>--
>    "Programmers never die. They do a GOSUB without RETURN." - Unknown source
>--
>Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
>Linux NTFS Maintainer
>ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

-- 
      "Education is what remains after one has forgotten everything he 
learned in school." - Albert Einstein
-- 
Anton Altaparmakov  Voice: +44-(0)1223-333541(lab) / +44-(0)7712-632205(mobile)
Christ's College    eMail: AntonA@bigfoot.com / aia21@cam.ac.uk
Cambridge CB2 3BU    ICQ: 8561279
United Kingdom       WWW: http://www-stu.christs.cam.ac.uk/~aia21/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
