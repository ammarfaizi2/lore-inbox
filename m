Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313933AbSDPWsS>; Tue, 16 Apr 2002 18:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313935AbSDPWsR>; Tue, 16 Apr 2002 18:48:17 -0400
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:30958 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S313933AbSDPWsP>; Tue, 16 Apr 2002 18:48:15 -0400
Message-ID: <3CBCA9B0.5010709@didntduck.org>
Date: Tue, 16 Apr 2002 18:46:08 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 36
In-Reply-To: <Pine.LNX.4.33.0204051657270.16281-100000@penguin.transmeta.com> <3CBBCD31.4090105@evision-ventures.com>
Content-Type: multipart/mixed;
 boundary="------------020809020004010901040401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020809020004010901040401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Martin Dalecki wrote:
> Tue Apr 16 01:02:47 CEST 2002 ide-clean-36
> 
> - Consolidate ide_choose_drive() and choose_drive() in to one function.
> 
> - Remove sector data byteswpapping support. Byte-swapping the data is 
> supported
>   on the file-system level where applicable.  Byte-swapped interfaces are
>   supported on a lower level anyway. And finally it was used 
> inconsistently.
> 
> - Eliminate taskfile_input_data() and taskfile_output_data(). This 
> allowed us
>   to split up ideproc and eliminate the ugly action switch as well as the
>   corresponding defines.

There is a typo in the cris ide driver ata_write value.  Also,
e100_ideproc is now dead and can be removed.  Patch attached (untested, 
but obvious).

-- 

						Brian Gerst

--------------020809020004010901040401
Content-Type: text/plain;
 name="ide36-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide36-1"

diff -urN linux-ide/arch/cris/drivers/ide.c linux/arch/cris/drivers/ide.c
--- linux-ide/arch/cris/drivers/ide.c	Tue Apr 16 18:37:43 2002
+++ linux/arch/cris/drivers/ide.c	Tue Apr 16 18:40:18 2002
@@ -192,8 +192,6 @@
 #define ATA_PIO0_HOLD    4
 
 static int e100_dmaproc (ide_dma_action_t func, ide_drive_t *drive);
-static void e100_ideproc (ide_ide_action_t func, ide_drive_t *drive,
-			  void *buffer, unsigned int length);
 
 /*
  * good_dma_drives() lists the model names (from "hdparm -i")
@@ -280,7 +278,7 @@
 		hwif->tuneproc = &tune_e100_ide;
 		hwif->dmaproc = &e100_dmaproc;
 		hwif->ata_read = e100_ide_input_data;
-		hwif->ata_write = e100_ide_input_data;
+		hwif->ata_write = e100_ide_output_data;
 		hwif->atapi_read = e100_atapi_read;
 		hwif->atapi_write = e100_atapi_write;
 	}
@@ -560,32 +558,6 @@
 	e100_atapi_write(drive, buffer, wcount << 2);
 }
 
-/*
- * The multiplexor for ide_xxxput_data and atapi calls
- */
-static void 
-e100_ideproc (ide_ide_action_t func, ide_drive_t *drive,
-	      void *buffer, unsigned int length)
-{
-	switch (func) {
-		case ideproc_ide_input_data:
-			e100_ide_input_data(drive, buffer, length);
-			break;
-		case ideproc_ide_output_data:
-			e100_ide_input_data(drive, buffer, length);
-			break;
-		case ideproc_atapi_read:
-			e100_atapi_read(drive, buffer, length);
-			break;
-		case ideproc_atapi_write:
-			e100_atapi_write(drive, buffer, length);
-			break;
-		default:
-			printk("e100_ideproc: unsupported func %d!\n", func);
-			break;
-	}
-}
-
 /* we only have one DMA channel on the chip for ATA, so we can keep these statically */
 static etrax_dma_descr ata_descrs[MAX_DMA_DESCRS];
 static unsigned int ata_tot_size;

--------------020809020004010901040401--

