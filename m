Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbUKPRdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbUKPRdx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 12:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbUKPRdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 12:33:53 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:6621 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S262067AbUKPRdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 12:33:50 -0500
Date: Tue, 16 Nov 2004 18:33:52 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Andrew Morton <akpm@osdl.org>, Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: mlock hanging on non-ram with VM_IO set
Message-ID: <20041116173352.GL4758@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a report of mlock deadlocking on non-ram mappings (precisely on
a mmap of /dev/mem outside the mem_map array range)

I believe this should fix it (I verified the mlock is the only one
passing down pages == NULL, and infact mlock is the only one hanging on
VM_IO vmas since the pfn isn't valid and handle_mm_fault sure can't
istantiate a valid pfn there since the ptes are filled synchronously at
mmap time), comments? (I don't see any reason why mlock should be
allowed to trigger page faults on VM_IO regions)

This is not a bad bug, mlock is privilegied, and /dev/mem is privilegied
too, and mlock makes no sense on a non-ram mappings (noop), but I guess
it's ok to add it mostly for things like mlockall that would otherwise
deadlock the box and I guess it's nicer if they work transparently, no
matter what mappings are in the task.

btw, mlock traps the error and ignores it as it should.

this is untested but I guess it should fix it (and it applied cleanly to
kernel CVS).

Signed-off-by: Andrea Arcangeli <andrea@novell.com>

--- sles/mm/memory.c.~1~	2004-11-12 12:30:25.000000000 +0100
+++ sles/mm/memory.c	2004-11-16 17:58:02.752131952 +0100
@@ -753,7 +753,7 @@ int get_user_pages(struct task_struct *t
 			continue;
 		}
 
-		if (!vma || (pages && (vma->vm_flags & VM_IO))
+		if (!vma || (vma->vm_flags & VM_IO)
 				|| !(flags & vma->vm_flags))
 			return i ? : -EFAULT;
 
