Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316896AbSFDWTP>; Tue, 4 Jun 2002 18:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316900AbSFDWTO>; Tue, 4 Jun 2002 18:19:14 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14855 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316896AbSFDWTK>; Tue, 4 Jun 2002 18:19:10 -0400
Date: Tue, 4 Jun 2002 23:18:59 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: zlatko.calusic@iskon.hr, linux-kernel@vger.kernel.org,
        Martin Dalecki <dalecki@evision-ventures.com>
Subject: Re: IDE{,-SCSI} trouble [2.5.20]
Message-ID: <20020604231859.F32338@flint.arm.linux.org.uk>
In-Reply-To: <200206042137.OAA00695@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 02:37:55PM -0700, Adam J. Richter wrote:
> --- linux/drivers/ide/icside.c	2002-06-03 00:46:21.000000000 -0700
> +++ linux-2.5.20/drivers/ide/icside.c	2002-06-02 18:44:41.000000000 -0700
> @@ -275,9 +275,8 @@
>  #define NR_ENTRIES 256
>  #define TABLE_SIZE (NR_ENTRIES * 8)
>  
> -static int ide_build_sglist(struct ata_device *drive, struct request *rq)
> +static int ide_build_sglist(struct ata_channel *ch, struct request *rq)
>  {
> -	struct ata_channel *ch = drive->channel;
>  	struct scatterlist *sg = ch->sg_table;
>  	int nents;
>  

Umm, you sure this is right?  ide_build_sglist takes an ata_channel
argument in my 2.5.20.

If this is reversed, you also forgot to change where it is used in
icside.c.  Besides that, one of the recent changes from Martin broke
the driver rather disgustingly again.  The following patch fixes this
breakage such that:

1. we won't issue *WRITE* commands to the drive when trying to
   *READ* data from said drive.
2. allows icside.c to build again.

Luckily, (2) prevents its use in 2.5.20, which is a god-send given the
effects that (1) could have.  Martin, could you please be more careful
with your editing in future?  Maybe using '#error' if you're not able
to fix stuff up properly?

--- orig/drivers/ide/icside.c	Mon Jun  3 10:24:34 2002
+++ linux/drivers/ide/icside.c	Mon Jun  3 11:54:42 2002
@@ -517,33 +517,6 @@
 	return 0;
 }
 
-static int icside_dma_read(struct ata_device *drive, struct request *rq)
-{
-	struct ata_channel *ch = drive->channel;
-	unsigned int cmd;
-
-	if (icside_dma_common(drive, rq, DMA_MODE_READ))
-		return 1;
-
-	if (drive->type != ATA_DISK)
-		return 0;
-
-	ide_set_handler(drive, icside_dmaintr, WAIT_CMD, NULL);
-
-	if ((rq->flags & REQ_DRIVE_ACB) && drive->addressing == 1) {
-		struct ata_taskfile *args = rq->special;
-		cmd = args->taskfile.command;
-	} else if (drive->addressing) {
-		cmd = WIN_READDMA_EXT;
-	} else {
-		cmd = WIN_READDMA;
-	}
-
-	OUT_BYTE(cmd, IDE_COMMAND_REG);
-	enable_dma(ch->hw.dma);
-	return 0;
-}
-
 static int icside_dma_init(struct ata_device *drive, struct request *rq)
 {
 	struct ata_channel *ch = drive->channel;
@@ -559,11 +532,11 @@
 
 	if ((rq->flags & REQ_DRIVE_ACB) && drive->addressing == 1) {
 		struct ata_taskfile *args = rq->special;
-		cmd = args->taskfile.command;
+		cmd = args->cmd;
 	} else if (drive->addressing) {
-		cmd = WIN_WRITEDMA_EXT;
+		cmd = rq_data_dir(rq) == WRITE ? WIN_WRITEDMA_EXT : WIN_READDMA_EXT;
 	} else {
-		cmd = WIN_WRITEDMA;
+		cmd = rq_data_dir(rq) == WRITE ? WIN_WRITEDMA : WIN_READDMA;
 	}
 	OUT_BYTE(cmd, IDE_COMMAND_REG);
 


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

