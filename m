Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265792AbUHICRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265792AbUHICRt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 22:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUHICRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 22:17:49 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:10968 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265792AbUHICRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 22:17:44 -0400
Date: Mon, 9 Aug 2004 04:17:41 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: [patch] 2.6.8-rc3-mm2: sk98lin/skge.c doesn't compile with PROC_FS=n
Message-ID: <20040809021741.GL26174@fs.tum.de>
References: <20040808152936.1ce2eab8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040808152936.1ce2eab8.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error with CONFIG_PROC_FS=n:

<--  snip  -->

...
  CC      drivers/net/sk98lin/skge.o
drivers/net/sk98lin/skge.c: In function `skge_remove_one':
drivers/net/sk98lin/skge.c:5116: warning: implicit declaration of function `remove_proc_entry'
drivers/net/sk98lin/skge.c:5116: `pSkRootDir' undeclared (first use in this function)
drivers/net/sk98lin/skge.c:5116: (Each undeclared identifier is reported only once
drivers/net/sk98lin/skge.c:5116: for each function it appears in.)
drivers/net/sk98lin/skge.c: In function `skge_init':
drivers/net/sk98lin/skge.c:5188: `SK_Root_Dir_entry' undeclared (first use in this function)
make[3]: *** [drivers/net/sk98lin/skge.o] Error 1

<--  snip  -->


The fix is pretty straightforward:

Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc3-mm2-full/drivers/net/sk98lin/skge.c.old	2004-08-09 04:11:31.000000000 +0200
+++ linux-2.6.8-rc3-mm2-full/drivers/net/sk98lin/skge.c	2004-08-09 04:13:58.000000000 +0200
@@ -110,10 +110,7 @@
 
 #include	<linux/module.h>
 #include	<linux/init.h>
-
-#ifdef CONFIG_PROC_FS
 #include 	<linux/proc_fs.h>
-#endif
 
 #include	"h/skdrv1st.h"
 #include	"h/skdrv2nd.h"
@@ -5185,9 +5182,9 @@
 {
 	int error;
 
+#ifdef CONFIG_PROC_FS
 	memcpy(&SK_Root_Dir_entry, BOOT_STRING, sizeof(SK_Root_Dir_entry) - 1);
 
-#ifdef CONFIG_PROC_FS
 	pSkRootDir = proc_mkdir(SK_Root_Dir_entry, proc_net);
 	if (!pSkRootDir) {
 		printk(KERN_WARNING "Unable to create /proc/net/%s",

