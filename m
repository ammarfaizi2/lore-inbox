Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265897AbUBGUbN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 15:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265928AbUBGUbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 15:31:13 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:54742 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265897AbUBGUbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 15:31:07 -0500
Date: Sat, 7 Feb 2004 21:30:58 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: matthew@wil.cx, linux-scsi@vger.kernel.org, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org
Subject: [patch] sym53c8xx_2 uses SYM_MEM_CLUSTER_SHIFT before its #define'd
Message-ID: <20040207203058.GA7388@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling 2.6.2-mm1 (this problem doesn't seem to be specific
to -mm) with -Wundef I got many of the following warnings:

<--  snip  -->

...
In file included from drivers/scsi/sym53c8xx_2/sym_glue.h:446,
                 from drivers/scsi/sym53c8xx_2/sym_fw.c:56:
drivers/scsi/sym53c8xx_2/sym_hipd.h:186:30: 
warning: "SYM_MEM_CLUSTER_SIZE" is not defined
...

<--  snip  -->

This seems to be a bug:
SYM_MEM_CLUSTER_SIZE is used before it's #define'd.

The patch below fixes this issue.

cu
Adrian

--- linux-2.6.2-mm1/drivers/scsi/sym53c8xx_2/sym_hipd.h.old	2004-02-07 21:20:04.000000000 +0100
+++ linux-2.6.2-mm1/drivers/scsi/sym53c8xx_2/sym_hipd.h	2004-02-07 21:20:54.000000000 +0100
@@ -171,6 +171,15 @@
 #define	SYM_CONF_MIN_ASYNC (40)
 
 /*
+ *  Shortest memory chunk is (1<<SYM_MEM_SHIFT), currently 16.
+ *  Actual allocations happen as SYM_MEM_CLUSTER_SIZE sized.
+ *  (1 PAGE at a time is just fine).
+ */
+#define SYM_MEM_SHIFT   4
+#define SYM_MEM_CLUSTER_SIZE    (1UL << SYM_MEM_CLUSTER_SHIFT)
+#define SYM_MEM_CLUSTER_MASK    (SYM_MEM_CLUSTER_SIZE-1)
+
+/*
  *  Number of entries in the START and DONE queues.
  *
  *  We limit to 1 PAGE in order to succeed allocation of 
@@ -1322,14 +1331,6 @@
  *  MEMORY ALLOCATOR.
  */
 
-/*
- *  Shortest memory chunk is (1<<SYM_MEM_SHIFT), currently 16.
- *  Actual allocations happen as SYM_MEM_CLUSTER_SIZE sized.
- *  (1 PAGE at a time is just fine).
- */
-#define SYM_MEM_SHIFT	4
-#define SYM_MEM_CLUSTER_SIZE	(1UL << SYM_MEM_CLUSTER_SHIFT)
-#define SYM_MEM_CLUSTER_MASK	(SYM_MEM_CLUSTER_SIZE-1)
 
 /*
  *  Link between free memory chunks of a given size.
