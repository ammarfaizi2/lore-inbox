Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312498AbSFODjD>; Fri, 14 Jun 2002 23:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313305AbSFODjC>; Fri, 14 Jun 2002 23:39:02 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:61938 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S312498AbSFODjB>; Fri, 14 Jun 2002 23:39:01 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 14 Jun 2002 21:37:24 -0600
To: Tomaz Susnik <tomaz.susnik@hermes.si>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 kernel lseek() bug
Message-ID: <20020615033724.GA14468@clusterfs.com>
Mail-Followup-To: Tomaz Susnik <tomaz.susnik@hermes.si>,
	linux-kernel@vger.kernel.org
In-Reply-To: <FED7EB450413D511ABC100B0D0211732064F7725@hal9000.hermes.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 14, 2002  15:07 +0200, Tomaz Susnik wrote:
> [1] 	Problem description 
> ----------------------------------
> 
>  	a call to lseek() fails with EINVAL under the following conditions:
> 		- it is called on a disk device file
> 		- required offset is larger than the target disk device size

Is this behaviour mandated in a standard, or is it just different from
previous behaviour?  I'm not saying it _isn't_ a bug, but I don't see
how seeking past the end of a block device is very useful.

> 	Attempting to seek through file /dev/hda3 
> 
> 	lseek(6 Gb     ): errno = 0 ret = 6442450944
> 	lseek(7 Gb     ): errno = 0 ret = 7516192768
> 	lseek(8 Gb     ): errno = 0 ret = 8589934592
> 	lseek(9 Gb     ): errno = 0 ret = 9663676416
> 
> 	
> 	Sample output on the same machine, but booted with kernel 2.4.18:
> 
> 	Attempting to seek through file /dev/hda3 
> 
> 	lseek(6 Gb     ): errno = 0 ret = 6442450944
> 	lseek(7 Gb     ): errno = 0 ret = 7516192768
> 	lseek(8 Gb     ): errno = 22 ret = -1
> 	lseek(9 Gb     ): errno = 22 ret = -1
> 
> [6] 	Reason for reporting this problem
> ---------------------------------------------------
> 	Our multi-platform backup product relies on proper behaviour of the
> lseek() command to calculate a rawdisk size.

Well, e2fsprogs has a similar test that it uses if the BLKGETSZ ioctl
fails, but I don't see how this new behaviour is a real problem.  All you
have to do is check if _either_ lseek(offset) fails or read() from that
offset fails to know you are past the end of the block device.  It hardly
changes the algorithm at all.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

