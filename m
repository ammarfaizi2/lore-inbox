Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWFUJdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWFUJdu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 05:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWFUJdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 05:33:50 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:32924 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751330AbWFUJdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 05:33:50 -0400
Date: Wed, 21 Jun 2006 11:33:48 +0200
From: Andreas Mohr <andim2@users.sourceforge.net>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: andi@lisas.de, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, hal@lists.freedesktop.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] USB/hal: USB open() broken? (USB CD burner underruns, USB HDD hard resets)
Message-ID: <20060621093348.GA13143@rhlx01.fht-esslingen.de>
Reply-To: andi@lisas.de
References: <20060620090532.GA6170@rhlx01.fht-esslingen.de> <Pine.LNX.4.44L0.0606201017030.6455-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0606201017030.6455-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 20, 2006 at 10:22:57AM -0400, Alan Stern wrote:
> On Tue, 20 Jun 2006, Andreas Mohr wrote:
> 
> > But how would HAL safely determine whether a (IDE/USB) drive is busy?
> > As my test app demonstrates (without HAL running), the *very first* open()
> > happening during an ongoing burning operation will kill it instantly, in the
> > USB case.
> > Are there any options left for HAL at all? Still seems to strongly point
> > towards a kernel issue so far.
> > 
> > One (rather less desireable) way I can make up might be to have HAL
> > keep the device open permanently and do an ioctl query on whether it's "busy"
> > and then quickly close the device again before the newly started
> > burning process gets disrupted (if this even properly works at all).
> 
> The open() call is not in itself the problem.
> 
> I would guess that the problem is sparked by the TEST UNIT READY command
> automatically sent when the device file is opened.  Although a drive
> should have no difficulty handling this command while carrying out a burn,
> apparently yours aborts.  In other words, this is likely to be a firmware 
> problem in the CD drive.

OK, at http://lisas.de/~andi/temp_usb/ there are logs:
debug.log.gz: burning, then running my open() test app: test app started
at 22:43:49, disrupted burning process.
only_device_open.log.gz: device open() *only* (plus close()!),
no other USB activity such as burning happening (for comparison purposes, to see
what a usual open()/close() is like)

only_device_open.log.gz (and close()!) contains:
- TEST_UNIT_READY (failure?)
- TEST_UNIT_READY
- TEST_UNIT_READY
- READ_TOC (failure?)
- ALLOW_MEDIUM_REMOVAL
- (unknown command) !!!!!!!
- TEST_UNIT_READY
- READ_TOC (failure?)
- READ_TOC (failure?)
- READ_CAPACITY
- ALLOW_MEDIUM_REMOVAL

Hmm, multiple failures in there: might be cable issues??


debug.log.gz contains:
*** ongoing burning: ***
- lots of WRITE_10 (NO failure!)
- READ BUFFER CAPACITY
- lots of WRITE_10 (NO failure!)
- READ BUFFER CAPACITY
- a couple WRITE_10 (NO failure!)
*** [22:43:49] device open(): ***
- TEST_UNIT_READY (ok!)
- WRITE_10 (ok!!)
- TEST_UNIT_READY (ok!)
- WRITE_10 (ok!)
- READ_TOC (*** ERROR!! ***)
- WRITE_10 (ok!)
- ALLOW_MEDIUM_REMOVAL (ok!)
- WRITE_10 (*** FAILURE! ***)
- going downhill from here...


So what could be the problem here?
READ_TOC might be it, but then it might be fully ok to have it fail
(after all it's non-valid data content), so ALLOW_MEDIUM_REMOVAL would be the
problem then? (next WRITE_10 FAILS!).

I could be totally wrong, though, since I don't have much storage debugging
experience.


A good idea would be to further check whether it's the open() or the close()
which disrupts burning for me.


> I can't tell what's going on with the USB HDD since you haven't provided 
> any information.

I'd like to, but can't since I don't have device access any more.


Oh, and that burner_switchoff_oops.jpg in the same directory
is an OOPS that happened when I tried to blank a CDRW,
then cancelled the operation (2x Ctrl-C on cdrecord),
but then had HAL device polling daemon and my test app block on I/O wait on the
device that continued blanking the CDRW. Since I then didn't want to wait
for the blanking to finish I had to switch off the device: immediate OOPS,
possibly due to mis-handling the two processes still waiting on a busy device
which then got switched off completely. Kernel 2.6.17-rc6-mm2.

Thanks!

Andreas Mohr
