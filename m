Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316832AbSFQICv>; Mon, 17 Jun 2002 04:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316835AbSFQICu>; Mon, 17 Jun 2002 04:02:50 -0400
Received: from guardian.hermes.si ([193.77.5.150]:26892 "EHLO
	guardian.hermes.si") by vger.kernel.org with ESMTP
	id <S316832AbSFQICt>; Mon, 17 Jun 2002 04:02:49 -0400
Message-ID: <FED7EB450413D511ABC100B0D0211732064F78C3@hal9000.hermes.si>
From: Tomaz Susnik <tomaz.susnik@hermes.si>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.4.18 kernel lseek() bug
Date: Mon, 17 Jun 2002 10:02:30 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your suggestion. I agree that the fix to our code should 
be quite simple. 
On the other hand, it's a multi-paltform piece of code that seems to work 
fine on many UNIX platforms. This problem came up at a rather bad time for 
us, because our product is closing up to a release deadline. At this stage 
I'd have hard time explaining to the Project Manager why I suddenly want 
to change code that worked just fine for years...

If the new lseek() behaviour really is to become accepted (that is if
no patch is to be released for kernel 2.4.18) I will of course do my best 
to force the necessary changes into our code.

BR, Tomaz 



-----Original Message-----
From: Andreas Dilger [mailto:adilger@clusterfs.com]
Sent: Saturday, June 15, 2002 5:37 AM
To: Tomaz Susnik
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 kernel lseek() bug


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
