Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263222AbRE2GSq>; Tue, 29 May 2001 02:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262762AbRE2GSg>; Tue, 29 May 2001 02:18:36 -0400
Received: from gold.MUSKOKA.COM ([216.123.107.5]:62991 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S262733AbRE2GS3>;
	Tue, 29 May 2001 02:18:29 -0400
Message-ID: <3B133ADC.974A76A@yahoo.com>
Date: Tue, 29 May 2001 01:59:57 -0400
From: Paul Gortmaker <p_gortmaker@yahoo.com>
To: linux-kernel list <linux-kernel@vger.kernel.org>
CC: linux-scsi@vger.kernel.org, axboe@suse.de
Subject: [PATCH] panic in scsi_free/sr_scatter_pad
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I recall seeing something reported like this on the list(?):

  sr: ran out of mem for scatter pad
  Kernel panic: scsi_free: bad offset

Regardless, I've seen this on 2.4.5, aha1542, 40MB, mount /dev/scd0 after 
a fresh reboot and spark, pop, fizz, plop...

Seems there is a bug in sr_scatter_pad() associated with ENOMEM handling. 
AFAICT it goes something like this:

- sr_scatter_pad increases use_sg (and sglist_len) 
- scsi_malloc(sglist_len) returns NULL (hence message 1)
- sr_scatter_pad bails out but leaves increased values
- scsi_release_buffers loops on use_sg, calls scsi_free each time. 
- scsi_free gets called with random garbage - hence message 2.  8-)

Restoring the old info back into SCpnt fixes the panic - patch 
follows.  I'll have to read some more to determine why scsi_malloc is
having trouble in handing out ISA DMA mem and causing the 1st message...

Paul.

--- drivers/scsi/sr.c~	Sun May 27 03:53:26 2001
+++ drivers/scsi/sr.c	Tue May 29 01:46:29 2001
@@ -31,6 +31,8 @@
  *	 Modified by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
  *	 check resource allocation in sr_init and some cleanups
  *
+ *	 Restore SCpnt state if scsi_malloc fails in sr_scatter_pad - Paul G.
+ *
  */
 
 #include <linux/module.h>
@@ -263,10 +265,13 @@
 {
 	struct scatterlist *sg, *old_sg = NULL;
 	int i, fsize, bsize, sg_ent;
+	unsigned short old_sglist_len;
 	char *front, *back;
 
 	back = front = NULL;
 	sg_ent = SCpnt->use_sg;
+	old_sglist_len = SCpnt->sglist_len;
+	SCpnt->old_use_sg = SCpnt->use_sg;
 	bsize = 0; /* gcc... */
 
 	/*
@@ -332,6 +337,8 @@
 
 no_mem:
 	printk("sr: ran out of mem for scatter pad\n");
+	SCpnt->use_sg = SCpnt->old_use_sg;
+	SCpnt->sglist_len = old_sglist_len;
 	if (front)
 		scsi_free(front, fsize);
 	if (back)


