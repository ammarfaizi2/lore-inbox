Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264006AbTHWRKf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 13:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264353AbTHWRKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 13:10:35 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:41088 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264006AbTHWRFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 13:05:12 -0400
Date: Sat, 23 Aug 2003 19:05:10 +0200 (MEST)
Message-Id: <200308231705.h7NH5Ai6024024@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Subject: [PATCH] fix 2.6.0-test4 IDE warning
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling IDE in 2.6.0-test4 with CONFIG_BLK_DEV_IDEDMA=n results in:

  gcc -Wp,-MD,drivers/ide/.ide-lib.o.d -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i486 -Iinclude/asm-i386/mach-default -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i486 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ide_lib -DKBUILD_MODNAME=ide_lib -c -o drivers/ide/ide-lib.o drivers/ide/ide-lib.c
drivers/ide/ide-lib.c: In function `ide_rate_filter':
drivers/ide/ide-lib.c:173: warning: comparison of distinct pointer types lacks a cast

This is because the type-checking min() macro is applied to a u8
variable and an int constant, resulting in a type mismatch. Fix below.

(CONFIG_BLK_DEV_IDEDMA=n is what one gets on an old PCI-less 486.)

/Mikael

--- linux-2.6.0-test4/drivers/ide/ide-lib.c.~1~	2003-08-09 11:54:06.000000000 +0200
+++ linux-2.6.0-test4/drivers/ide/ide-lib.c	2003-08-23 18:43:52.000000000 +0200
@@ -170,7 +170,7 @@
 		BUG();
 	return min(speed, speed_max[mode]);
 #else /* !CONFIG_BLK_DEV_IDEDMA */
-	return min(speed, XFER_PIO_4);
+	return min(speed, (u8)XFER_PIO_4);
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 }
 
