Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbUK1LBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbUK1LBv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 06:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbUK1LBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 06:01:51 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:34528 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261429AbUK1LBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 06:01:49 -0500
Date: Sun, 28 Nov 2004 11:01:26 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Sami Farin <7atbggg02@sneakemail.com>, William Irwin <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] VmLib wrapped: executable brk
Message-ID: <Pine.LNX.4.44.0411281057160.11877-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases /proc/<pid>/status shows VmLib: 42949..... kB.

If READ_IMPLIES_EXEC then the break area is VM_EXEC, but omitted from
exec_vm since do_brk contains no __vm_stat_account call.  Later munmaps
count its pages out of exec_vm, hence (exec_vm - VmExe) can go negative.

do_brk is right not to call __vm_stat_account, its pages shouldn't need
to be counted.  What's wrong is that __vm_stat_account is counting all
the VM_EXEC pages, whereas (to mimic 2.4 and earlier 2.6) it should be
leaving VM_WRITE areas and non-vm_file areas out of exec_vm.

VmLib may still appear larger than before - where a READ_IMPLIES_EXEC
personality makes what was a readonly mapping of a file now executable
e.g. /usr/lib/locale stuff.  And a program which mprotects its own text
as writable will appear with wrapped VmLib: sorry, but while it's worth
showing ordinary programs as ordinary, it's not worth much effort to
avoid showing odd ones as odd.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
Acked-by: William Lee Irwin III <wli@holomorphy.com>

--- 2.6.10-rc2-bk9/mm/mmap.c	2004-11-15 16:21:24.000000000 +0000
+++ linux/mm/mmap.c	2004-11-25 15:58:55.710366040 +0000
@@ -744,12 +744,12 @@ void __vm_stat_account(struct mm_struct 
 	}
 #endif /* CONFIG_HUGETLB */
 
-	if (file)
+	if (file) {
 		mm->shared_vm += pages;
-	else if (flags & stack_flags)
+		if ((flags & (VM_EXEC|VM_WRITE)) == VM_EXEC)
+			mm->exec_vm += pages;
+	} else if (flags & stack_flags)
 		mm->stack_vm += pages;
-	if (flags & VM_EXEC)
-		mm->exec_vm += pages;
 	if (flags & (VM_RESERVED|VM_IO))
 		mm->reserved_vm += pages;
 }


