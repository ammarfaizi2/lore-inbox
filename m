Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265478AbTIDSnq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 14:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265487AbTIDSnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 14:43:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:6630 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265478AbTIDSnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 14:43:06 -0400
Date: Thu, 4 Sep 2003 11:42:54 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Hugh Dickins <hugh@veritas.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
In-Reply-To: <Pine.LNX.4.44.0309041139130.6676-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0309041142070.6676-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Oops. Forgot the actual patch. ]

On Thu, 4 Sep 2003, Linus Torvalds wrote:
>
> How about something like this [ ... ]

THIS. 

		Linus

===== mm/mprotect.c 1.23 vs edited =====
--- 1.23/mm/mprotect.c	Wed Jul  2 21:22:38 2003
+++ edited/mm/mprotect.c	Thu Sep  4 11:12:09 2003
@@ -224,7 +224,7 @@
 asmlinkage long
 sys_mprotect(unsigned long start, size_t len, unsigned long prot)
 {
-	unsigned long nstart, end, tmp;
+	unsigned long flags, nstart, end, tmp;
 	struct vm_area_struct * vma, * next, * prev;
 	int error = -EINVAL;
 
@@ -239,6 +239,12 @@
 	if (end == start)
 		return 0;
 
+	/*
+	 * FIXME! This assumes that PROT_xxx == VM_xxxx for READ, WRITE, EXEC
+	 * That does happen to be true, but it's ugly.. mmap() gets this right.
+	 */
+	flags = prot & (VM_READ | VM_WRITE | VM_EXEC);
+
 	down_write(&current->mm->mmap_sem);
 
 	vma = find_vma_prev(current->mm, start, &prev);
@@ -257,7 +263,7 @@
 			goto out;
 		}
 
-		newflags = prot | (vma->vm_flags & ~(PROT_READ | PROT_WRITE | PROT_EXEC));
+		newflags = flags | (vma->vm_flags & ~(VM_READ | VM_WRITE | VM_EXEC));
 		if ((newflags & ~(newflags >> 4)) & 0xf) {
 			error = -EACCES;
 			goto out;

