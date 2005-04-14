Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVDNSqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVDNSqq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 14:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVDNSqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 14:46:46 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:8683 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261404AbVDNSqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 14:46:30 -0400
Date: Thu, 14 Apr 2005 14:46:30 -0400
To: aeriksson@fastmail.fm
Cc: linux-kernel@vger.kernel.org
Subject: Re: DVD writer and IDE support...
Message-ID: <20050414184630.GV521@csclub.uwaterloo.ca>
References: <20050413181421.5C20E240480@latitude.mynet.no-ip.org> <20050413183722.GQ17865@csclub.uwaterloo.ca> <20050413190756.54474240480@latitude.mynet.no-ip.org> <20050413193924.GN521@csclub.uwaterloo.ca> <20050413205949.E987A240480@latitude.mynet.no-ip.org> <20050414124226.GQ521@csclub.uwaterloo.ca> <20050414133523.6D747240480@latitude.mynet.no-ip.org> <20050414143420.GR521@csclub.uwaterloo.ca> <20050414162539.4F963240480@latitude.mynet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050414162539.4F963240480@latitude.mynet.no-ip.org>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 06:25:39PM +0200, aeriksson@fastmail.fm wrote:
> > On Thu, Apr 14, 2005 at 03:35:22PM +0200, aeriksson@fastmail.fm wrote:
> > Well there is a cdwrite mailing list hosted on lists.debian.org which is
> > a great place to figure out what weird errors are and such, and the
> > authors of the programs used for writing discs are on thoses lists too,
> > so you may want to ask for advice there.
> > 
> Thanks, I'll get myself onto that list...
> 
> > Did you try writing using ide-scsi mode with growisofs ?  Any
> > difference?  Does dvd+rw-media return anything with a disc in the drive?
> > 
> With this array of modules:
> sg                     34112  0 
> sr_mod                 17700  0 
> ide_scsi               15556  0 
> scsi_mod              126952  3 sg,sr_mod,ide_scsi
> ide_cd                 40004  0 
> 
> Where ide_cd was told to ignore hdc (inspired from the dvd+rw-tools 
> web), I got this:
> tippex root # dvd+rw-mediainfo /dev/sr0
> INQUIRY:                [AOPEN   ][DUW1608/ARR     ][A060]
> GET [CURRENT] CONFIGURATION:
>  Mounted Media:         14h, DVD-RW Sequential
>  Multi-session Info:    #1@0
[snip]
> READ CAPACITY:          2298496*2048=4707319808
> 
> Not sure what it says, but I see one sesssion there. I guess that's 
> from my previos burn attempt. I seemed to be successful with:

Well that looks normal at least.

> tippex root # dvd+rw-format -blank /dev/sr0
> * DVD?RW/-RAM format utility by <appro@fy.chalmers.se>, version 4.10.
> * 4.7GB DVD-RW media in Sequential mode detected.
> * blanking |
> 
> No errors reported! Now I get:
> tippex root # dvd+rw-mediainfo /dev/sr0
> INQUIRY:                [AOPEN   ][DUW1608/ARR     ][A060]
> GET [CURRENT] CONFIGURATION:
>  Mounted Media:         14h, DVD-RW Sequential
>  Media ID:              CMCW02      
[snip]
>  Next Writable Address: 0*2KB
>  Free Blocks:           2297888*2KB
>  Track Size:            2297888*2KB
> READ CAPACITY:          1*2048=2048

And so does that.

> ... which seems consistent with expectations. Now another try with 
> the burner:
> tippex root # growisofs -Z /dev/sr0 -R -J /tmp/quilt-0.32/
> Executing 'mkisofs -R -J /tmp/quilt-0.32/ | builtin_dd of=/dev/sr0 obs=32k seek=0'
> Using SNAPS000.TES;1 for  /tmp/quilt-0.32/test/snapshot.test (snapshot2.test)
> /dev/sr0: FEATURE 21h is not on, engaging DAO...
> /dev/sr0: reserving 432 block, warning for short DAO recording
> /dev/sr0: "Current Write Speed" is 2.0x1385KBps.
> :-( unable to WRITE@LBA=0h: Input/output error
> :-( attempt to re-run with -dvd-compat -dvd-compat to engage DAO or apply full blanking procedure
> :-( write failed: Input/output error
> 
> and the kernel log has:
> Apr 14 18:12:54 tippex hdc: DMA timeout retry
> Apr 14 18:12:54 tippex hdc: timeout waiting for DMA
> Apr 14 18:12:54 tippex hdc: ATAPI reset complete
> Apr 14 18:13:14 tippex scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 8 lun 0
> Apr 14 18:13:14 tippex SCSI error : <0 0 8 0> return code = 0x6000000
> Apr 14 18:13:14 tippex scsi0 (8:0): rejecting I/O to offline device

Maybe try growisofs -dvd-compat -dvd-compat -Z /dev/sr0 .... like it suggested.
Maybe the drive's firmware doesn't support the modes normally expected
by growisofs.

growisofs has some odd options in the source code, and the authors on
the cdwrite list may be able to help.  I think it is starting to look
like bad firmware or a defective drive.

> 
> Yep. I get the feeling my media and the drive as-is don't like each
> other. What are the chances that the device is faulty but i can still 
> blank the media (btw where can I read up on blanking vs. formating?)

Well I am not sure it's the media either.  I think the drive isn't quite
up to the specs growisofs expects.  The authors may be better able to
answer that.  They also have some tools they may ask you to run to ask
the drive what features it has so they can see if the drive is a bit odd
or not.

> Starting to seem like a wise choice...

I got the PX716A a few weeks ago while they had a $30 mail in rebate.
Made it not much more than buying a lesser drive.  Unfortuantely that
expired at the end of March.

On the other hand, not having to run around trying weird things,
wondering if my media is bad, I just burn discs.  Sometimes it burns 8x
media at 2x if it doesn't think they are high enough quality, but it
burns them right each time.

Len Sorensen
