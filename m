Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286336AbSBGIpn>; Thu, 7 Feb 2002 03:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286339AbSBGIpe>; Thu, 7 Feb 2002 03:45:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:33547 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S286336AbSBGIpW>;
	Thu, 7 Feb 2002 03:45:22 -0500
Date: Thu, 7 Feb 2002 09:45:12 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] make ide-dma compile in 2.5.4-pre2, woops
Message-ID: <20020207094512.D16105@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A minor slip up on my behalf broke ide-dma compile in 2.5.4-pre2 due to
the scatterlist ->address removal. This patch should make it work again,
but please not that it is NOT a good example for follow for folks trying
to fixup other drivers due to address breakage...

scatterlist building for a task file ioctl will be moved to be unified
with regular bio sglist building instead of the current nasty hack
soonish.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.223   -> 1.224  
#	drivers/ide/ide-dma.c	1.9     -> 1.10   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/02/07	axboe@burns.home.kernel.dk	1.224
# scatterlist address breakage in task file ioctl building
# --------------------------------------------
#
diff -Nru a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c	Thu Feb  7 09:44:56 2002
+++ b/drivers/ide/ide-dma.c	Thu Feb  7 09:44:56 2002
@@ -266,14 +266,16 @@
 #if 1	
 	if (sector_count > 128) {
 		memset(&sg[nents], 0, sizeof(*sg));
-		sg[nents].address = virt_addr;
+		sg[nents].page = virt_to_page(virt_addr);
+		sg[nents].offset = (unsigned long) virt_addr & ~PAGE_MASK;
 		sg[nents].length = 128  * SECTOR_SIZE;
 		nents++;
 		virt_addr = virt_addr + (128 * SECTOR_SIZE);
 		sector_count -= 128;
 	}
 	memset(&sg[nents], 0, sizeof(*sg));
-	sg[nents].address = virt_addr;
+	sg[nents].page = virt_to_page(virt_addr);
+	sg[nents].offset = (unsigned long) virt_addr & ~PAGE_MASK;
 	sg[nents].length =  sector_count  * SECTOR_SIZE;
 	nents++;
  #endif

-- 
Jens Axboe

