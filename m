Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbTK1SAG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 13:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263137AbTK1SAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 13:00:06 -0500
Received: from 200-203-041-086.paemt7002.e.brasiltelecom.net.br ([200.203.41.86]:47965
	"EHLO einstein.tteng.com.br") by vger.kernel.org with ESMTP
	id S262760AbTK1R7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 12:59:44 -0500
Date: Fri, 28 Nov 2003 15:58:53 -0200
From: "Tiago Sant' Anna" <sapuglha@yahoo.com.br>
To: rusty@rustcorp.com.au
Cc: sisopiii-l@cscience.org, linux-kernel@vger.kernel.org,
       julianofs@pop.com.br
Subject: New feature: Removal of the exceptions wich belongs to the init
 section
Message-Id: <20031128155853.33283fec.sapuglha@yahoo.com.br>
Organization: Mine ;)
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-pc-linux-gnu)
X-Face: %(]EDRrq\[:5'@@)M4YF3HZt-<qmLw4tL@[EYs]#%<E<^Z?o@08x]4+tlb8-bTvc4!wba,!Km3_U~LL$7]Kr>"-fMGf'/uJ{0P`JliRLVl+\bLTx}]%TsUA$t(4pi?U|G|!{:L=f94pjRucb^aw!%J;'z_HI9cke=>~h
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Fri__28_Nov_2003_15_58_53_-0200_76xDNNKgKFXBpbOs"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Fri__28_Nov_2003_15_58_53_-0200_76xDNNKgKFXBpbOs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello Rusty,

We, Juliano (julianofs@pop.com.br) and I (Tiago Sant' Anna
(sapuglha@yahoo.com.br) developed this patch.

It adds the following feature to the kernel:
	- Removal of the exceptions which belong to the init section from the
exceptions list, when discarding the init section of some module.

	There are some things to notice:
- As we needed to add a sort function, we did it inside the kernel, not
regarding to any architeture. Thought it would be interesting to the exceptions.

But there was a necessity to implement inside each architeture its own function
to compare the values from exception_table_entry, so we tried it; take a look at
arch/<some>/mm/extable.c in the function extable_cmp(). But we didn't had the
chance to test it in other architetures than i386, and we thought it would fail
with ppc and ppc64, because it already had some functions like this.

The sort_ex_table() function is implemented inside include/linux/extable.h.
It's based on one found in the ppc code. Also, inside this header we included
the declaration to extern extable_cmp() wich must be implemented inside each
architeture.

Cheers, and thanks for your e-mails helping us.

 
=> Tiago Sant' Anna and Juliano F. Silva

--Multipart=_Fri__28_Nov_2003_15_58_53_-0200_76xDNNKgKFXBpbOs
Content-Type: text/plain;
 name="patch-init_exceptions_removal.diff"
Content-Disposition: attachment;
 filename="patch-init_exceptions_removal.diff"
Content-Transfer-Encoding: 7bit

diff -Nur linux-2.6.0-test9-vanilla/arch/alpha/mm/extable.c linux-2.6.0-test9-modified/arch/alpha/mm/extable.c
--- linux-2.6.0-test9-vanilla/arch/alpha/mm/extable.c	2003-10-25 16:42:52.000000000 -0200
+++ linux-2.6.0-test9-modified/arch/alpha/mm/extable.c	2003-11-28 10:43:18.000000000 -0200
@@ -27,3 +27,18 @@
 
         return NULL;
 }
+
+/* Exception_table_entry Comparison. Only the field insn is considered. 
+   Results:
+	equal: 0
+	ex1 less than ex2: -1
+	ex1 major than ex2: 1
+*/
+int extable_cmp(const struct exception_table_entry ex1, const struct exception_table_entry ex2) {
+	
+	if (ex1.insn < ex2.insn)
+		return(-1);
+	else if (ex1.insn > ex2.insn)
+		return(1);
+	return(0);
+}
diff -Nur linux-2.6.0-test9-vanilla/arch/arm/mm/extable.c linux-2.6.0-test9-modified/arch/arm/mm/extable.c
--- linux-2.6.0-test9-vanilla/arch/arm/mm/extable.c	2003-10-25 16:43:46.000000000 -0200
+++ linux-2.6.0-test9-modified/arch/arm/mm/extable.c	2003-11-28 08:32:44.000000000 -0200
@@ -35,3 +35,19 @@
 
 	return fixup != NULL;
 }
+
+/* Exception_table_entry Comparison. Only the field insn is considered. 
+	Results:
+		equal: 0
+		ex1 less than ex2: -1
+		ex1 major than ex2: 1
+	
+*/
+int extable_cmp(const struct exception_table_entry ex1, const struct exception_table_entry ex2) {
+	
+	if (ex1.insn < ex2.insn)
+		return(-1);
+	else if (ex1.insn > ex2.insn)
+		return(1);
+	return(0);
+}
diff -Nur linux-2.6.0-test9-vanilla/arch/arm26/mm/extable.c linux-2.6.0-test9-modified/arch/arm26/mm/extable.c
--- linux-2.6.0-test9-vanilla/arch/arm26/mm/extable.c	2003-10-25 16:43:29.000000000 -0200
+++ linux-2.6.0-test9-modified/arch/arm26/mm/extable.c	2003-11-28 08:32:44.000000000 -0200
@@ -38,3 +38,18 @@
         return fixup != NULL;
 }
 
+/* Exception_table_entry Comparison. Only the field insn is considered. 
+	Results:
+		equal: 0
+		ex1 less than ex2: -1
+		ex1 major than ex2: 1
+	
+*/
+int extable_cmp(const struct exception_table_entry ex1, const struct exception_table_entry ex2) {
+	
+	if (ex1.insn < ex2.insn)
+		return(-1);
+	else if (ex1.insn > ex2.insn)
+		return(1);
+	return(0);
+}
diff -Nur linux-2.6.0-test9-vanilla/arch/cris/mm/extable.c linux-2.6.0-test9-modified/arch/cris/mm/extable.c
--- linux-2.6.0-test9-vanilla/arch/cris/mm/extable.c	2003-10-25 16:45:07.000000000 -0200
+++ linux-2.6.0-test9-modified/arch/cris/mm/extable.c	2003-11-28 08:32:44.000000000 -0200
@@ -46,3 +46,19 @@
         }
         return NULL;
 }
+
+/* Exception_table_entry Comparison. Only the field insn is considered. 
+	Results:
+		equal: 0
+		ex1 less than ex2: -1
+		ex1 major than ex2: 1
+	
+*/
+int extable_cmp(const struct exception_table_entry ex1, const struct exception_table_entry ex2) {
+	
+	if (ex1.insn < ex2.insn)
+		return(-1);
+	else if (ex1.insn > ex2.insn)
+		return(1);
+	return(0);
+}
diff -Nur linux-2.6.0-test9-vanilla/arch/h8300/mm/extable.c linux-2.6.0-test9-modified/arch/h8300/mm/extable.c
--- linux-2.6.0-test9-vanilla/arch/h8300/mm/extable.c	2003-10-25 16:43:29.000000000 -0200
+++ linux-2.6.0-test9-modified/arch/h8300/mm/extable.c	2003-11-28 08:32:44.000000000 -0200
@@ -28,3 +28,19 @@
         }
         return NULL;
 }
+
+/* Exception_table_entry Comparison. Only the field insn is considered. 
+	Results:
+		equal: 0
+		ex1 less than ex2: -1
+		ex1 major than ex2: 1
+	
+*/
+int extable_cmp(const struct exception_table_entry ex1, const struct exception_table_entry ex2) {
+	
+	if (ex1.insn < ex2.insn)
+		return(-1);
+	else if (ex1.insn > ex2.insn)
+		return(1);
+   	return(0);
+}
diff -Nur linux-2.6.0-test9-vanilla/arch/i386/kernel/module.c linux-2.6.0-test9-modified/arch/i386/kernel/module.c
--- linux-2.6.0-test9-vanilla/arch/i386/kernel/module.c	2003-10-25 16:43:36.000000000 -0200
+++ linux-2.6.0-test9-modified/arch/i386/kernel/module.c	2003-11-28 10:54:23.725411848 -0200
@@ -21,6 +21,9 @@
 #include <linux/fs.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
+#include <asm/uaccess.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
 
 #if 0
 #define DEBUGP printk
@@ -35,13 +38,60 @@
 	return vmalloc(size);
 }
 
+/* Verify if the addr belongs to the init section */
+static inline int within_mod_init_section(unsigned long addr, 
+                                          void *start, unsigned long size)
+{
+	    return ((void *)addr >= start && (void *)addr < start + size);
+}
+
+/* Remove exception table entries that point to init area.
+ * It will be used in the unload of init section.
+ */
+void remove_init_exceptions(struct module *mod) {
+
+	static spinlock_t init_ex_remove = SPIN_LOCK_UNLOCKED;
+
+	const struct exception_table_entry *local;
+	unsigned int i;
+	int num_init_ex=0;
+
+
+	local = mod->extable;
+	i = 1;
+
+	while (i <= mod->num_exentries) {
+		if (within_mod_init_section((unsigned long) local->insn, mod->module_init, mod->init_size)) {
+			num_init_ex++;			
+		}
+		else break;
+		local = local+1;
+		i++;
+	}
+
+	local = mod->extable;
+
+	/* Move the pointer to remove the init exceptions */
+	spin_lock(init_ex_remove);
+		mod->extable += num_init_ex;
+		mod->num_exentries -= num_init_ex;
+	spin_unlock(init_ex_remove);
+
+	/* Unload the init exceptions */
+	for(i=0; i < num_init_ex; ++i)
+		kfree(local+i);
+}
+
 
 /* Free memory returned from module_alloc */
 void module_free(struct module *mod, void *module_region)
-{
+{	
+	/* Remove exception entries of the init section */
+	if (module_region == mod->module_init) {
+		remove_init_exceptions(mod);
+	}
+	
 	vfree(module_region);
-	/* FIXME: If module_region == mod->init_region, trim exception
-           table entries. */
 }
 
 /* We don't need anything special. */
diff -Nur linux-2.6.0-test9-vanilla/arch/i386/mm/extable.c linux-2.6.0-test9-modified/arch/i386/mm/extable.c
--- linux-2.6.0-test9-vanilla/arch/i386/mm/extable.c	2003-10-25 16:44:54.000000000 -0200
+++ linux-2.6.0-test9-modified/arch/i386/mm/extable.c	2003-11-28 10:43:38.000000000 -0200
@@ -56,3 +56,22 @@
 
 	return 0;
 }
+
+/* Exception_table_entry Comparison. Only the field insn is considered.
+        Results:
+                equal: 0
+                ex1 less than ex2: -1
+                ex1 major than ex2: 1
+
+*/
+int extable_cmp(const struct exception_table_entry ex1, 
+		const struct exception_table_entry ex2) 
+{
+	if (ex1.insn < ex2.insn)
+		return(-1);
+	else if (ex1.insn > ex2.insn)
+		return(1);
+     	return(0);
+}	     	
+
+
diff -Nur linux-2.6.0-test9-vanilla/arch/ia64/mm/extable.c linux-2.6.0-test9-modified/arch/ia64/mm/extable.c
--- linux-2.6.0-test9-vanilla/arch/ia64/mm/extable.c	2003-10-25 16:43:15.000000000 -0200
+++ linux-2.6.0-test9-modified/arch/ia64/mm/extable.c	2003-11-28 08:32:44.000000000 -0200
@@ -44,3 +44,19 @@
 	regs->cr_iip = fix & ~0xf;
 	ia64_psr(regs)->ri = fix & 0x3;		/* set continuation slot number */
 }
+
+/* Exception_table_entry Comparison. Only the field insn is considered. 
+	Results:
+		equal: 0
+		ex1 less than ex2: -1
+		ex1 major than ex2: 1
+	
+*/
+int extable_cmp(const struct exception_table_entry ex1, const struct exception_table_entry ex2) {
+	
+	if (ex1.addr < ex2.addr)
+		return(-1);
+	else if (ex1.addr > ex2.addr)
+		return(1);
+	return(0);
+}
diff -Nur linux-2.6.0-test9-vanilla/arch/m68k/mm/extable.c linux-2.6.0-test9-modified/arch/m68k/mm/extable.c
--- linux-2.6.0-test9-vanilla/arch/m68k/mm/extable.c	2003-10-25 16:44:46.000000000 -0200
+++ linux-2.6.0-test9-modified/arch/m68k/mm/extable.c	2003-11-28 08:32:44.000000000 -0200
@@ -31,3 +31,19 @@
 	return NULL;
 }
 
+/* Exception_table_entry Comparison. Only the field insn is considered. 
+	Results:
+		equal: 0
+		ex1 less than ex2: -1
+		ex1 major than ex2: 1
+	
+*/
+int extable_cmp(const struct exception_table_entry ex1, const struct exception_table_entry ex2) {
+	
+	if (ex1.insn < ex2.insn)
+		return(-1);
+	else if (ex1.insn > ex2.insn)
+		return(1);
+	return(0);
+}
+
diff -Nur linux-2.6.0-test9-vanilla/arch/m68knommu/mm/extable.c linux-2.6.0-test9-modified/arch/m68knommu/mm/extable.c
--- linux-2.6.0-test9-vanilla/arch/m68knommu/mm/extable.c	2003-10-25 16:43:01.000000000 -0200
+++ linux-2.6.0-test9-modified/arch/m68knommu/mm/extable.c	2003-11-28 08:32:44.000000000 -0200
@@ -28,3 +28,19 @@
         }
         return NULL;
 }
+
+/* Exception_table_entry Comparison. Only the field insn is considered. 
+	Results:
+		equal: 0
+		ex1 less than ex2: -1
+		ex1 major than ex2: 1
+	
+*/
+int extable_cmp(const struct exception_table_entry ex1, const struct exception_table_entry ex2) {
+	
+	if (ex1.insn < ex2.insn)
+		return(-1);
+	else if (ex1.insn > ex2.insn)
+		return(1);
+	return(0);
+}
diff -Nur linux-2.6.0-test9-vanilla/arch/mips/mm/extable.c linux-2.6.0-test9-modified/arch/mips/mm/extable.c
--- linux-2.6.0-test9-vanilla/arch/mips/mm/extable.c	2003-10-25 16:43:50.000000000 -0200
+++ linux-2.6.0-test9-modified/arch/mips/mm/extable.c	2003-11-28 08:32:44.000000000 -0200
@@ -28,3 +28,19 @@
         }
         return NULL;
 }
+
+/* Exception_table_entry Comparison. Only the field insn is considered. 
+	Results:
+		equal: 0
+		ex1 less than ex2: -1
+		ex1 major than ex2: 1
+	
+*/
+int extable_cmp(const struct exception_table_entry ex1, const struct exception_table_entry ex2) {
+	
+	if (ex1.insn < ex2.insn)
+		return(-1);
+	else if (ex1.insn > ex2.insn)
+		return(1);
+	return(0);
+}
diff -Nur linux-2.6.0-test9-vanilla/arch/parisc/mm/extable.c linux-2.6.0-test9-modified/arch/parisc/mm/extable.c
--- linux-2.6.0-test9-vanilla/arch/parisc/mm/extable.c	2003-10-25 16:43:17.000000000 -0200
+++ linux-2.6.0-test9-modified/arch/parisc/mm/extable.c	2003-11-28 08:32:44.000000000 -0200
@@ -35,3 +35,18 @@
         return 0;
 }
 
+/* Exception_table_entry Comparison. Only the field insn is considered. 
+	Results:
+		equal: 0
+		ex1 less than ex2: -1
+		ex1 major than ex2: 1
+	
+*/
+int extable_cmp(const struct exception_table_entry ex1, const struct exception_table_entry ex2) {
+	
+	if (ex1.addr < ex2.addr)
+		return(-1);
+	else if (ex1.addr > ex2.addr)
+		return(1);
+	return(0);
+}
diff -Nur linux-2.6.0-test9-vanilla/arch/ppc/mm/extable.c linux-2.6.0-test9-modified/arch/ppc/mm/extable.c
--- linux-2.6.0-test9-vanilla/arch/ppc/mm/extable.c	2003-10-25 16:44:43.000000000 -0200
+++ linux-2.6.0-test9-modified/arch/ppc/mm/extable.c	2003-11-28 08:32:44.000000000 -0200
@@ -12,35 +12,6 @@
 extern struct exception_table_entry __start___ex_table[];
 extern struct exception_table_entry __stop___ex_table[];
 
-/*
- * The exception table needs to be sorted because we use the macros
- * which put things into the exception table in a variety of segments
- * such as the prep, pmac, chrp, etc. segments as well as the init
- * segment and the main kernel text segment.
- */
-static inline void
-sort_ex_table(struct exception_table_entry *start,
-	      struct exception_table_entry *finish)
-{
-	struct exception_table_entry el, *p, *q;
-
-	/* insertion sort */
-	for (p = start + 1; p < finish; ++p) {
-		/* start .. p-1 is sorted */
-		if (p[0].insn < p[-1].insn) {
-			/* move element p down to its right place */
-			el = *p;
-			q = p;
-			do {
-				/* el comes before q[-1], move q[-1] up one */
-				q[0] = q[-1];
-				--q;
-			} while (q > start && el.insn < q[-1].insn);
-			*q = el;
-		}
-	}
-}
-
 void __init
 sort_exception_table(void)
 {
@@ -68,3 +39,19 @@
         }
 	return NULL;
 }
+
+/* Exception_table_entry Comparison. Only the field insn is considered. 
+	Results:
+		equal: 0
+		ex1 less than ex2: -1
+		ex1 major than ex2: 1
+	
+*/
+int extable_cmp(const struct exception_table_entry ex1, const struct exception_table_entry ex2) {
+	
+	if (ex1.insn < ex2.insn)
+		return(-1);
+	else if (ex1.insn > ex2.insn)
+		return(1);
+	return(0);
+}
diff -Nur linux-2.6.0-test9-vanilla/arch/ppc64/mm/extable.c linux-2.6.0-test9-modified/arch/ppc64/mm/extable.c
--- linux-2.6.0-test9-vanilla/arch/ppc64/mm/extable.c	2003-10-25 16:43:20.000000000 -0200
+++ linux-2.6.0-test9-modified/arch/ppc64/mm/extable.c	2003-11-28 08:32:44.000000000 -0200
@@ -72,3 +72,20 @@
 	}
 	return NULL;
 }
+
+/* Exception_table_entry Comparison. Only the field insn is considered. 
+	Results:
+		equal: 0
+		ex1 less than ex2: -1
+		ex1 major than ex2: 1
+	
+*/
+int extable_cmp(const struct exception_table_entry ex1, const struct exception_table_entry ex2) {
+	
+	if (ex1.insn < ex2.insn)
+		return(-1);
+	else if (ex1.insn > ex2.insn)
+		return(1);
+	return(0);
+}
+
diff -Nur linux-2.6.0-test9-vanilla/arch/s390/mm/extable.c linux-2.6.0-test9-modified/arch/s390/mm/extable.c
--- linux-2.6.0-test9-vanilla/arch/s390/mm/extable.c	2003-10-25 16:44:06.000000000 -0200
+++ linux-2.6.0-test9-modified/arch/s390/mm/extable.c	2003-11-28 08:32:44.000000000 -0200
@@ -32,3 +32,19 @@
 	}
 	return NULL;
 }
+
+/* Exception_table_entry Comparison. Only the field insn is considered. 
+	Results:
+		equal: 0
+		ex1 less than ex2: -1
+		ex1 major than ex2: 1
+	
+*/
+int extable_cmp(const struct exception_table_entry ex1, const struct exception_table_entry ex2) {
+	
+	if (ex1.insn < ex2.insn)
+		return(-1);
+	else if (ex1.insn > ex2.insn)
+		return(1);
+	return(0);
+}
diff -Nur linux-2.6.0-test9-vanilla/arch/sh/mm/extable.c linux-2.6.0-test9-modified/arch/sh/mm/extable.c
--- linux-2.6.0-test9-vanilla/arch/sh/mm/extable.c	2003-10-25 16:42:48.000000000 -0200
+++ linux-2.6.0-test9-modified/arch/sh/mm/extable.c	2003-11-28 08:32:44.000000000 -0200
@@ -44,3 +44,19 @@
 
 	return 0;
 }
+
+/* Exception_table_entry Comparison. Only the field insn is considered. 
+	Results:
+		equal: 0
+		ex1 less than ex2: -1
+		ex1 major than ex2: 1
+	
+*/
+int extable_cmp(const struct exception_table_entry ex1, const struct exception_table_entry ex2) {
+	
+	if (ex1.insn < ex2.insn)
+		return(-1);
+	else if (ex1.insn > ex2.insn)
+		return(1);
+	return(0);
+}
diff -Nur linux-2.6.0-test9-vanilla/arch/sparc/mm/extable.c linux-2.6.0-test9-modified/arch/sparc/mm/extable.c
--- linux-2.6.0-test9-vanilla/arch/sparc/mm/extable.c	2003-10-25 16:43:41.000000000 -0200
+++ linux-2.6.0-test9-modified/arch/sparc/mm/extable.c	2003-11-28 08:32:44.000000000 -0200
@@ -70,3 +70,19 @@
 
 	return entry->fixup;
 }
+
+/* Exception_table_entry Comparison. Only the field insn is considered. 
+	Results:
+		equal: 0
+		ex1 less than ex2: -1
+		ex1 major than ex2: 1
+	
+*/
+int extable_cmp(const struct exception_table_entry ex1, const struct exception_table_entry ex2) {
+	
+	if (ex1.insn < ex2.insn)
+		return(-1);
+	else if (ex1.insn > ex2.insn)
+		return(1);
+	return(0);
+}
diff -Nur linux-2.6.0-test9-vanilla/arch/sparc64/mm/extable.c linux-2.6.0-test9-modified/arch/sparc64/mm/extable.c
--- linux-2.6.0-test9-vanilla/arch/sparc64/mm/extable.c	2003-10-25 16:43:25.000000000 -0200
+++ linux-2.6.0-test9-modified/arch/sparc64/mm/extable.c	2003-11-28 08:32:44.000000000 -0200
@@ -73,3 +73,20 @@
 
 	return entry->fixup;
 }
+
+/* Exception_table_entry Comparison. Only the field insn is considered. 
+	Results:
+		equal: 0
+		ex1 less than ex2: -1
+		ex1 major than ex2: 1
+	
+*/
+int extable_cmp(const struct exception_table_entry ex1, const struct exception_table_entry ex2) {
+	
+	if (ex1.insn < ex2.insn)
+		return(-1);
+	else if (ex1.insn > ex2.insn)
+		return(1);
+	return(0);
+}
+
diff -Nur linux-2.6.0-test9-vanilla/arch/x86_64/mm/extable.c linux-2.6.0-test9-modified/arch/x86_64/mm/extable.c
--- linux-2.6.0-test9-vanilla/arch/x86_64/mm/extable.c	2003-10-25 16:44:44.000000000 -0200
+++ linux-2.6.0-test9-modified/arch/x86_64/mm/extable.c	2003-11-28 08:32:44.000000000 -0200
@@ -55,3 +55,19 @@
 	return 0;
 }
 core_initcall(check_extable);
+
+/* Exception_table_entry Comparison. Only the field insn is considered. 
+	Results:
+		equal: 0
+		ex1 less than ex2: -1
+		ex1 major than ex2: 1
+	
+*/
+int extable_cmp(const struct exception_table_entry ex1, const struct exception_table_entry ex2) {
+	
+	if (ex1.insn < ex2.insn)
+		return(-1);
+	else if (ex1.insn > ex2.insn)
+		return(1);
+	return(0);
+}
diff -Nur linux-2.6.0-test9-vanilla/include/linux/extable.h linux-2.6.0-test9-modified/include/linux/extable.h
--- linux-2.6.0-test9-vanilla/include/linux/extable.h	1969-12-31 21:00:00.000000000 -0300
+++ linux-2.6.0-test9-modified/include/linux/extable.h	2003-11-28 10:40:57.000000000 -0200
@@ -0,0 +1,51 @@
+#ifndef _EXTABLE_H
+#define _EXTABLE_H
+
+/*
+ * Functions regarding to exception's table.
+ *
+ *	* Written by Juliano Silva and Tiago Silva, 2003
+ *	
+ **/
+
+
+#include <linux/module.h>
+#include <asm/uaccess.h>
+#include <asm/sections.h>
+#include <linux/init.h>
+ 
+/* Exception_table_entry Comparison. Only the field insn is considered.
+ *   Results:
+ *            equal: 0
+ *            ex1 less than ex2: -1
+ *            ex1 major than ex2: 1
+ *                                                         */
+extern int extable_cmp(struct exception_table_entry ex1,
+                       struct exception_table_entry ex2);
+
+/* This code sorts an exception table. It is very used with modules code 
+ * void __init_or_module sort_ex_table(struct exception_table_entry *start,
+ * struct exception_table_entry *finish);
+ */
+void __init_or_module sort_ex_table(struct exception_table_entry *start, struct exception_table_entry *finish)
+{
+	struct exception_table_entry el, *p, *q;
+
+	/* insertion sort */
+	for (p = start + 1; p < finish; ++p) {
+		/* start .. p-1 is sorted */
+		if (extable_cmp(p[0], p[-1]) == -1) {
+		/* move element p down to its right place */
+			el = *p;
+			q = p;
+			do {
+			/* el comes before q[-1], move q[-1] up one */
+				q[0] = q[-1];
+				--q;
+			} while (q > start && extable_cmp(el, q[-1]) == -1);
+			*q = el;
+		}
+	}
+}
+
+#endif
diff -Nur linux-2.6.0-test9-vanilla/kernel/module.c linux-2.6.0-test9-modified/kernel/module.c
--- linux-2.6.0-test9-vanilla/kernel/module.c	2003-10-25 16:44:09.000000000 -0200
+++ linux-2.6.0-test9-modified/kernel/module.c	2003-11-28 10:41:17.000000000 -0200
@@ -37,6 +37,8 @@
 #include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
 
+#include <linux/extable.h>
+
 #if 0
 #define DEBUGP printk
 #else
@@ -1379,6 +1381,7 @@
 }
 #endif
 
+
 /* Allocate and load the module: note that size of section 0 is always
    zero, and we rely on this for optional sections. */
 static struct module *load_module(void __user *umod,
@@ -1615,6 +1618,11 @@
 	mod->num_exentries = sechdrs[exindex].sh_size / sizeof(*mod->extable);
 	mod->extable = (void *)sechdrs[exindex].sh_addr;
 
+        /* Classifying the exception table */
+        sort_ex_table((struct exception_table_entry *)mod->extable,
+                      (struct exception_table_entry *)mod->extable +
+                                mod->num_exentries);
+
 	/* Now do relocations. */
 	for (i = 1; i < hdr->e_shnum; i++) {
 		const char *strtab = (char *)sechdrs[strindex].sh_addr;


--Multipart=_Fri__28_Nov_2003_15_58_53_-0200_76xDNNKgKFXBpbOs--
