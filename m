Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318389AbSHKVz1>; Sun, 11 Aug 2002 17:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318398AbSHKVz1>; Sun, 11 Aug 2002 17:55:27 -0400
Received: from codepoet.org ([166.70.99.138]:50916 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S318389AbSHKVz0>;
	Sun, 11 Aug 2002 17:55:26 -0400
Date: Sun, 11 Aug 2002 15:59:14 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: [PATCH] cdrom sane fallback vs 2.4.20-pre1
Message-ID: <20020811215914.GC27048@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an update to cdrom.c.   SCSI-II devices are not required
to support the READ_CD packet command.  Currently, the cdrom
driver assumes that _all_ READ_CD packet command failures are due
to READ_CD being unsupported.  Obviously, there are a million
other reasons for a READ_CD packet command to fail.  Here at my
house, the most common reason for READ_CD failures is that my
kids have, once again, scratched up my CDs resulting in bad
sectors.  So the drive hits an uncorrectable error and thinks
that READ_CD is unsupported, and then trys again using READ_10
(which takes another a few seconds to fail and, of course, again
returns an L-EC Uncorrectable Error).

This patch teaches cdrom.c to only fall back to READ_10 when
the drive reports that we sent it an invalid command...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

--- drivers/cdrom/cdrom.c~	Sun Aug 11 15:37:20 2002
+++ drivers/cdrom/cdrom.c	Sun Aug 11 15:37:24 2002
@@ -1916,6 +1916,7 @@
 {		
 	struct cdrom_device_ops *cdo = cdi->ops;
 	struct cdrom_generic_command cgc;
+	struct request_sense sense;
 	kdev_t dev = cdi->dev;
 	char buffer[32];
 	int ret = 0;
@@ -1951,9 +1952,11 @@
 		cgc.buffer = (char *) kmalloc(blocksize, GFP_KERNEL);
 		if (cgc.buffer == NULL)
 			return -ENOMEM;
+		memset(&sense, 0, sizeof(sense));
+		cgc.sense = &sense;
 		cgc.data_direction = CGC_DATA_READ;
 		ret = cdrom_read_block(cdi, &cgc, lba, 1, format, blocksize);
-		if (ret) {
+		if (ret && sense.sense_key==0x05 && sense.asc==0x20 && sense.ascq==0x00) {
 			/*
 			 * SCSI-II devices are not required to support
 			 * READ_CD, so let's try switching block size
