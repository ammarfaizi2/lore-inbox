Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313380AbSDPPZ1>; Tue, 16 Apr 2002 11:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313392AbSDPPZ0>; Tue, 16 Apr 2002 11:25:26 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:23433 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S313380AbSDPPZZ>;
	Tue, 16 Apr 2002 11:25:25 -0400
Date: Tue, 16 Apr 2002 17:24:34 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        David Lang <david.lang@digitalinsight.com>,
        Vojtech Pavlik <vojtech@suse.cz>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 36
Message-ID: <20020416172434.A1180@ucw.cz>
In-Reply-To: <Pine.LNX.4.44.0204160215570.389-100000@dlang.diginsite.com> <3CBBE42D.7030906@evision-ventures.com> <200204161414.g3GEE5808527@vindaloo.ras.ucalgary.ca> <3CBC2C05.9010207@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 03:49:57PM +0200, Martin Dalecki wrote:
> Richard Gooch wrote:
> > Martin Dalecki writes:
> > 
> >>David Lang wrote:
> >>
> >>>The common thing I use byteswap for is to mount my tivo (kernel 2.1.x)
> >>>drives on my PC (2.4/5.x).  those drives are byteswapped throughout the
> >>>entire drive, including the partition table.
> >>>
> >>>It sounds as if you are removing this capability, am I misunderstaning you
> >>>or is there some other way to do this? (and duplicating the drive to use
> >>>dd to byteswap is not practical for 100G+)
> >>
> >>Same problem as with SCSI disks, which are even more commonly moved
> >>between different system types - please look there for a solution.
> >>BTW. I hardly beleve that your tivo is containing a DOS partition
> >>table - otherwise the partition table will handle it all
> >>autmagically.
> > 
> > 
> > Well, there *is* a partition table on the drive, but the byte-swapping
> > isn't handled automatically. Otherwise people wouldn't need to bswap
> > their TiVo drives when plugging into an x86 box.
> > 
> > Having the bswap option is definately useful. With it, you can "bless"
> > the drive and then mount the partitions and poke around. Please don't
> > remove the bswap option. You'll make life harder for a bunch of
> > people.
> 
> Please note one sample from ext2 code:
> 
> 	if (le32_to_cpu(es->s_rev_level) > EXT2_GOOD_OLD_REV)
> 
> And from partition handling code linux/fs/partitions/sun.c:
> 
> 	/* All Sun disks have 8 partition entries */
> 	spc = be16_to_cpu(label->ntrks) * be16_to_cpu(label->nsect);
> 
> You see those many le32_to_cpu() and reverse commands?
> If there is something that has to be fixed for linux/fs/partition/whatever.c -
> please fix it there if you are actually *needing* it.

Note that the above commands are no help in case of plugging TIVO
drive into a PC. While they assure that all ext2 filesystems are LE on
the media and all sun disklabels are BE on the media, still if you plug
in a BE ext2 into the system (or a BE PC partition table), the kernel
won't understand them.

> You also notice that the option was used only by the
> taskfile_(in|out)put_bytes() function, which in turn was only used for
> taks_in_intr, which in turn only matters for PIO mode but did NOTHING to DMA
> transfers for example? DMA transfers are those days the >> 90% most common
> on disks in PC systems. And you notice that the IDE driver sometimes starts in
> DMA and falls backs to DMA if it has for example to fill in a not full memmory
> page?

I think you wanted to say 'falls back to PIO'. Oh, OK. But still I can
disable DMA and access the damn TIVO drive data.

> And you notice that the SCSI people are more likely to exchange disks
> regularly between some RISC big endian host and linux on intel?
> Please ask yourself why they don't have someting like the byteswap option.

Because for Linux filesystems it was decided some time ago (after people
HAD huge byteswap problems) that ext2 is always LE, etc, etc. So
filesystems are supposed to be the same on every system.

But IDE is used in some pretty weird hardware configurations, where you
actually get one more byteswap on IDE, even when Linux takes care of the
system itself being LE/BE. And furthermore, IDE is now used in stuff
like TIVO or X-Box, where you can't really control what's on the drive,
and thus you can't rely on that it'll be in a format you decided is the
'right' one.

> Do you remember that byteswap was something introduced by the Atari people
> a long long time ago even before the fs code started to understand
> about native endianess issues and is today both: broken (it *may* work
> for someone but it *is* broken) unneccessary and not the proper
> way to deal with the problems in question?

It may be it's broken now. But IMO it should be fixed instead of
removed. Limited to PIO perhaps (if you set bswap on a drive, then it
the driver won't allow DMA on it), but still it's a feature that's
useful now and then.

> You notice as well that the arch specific bytswapping for physically
> cross wired ata host chips on some historical archs is still there
> where it should be?
> 
> You don't? So please flame me now as much as you desire...

-- 
Vojtech Pavlik
SuSE Labs
