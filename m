Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267026AbTBKGZh>; Tue, 11 Feb 2003 01:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267081AbTBKGZh>; Tue, 11 Feb 2003 01:25:37 -0500
Received: from pandora.cantech.net.au ([203.26.6.29]:4367 "EHLO
	pandora.cantech.net.au") by vger.kernel.org with ESMTP
	id <S267026AbTBKGZg>; Tue, 11 Feb 2003 01:25:36 -0500
Date: Tue, 11 Feb 2003 14:35:02 +0800 (WST)
From: "Anthony J. Breeds-Taurima" <tony@cantech.net.au>
To: arrays@compaq.com
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.60 cciss_scsi.c
Message-ID: <Pine.LNX.4.44.0302111414100.1039-100000@thor.cantech.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
	I recently tried to compile kernel 2.5.60.  The compile failed
---
make -f scripts/Makefile.build obj=drivers/block
  gcc -Wp,-MD,drivers/block/.cciss.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=pentium3 -Iinclude/asm-i386/mach-default
-fomit-frame-pointer -nostdinc -iwithprefix include -DMODULE
-DKBUILD_BASENAME=cciss -DKBUILD_MODNAME=cciss -c -o drivers/block/cciss.o
drivers/block/cciss.c
In file included from drivers/block/cciss.c:136:
drivers/block/cciss_scsi.c: In function `cciss_scsi_proc_info':
drivers/block/cciss_scsi.c:1265: warning: unused variable `found'
In file included from drivers/block/cciss.c:136:
drivers/block/cciss_scsi.c: In function `cciss_scsi_queue_command':
drivers/block/cciss_scsi.c:1382: structure has no member named `host'
drivers/block/cciss_scsi.c:1385: structure has no member named `channel'
drivers/block/cciss_scsi.c:1385: structure has no member named `target'
drivers/block/cciss_scsi.c:1385: structure has no member named `lun'
make[2]: *** [drivers/block/cciss.o] Error 1
make[1]: *** [drivers/block] Error 2
make: *** [drivers] Error 2
---

The patch at:
	http://linux.bkbits.net:8080/linux-2.5/diffs/drivers/scsi/scsi.h@1.58
seems to have removed a compatabilty layer you were useing.

The driver compiles fine with this patch:
================================================================================
diff -X dontdiff -urN linux-2.5.60.clean/drivers/block/cciss_scsi.c linux-2.5.60.cciss/drivers/block/cciss_scsi.c
--- linux-2.5.60.clean/drivers/block/cciss_scsi.c	2002-12-04 17:54:44.000000000 +0800
+++ linux-2.5.60.cciss/drivers/block/cciss_scsi.c	2003-02-12 14:03:09.000000000 +0800
@@ -1379,10 +1379,10 @@
 
 	// Get the ptr to our adapter structure (hba[i]) out of cmd->host.
 	// We violate cmd->host privacy here.  (Is there another way?)
-	c = (ctlr_info_t **) &cmd->host->hostdata[0];	
+	c = (ctlr_info_t **) &cmd->device->hostdata[0];	
 	ctlr = (*c)->ctlr;
 
-	rc = lookup_scsi3addr(ctlr, cmd->channel, cmd->target, cmd->lun, 
+	rc = lookup_scsi3addr(ctlr, cmd->device->channel, cmd->device->id, cmd->device->lun, 
 			scsi3addr);
 	if (rc != 0) {
 		/* the scsi nexus does not match any that we presented... */
================================================================================

I don't have the device so I'm unable to test it's functioning.



Yours Tony.

/*
 * "The significant problems we face cannot be solved at the 
 * same level of thinking we were at when we created them."
 * --Albert Einstein
 */


