Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbTK3Vea (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 16:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbTK3Vea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 16:34:30 -0500
Received: from pop.gmx.net ([213.165.64.20]:15558 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263101AbTK3Ve2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 16:34:28 -0500
X-Authenticated: #4512188
Message-ID: <3FCA625F.3060305@gmx.de>
Date: Sun, 30 Nov 2003 22:34:23 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031116
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
       Jeff Garzik <jgarzik@pobox.com>, marcush@onlinehome.de, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: Silicon Image 3112A SATA trouble
References: <3FC36057.40108@gmx.de> <200311301721.41812.bzolnier@elka.pw.edu.pl> <3FCA26AA.90302@gmx.de> <200311301907.01152.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200311301907.01152.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Sunday 30 of November 2003 18:19, Prakash K. Cheemplavam wrote:
> 
>>Bartlomiej Zolnierkiewicz wrote:
>>
>>>In 2.6.x there is no max_kb_per_request setting in
>>>/proc/ide/hdx/settings. Therefore
>>>	echo "max_kb_per_request:128" > /proc/ide/hde/settings
>>>does not work.
>>>
>>>Hmm. actually I was under influence that we have generic ioctls in 2.6.x,
>>>but I can find only BLKSECTGET, BLKSECTSET was somehow lost.  Jens?
>>>
>>>Prakash, please try patch and maybe you will have 2 working drivers now
>>>:-).
>>
>>OK, this driver fixes the transfer rate problem. Nice, so I wanted to do
>>the right thing, but it didn't work, as you explained... Thanks.
> 
> 
> Cool.
> 
> 
>>Nevertheless there is still the issue left:
>>
>>hdparm -d1 /dev/hde makes the drive get major havoc (something like:
>>ide: dma_intr: status=0x58 { DriveReady, SeekCOmplete, DataRequest}
>>
>>ide status timeout=0xd8{Busy}; messages taken from swsups kernal panic
>>). Have to do a hard reset. I guess it is the same reason why swsusp
>>gets a kernel panic when it sends PM commands to siimage.c. (Mybe the
>>same error is in libata causing the same kernel panic on swsusp.)
>>
>>Any clues?
> 
> 
> Strange.  While doing 'hdparm -d1 /dev/hde' the same code path is executed
> which is executed during boot so probably device is in different state or you
> hit some weird driver bug :/.
> 
> And you are right, thats the reason why swsusp panics.

I think the bug is, the driver specifically doesn't like my 
controller-sata converter-hd combination. As I stated in my very first 
message, on HD access the siimage.c constantly calls:

static int siimage_mmio_ide_dma_test_irq (ide_drive_t *drive)
{
	ide_hwif_t *hwif	= HWIF(drive);
	unsigned long base	= (unsigned long)hwif->hwif_data;
	unsigned long addr	= siimage_selreg(hwif, 0x1);

	if (SATA_ERROR_REG) {
		u32 ext_stat = hwif->INL(base + 0x10);
		u8 watchdog = 0;
		if (ext_stat & ((hwif->channel) ? 0x40 : 0x10)) {
//			u32 sata_error = hwif->INL(SATA_ERROR_REG);
//			hwif->OUTL(sata_error, SATA_ERROR_REG);
//			watchdog = (sata_error & 0x00680000) ? 1 : 0;
//#if 1
//			printk(KERN_WARNING "%s: sata_error = 0x%08x, "
//				"watchdog = %d, %s\n",
//				drive->name, sata_error, watchdog,
//				__FUNCTION__);
//#endif

		} else {

Thats why I commented above portions out, otherwise my dmesg gets 
flooded. What is strange, when I compile the kernel to *not* enable DMA 
at boot, the siimage DMA gets enabled nevertheless, so I am not sure 
whether hdparm -d1 and kernel boot take the same path to enable DMA. It 
seems some sort of hack within siimage.c is used to enable DMA on my 
drive. Remember, I have no native SATA drive, maybe thats the problem.

Prakash

