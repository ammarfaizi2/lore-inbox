Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271149AbRHQKnU>; Fri, 17 Aug 2001 06:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271346AbRHQKnJ>; Fri, 17 Aug 2001 06:43:09 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:31222 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S271149AbRHQKm4>; Fri, 17 Aug 2001 06:42:56 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Fri, 17 Aug 2001 04:42:56 -0600
To: Mike Black <mblack@csihq.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Recommended change
Message-ID: <20010817044256.E32617@turbolinux.com>
Mail-Followup-To: Mike Black <mblack@csihq.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <001f01c12702$f5fd98a0$e1de11cc@csihq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001f01c12702$f5fd98a0$e1de11cc@csihq.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 17, 2001  05:57 -0400, Mike Black wrote:
> I upgraded to e2fsprog-1.23 and LInux 2.4.8 yesterday and saw this:
> 
> Aug 16 08:58:20 yeti kernel: md: fsck.ext3(pid 207) used obsolete MD ioctl,
> upgrade your software to use new ictls.
> 
> Do you suppose we could change the printk line to actually output the ioctl
> that was requested?
> 
> i.e.:
> 
> /usr/src/linux/drivers/md/md.c
> 
>                 default:
>                         printk(KERN_WARNING "md: %s(pid %d) used obsolete MD
> ioctl(%d), upgrade your software to use new ictls.\n", current->comm,
> current->pid, cmd);

Some notes:
1) It should probably print the ioctl as 0x%X, because this makes it a lot
   easier to decode which ioctl it is.

2) The ioctl in question is actually BLKGETSIZE64, which is part of Jens'
   64-bit block device patch, but is not part of the stock kernel.  It
   was added to e2fsprogs in order to support devices > 2TB.

3) Drivers probably shouldn't complain about ioctls they don't understand,
   as it just causes a lot of grief (see this thread here).  If anything,
   they _could_ complain about specific obsolete ioctl numbers, or maybe
   ioctl numbers in their "allocated" namespace (0x09 for MD it appears).
   Even so, this "breaks" forward compatibility, if tools try to use a
   new ioctl on an older kernel before falling back to the old ioctl, you
   get a lot of spurious warnings.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

