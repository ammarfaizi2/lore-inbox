Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVACRwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVACRwZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 12:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVACRuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 12:50:52 -0500
Received: from holomorphy.com ([207.189.100.168]:51100 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261608AbVACRp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:45:27 -0500
Date: Mon, 3 Jan 2005 09:45:21 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [7/8] fix unresolved MTD symbols in scx200_docflash.c
Message-ID: <20050103174521.GI29332@holomorphy.com>
References: <20050103172013.GA29332@holomorphy.com> <20050103172303.GB29332@holomorphy.com> <20050103172615.GD29332@holomorphy.com> <20050103172839.GE29332@holomorphy.com> <20050103173406.GF29332@holomorphy.com> <20050103173643.GG29332@holomorphy.com> <20050103173952.GH29332@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103173952.GH29332@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is using some private #ifdef to try to control the use of
partitions and calling functions that get compiled out of the kernel
if it's set (which it is by default). This results in unresolved module
symbols, which are bad.

This patch synchronizes the conditional compilation of partition
management in the driver with the global config option for MTD
partition management and thereby fixes the unresolved symbol problem.

Signed-off-by: William Irwin <wli@holomorphy.com>

Index: mm1-2.6.10/drivers/mtd/maps/scx200_docflash.c
===================================================================
--- mm1-2.6.10.orig/drivers/mtd/maps/scx200_docflash.c	2005-01-03 06:46:06.000000000 -0800
+++ mm1-2.6.10/drivers/mtd/maps/scx200_docflash.c	2005-01-03 08:25:39.000000000 -0800
@@ -26,9 +26,6 @@
 MODULE_DESCRIPTION("NatSemi SCx200 DOCCS Flash Driver");
 MODULE_LICENSE("GPL");
 
-/* Set this to one if you want to partition the flash */
-#define PARTITION 1
-
 static int probe = 0;		/* Don't autoprobe */
 static unsigned size = 0x1000000; /* 16 MiB the whole ISA address space */
 static unsigned width = 8;	/* Default to 8 bits wide */
@@ -50,7 +47,7 @@
 
 static struct mtd_info *mymtd;
 
-#if PARTITION
+#ifdef CONFIG_MTD_PARTITIONS
 static struct mtd_partition partition_info[] = {
 	{ 
 		.name   = "DOCCS Boot kernel", 
@@ -200,7 +197,7 @@
 
 	mymtd->owner = THIS_MODULE;
 
-#if PARTITION
+#ifdef CONFIG_MTD_PARTITIONS
 	partition_info[3].offset = mymtd->size-partition_info[3].size;
 	partition_info[2].size = partition_info[3].offset-partition_info[2].offset;
 	add_mtd_partitions(mymtd, partition_info, NUM_PARTITIONS);
@@ -213,7 +210,7 @@
 static void __exit cleanup_scx200_docflash(void)
 {
 	if (mymtd) {
-#if PARTITION
+#ifdef CONFIG_MTD_PARTITIONS
 		del_mtd_partitions(mymtd);
 #else
 		del_mtd_device(mymtd);
