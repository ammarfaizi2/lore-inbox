Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965033AbVLFTrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbVLFTrp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 14:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbVLFTrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 14:47:45 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:23861 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965033AbVLFTro convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 14:47:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MYNjqBL+NtjxZxrf9XvZsfVIC2Q/sYw9k7BeNOHoORu38RuVZUsiWllOF05KY6+YWNVlPKnODVraASHCiT3uCCUBB4F5i2GlfnvvfMv8v6N3hd7i7/R4wmbTUJb846u7m+5QoFqCuVjuhj0/vY8S+RsF59Fe6gGVTduTmT2ytTA=
Message-ID: <7744a2840512061147i5c101455g9ed99624aca344dd@mail.gmail.com>
Date: Tue, 6 Dec 2005 14:47:42 -0500
From: Richard Bollinger <rabollinger@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_sil: combined irq + LBT DMA patch for testing
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20051204011953.GA16381@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051204011953.GA16381@havoc.gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/05, Jeff Garzik <jgarzik@pobox.com> wrote:
>
> To make it easy for others to test, since there are merge conflicts,
> I've combined the two previous sata_sil patches into a single patch.
>
> Verified here on my 3112 (Adaptec 1210SA).
>
> I'm especially interested to hear from anyone willing to test on a
> SI 3114 (4-port).
>
>
> The 'sii' branch of
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
>
> contains the following updates:
>
>  drivers/scsi/sata_sil.c |  233 +++++++++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 219 insertions(+), 14 deletions(-)
>
> Jeff Garzik:
>      [libata sata_sil] improved interrupt handling
>      [libata sata_sil] Greatly improve DMA handling
>
> diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
> index 3609186..9e4630f 100644
> --- a/drivers/scsi/sata_sil.c
> +++ b/drivers/scsi/sata_sil.c
>...

Not so well on my Gigabyte GA-K8N Ultra 9.  lspci -v says:
01:09.0 RAID bus controller: CMD Technology Inc: Unknown device 3114 (rev 02)
Subsystem: Giga-byte Technology: Unknown device b004
Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 5
I/O ports at 8800 [size=8]
I/O ports at 8c00 [size=4]
I/O ports at 9000 [size=8]
I/O ports at 9400 [size=4]
I/O ports at 9800 [size=16]
Memory at f5841000 (32-bit, non-prefetchable) [size=1K]
Expansion ROM at 88000000 [disabled] [size=512K]
Capabilities: [60] Power Management version 2

Applied the patch to 2.6.15-rc5, with some manual fixups.  Here're the
dmesg differences of note:
1c1
< Linux version 2.6.15-rc5 (root@LS09) (gcc version 2.95.3 20010315
(release)) #5 Tue Dec 6 09:40:42 EST 2005
---
> Linux version 2.6.15-rc5 (root@LS09) (gcc version 2.95.3 20010315 (release)) #6 Tue Dec 6 13:20:17 EST 2005
125,128c125,128
< ata1: SATA max UDMA/100 cmd 0xF8800080 ctl 0xF880008A bmdma 0xF8800000 irq 5
< ata2: SATA max UDMA/100 cmd 0xF88000C0 ctl 0xF88000CA bmdma 0xF8800008 irq 5
< ata3: SATA max UDMA/100 cmd 0xF8800280 ctl 0xF880028A bmdma 0xF8800200 irq 5
< ata4: SATA max UDMA/100 cmd 0xF88002C0 ctl 0xF88002CA bmdma 0xF8800208 irq 5
---
> ata1: SATA max UDMA/100 cmd 0xF8800080 ctl 0xF880008A bmdma 0xF8800010 irq 5
> ata2: SATA max UDMA/100 cmd 0xF88000C0 ctl 0xF88000CA bmdma 0xF8800018 irq 5
> ata3: SATA max UDMA/100 cmd 0xF8800280 ctl 0xF880028A bmdma 0xF8800210 irq 5
> ata4: SATA max UDMA/100 cmd 0xF88002C0 ctl 0xF88002CA bmdma 0xF8800218 irq 5
488a489,494
> ata4: BUG: SG size underflow
> ata4: status=0x50 { DriveReady SeekComplete }
> sdd: Current: sense key: No Sense
>     Additional sense: No additional sense information
> ata3: BUG: SG size underflow
> ata3: status=0x50 { DriveReady SeekComplete }
500a507,508
> ata2: BUG: SG size underflow
> ata2: status=0x50 { DriveReady SeekComplete }
578a586,592
> ata4: BUG: SG size underflow
> ata4: status=0x50 { DriveReady SeekComplete }
> sdd: Current: sense key: No Sense
>     Additional sense: No additional sense information
> ata1: BUG: SG size underflow
> ata1: status=0x50 { DriveReady SeekComplete }
> blk: request botched
