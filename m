Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315426AbSEBVRs>; Thu, 2 May 2002 17:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315427AbSEBVRr>; Thu, 2 May 2002 17:17:47 -0400
Received: from [195.63.194.11] ([195.63.194.11]:46096 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315426AbSEBVRp>; Thu, 2 May 2002 17:17:45 -0400
Message-ID: <3CD19E45.6030807@evision-ventures.com>
Date: Thu, 02 May 2002 22:15:01 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Mark Orr <markorr@intersurf.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.12-dj1:  IDE trouble - RZ1000 still won't finish booting
In-Reply-To: <20020502154425.45437b42.markorr@intersurf.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Mark Orr napisa?:
> I posted a log about this about a week ago regarding
> Linux 2.5.10 not completing boot on an older system with a
> RZ1000 IDE interface.   (and that RZ1000 by itself, w/ CMD640
> and generic PCI IDE disabled in make config, wouldnt even
> compile  -- it still doesnt with 2.5.12-dj1)
> 
> 
> It still crashes at the same place - when the root
> filesystem is remounted with R/W.   The messages look different,
> i.e. the "unexpected interrupt <x> <y>" is gone, but it looks
> like it's still complaining about the same thing:
> 
> hda: task_mulout_intr: error=0x04  { DriveStatusError }
> 
> then several of these:
> 
>    { task_mulout_intr }
> hda:  ide_set_handler: handler not null  old=<some hex> new=<some other hex>
> bug: kernel timer added twice
> 
> finally:
> 
> end_request: I/O error, dev 03:00, sector 456628
> end_buffer_io_sync: I/O error
> hda: ata_irq_request: hwgroup was not busy!?
> Unable to hand kernel NULL pointer dereference...
> 
> ...and the usual dumpage.    (which isnt logged, naturally)

There where no reaction becouse problems with the multi sector
IO code path in the driver are well known... and unfortunately still
not resolved becouse there are expected changes in the whole
handling of them. However to confirm this you could for the time
beeing please just try to displabe multi sector writes
on this driver by editing the following code in ide-disk.c

#ifdef CONFIG_IDEDISK_MULTI_MODE
		id->multsect = ((id->max_multsect/2) > 1) ? id->max_multsect : 0;
		id->multsect_valid = id->multsect ? 1 : 0;
		drive->mult_req = id->multsect_valid ? id->max_multsect : INITIAL_MULT_COUNT;
		if (drive->mult_req)
			drive->special_cmd |= ATA_SPECIAL_MMODE;
#else
		/* original, pre IDE-NFG, per request of AC */
		drive->mult_req = INITIAL_MULT_COUNT;
		if (drive->mult_req > id->max_multsect)
			drive->mult_req = id->max_multsect;
		if (drive->mult_req || ((id->multsect_valid & 1) && id->multsect))
			drive->special_cmd |= ATA_SPECIAL_MMODE;
#endif

to always set mult_req to 0.

Peerhaps you could of course check bfore hand first
if CONFIG_IDEDISK_MULTI_MODE is set and
INITIAL_MULT_COUNT allways equal to 0.

Thank you in advance.


