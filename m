Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWAVWSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWAVWSI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 17:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWAVWSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 17:18:08 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:9997 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id S932154AbWAVWSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 17:18:07 -0500
Date: Sun, 22 Jan 2006 17:17:58 -0500 (EST)
Message-Id: <200601222217.k0MMHw1D216186@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, arjan@infradead.org
Subject: [PATCH 3/4] pmap: fix integer overflow
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This fixes an integer overflow in the /proc/*/maps files.
The size of a file may exceed the limit of unsigned long
on a 32-bit platform.

Some parsers will break if they encounter a mapping of a
file that has an offset which doesn't fit into unsigned long.
Parsers which need the offset to be correct will break
without this change though. Parsers which can not handle
large numbers are likely to get LONG_MAX from strtol().

Signed-off-by: Albert Cahalan <acahalan@gmail.com>

---

This applies to -git4, grabbed Saturday night.


diff -Naurd 2/fs/proc/task_mmu.c 3/fs/proc/task_mmu.c
--- 2/fs/proc/task_mmu.c	2006-01-22 15:20:24.000000000 -0500
+++ 3/fs/proc/task_mmu.c	2006-01-22 15:26:54.000000000 -0500
@@ -135,14 +135,14 @@
 		ino = inode->i_ino;
 	}
 
-	seq_printf(m, "%08lx-%08lx %c%c%c%c %08lx %02x:%02x %lu %n",
+	seq_printf(m, "%08lx-%08lx %c%c%c%c %08llx %02x:%02x %lu %n",
 			vma->vm_start,
 			vma->vm_end,
 			flags & VM_READ ? 'r' : '-',
 			flags & VM_WRITE ? 'w' : '-',
 			flags & VM_EXEC ? 'x' : '-',
 			flags & VM_MAYSHARE ? 's' : 'p',
-			vma->vm_pgoff << PAGE_SHIFT,
+			(unsigned long long)vma->vm_pgoff << PAGE_SHIFT,
 			MAJOR(dev), MINOR(dev), ino, &len);
 
 	/*
