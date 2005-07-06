Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262413AbVGGAXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbVGGAXJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbVGFUAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:00:06 -0400
Received: from [151.97.230.9] ([151.97.230.9]:45499 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S262179AbVGFQgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 12:36:02 -0400
Subject: [patch 1/1] uml: consolidate modify_ldt
To: jdike@addtoit.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Wed, 06 Jul 2005 18:39:23 +0200
Message-Id: <20050706163928.89109157D28@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

*) Reorganize the two cases of sys_modify_ldt to share all the reasonably
common code.

*) Avoid memory allocation when unneeded (i.e. when we are writing and the
passed buffer size is known), thus not returning ENOMEM (which isn't allowed
for this syscall, even if there is no strict "specification").

*) Add copy_{from,to}_user to modify_ldt for TT mode.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/sys-i386/ldt.c |  112 +++++++++++++++--------------
 linux-2.6.git-paolo/include/asm-um/ldt.h   |    5 +
 2 files changed, 66 insertions(+), 51 deletions(-)

diff -puN arch/um/sys-i386/ldt.c~uml-modify-ldt-consolidate arch/um/sys-i386/ldt.c
--- linux-2.6.git/arch/um/sys-i386/ldt.c~uml-modify-ldt-consolidate	2005-05-10 00:34:03.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/sys-i386/ldt.c	2005-05-10 00:36:24.000000000 +0200
@@ -4,96 +4,106 @@
  */
 
 #include "linux/config.h"
+#include "linux/sched.h"
 #include "linux/slab.h"
+#include "linux/types.h"
 #include "asm/uaccess.h"
 #include "asm/ptrace.h"
+#include "asm/smp.h"
+#include "asm/ldt.h"
 #include "choose-mode.h"
 #include "kern.h"
+#include "mode_kern.h"
 
 #ifdef CONFIG_MODE_TT
-extern int modify_ldt(int func, void *ptr, unsigned long bytecount);
 
-/* XXX this needs copy_to_user and copy_from_user */
+extern int modify_ldt(int func, void *ptr, unsigned long bytecount);
 
-int sys_modify_ldt_tt(int func, void __user *ptr, unsigned long bytecount)
+static int do_modify_ldt_tt(int func, void *ptr, unsigned long bytecount)
 {
-	if (!access_ok(VERIFY_READ, ptr, bytecount))
-		return -EFAULT;
-
 	return modify_ldt(func, ptr, bytecount);
 }
+
 #endif
 
 #ifdef CONFIG_MODE_SKAS
-extern int userspace_pid[];
 
+#include "skas.h"
 #include "skas_ptrace.h"
 
-int sys_modify_ldt_skas(int func, void __user *ptr, unsigned long bytecount)
+static int do_modify_ldt_skas(int func, void *ptr, unsigned long bytecount)
 {
 	struct ptrace_ldt ldt;
-	void *buf;
-	int res, n;
+	u32 cpu;
+	int res;
+
+	ldt = ((struct ptrace_ldt) { .func	= func,
+				     .ptr	= ptr,
+				     .bytecount = bytecount });
 
-	buf = kmalloc(bytecount, GFP_KERNEL);
-	if(buf == NULL)
-		return(-ENOMEM);
+	cpu = get_cpu();
+	res = ptrace(PTRACE_LDT, userspace_pid[cpu], 0, (unsigned long) &ldt);
+	put_cpu();
 
-	res = 0;
+	return res;
+}
+#endif
+
+int sys_modify_ldt(int func, void __user *ptr, unsigned long bytecount)
+{
+	struct user_desc info;
+	int res = 0;
+	void *buf = NULL;
+	void *p = NULL; /* What we pass to host. */
 
 	switch(func){
 	case 1:
-	case 0x11:
-		res = copy_from_user(buf, ptr, bytecount);
+	case 0x11: /* write_ldt */
+		/* Do this check now to avoid overflows. */
+		if (bytecount != sizeof(struct user_desc)) {
+			res = -EINVAL;
+			goto out;
+		}
+
+		if(copy_from_user(&info, ptr, sizeof(info))) {
+			res = -EFAULT;
+			goto out;
+		}
+
+		p = &info;
 		break;
-	}
+	case 0:
+	case 2: /* read_ldt */
 
-	if(res != 0){
-		res = -EFAULT;
+		/* The use of info avoids kmalloc on the write case, not on the
+		 * read one. */
+		buf = kmalloc(bytecount, GFP_KERNEL);
+		if (!buf) {
+			res = -ENOMEM;
+			goto out;
+		}
+		p = buf;
+	default:
+		res = -ENOSYS;
 		goto out;
 	}
 
-	ldt = ((struct ptrace_ldt) { .func	= func,
-				     .ptr	= buf,
-				     .bytecount = bytecount });
-#warning Need to look up userspace_pid by cpu
-	res = ptrace(PTRACE_LDT, userspace_pid[0], 0, (unsigned long) &ldt);
+	res = CHOOSE_MODE_PROC(do_modify_ldt_tt, do_modify_ldt_skas, func,
+				p, bytecount);
 	if(res < 0)
 		goto out;
 
 	switch(func){
 	case 0:
 	case 2:
-		n = res;
-		res = copy_to_user(ptr, buf, n);
-		if(res != 0)
+		/* Modify_ldt was for reading and returned the number of read
+		 * bytes.*/
+		if(copy_to_user(ptr, p, res))
 			res = -EFAULT;
-		else 
-			res = n;
 		break;
 	}
 
- out:
+out:
 	kfree(buf);
-	return(res);
-}
-#endif
-
-int sys_modify_ldt(int func, void __user *ptr, unsigned long bytecount)
-{
-	return(CHOOSE_MODE_PROC(sys_modify_ldt_tt, sys_modify_ldt_skas, func, 
-				ptr, bytecount));
+	return res;
 }
-
-
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -puN /dev/null include/asm-um/ldt.h
--- /dev/null	2005-05-09 17:36:13.454367832 +0200
+++ linux-2.6.git-paolo/include/asm-um/ldt.h	2005-05-10 00:37:00.000000000 +0200
@@ -0,0 +1,5 @@
+#ifndef __UM_LDT_H
+#define __UM_LDT_H
+
+#include "asm/arch/ldt.h"
+#endif
_
