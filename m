Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266124AbUAUWzi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 17:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266123AbUAUWzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 17:55:38 -0500
Received: from smtp.sys.beep.pl ([195.245.198.13]:33796 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S266122AbUAUWzf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 17:55:35 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Andrew Morton <akpm@osdl.org>
Subject: modular ide + fixed legacy/ppc doesn't work when non modular on ppc
Date: Wed, 21 Jan 2004 23:54:45 +0100
User-Agent: KMail/1.5.94
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200401212354.45957.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm trying to compile 2.6.2-rc1 with fixed modular ide patch (Bartlomiej patch + legacy/ppc fixes posted here)
(http://cvs.pld-linux.org/cgi-bin/cvsweb/SOURCES/2.6.1-modular-ide-lkml.patch?rev=1.1.2.1)
but with non-modular config.

Unfortunately on PPC:

[builder@an2 linux-2.6.2-rc1]$ make bzImage SUBDIRS=drivers/ide V=1
make -f scripts/Makefile.build obj=scripts
mkdir -p .tmp_versions
make -f scripts/Makefile.build obj=arch/ppc/kernel arch/ppc/kernel/asm-offsets.s
make[1]: `arch/ppc/kernel/asm-offsets.s' is up to date.
make -f scripts/Makefile.build obj=drivers/ide
make -f scripts/Makefile.build obj=drivers/ide/arm
make -f scripts/Makefile.build obj=drivers/ide/legacy
make -f scripts/Makefile.build obj=drivers/ide/pci
  gcc -Wp,-MD,drivers/ide/ppc/.pmac.o.d -nostdinc -iwithprefix include -D__KERNEL__ -Iinclude  -Iarch/ppc -D__KERNEL__ -Iinclude  -Iarch/ppc -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Iarch/ppc -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -O2 -fomit-frame-pointer     -DKBUILD_BASENAME=pmac -DKBUILD_MODNAME=ide_core -c -o drivers/ide/ppc/pmac.o drivers/ide/ppc/pmac.c
drivers/ide/ppc/pmac.c:49:24: ide-timing.h: No such file or directory
drivers/ide/ppc/pmac.c: In function `set_timings_udma_ata6':
drivers/ide/ppc/pmac.c:716: warning: implicit declaration of function `ide_timing_find_mode'
drivers/ide/ppc/pmac.c:716: warning: initialization makes pointer from integer without a cast
drivers/ide/ppc/pmac.c:721: error: dereferencing pointer to incomplete type
drivers/ide/ppc/pmac.c: In function `pmac_ide_dma_check':
drivers/ide/ppc/pmac.c:1756: error: `XFER_MWDMA' undeclared (first use in this function)
drivers/ide/ppc/pmac.c:1756: error: (Each undeclared identifier is reported only once
drivers/ide/ppc/pmac.c:1756: error: for each function it appears in.)
drivers/ide/ppc/pmac.c:1758: error: `XFER_UDMA' undeclared (first use in this function)
drivers/ide/ppc/pmac.c:1760: error: `XFER_UDMA_66' undeclared (first use in this function)
drivers/ide/ppc/pmac.c:1762: error: `XFER_UDMA_100' undeclared (first use in this function)
drivers/ide/ppc/pmac.c:1765: warning: implicit declaration of function `ide_find_best_mode'
make[1]: *** [drivers/ide/ppc/pmac.o] Error 1

-I is missing, so fix goes here (tested)

[builder@an2 linux-2.6.2-rc1]$ diff -u drivers/ide/Makefile~ drivers/ide/Makefile
--- drivers/ide/Makefile~       2004-01-21 20:24:01.000000000 +0000
+++ drivers/ide/Makefile        2004-01-21 22:44:35.000000000 +0000
@@ -8,6 +8,9 @@
 # In the future, some of these should be built conditionally.
 #
 # First come modules that register themselves with the core
+
+EXTRA_CFLAGS            += -Idrivers/ide
+
 obj-$(CONFIG_BLK_DEV_IDE)              += pci/

 ide-core-y += ide.o ide-default.o ide-io.o ide-iops.o ide-lib.o ide-probe.o \

-- 
Arkadiusz Mi¶kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux
