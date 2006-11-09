Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424228AbWKIXA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424228AbWKIXA6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 18:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424229AbWKIXA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 18:00:58 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:50315 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1424228AbWKIXA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 18:00:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=h5rwr6oME4QaKgrnIAWLMoW7KpMGsujnfFobleTHwEMGMe8r9h05EjmPvi/b9Y1fBwBFyOSgq/1xOCsEGRBQGKLtniOLtLMLSzm4Uu0+U0j+yrs2ohSpMsNYhbMFzU65cGjXpLfTFv6vdL+tBaEnTHSYHLfsdB7iCzioP+CV5xI=
Message-ID: <4553B31E.3070407@gmail.com>
Date: Fri, 10 Nov 2006 08:00:46 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: Stephen.Clark@seclark.us
CC: Arjan van de Ven <arjan@infradead.org>,
       =?ISO-8859-1?Q?=22=5C=22J=2EA?=
	 =?ISO-8859-1?Q?=2E=5C=22_Magall=F3n=22?= <jamagallon@ono.com>,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       Mark Lord <lkml@rtr.ca>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Abysmal PATA IDE performance
References: <455206E7.2050104@seclark.us> <45526D50.5020105@rtr.ca>	 <455277E1.3040803@seclark.us> <20061109020758.GA21537@atjola.homenet>	 <4552A638.4010207@seclark.us>  <20061109094014.1c8b6bed@werewolf-wl>	 <1163062700.3138.467.camel@laptopd505.fenrus.org>	 <45533DB9.4000405@seclark.us> <1163084045.3138.502.camel@laptopd505.fenrus.org> <45536653.50006@seclark.us>
In-Reply-To: <45536653.50006@seclark.us>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Clark wrote:
[--snip--]
> ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
> scsi0 : ata_piix
> Synaptics Touchpad, model: 1, fw: 6.1, id: 0xa3a0b3, caps: 0xa04713/0x10008
> input: SynPS/2 Synaptics TouchPad as /class/input/input1
> ATA: abnormal status 0x7F on port 0x1F7
> ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15
> scsi1 : ata_piix
> ata2.00: ATA-6, max UDMA/100, 117210240 sectors: LBA48
> ata2.00: ata2: dev 0 multi count 16
> usb 2-2: new low speed USB device using uhci_hcd and address 3
> ata2.01: ATAPI, max UDMA/33
> ata2.00: configured for UDMA/33 <==== why isn't this 66 or 100 ?

See below.

> ===============****
> usb 2-2: configuration #1 chosen from 1 choice
> input: Logitech USB-PS/2 Trackball as /class/input/input2
> input: USB HID v1.00 Mouse [Logitech USB-PS/2 Trackball] on
> usb-0000:00:1d.1-2
> ata2.01: configured for UDMA/33 <=========== is this related to the
> following 2 lines? ====

Nope,

>   Vendor: ATA       Model: HTS721060G9AT00   Rev: MC3O
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
> SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
>  sda: sda1 sda2
> sd 1:0:0:0: Attached scsi disk sda

The above is for ata2.00.

>   Vendor: HL-DT-ST  Model: DVDRAM GMA-4082N  Rev: HJ02
>   Type:   CD-ROM                             ANSI SCSI revision: 05

And, this for ata2.01.

PATA devices occupying the same channel literally share the cable, and 
the driver needs to configure PIO mode of both devices to the slowest of 
the two (PIO mode is always configured regardless of actual transfer 
mode).  UDMA mode doesn't save such restriction, so devices can be 
configured to its own maximum transfer mode.

libata, until recently, simply used the slowest max transfer mode for 
both PIO and UDMA modes (MWDMA too).  So, that's what's happening to 
you.  Your cdrom's max UDMA mode is UDMA/33, so libata is using it for 
both devices on the channel.  Recent kernels (2.6.19-rcX) don't have 
this restriction.  Give 2.6.19-rc5 a shot.

-- 
tejun
