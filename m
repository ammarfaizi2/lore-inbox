Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277178AbRJLDcn>; Thu, 11 Oct 2001 23:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277183AbRJLDcc>; Thu, 11 Oct 2001 23:32:32 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:6647 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S277178AbRJLDcS>; Thu, 11 Oct 2001 23:32:18 -0400
Date: Thu, 11 Oct 2001 21:32:11 -0600
From: "'adilger@turbolabs.com'" <adilger@turbolabs.com>
To: Xuan Baldauf <xuan--lkml@baldauf.org>
Cc: Venkatesh Ramamurthy <Venkateshr@ami.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: dynamic swap prioritizing
Message-ID: <20011011213211.P8382@turbolinux.com>
Mail-Followup-To: Xuan Baldauf <xuan--lkml@baldauf.org>,
	Venkatesh Ramamurthy <Venkateshr@ami.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <1355693A51C0D211B55A00105ACCFE6402B9E013@ATL_MS1> <20011010095536.C10443@turbolinux.com> <3BC63D38.AF65AAF5@baldauf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BC63D38.AF65AAF5@baldauf.org>
User-Agent: Mutt/1.3.22i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 12, 2001  02:45 +0200, Xuan Baldauf wrote:
> > I'd rather just have the statistic data in a regular file for ALL disks,
> > and then send it to the kernel via ioctl or write to a special file that
> > the kernel will read from.  I don't think it is critical to have this
> > data right at boot time, since it would only be used for optimizing I/O
> > access and would not be required for a disk to actually work.
> 
> why do you want to separate statistics data out? The statistics are not
> about disk throughput, head seek times, etc. They are just about the time
> between "needing a page" and "getting that page", which is very abstract.
> Let's call it the swapin-delay. It does not only depend on disk-throughput
> and head seek times, but also on "device business".

What I am saying is that such information is useful for ALL devices, and
not just swap devices.  There was a long thread from Daniel Phillips
where he was working on (1) a few months ago.  Why is this data useful?

1) You have dirty pages in RAM, when should you write them?  The current
   system is to delay the write as long as possible in case the dirty
   pages are discarded (e.g. temp file) before they need to be written.
   However, if the disk is idle during this time, then doing the write
   immediately will not impose extra overhead, and will mean that the
   dirty page could be freed quickly if there was a need for memory.
2) Swap or MD RAID 1 load balancing.  Which device should you write to
   (swap) or read from (RAID 1)?  If you know how fast/busy each device
   is, you can make a better decision on this instead of round-robin.
3) Guaranteed rate I/O.  For XFS/XLV on SGI IRIX, you can request a
   guaranteed I/O rate for a specific time period (e.g. to record video
   or capture data from an experiment) and the system will tell you if
   it is possible or not.  In the IRIX case, they had data on each
   drive to tell them what the performance is in advance, while Linux
   would need to do a drive-by-drive benchmark instead.

A lot of the data needed for this is already part of "sard", but that
is only reporting the data to user space, while some of the above
decisions need to be done inside the kernel on a continuous basis.

Note that I'm NOT saying that having all of this data will improve
system performance (it may slow it down from overhead), but I was just
advocating a broader view of what could be done (and what has already
been done in related areas).

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

