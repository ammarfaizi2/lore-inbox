Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312269AbSDXOrc>; Wed, 24 Apr 2002 10:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312277AbSDXOrb>; Wed, 24 Apr 2002 10:47:31 -0400
Received: from [195.63.194.11] ([195.63.194.11]:51726 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312269AbSDXOrb>; Wed, 24 Apr 2002 10:47:31 -0400
Message-ID: <3CC6B6E0.3030106@evision-ventures.com>
Date: Wed, 24 Apr 2002 15:45:04 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: rwhron@earthlink.net
CC: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.5.9 -- OOPS in IDE code (symbolic dump and boot log included)
In-Reply-To: <20020424100158.A21685@rushmore>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik rwhron@earthlink.net napisa?:
>>>>>Oops on 2.5.9 at boot time.
>>>>
> 
>>Look, the problem is easy. Backout the changes to ide_cdrom_do_request()
>>and cdrom_start_read(), then re-add the
>>
>>       HWGROUP(drive)->rq->special = NULL;
>>
>>in cdrom_end_request() before calling ide_end_request()
>>
>>Something ala, completely untested (not even compiled). See the thread
>>about the ide-cd changes being broken.
> 
> 
> That works!  Applied to 2.5.10, compiled and booted.
> Mounted a cdrom and that works too.
> 
> Thanks!

Yes but if you look at ide_start_dma() in ide-dma.c you will notice
that the if (!ar) path is taken, which will cause fallback from
DMA to PIO transfer:

/*
  * Start DMA engine.
  */
int ide_start_dma(struct ata_channel *hwif, ide_drive_t *drive, ide_dma_action_t 
func)
{
	unsigned int reading = 0, count;
	unsigned long dma_base = hwif->dma_base;
	struct ata_request *ar = IDE_CUR_AR(drive);

	/* This can happen with drivers abusing the special request field.
	 */

	if (!ar) {
		printk(KERN_ERR "DMA without ATA request\n");

		return 1;
	}





-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort: ru_RU.KOI8-R

