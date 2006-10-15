Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422876AbWJOTm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422876AbWJOTm4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 15:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422872AbWJOTm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 15:42:56 -0400
Received: from web31808.mail.mud.yahoo.com ([68.142.207.71]:38264 "HELO
	web31808.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932156AbWJOTmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 15:42:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Az47ZGwJjTG3awewQh6pBqsvQXqqQlctIp/L6DC6ifOur7PxnXvOQVgdQnfP4nNYZ25MBNHe8P69zZcDjW8mYwvLXJPO6Uj+YmGjtx3lT7+nK8ti8HQU/O5esrqn9967n3c97VTBwxAx7xEWrx1QmA3Z9wELQCUtS4ZE6h4Ef2w=  ;
Message-ID: <20061015194254.58866.qmail@web31808.mail.mud.yahoo.com>
Date: Sun, 15 Oct 2006 12:42:54 -0700 (PDT)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: [PATCH] libsas: support NCQ for SATA disks
To: "Darrick J. Wong" <djwong@us.ibm.com>,
       James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>,
       Mike Anderson <andmike@us.ibm.com>
In-Reply-To: <45328141.5020705@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- "Darrick J. Wong" <djwong@us.ibm.com> wrote:
> James Bottomley wrote:
> 
> > This doesn't seem to quite work for me on a SATA-1 disc:
> > 
> > sas: DOING DISCOVERY on port 1, pid:1897
> > sas: sas_ata_phy_reset: Found ATA device.
> > ata1.00: ATA-7, max UDMA/133, 781422768 sectors: LBA48 NCQ (depth 31/32)
> > ata1.00: configured for UDMA/133
> > scsi 2:0:1:0: Direct-Access     ATA      ST3400832AS      3.03 PQ: 0
> > ANSI: 5
> > SCSI device sdc: 781422768 512-byte hdwr sectors (400088 MB)
> > sdc: Write Protect is off
> > SCSI device sdc: drive cache: write back
> > SCSI device sdc: 781422768 512-byte hdwr sectors (400088 MB)
> > sdc: Write Protect is off
> > SCSI device sdc: drive cache: write back
> >  sdc: unknown partition table
> > sd 2:0:1:0: Attached scsi disk sdc
> > sas: DONE DISCOVERY on port 1, pid:1897, result:0
> > sas: command 0xf785f3c0, task 0x00000000, timed out: EH_HANDLED
> > sas: command 0xf785f3c0, task 0x00000000, timed out: EH_HANDLED
> > [...]
> > 
> > It looks like the first few commands get through (read capacity, ATA
> > IDENTIFY etc) and it hangs up on the read for the partition table.
> 
> Hm... if I put in some debug printks in the qc_issue code, I get the
> same symptoms.  I've observed that once again we get hung up on ATA
> commands where the tag number > 0.  I also noticed this pattern:
> 
> 1. ATA command w/ tag 0 (command A) issued.
> 2. Command A goes out to sas-ata.
> 2. ATA command w/ tag 1 (command B) issued.
> 3. Command A completes
> 4. Command B goes out to sas-ata.
> [...]
> 5. Command B times out.
> 
> Very odd that this all works if there are no printks.  I don't see
> anything obvious that would suggest why this apparent race seems to
> happen--unless there's some conflict between issuing an ATA command
> while completing another one.

Keep debugging.

The GPL open sourced SCSI/ATA Translation Layer (SATL) I maintain,
works perfectly for any SATA drive w/ NCQ (through the aic94xx
SDS/interconnect), and I haven't heard any complaints from people
using it.

    Luben

