Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWC1EeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWC1EeV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 23:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWC1EeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 23:34:20 -0500
Received: from mx1.magmacom.com ([206.191.0.217]:3480 "EHLO mx1.magmacom.com")
	by vger.kernel.org with ESMTP id S1751224AbWC1EeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 23:34:20 -0500
Message-ID: <4428BCBF.2050000@pobox.com>
Date: Mon, 27 Mar 2006 23:34:07 -0500
From: Mark Lord <mlord@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060305 SeaMonkey/1.1a
MIME-Version: 1.0
To: sander@humilis.net
CC: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Mark Lord <liml@rtr.ca>, Andrew Morton <akpm@osdl.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
References: <20060321121354.GB24977@favonius> <Pine.LNX.4.64.0603211316580.3622@g5.osdl.org> <20060322090006.GA8462@favonius> <200603220950.11922.lkml@rtr.ca> <20060322170959.GA3222@favonius>
In-Reply-To: <20060322170959.GA3222@favonius>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sander wrote:
..
> I've applied the patch against 2.6.16-git4. I'm sorry to say the
> messages are still there:
..
> [ 2511.238690] ata9: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> [ 2511.238753] ata9: status=0xd0 { Busy }
> [ 2990.792908] ata7: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> [ 2990.792960] ata7: status=0xd0 { Busy }
> [ 4672.691569] ata8: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> [ 4672.691623] ata8: status=0xd0 { Busy }
> [ 4988.884663] ata6: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> [ 4988.884717] ata6: status=0xd0 { Busy }

Okay, I've tracked these messages down now, and they appear to be due
to the Marvell 6081 interrupting us before CACHE_FLUSH commands
have completed.

These errors only occur for PIO commands during heavy write activity,
which pretty much narrows it down to CACHE_FLUSH.

So I added code to the sata_mv interrupt handler, to have it poll/wait
for non-busy status.  And sure enough, it takes from 0 to 300 microseconds
or so for the ATA status to change from BUSY to 0x50 for many of these commands.
*After* receipt of the interrupt.

Most peculiar.

Doing a quick "read and discard ATA status" before issuing new commands
makes no difference, so the interrupt does seem to be related to this
command, as opposed to being "left over" from something before.

I don't know yet whether *every* CACHE_FLUSH results in this condition,
nor whether this requires that other channels on the chip be busy
(or non-busy) for it to happen.  Just that it does happen.

Peculiar.  I'll probably submit the IRQ poll-busy code as a patch
within a few days, unless something new comes to light.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
