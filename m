Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264638AbUFVRSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264638AbUFVRSG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 13:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264034AbUFVRPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 13:15:06 -0400
Received: from holomorphy.com ([207.189.100.168]:16004 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264955AbUFVRK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:10:59 -0400
Date: Tue, 22 Jun 2004 10:10:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: rddunlap@osdl.org
Subject: Re: [profile]: [22/23] put 1 << prof_shift at prof_buffer[0]
Message-ID: <20040622171057.GD2135@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, rddunlap@osdl.org
References: <0406220817.2aWaKb4aHb4aMbZaWaLbKb5aLbXaXa0aWaYa2a1aKb5aMb5aXaZa3aIbIbIbHbYa15250@holomorphy.com> <0406220817.IbZaYa0a2aZaKb5aIbJbYaXa4aIbIbZaZaWa3aZa5a2a2aHbIbMbZa0aMbHbHbKb15250@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0406220817.IbZaYa0a2aZaKb5aIbJbYaXa4aIbIbZaZaWa3aZa5a2a2aHbIbMbZa0aMbHbHbKb15250@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 08:18:10AM -0700, William Lee Irwin III wrote:
> Change the profile buffer format so that prof_buffer[0] contains the
> stepsize.

And this actually needs to be the following, to fix up an off-by-one
and a hunk that migrated to the wrong patch of the series (to be
followed by an mmap() patch that actually applies atop this):


Index: prof-2.6.7/kernel/profile.c
===================================================================
--- prof-2.6.7.orig/kernel/profile.c	2004-06-22 08:28:11.401782488 -0700
+++ prof-2.6.7/kernel/profile.c	2004-06-22 10:06:59.034645320 -0700
@@ -32,8 +32,9 @@
 		return;
  
 	/* only text is profiled */
-	prof_len = (_etext - _stext) >> prof_shift;
+	prof_len = ((unsigned long)(_etext - _stext) >> prof_shift) + 1;
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
@@ -221,7 +210,7 @@
 	}
 #endif
 
-	memset(prof_buffer, 0, prof_len*sizeof(atomic_t));
+	memset(&prof_buffer[1], 0, (prof_len-1)*sizeof(atomic_t));
 	return count;
 }
 
@@ -240,6 +229,6 @@
 	if (!entry)
 		return;
 	entry->proc_fops = &proc_profile_operations;
-	entry->size = (1+prof_len) * sizeof(atomic_t);
+	entry->size = sizeof(atomic_t)*prof_len;
 }
 #endif /* CONFIG_PROC_FS */
