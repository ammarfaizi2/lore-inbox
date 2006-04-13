Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965017AbWDMXNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbWDMXNE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbWDMXMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:12:15 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:2027 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965017AbWDMXL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:11:57 -0400
From: hawkes@sgi.com
To: Andrew Morton <akpm@osdl.org>
Cc: hawkes@sgi.com, linux-kernel@vger.kernel.org
Date: Thu, 13 Apr 2006 16:11:52 -0700
Message-Id: <20060413231152.3398.31561.sendpatchset@tomahawk.engr.sgi.com>
Subject: [PATCH] mm/slob.c: for_each_possible_cpu(), not NR_CPUS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert for-loops that explicitly reference "NR_CPUS" into the potentially
more efficient for_each_possible_cpu() construct.

Signed-off-by: John Hawkes <hawkes@sgi.com>

Index: linux/mm/slob.c
===================================================================
--- linux.orig/mm/slob.c	2006-04-13 12:48:21.000000000 -0700
+++ linux/mm/slob.c	2006-04-13 15:55:08.000000000 -0700
@@ -354,9 +354,7 @@ void *__alloc_percpu(size_t size)
 	if (!pdata)
 		return NULL;
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_possible(i))
-			continue;
+	for_each_possible_cpu(i) {
 		pdata->ptrs[i] = kmalloc(size, GFP_KERNEL);
 		if (!pdata->ptrs[i])
 			goto unwind_oom;
@@ -383,11 +381,9 @@ free_percpu(const void *objp)
 	int i;
 	struct percpu_data *p = (struct percpu_data *) (~(unsigned long) objp);
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_possible(i))
-			continue;
+	for_each_possible_cpu(i)
 		kfree(p->ptrs[i]);
-	}
+
 	kfree(p);
 }
 EXPORT_SYMBOL(free_percpu);
