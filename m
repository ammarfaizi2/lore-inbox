Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262779AbTJJM5i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 08:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbTJJM5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 08:57:38 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.36.230]:30459 "EHLO
	ms-smtp-02.texas.rr.com") by vger.kernel.org with ESMTP
	id S262779AbTJJM5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 08:57:30 -0400
Date: Fri, 10 Oct 2003 07:57:20 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@dell.com>
X-X-Sender: mdomsch@iguana.domsch.com
To: Meelis Roos <mroos@linux.ee>
cc: linux-kernel@vger.kernel.org, <linux-megaraid-devel@dell.com>
Subject: Re: megaraid2 compilation failure in 2.4
In-Reply-To: <Pine.GSO.4.44.0310101351420.1585-100000@math.ut.ee>
Message-ID: <Pine.LNX.4.44.0310100746330.2846-100000@iguana.domsch.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> cc -D__KERNEL__ -I/home/mroos/compile/linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
> -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE
> -DMODVERSIONS -include /home/mroos/compile/linux-2.4/include/linux/modversions.h  -nostdinc -iwithprefix include
> -DKBUILD_BASENAME=megaraid2  -c -o megaraid2.o megaraid2.c
> 
> megaraid2.c: In function `mega_find_card':
> megaraid2.c:403: error: structure has no member named `lock'

Looks like the "no host lock" patch didn't get submitted/applied.  2.4.x stock 
still uses io_request_lock.  Thanks for catching this.
ftp://ftp.lsil.com/pub/linux-megaraid/drivers/version-2.00.9/megaraid-2009-wo-hostlock.patch.gz
ftp://ftp.lsil.com/pub/linux-megaraid/drivers/version-2.00.9/megaraid-2009-wo-hostlock.patch.gz.sig
has the patch to switch it back to using io_request_lock:

diff -Naur linux/drivers/scsi/megaraid2.c linux/drivers/scsi/megaraid2.c
--- linux/drivers/scsi/megaraid2.c	2003-09-09 15:31:43.000000000 -0400
+++ linux/drivers/scsi/megaraid2.c	2003-09-09 15:32:03.000000000 -0400
@@ -398,9 +398,7 @@
 		// replace adapter->lock with io_request_lock for kernels w/o
 		// per host lock and delete the line which tries to initialize
 		// the lock in host structure.
-		adapter->host_lock = &adapter->lock;
-
-		host->lock = adapter->host_lock;
+		adapter->host_lock = &io_request_lock;
 
 		host->cmd_per_lun = max_cmd_per_lun;
 		host->max_sectors = max_sectors_per_io;



> megaraid2.c:618: warning: integer constant is too large for "long" type

		   /* Set the Mode of addressing to 64 bit if we can */
		      if((adapter->flag & BOARD_64BIT)&&(sizeof(dma_addr_t) == 8)) {
					  pci_set_dma_mask(pdev, 0xffffffffffffffff);
								    adapter->has_64bit_addr = 1;

Aside from missing the ULL piece on the end, this is expected when dma_addr_t is 32 bits, so it's harmless.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com



