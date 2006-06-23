Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWFWNbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWFWNbz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 09:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWFWNbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 09:31:55 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:62501 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP id S964823AbWFWNby
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 09:31:54 -0400
Date: Fri, 23 Jun 2006 15:31:22 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch] s390: setup.c cleanup + build fix
Message-ID: <20060623133122.GJ9446@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Cleanup & fix 31 bit compilation:

  CC      arch/s390/kernel/setup.o
arch/s390/kernel/setup.c:83: error: initializer element is not computable at
                                    load time
arch/s390/kernel/setup.c:83: error: (near initialization for
                                    'code_resource.start')
Not sure which patch in the -mm tree breaks this, but since this can be
considered a cleanup it can be merged anyway.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

Patch is against 2.6.17-mm1.

 arch/s390/kernel/setup.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

Index: linux-2.6.17-mm1/arch/s390/kernel/setup.c
===================================================================
--- linux-2.6.17-mm1.orig/arch/s390/kernel/setup.c
+++ linux-2.6.17-mm1/arch/s390/kernel/setup.c
@@ -47,6 +47,7 @@
 #include <asm/irq.h>
 #include <asm/page.h>
 #include <asm/ptrace.h>
+#include <asm/sections.h>
 
 /*
  * Machine setup..
@@ -66,11 +67,6 @@ unsigned long __initdata zholes_size[MAX
 static unsigned long __initdata memory_end;
 
 /*
- * Setup options
- */
-extern int _text,_etext, _edata, _end;
-
-/*
  * This is set up by the setup-routine at boot-time
  * for S390 need to find out, what we have to setup
  * using address 0x10400 ...
@@ -80,15 +76,11 @@ extern int _text,_etext, _edata, _end;
 
 static struct resource code_resource = {
 	.name  = "Kernel code",
-	.start = (unsigned long) &_text,
-	.end = (unsigned long) &_etext - 1,
 	.flags = IORESOURCE_BUSY | IORESOURCE_MEM,
 };
 
 static struct resource data_resource = {
 	.name = "Kernel data",
-	.start = (unsigned long) &_etext,
-	.end = (unsigned long) &_edata - 1,
 	.flags = IORESOURCE_BUSY | IORESOURCE_MEM,
 };
 
@@ -422,6 +414,11 @@ setup_resources(void)
 	struct resource *res;
 	int i;
 
+	code_resource.start = (unsigned long) &_text;
+	code_resource.end = (unsigned long) &_etext - 1;
+	data_resource.start = (unsigned long) &_etext;
+	data_resource.end = (unsigned long) &_edata - 1;
+
 	for (i = 0; i < MEMORY_CHUNKS && memory_chunk[i].size > 0; i++) {
 		res = alloc_bootmem_low(sizeof(struct resource));
 		res->flags = IORESOURCE_BUSY | IORESOURCE_MEM;
