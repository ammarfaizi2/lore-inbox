Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262228AbVBBEAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbVBBEAe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 23:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVBBDD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 22:03:26 -0500
Received: from [211.58.254.17] ([211.58.254.17]:53385 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262228AbVBBCte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 21:49:34 -0500
Date: Wed, 2 Feb 2005 11:49:30 +0900
From: Tejun Heo <tj@home-tj.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 07/29] ide: ide_reg_valid_t endian fix
Message-ID: <20050202024930.GH621@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 07_ide_reg_valid_t_endian_fix.patch
> 
> 	ide_reg_valid_t contains bitfield flags but doesn't reverse
> 	bit orders using __*_ENDIAN_BITFIELD macros.  And constants
> 	for ide_reg_valid_t, IDE_{TASKFILE|HOB}_STD_{IN|OUT}_FLAGS,
> 	are defined as byte values which are correct only on
> 	little-endian machines.  This patch defines reversed constants
> 	and .h byte union structure to make things correct on big
> 	endian machines.  The only code which uses above macros is in
> 	flagged_taskfile() and the code is currently unused, so this
> 	patch doesn't change any behavior.  (The code will get used in
> 	later patches.)


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-export/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-taskfile.c	2005-02-02 10:27:15.930195526 +0900
+++ linux-ide-export/drivers/ide/ide-taskfile.c	2005-02-02 10:28:03.518474705 +0900
@@ -794,15 +794,15 @@ ide_startstop_t flagged_taskfile (ide_dr
 	 *	write and read the hob registers (sector,nsector,lcyl,hcyl)
 	 */
 	if (task->tf_out_flags.all == 0) {
-		task->tf_out_flags.all = IDE_TASKFILE_STD_OUT_FLAGS;
+		task->tf_out_flags.h.taskfile = IDE_TASKFILE_STD_OUT_FLAGS;
 		if (drive->addressing == 1)
-			task->tf_out_flags.all |= (IDE_HOB_STD_OUT_FLAGS << 8);
+			task->tf_out_flags.h.hob = IDE_HOB_STD_OUT_FLAGS;
         }
 
 	if (task->tf_in_flags.all == 0) {
-		task->tf_in_flags.all = IDE_TASKFILE_STD_IN_FLAGS;
+		task->tf_in_flags.h.taskfile = IDE_TASKFILE_STD_IN_FLAGS;
 		if (drive->addressing == 1)
-			task->tf_in_flags.all |= (IDE_HOB_STD_IN_FLAGS  << 8);
+			task->tf_in_flags.h.hob = IDE_HOB_STD_IN_FLAGS;
         }
 
 	/* ALL Command Block Executions SHALL clear nIEN, unless otherwise */
Index: linux-ide-export/include/linux/hdreg.h
===================================================================
--- linux-ide-export.orig/include/linux/hdreg.h	2005-02-02 10:27:15.931195364 +0900
+++ linux-ide-export/include/linux/hdreg.h	2005-02-02 10:28:03.519474543 +0900
@@ -1,6 +1,8 @@
 #ifndef _LINUX_HDREG_H
 #define _LINUX_HDREG_H
 
+#include <asm/byteorder.h>
+
 #ifdef __KERNEL__
 #include <linux/ata.h>
 
@@ -79,11 +81,26 @@
 
 /*
  * Define standard taskfile in/out register
+ *
+ * ide_reg_valid_t should have been defined conditionally using
+ * __*_ENDIAN_BITFIELD macros.  But ide_reg_valid_t and the following
+ * macros are already out in the wild.  Defining reversed constants on
+ * big endian machines and adding .h.{taskfile|hob} to ide_reg_valid_t
+ * seem to be the least disrupting solution. - tj
  */
+#if defined(__LITTLE_ENDIAN_BITFIELD)
 #define IDE_TASKFILE_STD_OUT_FLAGS	0xFE
 #define IDE_TASKFILE_STD_IN_FLAGS	0xFE
 #define IDE_HOB_STD_OUT_FLAGS		0x3C
 #define IDE_HOB_STD_IN_FLAGS		0x3C
+#elif defined(__BIG_ENDIAN_BITFIELD)
+#define IDE_TASKFILE_STD_OUT_FLAGS	0x7F
+#define IDE_TASKFILE_STD_IN_FLAGS	0x7F
+#define IDE_HOB_STD_OUT_FLAGS		0x3C
+#define IDE_HOB_STD_IN_FLAGS		0x3C
+#else
+#error "Please fix <asm/byteorder.h>"
+#endif
 
 typedef unsigned char task_ioreg_t;
 typedef unsigned long sata_ioreg_t;
@@ -91,6 +108,10 @@ typedef unsigned long sata_ioreg_t;
 typedef union ide_reg_valid_s {
 	unsigned all				: 16;
 	struct {
+		unsigned taskfile		: 8;
+		unsigned hob			: 8;
+	} h;
+	struct {
 		unsigned data			: 1;
 		unsigned error_feature		: 1;
 		unsigned sector			: 1;
