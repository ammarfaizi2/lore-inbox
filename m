Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbVGHHqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVGHHqq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 03:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVGHHqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 03:46:46 -0400
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:61154 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261834AbVGHHqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 03:46:45 -0400
Subject: Re: SATA: Assertion failed! qc->flags &
	ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_qc_complete,line=3052
From: Soeren Sonnenburg <kernel@nn7.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
In-Reply-To: <200507071243.39080.adobriyan@gmail.com>
References: <1120723473.18056.29.camel@localhost>
	 <200507071243.39080.adobriyan@gmail.com>
Content-Type: text/plain
Date: Fri, 08 Jul 2005 09:46:34 +0200
Message-Id: <1120808794.4399.4.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-07 at 12:43 +0400, Alexey Dobriyan wrote:
> On Thursday 07 July 2005 12:04, Soeren Sonnenburg wrote:
> > with hddtemp regularly polling for the temperature state together with
> > libsata from kernel 2.6.12 on a promise tx2. The disk is set to go to
> > sleep mode (hdparm -S 35 /dev/sda). And after a couple of hours the
> > machine oopsed (the disk was sleeping/not mounted at that time - with
> > high probability) :
> > 
> > ata2: command timeout
> > ata2: translated ATA stat/err 0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> > Assertion failed! qc->flags & ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_qc_complete,line=3052
> > ata2: translated ATA stat/err 0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> > ata2: status=0xb0 { Busy }
> > Unable to handle kernel NULL pointer dereference at virtual address 00000000
> 
> > EIP:    0060:[<c0118eac>]    Tainted: P      VLI
> 
> > I am now trying w/o hddtemp, lets see how long it survives...
> 
> With untainted kernel, please. To be sure it's our problem.

Ok, I've found a way to reproduce it without loading any prop. stuff.

1. boot with init=/bin/sh
2. run hdparm -S 1 /dev/sda
3. run hddtemp /dev/sda
4. immediate oops

another hang:

1. boot with init=/bin/sh
2. run hdparm -y /dev/sda

Nevertheless, as promised I rand without hddtemp for about a day. I got
this single error:

ata2: translated ATA stat/err 0x25/00 to SCSI SK/ASC/ASCQ 0x4/00/00
ata2: status=0x25 { DeviceFault CorrectedError Error }
SCSI error : <1 0 0 0> return code = 0x8000002
sda: Current: sense key: Hardware Error
    Additional sense: No additional sense information
end_request: I/O error, dev sda, sector 240910336

I will reverse apply the patch and proceed w/o hddtemp/hdparm... lets
see whether it survives this night.

Soeren
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.

