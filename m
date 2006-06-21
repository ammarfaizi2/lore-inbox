Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932679AbWFUTQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932679AbWFUTQn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932683AbWFUTQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:16:43 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:2467 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932679AbWFUTQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:16:42 -0400
Date: Wed, 21 Jun 2006 21:16:41 +0200
From: Andreas Mohr <andim2@users.sourceforge.net>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: andi@lisas.de, Bodo Eggert <7eggert@gmx.de>, Andrew Morton <akpm@osdl.org>,
       linux-usb-devel@lists.sourceforge.net, gregkh@suse.de,
       linux-kernel@vger.kernel.org, hal@lists.freedesktop.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [linux-usb-devel] USB/hal: USB open() broken? (USB CD burner underruns, USB HDD hard resets)
Message-ID: <20060621191640.GA8596@rhlx01.fht-esslingen.de>
Reply-To: andi@lisas.de
References: <20060621163410.GA22736@rhlx01.fht-esslingen.de> <Pine.LNX.4.44L0.0606211501290.8272-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0606211501290.8272-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 21, 2006 at 03:02:44PM -0400, Alan Stern wrote:
> On Wed, 21 Jun 2006, Andreas Mohr wrote:
> 
> > Maybe it's better to (additionally?) go down the route of fixing up
> > low-level communication weaknesses (since it's been semi-confirmed that it's
> > an USB communication issue, see other thread part).
> > IMHO this is a severe user experience issue that shouldn't be fixed up
> > ("covered", "hidden") by the O_EXCL thingy alone.
> 
> It's not a USB issue; it's a matter of lack of coordination between the sg 
> and sr drivers.  Each is unaware of the actions of the other, even when 
> they are speaking to the same device.

Right, I could have expressed it much better before, sorry.

Found the relevant code:
sd.c sd_open()

        if (!sdkp->openers++ && sdev->removable) {
                if (scsi_block_when_processing_errors(sdev))
                        scsi_set_medium_removal(sdev, SCSI_REMOVAL_PREVENT);
        }

And the obvious question would be whether the sdkp->openers++ thingy
could somehow be extended to enclose all hardware device users so that
e.g. sr.c wouldn't send ALLOW_MEDIUM_REMOVAL on a device already locked
by e.g. the sd.c driver.
Difficult question, though, since the group of drivers possible to use
with a certain device is not a static set:
it could be via
- sr.c
- sd.c
- IDE (in the case of ATA devices mapped via ide-scsi)
- ???

Is it possible to have such a per-*hardware*-device instance in the kernel
to keep track of various things such as number of device openers?
I'll do some investigation myself, too...

Thanks!

Andreas Mohr
