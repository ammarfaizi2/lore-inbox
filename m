Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbVJUCFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbVJUCFB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 22:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbVJUCFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 22:05:00 -0400
Received: from xenotime.net ([66.160.160.81]:43700 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750877AbVJUCFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 22:05:00 -0400
Date: Thu, 20 Oct 2005 19:04:57 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
       James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org, akpm@osdl.org
Subject: Re: scsi disk size reporting in dmesg
Message-Id: <20051020190457.5e678e8b.rdunlap@xenotime.net>
In-Reply-To: <4358228F.1020604@tmr.com>
References: <1129577044.17327.11.camel@dale.velocity.net>
	<20051019220920.7c91b922.rdunlap@xenotime.net>
	<1129810635.22387.11.camel@dale.velocity.net>
	<Pine.LNX.4.58.0510201206570.11550@shark.he.net>
	<4358228F.1020604@tmr.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2005 19:04:47 -0400 Bill Davidsen wrote:

> Randy.Dunlap wrote:
> > On Thu, 20 Oct 2005, Dale Blount wrote:
> > 
> > 
> >>On Wed, 2005-10-19 at 22:09 -0700, Randy.Dunlap wrote:
> >>
> >>>On Mon, 17 Oct 2005 15:24:04 -0400 Dale Blount wrote:
> >>>
> >>>
> >>>>Hello,
> >>>>
> >>>>I just added 2 external 1TB+ scsi devices to my i686 linux server
> >>>>running 2.6.13.4 connected to external LSI MPT card.  fdisk and df both
> >>>>show the sizes correctly (see below), but I'm worried that dmesg reports
> >>>>them incorrectly.
> >>>>
> >>>>SCSI device sda: 2460934144 512-byte hdwr sectors (160487 MB)
> >>>>SCSI device sdb: 3790438400 512-byte hdwr sectors (841193 MB)
> >>>>
> >>>>I don't think it's as simple as a variable overflow because both
> >>>>sdkp->capacity and mb look to be cast as unsigned long longs.  I know a
> >>>>workaround is to present less data per LUN, but I'd like to use it as
> >>>>it's setup currently if possible.  Is this just printing incorrectly or
> >>>>will I run into trouble when the device gets more full?
> >>>
> >>>The casts to (unsigned long long) just fix the printk() args to match
> >>>the format strings (and eliminate warnings).
> >>>
> >>>Looks to me like sdkp->capacity is correct.  The <mb> value looks
> >>>way off.  Since it's just printed here for user info, I don't see
> >>>how it can be a problem later on.
> >>>
> >>
> >>That's what I was hoping, but I didn't know for sure.  I figured I'd
> >>better ask to make sure my data wouldn't get truncated when the disk got
> >>fuller.  Between my first post and now, I've tested it by filling the
> >>drive with data and testing the md5sums for each file and it seems to
> >>work.  Other than the odd MB size reported, it seems to work just fine.
> >>
> >>
> >>>I don't see the error just yet.  Are there any other SCSI device-
> >>>related messages near these?  And just to confirm, but you must
> >>>have CONFIG_LBD (Large Block Device) enabled, right?
> >>>
> >>
> >>No, there are no other related messages near these other than the
> >>standard vendor/versions.  I did not enable CONFIG_LBD since the help
> >>says "bigger than 2TB", and I partitioned the storage system to present
> >>disks smaller than that.
> > 
> > 
> > I guessed at CONFIG_LBD=y last night.  Today I did the arithmetic
> > with CONFIG_LBD=n... and found the overflow.
> > 
> > In drivers/scsi/sd.c, approx. line #1260:
> > 
> > 		sector_t sz = sdkp->capacity * (hard_sector/256);
> > 
> > sz is 32 bits.
> > capacity is 32 bits with a value of 2,460,934,144 == 0x92ae_e000.
> > Then we multiply that by 2 (512 / 256)... and it overflows.
> > Should be hex 1_255d_c000, but we drop the '1'.
> > The rest of the calculation (with this new value) does result
> > in the 160487 MB, matching your log message.
> > 
> > I think that you can fix it (patch it) by changing that line
> > to make 'sz' be type 'u64' for now.
> > 
> > 		u64 sz = sdkp->capacity * (hard_sector/256);
> > 
> > But those divides by 1250 and 1950 are still voodoo to me.
> > 
> I think that just hides the real problem, and while that's useful to 
> stop the annoying numbers, the real problem is either (a) the value 
> calculated is wrong, (b) the size of sector_t is no longer large enough, 
> or (c) the type has been wrong all along and shouldn't be sector_t.
> 
> If I understand what sector_t really is, (b) is my candidate.

(b) is definitely the case with Dale's disk drive size.

---
~Randy
