Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751493AbWF1Rls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbWF1Rls (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 13:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWF1Rls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 13:41:48 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:18085 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751493AbWF1Rlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 13:41:47 -0400
Date: Wed, 28 Jun 2006 10:41:43 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: ZVC: Increase threshold for larger processor configurationss
Message-ID: <Pine.LNX.4.64.0606281038530.22262@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We detecteded a slight degree of contention with the new zoned VM counters 
if over 128 processors simultaneously fault anonymous pages. Raising the 
threshold to 64 fixed the contention issue.

So we need to increase the threshhold depending on the number of processors
in the system. And it may be best to overcompensate a bit.

We keep the existing threshold of 32 for configurations with less than or
equal to 64 processors. In the range of 64 to 128 processors we go to a
threshold of 64. Beyond that we go to 125 (we have to be able to increment
one beyond the threshold and then better avoid 127 just in case).

(There are a more scalability improvement possible by utilizing the 
cacheline when it has been acquired to update all pending counters but I 
want to first test with a few hundred processors to see if we need those 
and then we need to figure out if there are bad effects for smaller 
configurations.)

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-mm3/mm/vmstat.c
===================================================================
--- linux-2.6.17-mm3.orig/mm/vmstat.c	2006-06-27 20:24:37.455840645 -0700
+++ linux-2.6.17-mm3/mm/vmstat.c	2006-06-28 10:32:14.441818620 -0700
@@ -112,7 +112,21 @@ atomic_long_t vm_stat[NR_VM_ZONE_STAT_IT
 
 #ifdef CONFIG_SMP
 
+/*
+ * With higher processor counts we need higher threshold to avoid contention.
+ */
+#if NR_CPUS <= 64
 #define STAT_THRESHOLD 32
+#elif NR_CPUS <= 128
+#define STAT_THRESHOLD 64
+#else
+/*
+ * Use the maximum usable threshhold.
+ * We need to increment one beyond the threshold. To be safe
+ * also avoid 127.
+ */
+#define STAT_THRESHOLD 125
+#endif
 
 /*
  * Determine pointer to currently valid differential byte given a zone and
