Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129815AbQK3VQu>; Thu, 30 Nov 2000 16:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130205AbQK3VQe>; Thu, 30 Nov 2000 16:16:34 -0500
Received: from groupwise.hlyw.com ([207.115.234.141]:60421 "HELO hlyw.com")
	by vger.kernel.org with SMTP id <S129815AbQK3VQ0> convert rfc822-to-8bit;
	Thu, 30 Nov 2000 16:16:26 -0500
Message-Id: <sa264be0.010@hlyw.com>
X-Mailer: Novell GroupWise 5.5.2
Date: Thu, 30 Nov 2000 12:45:11 -0800
From: "Richard Pries" <PriesRx@hlyw.com>
To: <axboe@suse.de>
Cc: "Glen Gerber" <GlenG@hlyw.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Replace wrong structure type in mmc_ioctl() in cdrom.c
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens, 

Please consider the following patch for the wrong type of structure 
in mmc_ioctl() in cdrom.c.

Currently, mmc_ioctl() in cdrom.c is passed a cdrom_msf structure 
when ioctl() is called with CDROMREADRAW, CDROMREADMODE1, or 
CDROMREADMODE2 as its second argument.  This structure does not 
provide the required buffer for reading the data, and it does not 
correspond to the structure that cdrom.h says to use with these 
ioctl() calls. This patch replaces the cdrom_msf structure with a 
cdrom_read structure (as specified in cdrom.h).  Preliminary tests 
indicate that this patch works for both IDE and SCSI drives.   


--- linux-2.2.17/drivers/cdrom/cdrom.c	Mon Sep  4 10:39:17 2000
+++ linux-2.2.17rap/drivers/cdrom/cdrom.c	Thu Nov 30 09:01:54 2000
@@ -1432,7 +1432,7 @@
 	cgc->cmd[7] = (nblocks >>  8) & 0xff;
 	cgc->cmd[8] = nblocks & 0xff;
 	cgc->buflen = blksize * nblocks;
-	
+
 	/* set the header info returned */
 	switch (blksize) {
 	case CD_FRAMESIZE_RAW0	: cgc->cmd[9] = 0x58; break;
@@ -1863,8 +1863,10 @@
 	case CDROMREADRAW:
 	case CDROMREADMODE1:
 	case CDROMREADMODE2: {
-		struct cdrom_msf msf;
+
+		struct cdrom_read cdr;
 		int blocksize = 0, format = 0, lba;
+		int nframes;
 		
 		switch (cmd) {
 		case CDROMREADRAW:
@@ -1878,15 +1880,17 @@
 			blocksize = CD_FRAMESIZE_RAW0;
 			break;
 		}
-		IOCTL_IN(arg, struct cdrom_msf, msf);
-		lba = msf_to_lba(msf.cdmsf_min0,msf.cdmsf_sec0,msf.cdmsf_frame0);
+		IOCTL_IN(arg, struct cdrom_read, cdr);
+		lba = cdr.cdread_lba;
+		nframes = cdr.cdread_buflen/blocksize;
 		/* FIXME: we need upper bound checking, too!! */
-		if (lba < 0)
+		if (lba < 0) 
 			return -EINVAL;
-		cgc.buffer = (char *) kmalloc(blocksize, GFP_KERNEL);
+		cgc.buffer = (char *) kmalloc(blocksize*nframes, GFP_KERNEL);
 		if (cgc.buffer == NULL)
 			return -ENOMEM;
-		ret = cdrom_read_block(cdi, &cgc, lba, 1, format, blocksize);
+		ret = cdrom_read_block(cdi, &cgc, lba, nframes, format, 
+					blocksize);
 		if (ret) {
 			/*
 			 * SCSI-II devices are not required to support
@@ -1897,10 +1901,11 @@
 				kfree(cgc.buffer);
 				return ret;
 			}
-			ret = cdrom_read_cd(cdi, &cgc, lba, blocksize, 1);
+			ret = cdrom_read_cd(cdi, &cgc, lba, blocksize, nframes);
 			ret |= cdrom_switch_blocksize(cdi, blocksize);
 		}
-		if (!ret && copy_to_user((char *)arg, cgc.buffer, blocksize))
+		if (!ret && copy_to_user(cdr.cdread_bufaddr, cgc.buffer,
+					 blocksize*nframes))
 				ret = -EFAULT;
 		kfree(cgc.buffer);
 		return ret;


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
