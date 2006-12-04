Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936972AbWLDPBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936972AbWLDPBL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 10:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936961AbWLDPAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 10:00:40 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:6123 "EHLO
	mtagate6.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936921AbWLDOyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:54:51 -0500
Date: Mon, 4 Dec 2006 15:54:47 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] Cleanup memory_chunk array usage.
Message-ID: <20061204145447.GU32059@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] Cleanup memory_chunk array usage.

Need this at yet another file and don't want to add yet another
extern...

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/head31.S |    2 +-
 arch/s390/kernel/setup.c  |    7 ++-----
 arch/s390/mm/extmem.c     |   11 ++++-------
 include/asm-s390/setup.h  |   15 ++++++++++++---
 4 files changed, 19 insertions(+), 16 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/head31.S linux-2.6-patched/arch/s390/kernel/head31.S
--- linux-2.6/arch/s390/kernel/head31.S	2006-12-04 14:50:52.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/head31.S	2006-12-04 14:50:52.000000000 +0100
@@ -157,7 +157,7 @@ startup_continue:
 	slr	%r4,%r4			# set start of chunk to zero
 	slr	%r5,%r5			# set end of chunk to zero
 	slr	%r6,%r6			# set access code to zero
-	la	%r10, MEMORY_CHUNKS	# number of chunks
+	la	%r10,MEMORY_CHUNKS	# number of chunks
 .Lloop:
 	tprot	0(%r5),0		# test protection of first byte
 	ipm	%r7
diff -urpN linux-2.6/arch/s390/kernel/setup.c linux-2.6-patched/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	2006-12-04 14:50:50.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/setup.c	2006-12-04 14:50:52.000000000 +0100
@@ -64,11 +64,8 @@ unsigned int console_devno = -1;
 unsigned int console_irq = -1;
 unsigned long memory_size = 0;
 unsigned long machine_flags = 0;
-struct {
-	unsigned long addr, size, type;
-} memory_chunk[MEMORY_CHUNKS] = { { 0 } };
-#define CHUNK_READ_WRITE 0
-#define CHUNK_READ_ONLY 1
+
+struct mem_chunk memory_chunk[MEMORY_CHUNKS];
 volatile int __cpu_logical_map[NR_CPUS]; /* logical cpu to cpu address */
 unsigned long __initdata zholes_size[MAX_NR_ZONES];
 static unsigned long __initdata memory_end;
diff -urpN linux-2.6/arch/s390/mm/extmem.c linux-2.6-patched/arch/s390/mm/extmem.c
--- linux-2.6/arch/s390/mm/extmem.c	2006-12-04 14:50:46.000000000 +0100
+++ linux-2.6-patched/arch/s390/mm/extmem.c	2006-12-04 14:50:52.000000000 +0100
@@ -14,12 +14,13 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/bootmem.h>
+#include <linux/ctype.h>
 #include <asm/page.h>
 #include <asm/ebcdic.h>
 #include <asm/errno.h>
 #include <asm/extmem.h>
 #include <asm/cpcmd.h>
-#include <linux/ctype.h>
+#include <asm/setup.h>
 
 #define DCSS_DEBUG	/* Debug messages on/off */
 
@@ -82,10 +83,6 @@ static struct list_head dcss_list = LIST
 static char *segtype_string[] = { "SW", "EW", "SR", "ER", "SN", "EN", "SC",
 					"EW/EN-MIXED" };
 
-extern struct {
-	unsigned long addr, size, type;
-} memory_chunk[MEMORY_CHUNKS];
-
 /*
  * Create the 8 bytes, ebcdic VM segment name from
  * an ascii name.
@@ -249,8 +246,8 @@ segment_overlaps_storage(struct dcss_seg
 {
 	int i;
 
-	for (i=0; i < MEMORY_CHUNKS && memory_chunk[i].size > 0; i++) {
-		if (memory_chunk[i].type != 0)
+	for (i = 0; i < MEMORY_CHUNKS && memory_chunk[i].size > 0; i++) {
+		if (memory_chunk[i].type != CHUNK_READ_WRITE)
 			continue;
 		if ((memory_chunk[i].addr >> 20) > (seg->end >> 20))
 			continue;
diff -urpN linux-2.6/include/asm-s390/setup.h linux-2.6-patched/include/asm-s390/setup.h
--- linux-2.6/include/asm-s390/setup.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/setup.h	2006-12-04 14:50:52.000000000 +0100
@@ -2,7 +2,7 @@
  *  include/asm-s390/setup.h
  *
  *  S390 version
- *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Copyright IBM Corp. 1999,2006
  */
 
 #ifndef _ASM_S390_SETUP_H
@@ -30,6 +30,17 @@
 #endif /* __s390x__ */
 #define COMMAND_LINE      ((char *)            (0x10480))
 
+#define CHUNK_READ_WRITE 0
+#define CHUNK_READ_ONLY  1
+
+struct mem_chunk {
+	unsigned long addr;
+	unsigned long size;
+	unsigned long type;
+};
+
+extern struct mem_chunk memory_chunk[];
+
 /*
  * Machine features detected in head.S
  */
@@ -53,7 +64,6 @@ extern unsigned long machine_flags;
 #define MACHINE_HAS_MVCOS	(machine_flags & 512)
 #endif /* __s390x__ */
 
-
 #define MACHINE_HAS_SCLP	(!MACHINE_IS_P390)
 
 /*
@@ -71,7 +81,6 @@ extern unsigned int console_irq;
 #define SET_CONSOLE_3215	do { console_mode = 2; } while (0)
 #define SET_CONSOLE_3270	do { console_mode = 3; } while (0)
 
-
 struct ipl_list_hdr {
 	u32 len;
 	u8  reserved1[3];
