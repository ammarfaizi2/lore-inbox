Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273011AbTG3Qrh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 12:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273012AbTG3Qrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 12:47:37 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:63936 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S273011AbTG3Qrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 12:47:31 -0400
Date: Wed, 30 Jul 2003 18:47:24 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: dwmw2@redhat.com
Cc: mtd@infradead.org, linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [patch] mtd/ftl.c: remove always false comparison
Message-ID: <20030730164724.GA21734@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[resent with a subject]

gcc 3.3 correctly gives the following warning:

<--  snip  -->

...
  CC      drivers/mtd/ftl.o
drivers/mtd/ftl.c: In function `scan_header':
drivers/mtd/ftl.c:191: warning: comparison is always false due to 
limited range 
...

<--  snip  -->

Looking at the code it seems gcc is correct, a 16bit number can _never_
be > 65536.

The following patch removes this comparison:


--- linux-2.6.0-test2-full/drivers/mtd/ftl.c.old	2003-07-30 13:04:05.000000000 +0200
+++ linux-2.6.0-test2-full/drivers/mtd/ftl.c	2003-07-30 13:04:13.000000000 +0200
@@ -188,7 +188,7 @@
 	printk(KERN_NOTICE "ftl_cs: FTL header not found.\n");
 	return -ENOENT;
     }
-    if ((le16_to_cpu(header.NumEraseUnits) > 65536) || header.BlockSize != 9 ||
+    if (header.BlockSize != 9 ||
 	(header.EraseUnitSize < 10) || (header.EraseUnitSize > 31) ||
 	(header.NumTransferUnits >= le16_to_cpu(header.NumEraseUnits))) {
 	printk(KERN_NOTICE "ftl_cs: FTL header corrupt!\n");



I've tested the compilation with 2.6.0-test2 and 2.4.22-pre9.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

