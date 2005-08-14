Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbVHNCNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbVHNCNo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 22:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVHNCNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 22:13:44 -0400
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:28316 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932418AbVHNCNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 22:13:43 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Dave Jones <davej@redhat.com>
Subject: Re: IDE CD problems in 2.6.13rc6
Date: Sun, 14 Aug 2005 10:26:10 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20050813232957.GE3172@redhat.com>
In-Reply-To: <20050813232957.GE3172@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508141026.10734.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Aug 2005 09:29, Dave Jones wrote:
> I've noticed this week whilst trying to encode a bunch
> of audio CDs to oggs that my boxes running the latest
> kernels are having serious issues, whereas 2.6.12 seems
> to cope just fine.
>
> The symptoms vary. On some of my machines just inserting
> an audio CD makes the box instantly lock up.
> If I boot with the same CD in the drive, sound-juicer
> can read it just fine. When I get to the next CD, I have
> to reboot again, or it locks up.
>
> On another box, it gets stuck in a loop where it
> just prints out..
>
> hdc: irq timeout: status=0xd0 { Busy }    (This line sometimes has
> status=0xc0) ide: failed opcode was: unknown
>
> The net result is that I've not got a single box that
> will read audio CDs without doing something bad, and I've
> tried it on several quite diverse systems.
>
>
> I'll try and narrow down over the next few days when this
> started happening, but IDE / CD folks may have some better
> ideas about which changes were suspicious.

Ok I just started noticing unusual things on my IDE DVD-RW as well, presumably 
related, on 2.6.13-rc6. Putting in a cd and trying to read it will cause huge 
delays and then error out with:

ide-cd: cmd 0x28 timed out
hdc: DMA timeout retry
hdc: timeout waiting for DMA
hdc: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hdc: drive not ready for command
hdc: ATAPI reset complete

then it will read fine. If I start another read it goes through the same 
cycle. Forcing dma *off* with hdparm fixes the problem and all subsequent 
accesses don't have this pause, however this was never an issue on previous 
kernels with dma working fine.


relevant lspci:
00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB 
UHCI Controller #1 (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB 
UHCI Controller #2 (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB 
UHCI Controller #3 (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI 
Controller (rev 02)


hdparm info of hdc:
/dev/hdc:

ATAPI CD-ROM, with removable media
        Model Number:       LITE-ON DVDRW SOHW-1653S
        Serial Number:
        Firmware Revision:  CS02
Standards:
        Used: ATAPI for CD-ROMs, SFF-8020i, r2.5
        Supported: CD-ROM ATAPI-2
Configuration:
        DRQ response: 50us.
        Packet size: 12 bytes
Capabilities:
        LBA, IORDY(cannot be disabled)
        DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=227ns  IORDY flow control=120ns

relevant config=y info:
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_IVB=y
CONFIG_IDEDMA_AUTO=y


Cheers,
Con
