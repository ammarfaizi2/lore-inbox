Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313702AbSDPOw3>; Tue, 16 Apr 2002 10:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313704AbSDPOw1>; Tue, 16 Apr 2002 10:52:27 -0400
Received: from [195.63.194.11] ([195.63.194.11]:56331 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313702AbSDPOwZ>; Tue, 16 Apr 2002 10:52:25 -0400
Message-ID: <3CBC2C05.9010207@evision-ventures.com>
Date: Tue, 16 Apr 2002 15:49:57 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: David Lang <david.lang@digitalinsight.com>,
        Vojtech Pavlik <vojtech@suse.cz>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 36
In-Reply-To: <Pine.LNX.4.44.0204160215570.389-100000@dlang.diginsite.com>	<3CBBE42D.7030906@evision-ventures.com> <200204161414.g3GEE5808527@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> Martin Dalecki writes:
> 
>>David Lang wrote:
>>
>>>The common thing I use byteswap for is to mount my tivo (kernel 2.1.x)
>>>drives on my PC (2.4/5.x).  those drives are byteswapped throughout the
>>>entire drive, including the partition table.
>>>
>>>It sounds as if you are removing this capability, am I misunderstaning you
>>>or is there some other way to do this? (and duplicating the drive to use
>>>dd to byteswap is not practical for 100G+)
>>
>>Same problem as with SCSI disks, which are even more commonly moved
>>between different system types - please look there for a solution.
>>BTW. I hardly beleve that your tivo is containing a DOS partition
>>table - otherwise the partition table will handle it all
>>autmagically.
> 
> 
> Well, there *is* a partition table on the drive, but the byte-swapping
> isn't handled automatically. Otherwise people wouldn't need to bswap
> their TiVo drives when plugging into an x86 box.
> 
> Having the bswap option is definately useful. With it, you can "bless"
> the drive and then mount the partitions and poke around. Please don't
> remove the bswap option. You'll make life harder for a bunch of
> people.

Please note one sample from ext2 code:

	if (le32_to_cpu(es->s_rev_level) > EXT2_GOOD_OLD_REV)

And from partition handling code linux/fs/partitions/sun.c:

	/* All Sun disks have 8 partition entries */
	spc = be16_to_cpu(label->ntrks) * be16_to_cpu(label->nsect);

You see those many le32_to_cpu() and reverse commands?
If there is something that has to be fixed for linux/fs/partition/whatever.c -
please fix it there if you are actually *needing* it.

You also notice that the option was used only by the
taskfile_(in|out)put_bytes() function, which in turn was only used for
taks_in_intr, which in turn only matters for PIO mode but did NOTHING to DMA
transfers for example? DMA transfers are those days the >> 90% most common
on disks in PC systems. And you notice that the IDE driver sometimes starts in
DMA and falls backs to DMA if it has for example to fill in a not full memmory
page?

And you notice that the SCSI people are more likely to exchange disks
regularly between some RISC big endian host and linux on intel?
Please ask yourself why they don't have someting like the byteswap option.

Do you remember that byteswap was something introduced by the Atari people
a long long time ago even before the fs code started to understand
about native endianess issues and is today both: broken (it *may* work
for someone but it *is* broken) unneccessary and not the proper
way to deal with the problems in question?

You notice as well that the arch specific bytswapping for physically
cross wired ata host chips on some historical archs is still there
where it should be?

You don't? So please flame me now as much as you desire...

