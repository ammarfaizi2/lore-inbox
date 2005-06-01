Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVFANNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVFANNc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 09:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVFANMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 09:12:34 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:22189 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261295AbVFANKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 09:10:07 -0400
Date: Wed, 1 Jun 2005 09:10:07 -0400
To: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Writing large files onto sync mounted MMC corrupts the FS
Message-ID: <20050601131006.GL23621@csclub.uwaterloo.ca>
References: <20050601091320.GA1472@angel.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601091320.GA1472@angel.research.nokia.com>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 12:13:21PM +0300, Jarkko Lavinen wrote:
> I am seeing both VFAT and Ext3 becoming corrupted when using
> synchronous mount on MMC card (kernel is 2.6.12-rc2-omap1, HW is a
> test board with Omap 1710).  The problem is reproduced by mounting a
> MMC card synchronously and copying large file onto it.
> 
> Typically I insert vfat/ext3 formatted MMC card and do:
>   mount /dev/mmcblk0p1 /media/mmc1 -t vfat -o sync
>   cp /lib/libc-2.3.2.so  /media/mmc1
> or
>   mount /dev/mmcblk0p1 /media/mmc1 -t ext2 -o noatime,sync
>   cp /lib/libc-2.3.2.so  /media/mmc1
> 
> The results are further below. I have tried to reproduce VFAT problen
> in desktop PC with loopback device but to no avail. I have used
> different MMC cards but the problem persists. Disabling DMA reduces
> the number of error messages or pushes the first occurence a bit
> further, but does not remove the problem.
> 
> Very similar problem appears when writing a large file onto ext2
> formatted MMC card. The problem disappears if I mount asynchronoysly.
> Also similarly the problem on VFAT disappears when mounting
> asynchronously.
> 
> The VFAT problem seems to have appeared around January -- February
> this year but it is hard to tell the exact point and changeset. For
> ext2 I haven't done similar search.
> 
> Because there are two so similar problems appearing with two separate
> file-systems, I doubt this is VFAT or Ext3 only problem, but more
> likely problem in the mmc driver. It would be good to try this out on
> other on some other hardware using the same mmc core code. Has anybody
> else seen these?

Go read the thread on lkml a few weeks ago about how sync + vfat (and
others) does nasty destructive things to flash media that doesn't have
excelent wear leveling (vfat updates the fat sector for every block of
data written when you use sync option, which means you do a lot of
writes to one sector of the device, which is not good for devices with a
limited number of writes).  Typically when flash starts to reach it's
limit in number of writes, it starts having trouble holding the value
written (some bits start to drift back to one state) which can explain
your crc errors and such).

In other words: Don't use sync with flash media.  It's a horribly bad
idea, and if you look into how flash works (at least the cheaper ones)
you will realize why.  Anything with a limited number of writes allowed
to each sector should avoid rewriting the same sector again and again,
and that is what sync does when you use filesystems designed for disks
rather than flash.  JFFS was designed for flash use and rotates the
sectors it uses to store filesystem meta data and has spare space in the
filesystem to do wearleveling at the filesystem level.  vfat and ext2/3
do not, and it shows.  At least write caching/delayed write back
elliminates the worst of the rewriting of the meta data sectors.

Len Sorensen
