Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbVAaHlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbVAaHlE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 02:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVAaHjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 02:39:54 -0500
Received: from waste.org ([216.27.176.166]:60396 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261955AbVAaHfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 02:35:02 -0500
Date: Mon, 31 Jan 2005 01:35:00 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.com>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.416337461@selenic.com>
Message-Id: <6.416337461@selenic.com>
Subject: [PATCH 5/8] lib/sort: Replace open-coded O(pids**2) bubblesort in cpusets
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eep. cpuset uses bubble sort on a data set that's potentially O(#
processes). Switch to lib/sort.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: tq/kernel/cpuset.c
===================================================================
--- tq.orig/kernel/cpuset.c	2005-01-29 16:13:53.000000000 -0800
+++ tq/kernel/cpuset.c	2005-01-30 13:26:48.000000000 -0800
@@ -47,6 +47,7 @@
 #include <linux/string.h>
 #include <linux/time.h>
 #include <linux/backing-dev.h>
+#include <linux/sort.h>
 
 #include <asm/uaccess.h>
 #include <asm/atomic.h>
@@ -1055,21 +1056,9 @@
 	return n;
 }
 
-/*
- * In place bubble sort pidarray of npids pid_t's.
- */
-static inline void pid_array_sort(pid_t *pidarray, int npids)
+static int cmppid(const void *a, const void *b)
 {
-	int i, j;
-
-	for (i = 0; i < npids - 1; i++) {
-		for (j = 0; j < npids - 1 - i; j++)
-			if (pidarray[j + 1] < pidarray[j]) {
-				pid_t tmp = pidarray[j];
-				pidarray[j] = pidarray[j + 1];
-				pidarray[j + 1] = tmp;
-			}
-	}
+	return *(pid_t *)a - *(pid_t *)b;
 }
 
 /*
@@ -1114,7 +1103,7 @@
 		goto err1;
 
 	npids = pid_array_load(pidarray, npids, cs);
-	pid_array_sort(pidarray, npids);
+	sort(pidarray, npids, sizeof(pid_t), cmppid, 0);
 
 	/* Call pid_array_to_buf() twice, first just to get bufsz */
 	ctr->bufsz = pid_array_to_buf(&c, sizeof(c), pidarray, npids) + 1;
