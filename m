Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965015AbWEJQ1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbWEJQ1v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 12:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbWEJQ1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 12:27:51 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:9924 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965015AbWEJQ1u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 12:27:50 -0400
Subject: Re: Updated libata PATA patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kevin Radloff <radsaq@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3b0ffc1f0605100905x18d07f76jda38d1807cf9e9d7@mail.gmail.com>
References: <1147196676.3172.133.camel@localhost.localdomain>
	 <3b0ffc1f0605091848med1f37ua83c283a922ea682@mail.gmail.com>
	 <1147270145.17886.42.camel@localhost.localdomain>
	 <3b0ffc1f0605100905x18d07f76jda38d1807cf9e9d7@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 10 May 2006 17:39:58 +0100
Message-Id: <1147279198.19935.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-05-10 at 12:05 -0400, Kevin Radloff wrote:
> >         ae.irq_flags = SA_SHIRQ ?
> 
> Another new and exciting oops :)

Yay, so that one was the PCMCIA code being broken.

> pcmcia: registering new device pcmcia1.0
> ata3: PATA max PIO0 cmd 0x3100 ctl 0x310E bmdma 0x0 irq 11
> ata3: dev 0 cfg 49:0200 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0000
> ata3: dev 0 ATA-10, max PIO4, 2001888 sectors: LBA
> ata3: dev 0 configured for PIO0

This is all good. Its a PIO0 device (PCMCIA is ISA cycles which are PIO0
cycles)

> scsi2 : pata_pcmcia
>   Vendor: ATA       Model: SanDisk SDCFH-10  Rev: HDX
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> SCSI device sdb: 2001888 512-byte hdwr sectors (1025 MB)

The disk was found and the indentify data came out correctly.

> sdb: Write Protect is off
> sdb: Mode Sense: 00 3a 00 00
> SCSI device sdb: drive cache: write through
> SCSI device sdb: 2001888 512-byte hdwr sectors (1025 MB)
> sdb: Write Protect is off
> sdb: Mode Sense: 00 3a 00 00
> SCSI device sdb: drive cache: write through

The drive was sized, the cache checked properly.

>  sdb:<1>BUG: unable to handle kernel NULL pointer dereference at
> virtual address 00000000

Awww.. how to ruin a good day 8)

At this point its trying to read the partition table. It has translated
the command into a SCSI command block and into ATA,. It has queued it,
and it has just set out to issue it when it went boom

I'll do some more digging, but putting printks into ata_qc_issue_prot to
see where it explodes is the next step I suspect.

