Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266023AbUA1QeQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 11:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266043AbUA1QeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 11:34:16 -0500
Received: from ns.suse.de ([195.135.220.2]:15526 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266023AbUA1QeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 11:34:08 -0500
Date: Wed, 28 Jan 2004 17:33:20 +0100
From: Andi Kleen <ak@suse.de>
To: akpm@osdl.org, mingo@elte.hu, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Use address hint in mmap for search
Message-Id: <20040128173320.5daeb18a.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When the user gave an address hint in mmap use it as starting point for the
search for !MAP_FIXED. Currently it is only checked directly and when already
used the free area cache is used as starting point. With this change
you can use mmap(4096, ....) to e.g. get the lowest free address in your
address space, which is sometimes useful. For example on x86-64 glibc
wants to preferably allocate thread local data in the first 4GB but use
higher addresses when this is not possible.

This can be a bit more costly in CPU time because it may have to skip over more
VMAs, but gives better semantics for most cases. Most programs pass NULL as hint anyways 
so it won't make any difference for them. 

I did it for the generic mmap and for x86-64 for now.  Also minor white space
fixes for x86-64.

-Andi

diff -u linux-2.6.2rc2-amd64/arch/x86_64/kernel/sys_x86_64.c-o linux-2.6.2rc2-amd64/arch/x86_64/kernel/sys_x86_64.c
--- linux-2.6.2rc2-amd64/arch/x86_64/kernel/sys_x86_64.c-o	2004-01-28 07:50:31.000000000 -0800
+++ linux-2.6.2rc2-amd64/arch/x86_64/kernel/sys_x86_64.c	2004-01-28 08:11:59.291265619 -0800
@@ -105,13 +105,13 @@
 		return -ENOMEM;
 
 	if (addr) {
-	addr = PAGE_ALIGN(addr);
+		addr = PAGE_ALIGN(addr);
 		vma = find_vma(mm, addr);
 		if (end - len >= addr &&
 		    (!vma || addr + len <= vma->vm_start))
 			return addr;
-	}
-	addr = mm->free_area_cache;
+	} else
+		addr = mm->free_area_cache;
 	if (addr < begin) 
 		addr = begin; 
 	start_addr = addr;
diff -u linux-2.6.2rc2-amd64/mm/mmap.c-o linux-2.6.2rc2-amd64/mm/mmap.c
--- linux-2.6.2rc2-amd64/mm/mmap.c-o	2004-01-28 07:50:41.000000000 -0800
+++ linux-2.6.2rc2-amd64/mm/mmap.c	2004-01-28 08:12:37.009510784 -0800
@@ -743,8 +743,9 @@
 		if (TASK_SIZE - len >= addr &&
 		    (!vma || addr + len <= vma->vm_start))
 			return addr;
-	}
-	start_addr = addr = mm->free_area_cache;
+	} else
+		addr = mm->free_area_cache;
+	start_addr = addr;
 
 full_search:
 	for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
