Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281068AbRK3WXI>; Fri, 30 Nov 2001 17:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281067AbRK3WW6>; Fri, 30 Nov 2001 17:22:58 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:21999 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281066AbRK3WWt>;
	Fri, 30 Nov 2001 17:22:49 -0500
Date: Fri, 30 Nov 2001 15:22:07 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: M G Berberich <berberic@fmi.uni-passau.de>
Cc: linux-kernel@vger.kernel.org, tytso@thunk.org
Subject: Re: 2.4.16: hda9: attempt to access beyond end of device
Message-ID: <20011130152207.R15936@lynx.no>
Mail-Followup-To: M G Berberich <berberic@fmi.uni-passau.de>,
	linux-kernel@vger.kernel.org, tytso@thunk.org
In-Reply-To: <20011129225814.A464@fmi.uni-passau.de> <20011130210734.A489@fmi.uni-passau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011130210734.A489@fmi.uni-passau.de>; from berberic@fmi.uni-passau.de on Fri, Nov 30, 2001 at 09:07:34PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 30, 2001  21:07 +0100, M G Berberich wrote:
> Am Thursday, den 29. November 2001 22:58:14 schrieb berberic:
> > Partition boundary problem in 2.4.16 ?!
> > 
> > I just tried to make a mke2fs on my /dev/hda9 and mke2fs with kernel
> > 2.4.16 and it failed with a partial write. /var/log/messages says:
> > 
> >   kernel: 03:09: rw=0, want=289140, limit=289138
> >   kernel: attempt to access beyond end of device
> > 
> > It works fine with 2.4.13 and it works with 2.4.16 if blocksize is
> > set to 4k (fails with 1k blocks).
> 
> Now it failed with kernel 2.4.13 and mke2fs 1.25 on another partition,
> but works with kernel 2.4.13 and mke2fs 1.18. 1k-blocks again. 

To avoid issues with mke2fs, try "dd if=/dev/hda9 of=/dev/null bs=X"
where X=512,1k,2k,4k under both kernels and see if it still gives
errors.  Also, mke2fs outputs the device size that it got via the
BLKGETSIZE ioctl, so that may be informative also.  If you do an
strace of mke2fs, you should see that it is calling BLKGETSIZE (about
70 lines in, on my system).  If that ioctl is failing, then it may be
a bug elsewhere in the mke2fs code (which is rarely used), although
it is unlikely.

The likely reason it is failing with 1kB blocks and not 4kB blocks is
that mke2fs will ignore up to 3kB at the end of the device if it is
not a full multiple of the block size (i.e. 4kB).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

