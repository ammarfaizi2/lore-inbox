Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264196AbTDJVu6 (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 17:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264199AbTDJVu6 (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 17:50:58 -0400
Received: from palrel12.hp.com ([156.153.255.237]:54177 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S264196AbTDJVuy (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 17:50:54 -0400
Date: Thu, 10 Apr 2003 15:02:34 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200304102202.h3AM2YH3021747@napali.hpl.hp.com>
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: proc_misc.c bug
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

interrupts_open() can easily try to kmalloc() more memory than
supported by kmalloc.  E.g., with 16KB page size and NR_CPUS==64, it
would try to allocate 147456 bytes.

The workaround below is to allocate 4KB per 8 CPUs.  Not really a
solution, but the fundamental problem is that /proc/interrupts
shouldn't use a fixed buffer size in the first place.  I suppose
another solution would be to use vmalloc() instead.  It all feels like
bandaids though.

	--david

===== fs/proc/proc_misc.c 1.71 vs edited =====
--- 1.71/fs/proc/proc_misc.c	Sat Mar 22 22:14:49 2003
+++ edited/fs/proc/proc_misc.c	Thu Apr 10 14:35:16 2003
@@ -388,7 +388,7 @@
 extern int show_interrupts(struct seq_file *p, void *v);
 static int interrupts_open(struct inode *inode, struct file *file)
 {
-	unsigned size = PAGE_SIZE * (1 + NR_CPUS / 8);
+	unsigned size = 4096 * (1 + NR_CPUS / 8);
 	char *buf = kmalloc(size, GFP_KERNEL);
 	struct seq_file *m;
 	int res;
