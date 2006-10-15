Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161071AbWJORmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161071AbWJORmK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 13:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161072AbWJORmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 13:42:10 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:51093 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1161071AbWJORmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 13:42:08 -0400
Subject: Re: [PATCH] libsas: support NCQ for SATA disks
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>,
       Mike Anderson <andmike@us.ibm.com>
In-Reply-To: <453027A9.3060606@us.ibm.com>
References: <453027A9.3060606@us.ibm.com>
Content-Type: text/plain
Date: Sun, 15 Oct 2006 12:42:03 -0500
Message-Id: <1160934124.3544.7.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-13 at 16:56 -0700, Darrick J. Wong wrote:
> I've tested this patch on a x206m with a ST380819AS SATA2 disk plugged
> into the Adaptec SAS controller.  The drive came up with a queue depth
> of 31, and I successfully ran an I/O flood test to coerce libata into
> sending multiple commands simultaneously.  A kernel probe recorded the
> maximum tag number that had been seen before and after the flood test;
> before the test it was 2 and after it was 30, as I expected.

This doesn't seem to quite work for me on a SATA-1 disc:

sas: DOING DISCOVERY on port 1, pid:1897
sas: sas_ata_phy_reset: Found ATA device.
ata1.00: ATA-7, max UDMA/133, 781422768 sectors: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/133
scsi 2:0:1:0: Direct-Access     ATA      ST3400832AS      3.03 PQ: 0
ANSI: 5
SCSI device sdc: 781422768 512-byte hdwr sectors (400088 MB)
sdc: Write Protect is off
SCSI device sdc: drive cache: write back
SCSI device sdc: 781422768 512-byte hdwr sectors (400088 MB)
sdc: Write Protect is off
SCSI device sdc: drive cache: write back
 sdc: unknown partition table
sd 2:0:1:0: Attached scsi disk sdc
sas: DONE DISCOVERY on port 1, pid:1897, result:0
sas: command 0xf785f3c0, task 0x00000000, timed out: EH_HANDLED
sas: command 0xf785f3c0, task 0x00000000, timed out: EH_HANDLED
[...]

It looks like the first few commands get through (read capacity, ATA
IDENTIFY etc) and it hangs up on the read for the partition table.

James


