Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWH1LsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWH1LsT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 07:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWH1LsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 07:48:18 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:37604 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S964831AbWH1LsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 07:48:17 -0400
Message-ID: <44F2D70F.30102@s5r6.in-berlin.de>
Date: Mon, 28 Aug 2006 13:44:15 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.5) Gecko/20060721 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Linus Torvalds <torvalds@osdl.org>, Ben Collins <bcollins@ubuntu.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc4 1/5] ieee1394: sbp2: workaround for write protect
 bit of Initio firmware
References: <tkrat.bbaf8d081f6a31b7@s5r6.in-berlin.de> <tkrat.94cecc462a778dde@s5r6.in-berlin.de> <Pine.LNX.4.64.0608271308360.27779@g5.osdl.org> <20060828092429.GA8980@infradead.org>
In-Reply-To: <20060828092429.GA8980@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sun, Aug 27, 2006 at 01:17:31PM -0700, Linus Torvalds wrote:
>> Why does sbp2scsi_slave_configure() set "use_10_for_ms" in the first 
>> place?

Good question...

All I can say about it is that older versions of sbp2 enforced the usage
of MODE SENSE(10). If the SCSI stack passed down an MS(6), sbp2
converted it to MS(10) and converted returned data back into MS(6)
format. It did so for RBC disks, SBC disks, and CD-ROMs.
http://lxr.free-electrons.com/source/drivers/ieee1394/sbp2.c?v=2.4.32#2292
Some months ago all of these command conversions in sbp2 were removed
and the use_10_for_ms flag was switched on.

It would be a non-issue if devices simply returned "illegal request"
status on a wrong version of MODE SENSE. But these Initio INIC-1530
bridges return "good" status after either MODE SENSE(6) or (10) but
bogus data after the latter.

> I suspect that's because the typical command set for ieee1394 devices is
> RBC which only specifies the 10-byte commands.

RBC actually lists only MODE SENSE(6), not (10). This makes sbp2's old
behaviour even more questionable. Nevertheless, INIC-1530 is the very
first device that became known to break on MS(10). Everything else
seemed to work fine with MS(10) so far. Switching unconditionally to try
MS(6) before MS(10) could break any other devices.

I suppose I should set up an SBP-2 target (Oracle has a GPL'd userspace
implementation; somebody recently mentioned an as yet unpublished
kernelspace implementation) and use this to log which version of MODE
SENSE Windows and Mac OS prefer. Firmware coders certainly test their
works of art with some variants of these OSs.

PS: Initio's published data sheet mentions RBC support. But their
inquiry data indicate a peripheral device type of 0, which is associated
with SBC.

PPS: This patch here is not strictly needed. The INIC-1530 can be
corrected if the user directly asks Initio for a corrected firmware and
firmware uploader (they don't have it on their website) and has access
to a Windows PC to run the firmware uploader. But I think Linux users
are better served if our driver handles these devices out of the box.
-- 
Stefan Richter
-=====-=-==- =--- ==--=
http://arcgraph.de/sr/
