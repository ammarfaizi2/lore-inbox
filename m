Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264853AbUFVQuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264853AbUFVQuZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 12:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264958AbUFVP1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:27:00 -0400
Received: from holomorphy.com ([207.189.100.168]:44931 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264919AbUFVPSL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:18:11 -0400
To: linux-kernel@vger.kernel.org
From: William Lee Irwin III <wli@holomorphy.com>
Subject: [profile]: [22/23] put 1 << prof_shift at prof_buffer[0]
Message-ID: <0406220817.IbZaYa0a2aZaKb5aIbJbYaXa4aIbIbZaZaWa3aZa5a2a2aHbIbMbZa0aMbHbHbKb15250@holomorphy.com>
In-Reply-To: <0406220817.2aWaKb4aHb4aMbZaWaLbKb5aLbXaXa0aWaYa2a1aKb5aMb5aXaZa3aIbIbIbHbYa15250@holomorphy.com>
CC: rddunlap@osdl.org
Date: Tue, 22 Jun 2004 08:18:10 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change the profile buffer format so that prof_buffer[0] contains the
stepsize.

Index: prof-2.6.7/kernel/profile.c
===================================================================
--- prof-2.6.7.orig/kernel/profile.c	2004-06-22 07:26:01.063880048 -0700
+++ prof-2.6.7/kernel/profile.c	2004-06-22 07:26:01.925749024 -0700
@@ -32,8 +32,9 @@
 		return;
  
 	/* only text is profiled */
-	prof_len = (_etext - _stext) >> prof_shift;
+	prof_len = ((unsigned long)(_etext - _stext) + 1) >> prof_shift;
 	prof_buffer = alloc_bootmem(sizeof(atomic_t)*prof_len);
+	atomic_set(prof_buffer, 1 << prof_shift);
 }
 
 int profiling_on(void)
@@ -48,7 +49,7 @@
 	if (!prof_on)
 		return;
 	idx = (pc - (unsigned long)_stext) >> prof_shift;
-	atomic_inc(&prof_buffer[min(idx, prof_len - 1)]);
+	atomic_inc(&prof_buffer[min(idx + 1, prof_len - 1)]);
 }
 
 /* Profile event notifications */
@@ -176,26 +177,14 @@
 read_profile(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
 	unsigned long p = *ppos;
-	ssize_t read;
-	char * pnt;
-	unsigned int sample_step = 1 << prof_shift;
 
-	if (p >= (prof_len+1)*sizeof(atomic_t))
+	if (p >= sizeof(atomic_t)*prof_len)
 		return 0;
-	if (count > (prof_len+1)*sizeof(atomic_t) - p)
-		count = (prof_len+1)*sizeof(atomic_t) - p;
-	read = 0;
-
-	while (p < sizeof(atomic_t) && count > 0) {
-		put_user(*((char *)(&sample_step)+p),buf);
-		buf++; p++; count--; read++;
-	}
-	pnt = (char *)prof_buffer + p - sizeof(atomic_t);
-	if (copy_to_user(buf,(void *)pnt,count))
+	count = min(prof_len*sizeof(atomic_t) - p, count);
+	if (copy_to_user(buf, (char *)prof_buffer + p, count))
 		return -EFAULT;
-	read += count;
-	*ppos += read;
-	return read;
+	*ppos += count;
+	return count;
 }
 
 /*
@@ -240,6 +229,6 @@
 	if (!entry)
 		return;
 	entry->proc_fops = &proc_profile_operations;
-	entry->size = (1+prof_len) * sizeof(atomic_t);
+	entry->size = sizeof(atomic_t)*prof_len;
 }
 #endif /* CONFIG_PROC_FS */
