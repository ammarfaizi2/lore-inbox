Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbVIURux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbVIURux (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbVIURuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:50:50 -0400
Received: from [151.97.230.9] ([151.97.230.9]:22723 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1751344AbVIURs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:48:56 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 04/10] uml: fix hang in TT mode on fault
Date: Wed, 21 Sep 2005 19:28:36 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20050921172835.10219.94895.stgit@zion.home.lan>
In-Reply-To: <200509211923.21861.blaisorblade@yahoo.it>
References: <200509211923.21861.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

The current code doesn't handle well general protection faults on the host - it
thinks that cr2 is always the address of a page fault. While actually, on
general protection faults, that address is not accessible, so we'd better assume
we couldn't satisfy the fault. Currently instead we think we've fixed it, so we
go back, retry the instruction and fault again endlessly.

This leads to the kernel hanging when doing copy_from_user(dest, -1, ...) in TT
mode, since reading *(-1) causes a GFP, and we don't support kernel preemption.

Thanks to Luo Xin for testing UML with LTP and reporting the failures he got.

Cc: Luo Xin <luothing@sina.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/trap_kern.c       |   11 ++++++++++-
 arch/um/kernel/tt/uaccess_user.c |   11 +++++++++--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/um/kernel/trap_kern.c b/arch/um/kernel/trap_kern.c
--- a/arch/um/kernel/trap_kern.c
+++ b/arch/um/kernel/trap_kern.c
@@ -18,6 +18,7 @@
 #include "asm/a.out.h"
 #include "asm/current.h"
 #include "asm/irq.h"
+#include "sysdep/sigcontext.h"
 #include "user_util.h"
 #include "kern_util.h"
 #include "kern.h"
@@ -125,7 +126,15 @@ unsigned long segv(struct faultinfo fi, 
         }
 	else if(current->mm == NULL)
 		panic("Segfault with no mm");
-	err = handle_page_fault(address, ip, is_write, is_user, &si.si_code);
+
+	if (SEGV_IS_FIXABLE(&fi))
+		err = handle_page_fault(address, ip, is_write, is_user, &si.si_code);
+	else {
+		err = -EFAULT;
+		/* A thread accessed NULL, we get a fault, but CR2 is invalid.
+		 * This code is used in __do_copy_from_user() of TT mode. */
+		address = 0;
+	}
 
 	catcher = current->thread.fault_catcher;
 	if(!err)
diff --git a/arch/um/kernel/tt/uaccess_user.c b/arch/um/kernel/tt/uaccess_user.c
--- a/arch/um/kernel/tt/uaccess_user.c
+++ b/arch/um/kernel/tt/uaccess_user.c
@@ -22,8 +22,15 @@ int __do_copy_from_user(void *to, const 
 			       __do_copy, &faulted);
 	TASK_REGS(get_current())->tt = save;
 
-	if(!faulted) return(0);
-	else return(n - (fault - (unsigned long) from));
+	if(!faulted)
+		return 0;
+	else if (fault)
+		return n - (fault - (unsigned long) from);
+	else
+		/* In case of a general protection fault, we don't have the
+		 * fault address, so NULL is used instead. Pretend we didn't
+		 * copy anything. */
+		return n;
 }
 
 static void __do_strncpy(void *dst, const void *src, int count)

