Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282918AbRLMJGJ>; Thu, 13 Dec 2001 04:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282866AbRLMJGB>; Thu, 13 Dec 2001 04:06:01 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:32498 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S282848AbRLMJFv>;
	Thu, 13 Dec 2001 04:05:51 -0500
Date: Thu, 13 Dec 2001 02:05:43 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: PANTELIS PROIOS <pproios@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: little OT: 2.4.13 kernel complains about  E2FS utils trying to go over partit
Message-ID: <20011213020543.I940@lynx.no>
Mail-Followup-To: PANTELIS PROIOS <pproios@hotmail.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <F1264iZWw8gRzpPWywC0000cfcd@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <F1264iZWw8gRzpPWywC0000cfcd@hotmail.com>; from pproios@hotmail.com on Fri, Dec 07, 2001 at 06:10:24PM +0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 07, 2001  18:10 +0200, PANTELIS PROIOS wrote:
> I am having some problems with e2fs utils and was wondering if you could
> help clear some things out for me. Please CC me as I am not subscribed to 
> the list.
> 
> I start with a dump of my partition table:
> ##########################################################################
> FDISK
> ##########################################################################
> 
> #  fdisk -l -u /dev/hdc
> Disk /dev/hdc: 255 heads, 63 sectors, 789 cylinders
> Units = sectors of 1 * 512 bytes
> 
>    Device Boot    Start       End    Blocks   Id  System
> /dev/hdc1   *        63   6409934   3204936    b  Win95 FAT32
> /dev/hdc2       6409935   8498384   1044225    e  Win95 FAT16 (LBA)
> /dev/hdc3       8498385  10586834   1044225   83  Linux native
> /dev/hdc4      10586835  12675284   1044225   83  Linux native
> 
> 
> 1) badblocks kept on trying to access a block beyond the end of the
> device/partition (1044226) !!  Thank god it wasn't allowed to do it. Below
> is the output from the badblocks run and also from my /var/log/messages

Did you repartition the drive before doing this?  If so, you need to
reboot to have the changes take effect (sad, I know).

> # badblocks -c64 -svw /dev/hdc3
> 
> Checking for bad blocks in read-write mode
> >From block 0 to 1044225
> Writing pattern 0xaaaaaaaa: done
> Reading and comparing: 104422472/  1044225 <--- WTF ????
> 
> #at the end of each "Writing pattern 0x...."
> Dec  3 20:25:39  kernel: attempt to access beyond end of device
> Dec  3 20:25:39  kernel: 16:03: rw=0, want=1044226, limit=1044225

Hmm, kind of strange that the very last block is "bad".  More likely
it is an error somewhere in the partitioning code (or no reboot, as
above) which is reporting the wrong size for the partition.  Now that
I think about it, Linux is unable to use the last 512 bytes of any
partition, so it should never tell you that the partition has an odd
number of sectors in it.  What does /proc/partitions say?

> Well after I was done with badblocks -o I went on to e2fsck with 1024byte
> blocks (I am gonna have lots of small files). But that wouldn't fly. The
> output below tells why, but I am not sure why it would be having short
> reads that early into the partition...
> 
> # mke2fs -b 0124 -m 1 /dev/hdc3
> 
> Filesystem label=
> OS type: Linux
> Block size=1024 (log=0)
> Fragment size=1024 (log=0)
> 131072 inodes, 1044225 blocks
                 ^^^^^^^  This is very strange.  Above, fdisk says the units
		          are 512-byte sectors, yet this says 1024-byte blocks?

> Could not write 8 blocks in inode table starting at 8:
> Attempt to write block from filesystem resulted in short write

No idea about this part.

> So I tried 2048byte blocks, but I got yet another problem this time! It
> ignores the badblock (1044224) saying it's out of range!? (even though the
> partition has 1044225 blocks, and even though I never specified the
> start/end blocks myself (i let it auto-figure it out)). Any ideas ?

Probably because mke2fs expects the bad blocks list to be in the same
units as the filesystem blocksize.  If you created the bad blocks list
with a 1024-byte blocksize, it will not work with a 2048-byte filesystem.
You need to divide all the block numbers by 2.  So, no real bug here.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

