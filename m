Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264961AbUFVQjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264961AbUFVQjh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 12:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264960AbUFVP1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:27:22 -0400
Received: from holomorphy.com ([207.189.100.168]:44675 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264917AbUFVPSL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:18:11 -0400
To: linux-kernel@vger.kernel.org
From: William Lee Irwin III <wli@holomorphy.com>
Subject: [profile]: [21/23] use atomic_t for prof_buffer
Message-ID: <0406220817.2aWaKb4aHb4aMbZaWaLbKb5aLbXaXa0aWaYa2a1aKb5aMb5aXaZa3aIbIbIbHbYa15250@holomorphy.com>
In-Reply-To: <0406220817.4aXa3aHb5aMb4a3a1aYaZa3aIbXa5aIbKbJbXa1aLbJb4a2a2aZaYa0aHb2aMbYa15250@holomorphy.com>
CC: rddunlap@osdl.org
Date: Tue, 22 Jun 2004 08:17:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert prof_buffer to an array of atomic_t's.

Index: prof-2.6.7/kernel/profile.c
===================================================================
--- prof-2.6.7.orig/kernel/profile.c	2004-06-22 07:26:00.201011224 -0700
+++ prof-2.6.7/kernel/profile.c	2004-06-22 07:26:01.063880048 -0700
@@ -10,7 +10,7 @@
 #include <linux/mm.h>
 #include <asm/sections.h>
 
-static unsigned int *prof_buffer;
+static atomic_t *prof_buffer;
 static unsigned long prof_len, prof_shift;
 static int prof_on;
 
@@ -33,7 +33,7 @@
  
 	/* only text is profiled */
 	prof_len = (_etext - _stext) >> prof_shift;
-	prof_buffer = alloc_bootmem(sizeof(unsigned int)*prof_len);
+	prof_buffer = alloc_bootmem(sizeof(atomic_t)*prof_len);
 }
 
 int profiling_on(void)
@@ -43,14 +43,12 @@
 
 void profile_tick(unsigned long pc)
 {
-	atomic_t *count;
 	unsigned long idx;
 
 	if (!prof_on)
 		return;
 	idx = (pc - (unsigned long)_stext) >> prof_shift;
-	count = (atomic_t *)&prof_buffer[min(idx, prof_len - 1)];
-	atomic_inc(count);
+	atomic_inc(&prof_buffer[min(idx, prof_len - 1)]);
 }
 
 /* Profile event notifications */
@@ -182,17 +180,17 @@
 	char * pnt;
 	unsigned int sample_step = 1 << prof_shift;
 
-	if (p >= (prof_len+1)*sizeof(unsigned int))
+	if (p >= (prof_len+1)*sizeof(atomic_t))
 		return 0;
-	if (count > (prof_len+1)*sizeof(unsigned int) - p)
-		count = (prof_len+1)*sizeof(unsigned int) - p;
+	if (count > (prof_len+1)*sizeof(atomic_t) - p)
+		count = (prof_len+1)*sizeof(atomic_t) - p;
 	read = 0;
 
-	while (p < sizeof(unsigned int) && count > 0) {
+	while (p < sizeof(atomic_t) && count > 0) {
 		put_user(*((char *)(&sample_step)+p),buf);
 		buf++; p++; count--; read++;
 	}
-	pnt = (char *)prof_buffer + p - sizeof(unsigned int);
+	pnt = (char *)prof_buffer + p - sizeof(atomic_t);
 	if (copy_to_user(buf,(void *)pnt,count))
 		return -EFAULT;
 	read += count;
@@ -223,7 +221,7 @@
 	}
 #endif
 
-	memset(prof_buffer, 0, prof_len * sizeof(*prof_buffer));
+	memset(prof_buffer, 0, prof_len*sizeof(atomic_t));
 	return count;
 }
 
@@ -242,6 +240,6 @@
 	if (!entry)
 		return;
 	entry->proc_fops = &proc_profile_operations;
-	entry->size = (1+prof_len) * sizeof(unsigned int);
+	entry->size = (1+prof_len) * sizeof(atomic_t);
 }
 #endif /* CONFIG_PROC_FS */
