Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbTIDXqj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 19:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTIDXqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 19:46:39 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:19853 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261406AbTIDXqe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 19:46:34 -0400
Date: Fri, 5 Sep 2003 00:46:13 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Stop mprotect() changing MAP_SHARED and other cleanup
Message-ID: <20030904234613.GB778@mail.jlokier.co.uk>
References: <20030904193454.GA31590@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030904193454.GA31590@mail.jlokier.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> +#include <asm/mman.h>

This is a resend of the mprotect() fix with a small change.  The
previous version added an unnecessary #include to <asm/mm.h>.
This one doesn't.

Patch: mprotect-2.6.0-test4-2

This patch:

  1. Removes the logic bug in mprotect() which allows it to change
     MAP_SHARED if PROT_SEM is passed.

  2. Moves the mapping of PROT_* bits to VM_* bits from mmap.c to
     the common header file <linux/mman.h>.

  3. Uses that function in mprotect() the same as mmap().  Previously
     mprotect() assumed the PROT_* and VM_* bits were numerically
     the same, which is what caused the PROT_SEM bug.

  4. Fixes an unlikely overflow in vm_locked accounting.

Enjoy,
-- Jamie


diff -urN --exclude-from=dontdiff orig-2.6.0-test4/include/linux/mman.h mprotect-2.6.0-test4/include/linux/mman.h
--- orig-2.6.0-test4/include/linux/mman.h	2003-07-12 17:57:37.000000000 +0100
+++ mprotect-2.6.0-test4/include/linux/mman.h	2003-09-04 20:24:35.000000000 +0100
@@ -2,6 +2,7 @@
 #define _LINUX_MMAN_H
 
 #include <linux/config.h>
+#include <linux/mm.h>
 
 #include <asm/atomic.h>
 #include <asm/mman.h>
@@ -27,4 +28,32 @@
 	vm_acct_memory(-pages);
 }
 
+/* Optimisation macro. */
+#define _calc_vm_trans(x,bit1,bit2) \
+  ((bit1) <= (bit2) ? ((x) & (bit1)) * ((bit2) / (bit1)) \
+   : ((x) & (bit1)) / ((bit1) / (bit2)))
+
+/*
+ * Combine the mmap "prot" argument into "vm_flags" used internally.
+ */
+static inline unsigned long
+calc_vm_prot_bits(unsigned long prot)
+{
+	return _calc_vm_trans(prot, PROT_READ,  VM_READ ) |
+	       _calc_vm_trans(prot, PROT_WRITE, VM_WRITE) |
+	       _calc_vm_trans(prot, PROT_EXEC,  VM_EXEC );
+}
+
+/*
+ * Combine the mmap "flags" argument into "vm_flags" used internally.
+ */
+static inline unsigned long
+calc_vm_flag_bits(unsigned long flags)
+{
+	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
+	       _calc_vm_trans(flags, MAP_DENYWRITE,  VM_DENYWRITE ) |
+	       _calc_vm_trans(flags, MAP_EXECUTABLE, VM_EXECUTABLE) |
+	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    );
+}
+
 #endif /* _LINUX_MMAN_H */
diff -urN --exclude-from=dontdiff orig-2.6.0-test4/include/linux/mm.h mprotect-2.6.0-test4/include/linux/mm.h
--- orig-2.6.0-test4/include/linux/mm.h	2003-09-02 23:06:10.000000000 +0100
+++ mprotect-2.6.0-test4/include/linux/mm.h	2003-09-04 20:18:21.000000000 +0100
@@ -85,12 +86,13 @@
 #define VM_READ		0x00000001	/* currently active flags */
 #define VM_WRITE	0x00000002
 #define VM_EXEC		0x00000004
-#define VM_SHARED	0x00000008
 
 #define VM_MAYREAD	0x00000010	/* limits for mprotect() etc */
 #define VM_MAYWRITE	0x00000020
 #define VM_MAYEXEC	0x00000040
