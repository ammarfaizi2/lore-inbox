Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWJOSnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWJOSnT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 14:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWJOSnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 14:43:19 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:55981 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751168AbWJOSnR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 14:43:17 -0400
Message-ID: <45328141.5020705@us.ibm.com>
Date: Sun, 15 Oct 2006 11:43:13 -0700
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>,
       Mike Anderson <andmike@us.ibm.com>
Subject: Re: [PATCH] libsas: support NCQ for SATA disks
References: <453027A9.3060606@us.ibm.com> <1160934124.3544.7.camel@mulgrave.il.steeleye.com>
In-Reply-To: <1160934124.3544.7.camel@mulgrave.il.steeleye.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:

> This doesn't seem to quite work for me on a SATA-1 disc:
> 
> sas: DOING DISCOVERY on port 1, pid:1897
> sas: sas_ata_phy_reset: Found ATA device.
> ata1.00: ATA-7, max UDMA/133, 781422768 sectors: LBA48 NCQ (depth 31/32)
> ata1.00: configured for UDMA/133
> scsi 2:0:1:0: Direct-Access     ATA      ST3400832AS      3.03 PQ: 0
> ANSI: 5
> SCSI device sdc: 781422768 512-byte hdwr sectors (400088 MB)
> sdc: Write Protect is off
> SCSI device sdc: drive cache: write back
> SCSI device sdc: 781422768 512-byte hdwr sectors (400088 MB)
> sdc: Write Protect is off
> SCSI device sdc: drive cache: write back
>  sdc: unknown partition table
> sd 2:0:1:0: Attached scsi disk sdc
> sas: DONE DISCOVERY on port 1, pid:1897, result:0
> sas: command 0xf785f3c0, task 0x00000000, timed out: EH_HANDLED
> sas: command 0xf785f3c0, task 0x00000000, timed out: EH_HANDLED
> [...]
> 
> It looks like the first few commands get through (read capacity, ATA
> IDENTIFY etc) and it hangs up on the read for the partition table.

Hm... if I put in some debug printks in the qc_issue code, I get the
same symptoms.  I've observed that once again we get hung up on ATA
commands where the tag number > 0.  I also noticed this pattern:

1. ATA command w/ tag 0 (command A) issued.
2. Command A goes out to sas-ata.
2. ATA command w/ tag 1 (command B) issued.
3. Command A completes
4. Command B goes out to sas-ata.
[...]
5. Command B times out.

Very odd that this all works if there are no printks.  I don't see
anything obvious that would suggest why this apparent race seems to
happen--unless there's some conflict between issuing an ATA command
while completing another one.

--D
