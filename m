Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289323AbSAIKoU>; Wed, 9 Jan 2002 05:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289322AbSAIKoL>; Wed, 9 Jan 2002 05:44:11 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:30716 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S289323AbSAIKoC>;
	Wed, 9 Jan 2002 05:44:02 -0500
Date: Wed, 9 Jan 2002 03:43:46 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Thomas Capricelli <tcaprice@logatique.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fs corruption recovery?
Message-ID: <20020109034346.H769@lynx.adilger.int>
Mail-Followup-To: Thomas Capricelli <tcaprice@logatique.fr>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C3BB082.8020204@fit.edu> <20020108200705.S769@lynx.adilger.int> <20020109092659.2907323CBB@persephone.dmz.logatique.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020109092659.2907323CBB@persephone.dmz.logatique.fr>; from tcaprice@logatique.fr on Wed, Jan 09, 2002 at 10:28:57AM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 09, 2002  10:28 +0100, Thomas Capricelli wrote:
> On Wednesday 09 January 2002 04:07, Andreas Dilger wrote:
> > Try "e2fsck -B 4096 -b 32768 <device>" instead.
> 
> I thought e2fsck was already trying the different superblocks present on the 
> device.

Well, yes and no.  Most versions of e2fsck (i.e. every version in existence
unless you have a very recent copy from Ted's BitKeeper repository) will
try possible block sizes, but will not try different block numbers.

> Why isn't e2fsck smart enought to look for then? Is this an intended purpose?

Well, in the most recent versions, it will try a lot harder to try and find
backup superblocks.  It will still not run e2fsck automatically on the device.
There are many reasons why e2fsck may think the superblock is corrupted, but
in fact it isn't:

1) superblock has a new feature which an old e2fsck doesn't understand
2) filesystem is no longer ext2, but may still have the backup superblock
   (e.g. you mkswap on an old ext2 partition, it leaves the old superblock)

> Why do you use the -B option ? How can it be useful to force the block size?
> Especially if this one is different. 

Well, since it is possible to have multiple block sizes for ext2, if you
specify "-b 32768" (i.e. block 32768) for the superblock backup, how does
it know what the blocksize is if you don't tell it that also*.  The old
error message (try -b 8193) assumes that you have a 1kB blocksize.  All
ext2 filesystems larger than 500MB made in the last couple of years really
have 4kB blocksize** so e2fsck is far more likely to find a superblock
backup at 4kB * 32768 than at 1kB * 32768 (especially since there will
never be a backup at 1kB * 32768, but rather 1kB * 32769, and only on
_really_old_ non-sparse ext2 filesystems).

Cheers, Andreas

*) OK, that is a bit of a lie, e2fsck appears to check all valid blocksizes
   when a block number is given, but since one can assume it is a 4kB
   block size, you may as well specify it.
**) 4kB blocks provide _much_ better performance than 1kB blocks, even if
   they waste more space, and also allow for larger filesystems.
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