-#define VM_MAYSHARE	0x00000080
+
+#define VM_SHARED	0x00000008	/* shared AND may write to pages */
+#define VM_MAYSHARE	0x00000080	/* set iff MAP_SHARED was set */
 
 #define VM_GROWSDOWN	0x00000100	/* general info on the segment */
 #define VM_GROWSUP	0x00000200
diff -urN --exclude-from=dontdiff orig-2.6.0-test4/mm/mmap.c mprotect-2.6.0-test4/mm/mmap.c
--- orig-2.6.0-test4/mm/mmap.c	2003-08-27 22:56:05.000000000 +0100
+++ mprotect-2.6.0-test4/mm/mmap.c	2003-09-04 20:10:02.000000000 +0100
@@ -136,29 +136,6 @@
 	return retval;
 }
 
-/* Combine the mmap "prot" and "flags" argument into one "vm_flags" used
- * internally. Essentially, translate the "PROT_xxx" and "MAP_xxx" bits
- * into "VM_xxx".
- */
-static inline unsigned long
-calc_vm_flags(unsigned long prot, unsigned long flags)
-{
-#define _trans(x,bit1,bit2) \
-((bit1==bit2)?(x&bit1):(x&bit1)?bit2:0)
-
-	unsigned long prot_bits, flag_bits;
-	prot_bits =
-		_trans(prot, PROT_READ, VM_READ) |
-		_trans(prot, PROT_WRITE, VM_WRITE) |
-		_trans(prot, PROT_EXEC, VM_EXEC);
-	flag_bits =
-		_trans(flags, MAP_GROWSDOWN, VM_GROWSDOWN) |
-		_trans(flags, MAP_DENYWRITE, VM_DENYWRITE) |
-		_trans(flags, MAP_EXECUTABLE, VM_EXECUTABLE);
-	return prot_bits | flag_bits;
-#undef _trans
-}
-
 #ifdef DEBUG_MM_RB
 static int browse_rb(struct rb_node * rb_node) {
 	int i = 0;
@@ -500,19 +477,17 @@
 	 * to. we assume access permissions have been handled by the open
 	 * of the memory object, so we don't do any here.
 	 */
-	vm_flags = calc_vm_flags(prot,flags) | mm->def_flags |
-			VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
+	vm_flags = calc_vm_prot_bits(prot) | calc_vm_flag_bits(flags) |
+			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 
-	if (flags & MAP_LOCKED) {
+	if (vm_flags & VM_LOCKED) {
+		unsigned long locked;
 		if (!capable(CAP_IPC_LOCK))
 			return -EPERM;
-		vm_flags |= VM_LOCKED;
-	}
-	/* mlock MCL_FUTURE? */
-	if (vm_flags & VM_LOCKED) {
-		unsigned long locked = mm->locked_vm << PAGE_SHIFT;
+		locked = (mm->locked_vm << PAGE_SHIFT);
 		locked += len;
-		if (locked > current->rlim[RLIMIT_MEMLOCK].rlim_cur)
+		if (locked < len || /* Overflow check. */
+		    locked > current->rlim[RLIMIT_MEMLOCK].rlim_cur)
 			return -EAGAIN;
 	}
 
diff -urN --exclude-from=dontdiff orig-2.6.0-test4/mm/mprotect.c mprotect-2.6.0-test4/mm/mprotect.c
--- orig-2.6.0-test4/mm/mprotect.c	2003-07-12 17:57:37.000000000 +0100
+++ mprotect-2.6.0-test4/mm/mprotect.c	2003-09-04 20:12:34.000000000 +0100
@@ -257,8 +257,11 @@
 			goto out;
 		}
 
-		newflags = prot | (vma->vm_flags & ~(PROT_READ | PROT_WRITE | PROT_EXEC));
-		if ((newflags & ~(newflags >> 4)) & 0xf) {
+		newflags = calc_vm_prot_bits(prot) |
+			(vma->vm_flags & ~(VM_READ | VM_WRITE | VM_EXEC));
+
+		/* Check against VM_MAYREAD, VM_MAYWRITE and VM_MAYEXEC. */
+		if ((newflags & ~(newflags >> 4)) & (VM_READ | VM_WRITE | VM_EXEC)) {
 			error = -EACCES;
 			goto out;
 		}
