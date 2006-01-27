Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751510AbWA0Q3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWA0Q3k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 11:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWA0Q3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 11:29:40 -0500
Received: from uproxy.gmail.com ([66.249.92.193]:41283 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751510AbWA0Q3j convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 11:29:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eZVM1QGa11HsRA0MYfmHpnBhENVIPGE6cy3qpWc6RvyBbgyNucwyn8o94UDWTXzZwKJfgbCIZfuyd/LJJ9VstP4uwSK0bJq6yU1MuWFvVnywNOqmvRzqg1+AJ+l5AosNjfhepFC8Wkvnb476vJ2njkAtUyxpM9aXJg41fD2z7Go=
Message-ID: <7744a2840601270829o135bb1c9ld0283042a0849abd@mail.gmail.com>
Date: Fri, 27 Jan 2006 11:29:37 -0500
From: Richard Bollinger <rabollinger@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] sata_sil: combined irq + LBT DMA patch for testing
Cc: Jeff Garzik <jgarzik@pobox.com>, Thomas Backlund <tmb@mandriva.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <58cb370e0601250826m330984g576839345ed908de@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051204011953.GA16381@havoc.gtf.org>
	 <7744a2840512061147i5c101455g9ed99624aca344dd@mail.gmail.com>
	 <43987A28.8070509@mandriva.org> <439899B6.2000302@pobox.com>
	 <43B16B06.3000401@mandriva.org> <43CD8E62.7060301@pobox.com>
	 <58cb370e0601250826m330984g576839345ed908de@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/06, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> Hi,
> ...
> I think I have finally found the bug
> after auditing the patch for x times...
>
> +       /* Stop DMA, if doing DMA */
> +       switch (qc->tf.protocol) {
> +       case ATA_PROT_DMA:
> +       case ATA_PROT_ATAPI_DMA:
> +               ata_bmdma_stop(qc);
>
> It should be sil_bmdma_stop()...
>
> By accident ata_bmdma_stop() is OK for sil3112 so that would
> explain why only people with sil3114 reported problems.
>
> My theory is that using ata_bmdma_stop() for sil3114 results
> in IRQs for port 2 and 3 not being delivered (because
> SIL_INTR_STEERING bit is cleared) and we end up with
> dma_stat_mask == 0.
>
> Rest of the patch looks perfectly fine for me.  Could somebody
> reporting problems with this patch retest with the above change?
> ...
> Bartlomiej
>
Still no joy... after a normal looking set of startup messages,
Jan 27 10:46:03 LS09 kernel: ata1: SATA max UDMA/100 cmd 0xF8800080
ctl 0xF880008A bmdma 0xF8800010 irq 5
Jan 27 10:46:03 LS09 kernel: ata2: SATA max UDMA/100 cmd 0xF88000C0
ctl 0xF88000CA bmdma 0xF8800018 irq 5
Jan 27 10:46:03 LS09 kernel: ata3: SATA max UDMA/100 cmd 0xF8800280
ctl 0xF880028A bmdma 0xF8800210 irq 5
Jan 27 10:46:03 LS09 kernel: ata4: SATA max UDMA/100 cmd 0xF88002C0
ctl 0xF88002CA bmdma 0xF8800218 irq 5
Jan 27 10:46:03 LS09 kernel: ata1: dev 0 ATA-6, max UDMA/100,
625142448 sectors: LBA48
Jan 27 10:46:03 LS09 kernel: ata1: dev 0 configured for UDMA/100
Jan 27 10:46:03 LS09 kernel: scsi0 : sata_sil
Jan 27 10:46:03 LS09 kernel: ata2: dev 0 ATA-6, max UDMA/100,
625142448 sectors: LBA48
Jan 27 10:46:03 LS09 kernel: ata2: dev 0 configured for UDMA/100
Jan 27 10:46:03 LS09 kernel: scsi1 : sata_sil
Jan 27 10:46:03 LS09 kernel: ata3: dev 0 ATA-6, max UDMA/100,
625142448 sectors: LBA48
Jan 27 10:46:03 LS09 kernel: ata3: dev 0 configured for UDMA/100
Jan 27 10:46:03 LS09 kernel: scsi2 : sata_sil
Jan 27 10:46:03 LS09 kernel: ata4: dev 0 ATA-6, max UDMA/100,
625142448 sectors: LBA48
Jan 27 10:46:03 LS09 kernel: ata4: dev 0 configured for UDMA/100
Jan 27 10:46:03 LS09 kernel: scsi3 : sata_sil
Jan 27 10:46:03 LS09 kernel:   Vendor: ATA       Model: WDC
WD3200JD-00K  Rev: 08.0
Jan 27 10:46:03 LS09 kernel:   Type:   Direct-Access                  
   ANSI SCSI revision: 05
Jan 27 10:46:03 LS09 kernel:   Vendor: ATA       Model: WDC
WD3200JD-00K  Rev: 08.0
Jan 27 10:46:03 LS09 kernel:   Type:   Direct-Access                  
   ANSI SCSI revision: 05
Jan 27 10:46:03 LS09 kernel:   Vendor: ATA       Model: WDC
WD3200JD-00K  Rev: 08.0
Jan 27 10:46:03 LS09 kernel:   Type:   Direct-Access                  
   ANSI SCSI revision: 05
Jan 27 10:46:03 LS09 kernel:   Vendor: ATA       Model: WDC
WD3200JD-00K  Rev: 08.0
Jan 27 10:46:03 LS09 kernel:   Type:   Direct-Access                  
   ANSI SCSI revision: 05

Once I actually start doing output to with a drive I get these messages:
Jan 27 10:47:05 LS09 kernel: sdc: Current: sense key: No Sense
Jan 27 10:47:05 LS09 kernel:     Additional sense: No additional sense
information
Jan 27 10:47:06 LS09 kernel: sdb: Current: sense key: No Sense
Jan 27 10:47:06 LS09 kernel:     Additional sense: No additional sense
information
Jan 27 10:47:07 LS09 in.rshd[1607]: connect from root@128.1.50.1
Jan 27 10:47:07 LS09 rshd[1608]: root@JE-LS1 as root: cmd='/sbin/ifconfig'
Jan 27 10:47:08 LS09 kernel: sdc: Current: sense key: No Sense
Jan 27 10:47:08 LS09 kernel:     Additional sense: No additional sense
information
Jan 27 10:47:10 LS09 kernel: sdd: Current: sense key: No Sense
Jan 27 10:47:10 LS09 kernel:     Additional sense: No additional sense
information
Jan 27 10:47:10 LS09 kernel: sdb: Current: sense key: No Sense
Jan 27 10:47:10 LS09 kernel:     Additional sense: No additional sense
information
Jan 27 10:47:40 LS09 kernel: sd 1:0:0:0: SCSI error: return code = 0x8000002
Jan 27 10:47:40 LS09 kernel: sdb: Current: sense key: Aborted Command
Jan 27 10:47:40 LS09 kernel:     Additional sense: Scsi parity error
Jan 27 10:47:40 LS09 kernel: sdc: Current: sense key: No Sense
Jan 27 10:47:40 LS09 kernel:     Additional sense: No additional sense
information
Jan 27 10:48:10 LS09 kernel: sd 1:0:0:0: SCSI error: return code = 0x8000002
Jan 27 10:48:10 LS09 kernel: sdb: Current: sense key: Aborted Command
Jan 27 10:48:10 LS09 kernel:     Additional sense: Scsi parity error
