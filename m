Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265416AbSIWKpD>; Mon, 23 Sep 2002 06:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265453AbSIWKpD>; Mon, 23 Sep 2002 06:45:03 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30097 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265416AbSIWKpC>;
	Mon, 23 Sep 2002 06:45:02 -0400
Date: Mon, 23 Sep 2002 12:49:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Pawel Bernadowski <pbern@wilnet.info>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.36 - trm290
Message-ID: <20020923104955.GE15479@suse.de>
References: <Pine.LNX.4.44L.0209202301190.13443-100000@niunius.wilnet.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0209202301190.13443-100000@niunius.wilnet.info>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20 2002, Pawel Bernadowski wrote:
> i didn`t compile 2.5.36(& 37).. error :
> 
>  gcc -Wp,-MD,./.trm290.o.d -D__KERNEL__ 
> -I/home/users/builder/rpm/BUILD/linux-2.5.37/include -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2
> -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
> -mpreferred-stack-boundary=2 -march=i686
> -I/home/users/builder/rpm/BUILD/linux-2.5.37/arch/i386/mach-generic 
> -nostdinc -iwithprefix include  -I../  -DKBUILD_BASENAME=trm290   -c -o 
> trm290.o    
> trm290.c
> trm290.c: In function `trm290_ide_dma_write':
> trm290.c:195: too many arguments to function `ide_build_dmatable'
> trm290.c: In function `trm290_ide_dma_read':
> trm290.c:239: too many arguments to function `ide_build_dmatable'
> make[3]: *** [trm290.o] Error 1

Might fix this differently later, but this should make it work for now.
The reason for the error is that 2.4.20-pre-ac has the extra argument to
indicate data direction, however this isn't needed on 2.5 since the
request has a data direction bit.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.603   -> 1.604  
#	drivers/ide/pci/trm290.c	1.5     -> 1.6    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/23	axboe@burns.home.kernel.dk	1.604
# Bad merge from 2.4.20-pre-ac, ide_build_dmatable() does not need data
# direction argument in 2.5 (it's implicit in the request)
# --------------------------------------------
#
diff -Nru a/drivers/ide/pci/trm290.c b/drivers/ide/pci/trm290.c
--- a/drivers/ide/pci/trm290.c	Mon Sep 23 12:48:51 2002
+++ b/drivers/ide/pci/trm290.c	Mon Sep 23 12:48:51 2002
@@ -192,7 +192,7 @@
 	trm290_prepare_drive(drive, 0);	/* select PIO xfer */
 	return 1;
 #endif
-	if (!(count = ide_build_dmatable(drive, rq, PCI_DMA_TODEVICE))) {
+	if (!(count = ide_build_dmatable(drive, rq))) {
 		/* try PIO instead of DMA */
 		trm290_prepare_drive(drive, 0); /* select PIO xfer */
 		return 1;
@@ -236,7 +236,7 @@
 	task_ioreg_t command	= WIN_NOP;
 	unsigned int count, reading = 2, writing = 0;
 
-	if (!(count = ide_build_dmatable(drive, rq, PCI_DMA_FROMDEVICE))) {
+	if (!(count = ide_build_dmatable(drive, rq))) {
 		/* try PIO instead of DMA */
 		trm290_prepare_drive(drive, 0); /* select PIO xfer */
 		return 1;

-- 
Jens Axboe

