Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265172AbTIDOta (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 10:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265173AbTIDOta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 10:49:30 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:29445 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265172AbTIDOt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 10:49:28 -0400
Subject: [PATCH] fix remap of shared read only mappings
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 04 Sep 2003 10:49:18 -0400
Message-Id: <1062686960.1829.11.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When mmap MAP_SHARED is done on a file, it gets marked with VM_MAYSHARE
and, if it's read/write, VM_SHARED.  However, if it is remapped with
mremap(), the MAP_SHARED is only passed into the new mapping based on
VM_SHARED.  This means that remapped read only MAP_SHARED mappings lose
VM_MAYSHARE.  This is causing us a problem on parisc because we have to
align all shared mappings carefully to mitigate cache aliasing problems.

The fix is to key passing the MAP_SHARED flag back into the remapped are
off VM_MAYSHARE not VM_SHARED.

James

===== mremap.c 1.32 vs 1.33 =====
--- 1.32/mm/mremap.c	Thu Aug  7 12:29:10 2003
+++ 1.33/mm/mremap.c	Sun Aug 24 06:50:10 2003
@@ -420,7 +420,7 @@
 	if (flags & MREMAP_MAYMOVE) {
 		if (!(flags & MREMAP_FIXED)) {
 			unsigned long map_flags = 0;
-			if (vma->vm_flags & VM_SHARED)
+			if (vma->vm_flags & VM_MAYSHARE)
 				map_flags |= MAP_SHARED;
 
 			new_addr = get_unmapped_area(vma->vm_file, 0, new_len,

