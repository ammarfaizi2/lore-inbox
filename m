Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314078AbSFEJqz>; Wed, 5 Jun 2002 05:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314138AbSFEJqy>; Wed, 5 Jun 2002 05:46:54 -0400
Received: from [195.63.194.11] ([195.63.194.11]:46610 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314078AbSFEJqw>; Wed, 5 Jun 2002 05:46:52 -0400
Message-ID: <3CFDD053.5090406@evision-ventures.com>
Date: Wed, 05 Jun 2002 10:48:19 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: "Adam J. Richter" <adam@yggdrasil.com>, zlatko.calusic@iskon.hr,
        linux-kernel@vger.kernel.org
Subject: Re: IDE{,-SCSI} trouble [2.5.20]
In-Reply-To: <200206042137.OAA00695@adam.yggdrasil.com> <20020604231859.F32338@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Tue, Jun 04, 2002 at 02:37:55PM -0700, Adam J. Richter wrote:
> 
>>--- linux/drivers/ide/icside.c	2002-06-03 00:46:21.000000000 -0700
>>+++ linux-2.5.20/drivers/ide/icside.c	2002-06-02 18:44:41.000000000 -0700
>>@@ -275,9 +275,8 @@
>> #define NR_ENTRIES 256
>> #define TABLE_SIZE (NR_ENTRIES * 8)
>> 
>>-static int ide_build_sglist(struct ata_device *drive, struct request *rq)
>>+static int ide_build_sglist(struct ata_channel *ch, struct request *rq)
>> {
>>-	struct ata_channel *ch = drive->channel;
>> 	struct scatterlist *sg = ch->sg_table;
>> 	int nents;
>> 
> 
> 
> Umm, you sure this is right?  ide_build_sglist takes an ata_channel
> argument in my 2.5.20.
> 
> If this is reversed, you also forgot to change where it is used in
> icside.c.  Besides that, one of the recent changes from Martin broke
> the driver rather disgustingly again.  The following patch fixes this
> breakage such that:
> 
> 1. we won't issue *WRITE* commands to the drive when trying to
>    *READ* data from said drive.
> 2. allows icside.c to build again.
> 
> Luckily, (2) prevents its use in 2.5.20, which is a god-send given the
> effects that (1) could have.  Martin, could you please be more careful
> with your editing in future?  Maybe using '#error' if you're not able
> to fix stuff up properly?

Sorry this change had to be done. As you can see from the
rest of the associated diff it's actually simplifying stuff.
The goal which got me at this was to finally make it possible
to unify udma_init and udma_tcq_taksfile.

Unfortuantely I have apparently missed the remaining usage of
taskfile.command in icside.c during find -exec grep...
However my changelog documented the change so I hope at least that
it was "pretty obvious" how to accomodate. BTW.> Disaster
1. could not occur becouse I deleted the usage of the read
variant altogether.

Anyway as always: Thank you for cheerishing this out.


> 
> --- orig/drivers/ide/icside.c	Mon Jun  3 10:24:34 2002
> +++ linux/drivers/ide/icside.c	Mon Jun  3 11:54:42 2002
> @@ -517,33 +517,6 @@
>  	return 0;
>  }
>  
> -static int icside_dma_read(struct ata_device *drive, struct request *rq)
> -{
> -	struct ata_channel *ch = drive->channel;
> -	unsigned int cmd;
> -
> -	if (icside_dma_common(drive, rq, DMA_MODE_READ))
> -		return 1;
> -
> -	if (drive->type != ATA_DISK)
> -		return 0;
> -
> -	ide_set_handler(drive, icside_dmaintr, WAIT_CMD, NULL);
> -
> -	if ((rq->flags & REQ_DRIVE_ACB) && drive->addressing == 1) {
> -		struct ata_taskfile *args = rq->special;
> -		cmd = args->taskfile.command;
> -	} else if (drive->addressing) {
> -		cmd = WIN_READDMA_EXT;
> -	} else {
> -		cmd = WIN_READDMA;
> -	}
> -
> -	OUT_BYTE(cmd, IDE_COMMAND_REG);
> -	enable_dma(ch->hw.dma);
> -	return 0;
> -}
> -
>  static int icside_dma_init(struct ata_device *drive, struct request *rq)
>  {
>  	struct ata_channel *ch = drive->channel;
> @@ -559,11 +532,11 @@
>  
>  	if ((rq->flags & REQ_DRIVE_ACB) && drive->addressing == 1) {
>  		struct ata_taskfile *args = rq->special;
> -		cmd = args->taskfile.command;
> +		cmd = args->cmd;
>  	} else if (drive->addressing) {
> -		cmd = WIN_WRITEDMA_EXT;
> +		cmd = rq_data_dir(rq) == WRITE ? WIN_WRITEDMA_EXT : WIN_READDMA_EXT;
>  	} else {
> -		cmd = WIN_WRITEDMA;
> +		cmd = rq_data_dir(rq) == WRITE ? WIN_WRITEDMA : WIN_READDMA;
>  	}
>  	OUT_BYTE(cmd, IDE_COMMAND_REG);
>  

