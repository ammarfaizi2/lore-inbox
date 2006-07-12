Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbWGLPLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWGLPLr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 11:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWGLPLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 11:11:47 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:8095 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751392AbWGLPLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 11:11:46 -0400
Date: Wed, 12 Jul 2006 17:11:45 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [patch] s390: xpram module parameter parsing.
Message-ID: <20060712151145.GA10588@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] xpram module parameter parsing.

The module parameters for xpram are not or in a wrong way parsed.
The xpram module uses the module_param_array directive with an int
parameter which causes the kernel to automatically parse the passed
numbers. This will cause errors if arguments are omitted or cause
wrong results if arguments have size qualifiers.
Use module_param_array with charp and parse the arguments later.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/xpram.c |   63 ++++-----------------------------------------
 1 files changed, 6 insertions(+), 57 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/xpram.c linux-2.6-patched/drivers/s390/block/xpram.c
--- linux-2.6/drivers/s390/block/xpram.c	2006-07-12 16:25:07.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/xpram.c	2006-07-12 16:25:28.000000000 +0200
@@ -71,11 +71,11 @@ static int xpram_devs;
 /*
  * Parameter parsing functions.
  */
-static int devs = XPRAM_DEVS;
-static unsigned int sizes[XPRAM_MAX_DEVS];
+static int __initdata devs = XPRAM_DEVS;
+static char __initdata *sizes[XPRAM_MAX_DEVS];
 
 module_param(devs, int, 0);
-module_param_array(sizes, int, NULL, 0);
+module_param_array(sizes, charp, NULL, 0);
 
 MODULE_PARM_DESC(devs, "number of devices (\"partitions\"), " \
 		 "the default is " __MODULE_STRING(XPRAM_DEVS) "\n");
@@ -86,59 +86,6 @@ MODULE_PARM_DESC(sizes, "list of device 
 		 "claimed by explicit sizes\n");
 MODULE_LICENSE("GPL");
 
-#ifndef MODULE
-/*
- * Parses the kernel parameters given in the kernel parameter line.
- * The expected format is
- *           <number_of_partitions>[","<partition_size>]*
- * where
- *           devices is a positive integer that initializes xpram_devs
- *           each size is a non-negative integer possibly followed by a
- *           magnitude (k,K,m,M,g,G), the list of sizes initialises
- *           xpram_sizes
- *
- * Arguments
- *           str: substring of kernel parameter line that contains xprams
- *                kernel parameters.
- *
- * Result    0 on success, -EINVAL else -- only for Version > 2.3
- *
- * Side effects
- *           the global variabls devs is set to the value of
- *           <number_of_partitions> and sizes[i] is set to the i-th
- *           partition size (if provided). A parsing error of a value
- *           results in this value being set to -EINVAL.
- */
-static int __init xpram_setup (char *str)
-{
-	char *cp;
-	int i;
-
-	devs = simple_strtoul(str, &cp, 10);
-	if (cp <= str || devs > XPRAM_MAX_DEVS)
-		return 0;
-	for (i = 0; (i < devs) && (*cp++ == ','); i++) {
-		sizes[i] = simple_strtoul(cp, &cp, 10);
-		if (*cp == 'g' || *cp == 'G') {
-			sizes[i] <<= 20;
-			cp++;
-		} else if (*cp == 'm' || *cp == 'M') {
-			sizes[i] <<= 10;
-			cp++;
-		} else if (*cp == 'k' || *cp == 'K')
-			cp++;
-		while (isspace(*cp)) cp++;
-	}
-	if (*cp == ',' && i >= devs)
-		PRINT_WARN("partition sizes list has too many entries.\n");
-	else if (*cp != 0)
-		PRINT_WARN("ignored '%s' at end of parameter string.\n", cp);
-	return 1;
-}
-
-__setup("xpram_parts=", xpram_setup);
-#endif
-
 /*
  * Copy expanded memory page (4kB) into main memory                  
  * Arguments                                                         
@@ -374,7 +321,9 @@ static int __init xpram_setup_sizes(unsi
 	mem_needed = 0;
 	mem_auto_no = 0;
 	for (i = 0; i < xpram_devs; i++) {
-		xpram_sizes[i] = (sizes[i] + 3) & -4UL;
+		if (sizes[i])
+			xpram_sizes[i] =
+				(memparse(sizes[i], &sizes[i]) + 3) & -4UL;
 		if (xpram_sizes[i])
 			mem_needed += xpram_sizes[i];
 		else
