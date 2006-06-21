Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWFUQPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWFUQPN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 12:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWFUQPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 12:15:12 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:19466 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932184AbWFUQPK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 12:15:10 -0400
Date: Wed, 21 Jun 2006 12:15:08 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: andi@lisas.de
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       <gregkh@suse.de>, <linux-kernel@vger.kernel.org>,
       <hal@lists.freedesktop.org>, <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] USB/hal: USB open() broken? (USB CD burner
 underruns, USB HDD hard resets)
In-Reply-To: <20060621093348.GA13143@rhlx01.fht-esslingen.de>
Message-ID: <Pine.LNX.4.44L0.0606211158030.6700-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006, Andreas Mohr wrote:

> OK, at http://lisas.de/~andi/temp_usb/ there are logs:
> debug.log.gz: burning, then running my open() test app: test app started
> at 22:43:49, disrupted burning process.
> only_device_open.log.gz: device open() *only* (plus close()!),
> no other USB activity such as burning happening (for comparison purposes, to see
> what a usual open()/close() is like)
> 
> only_device_open.log.gz (and close()!) contains:
> - TEST_UNIT_READY (failure?)

Normal failure.  This indicates that the media has been changed since the
last I/O operation.

> - TEST_UNIT_READY
> - TEST_UNIT_READY
> - READ_TOC (failure?)

I don't know why this failed.  Maybe the disc didn't have a valid Table of 
Contents.

> - ALLOW_MEDIUM_REMOVAL
> - (unknown command) !!!!!!!
> - TEST_UNIT_READY
> - READ_TOC (failure?)
> - READ_TOC (failure?)

These failed for the same reason as the earlier READ_TOC.

> - READ_CAPACITY
> - ALLOW_MEDIUM_REMOVAL
> 
> Hmm, multiple failures in there: might be cable issues??

No.  If the cable was a problem then all the commands (not just READ_TOC)  
would have gotten errors (not failures).

> debug.log.gz contains:
> *** ongoing burning: ***
> - lots of WRITE_10 (NO failure!)
> - READ BUFFER CAPACITY
> - lots of WRITE_10 (NO failure!)
> - READ BUFFER CAPACITY
> - a couple WRITE_10 (NO failure!)
> *** [22:43:49] device open(): ***
> - TEST_UNIT_READY (ok!)
> - WRITE_10 (ok!!)
> - TEST_UNIT_READY (ok!)
> - WRITE_10 (ok!)
> - READ_TOC (*** ERROR!! ***)

This was a different sort of error.  The code was "Logical unit not ready, 
long write in progress", which makes sense.

> - WRITE_10 (ok!)
> - ALLOW_MEDIUM_REMOVAL (ok!)
> - WRITE_10 (*** FAILURE! ***)
> - going downhill from here...
> 
> 
> So what could be the problem here?
> READ_TOC might be it, but then it might be fully ok to have it fail
> (after all it's non-valid data content), so ALLOW_MEDIUM_REMOVAL would be the
> problem then? (next WRITE_10 FAILS!).

It sure does look like the ALLOW_MEDIUM_REMOVAL is the cause of the 
problem.

> I could be totally wrong, though, since I don't have much storage debugging
> experience.
> 
> 
> A good idea would be to further check whether it's the open() or the close()
> which disrupts burning for me.

Yep.  The ALLOW_MEDIUM_REMOVAL occurs as part of handling the close().  
And you can understand a CD drive not wanting to carry out a long write 
when the door is unlocked.

The real problem seems to be that the device is reachable in two different 
ways, and they don't implement proper mutual exclusion.  HAL (or your test 
program) is undoubtedly using /dev/sr0 or something similar, whereas 
cdrecord uses /dev/sg0.  Going through two different drivers, it's no 
surprise they wind up interfering with each other.


> Oh, and that burner_switchoff_oops.jpg in the same directory
> is an OOPS that happened when I tried to blank a CDRW,
> then cancelled the operation (2x Ctrl-C on cdrecord),
> but then had HAL device polling daemon and my test app block on I/O wait on the
> device that continued blanking the CDRW. Since I then didn't want to wait
> for the blanking to finish I had to switch off the device: immediate OOPS,
> possibly due to mis-handling the two processes still waiting on a busy device
> which then got switched off completely. Kernel 2.6.17-rc6-mm2.

Unfortunately I can't debug this without seeing the start of the oops 
message.

Alan Stern

