Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269548AbUHZUD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269548AbUHZUD2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269550AbUHZT5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:57:42 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:38628 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S269548AbUHZT4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:56:51 -0400
Date: Thu, 26 Aug 2004 21:56:43 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-net@vger.kernel.org
Subject: [2.4 patch][1/6] lmc_media.c: fix gcc 3.4 compilation
Message-ID: <20040826195643.GD12772@fs.tum.de>
References: <20040826195133.GB12772@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826195133.GB12772@fs.tum.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error when trying to build 2.4.28-pre2 using
gcc 3.4:


<--  snip  -->

...
gcc-3.4 -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.28-pre2-full/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon 
-fno-unit-at-a-time  -I.  -nostdinc -iwithprefix include 
-DKBUILD_BASENAME=lmc_media  -c -o lmc_media.o lmc_media.c
lmc_media.c: In function `lmc_t1_get_link_status':
lmc_debug.h:50: sorry, unimplemented: inlining failed in call to 
'lmc_trace': function body not available
lmc_media.c:1073: sorry, unimplemented: called from here
lmc_debug.h:50: sorry, unimplemented: inlining failed in call to 
'lmc_trace': function body not available
lmc_media.c:1168: sorry, unimplemented: called from here
make[5]: *** [lmc_media.o] Error 1
make[5]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.28-pre2-full/drivers/net/wan/lmc'

<--  snip  -->


The patch below fixes this issue by uninlining lmc_trace.


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.4.28-pre2-full/drivers/net/wan/lmc/lmc_debug.h.old	2004-08-26 18:58:03.000000000 +0200
+++ linux-2.4.28-pre2-full/drivers/net/wan/lmc/lmc_debug.h	2004-08-26 18:58:32.000000000 +0200
@@ -47,6 +47,6 @@
 
 void lmcConsoleLog(char *type, unsigned char *ucData, int iLen);
 void lmcEventLog (u_int32_t EventNum, u_int32_t arg2, u_int32_t arg3);
-inline void lmc_trace(struct net_device *dev, char *msg);
+void lmc_trace(struct net_device *dev, char *msg);
 
 #endif
--- linux-2.4.28-pre2-full/drivers/net/wan/lmc/lmc_debug.c.old	2004-08-26 18:59:32.000000000 +0200
+++ linux-2.4.28-pre2-full/drivers/net/wan/lmc/lmc_debug.c	2004-08-26 18:59:47.000000000 +0200
@@ -66,7 +66,7 @@
 #endif
 }
 
-inline void lmc_trace(struct net_device *dev, char *msg){
+void lmc_trace(struct net_device *dev, char *msg){
 #ifdef LMC_TRACE
     unsigned long j = jiffies + 3; /* Wait for 50 ms */
 



