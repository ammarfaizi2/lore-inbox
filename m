Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130507AbRDPLEY>; Mon, 16 Apr 2001 07:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130532AbRDPLEP>; Mon, 16 Apr 2001 07:04:15 -0400
Received: from smtp-rt-6.wanadoo.fr ([193.252.19.160]:2549 "EHLO
	caroubier.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S130507AbRDPLEF>; Mon, 16 Apr 2001 07:04:05 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.linuxppc.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        <paulus@samba.org>, <cort@fsmlabs.com>
Subject: [PATCH] [resent] binfmt_elf.c fix with PPC update
Date: Mon, 16 Apr 2001 13:03:35 +0200
Message-Id: <20010416110335.5243@smtp.wanadoo.fr>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus !

Enclosed is a (not big ;) patch against 2.4.4pre1 that does a few
inter-dependant things, one beeing a bug fix for everybody, the other
is a mix of bug fix & cleanup on PPC:

 - binfmt_elf.c : fix DLINFO_ITEMS so that final alignement on the
   stack takes into account the AT_NULL entry (or it won't align).

   Remove hackish PPC addition (now re-done properly). Add a simple
   way (via 2 macros) for include/asm-xxx/elf.h to add platform
   specific entries to it while keeping the alignement right.

 - Remove shove_aux_table() in arch/ppc/kernel/process.c. That routine
   used to lookup the aux table on the stack and move it up to align
   it to a 16 bytes boundary (ABI). Now done via the ARCH_DLINFO in
   include/asm-ppc/elf.h

 - Re-implement the alignement mecanism properly, taking into account
   a pair glibc bugs we had until now (not doing so results in breaking
   existing userland binaries).

 - Add 3 new aux table entries for PPC containing some cache line size
   information. Those are part of our PPC SysV ABI, and were never
   properly implemented, possibly because of conflict in the AT_xxxx
   numbers assigned to them. This was now "fixed" and the next glibc
   release will understand them. Those informations are necessary for
   glibc to properly handle various brands of PPC CPUs when doing
   cache invalidates or using cache trick to speed up copy operations.

The patch has been tested on PPC, glibc is ready for it, and it's
simple enough not to damage other archs. Next are coming the PPC
AT_HWCAP infos, still beeing worked on.

Feel free to comment, not agree, whatever, I'd be glad however if you
could explain me if you don't want to merge that now as our glibc
maintainer is waiting for it ;)

Regards,
Ben.

--- linuxppc_2_4_orig/fs/binfmt_elf.c	Wed Apr 11 20:18:59 2001
+++ linuxppc_2_4/fs/binfmt_elf.c	Wed Apr 11 18:38:47 2001
@@ -36,7 +36,7 @@
 #include <asm/param.h>
 #include <asm/pgalloc.h>
 
-#define DLINFO_ITEMS 13
+#define DLINFO_ITEMS 14
 
 #include <linux/elf.h>
 
@@ -135,12 +135,13 @@
 
 	/*
 	 * Force 16 byte _final_ alignment here for generality.
-	 * Leave an extra 16 bytes free so that on the PowerPC we
-	 * can move the aux table up to start on a 16-byte boundary.
 	 */
-	sp = (elf_addr_t *)((~15UL & (unsigned long)(u_platform)) - 16UL);
+	sp = (elf_addr_t *)(~15UL & (unsigned long)(u_platform));
 	csp = sp;
 	csp -= DLINFO_ITEMS*2 + (k_platform ? 2 : 0);
+#ifdef DLINFO_ARCH_ITEMS
+	csp -= DLINFO_ARCH_ITEMS*2;
+#endif
 	csp -= envc+1;
 	csp -= argc+1;
 	csp -= (!ibcs ? 3 : 1);	/* argc itself */
@@ -174,6 +175,13 @@
 	NEW_AUX_ENT(10, AT_EUID, (elf_addr_t) current->euid);
 	NEW_AUX_ENT(11, AT_GID, (elf_addr_t) current->gid);
 	NEW_AUX_ENT(12, AT_EGID, (elf_addr_t) current->egid);
+#ifdef ARCH_DLINFO
+	/* 
+	 * ARCH_DLINFO must come last so platform specific code can enforce
+	 * special alignment requirements on the AUXV if necessary (eg. PPC).
+	 */
+	ARCH_DLINFO;
+#endif
 #undef NEW_AUX_ENT
 
 	sp -= envc+1;
--- linuxppc_2_4_orig/arch/ppc/kernel/process.c	Mon Apr  2 19:25:35 2001
+++ linuxppc_2_4/arch/ppc/kernel/process.c	Wed Apr 11 18:40:51 2001
@@ -378,45 +378,6 @@
 }
 
 /*
- * XXX ld.so expects the auxiliary table to start on
- * a 16-byte boundary, so we have to find it and
- * move it up. :-(
- */
-static inline void shove_aux_table(unsigned long sp)
-{
-	int argc;
-	char *p;
-	unsigned long e;
-	unsigned long aux_start, offset;
-
-	if (__get_user(argc, (int *)sp))
-		return;
-	sp += sizeof(int) + (argc + 1) * sizeof(char *);
-	/* skip over the environment pointers */
-	do {
-		if (__get_user(p, (char **)sp))
-			return;
-		sp += sizeof(char *);
-	} while (p != NULL);
-	aux_start = sp;
-	/* skip to the end of the auxiliary table */
-	do {
-		if (__get_user(e, (unsigned long *)sp))
-			return;
-		sp += 2 * sizeof(unsigned long);
-	} while (e != AT_NULL);
-	offset = ((aux_start + 15) & ~15) - aux_start;
-	if (offset != 0) {
-		do {
-			sp -= sizeof(unsigned long);
-			if (__get_user(e, (unsigned long *)sp)
-			    || __put_user(e, (unsigned long *)(sp + offset)))
-				return;
-		} while (sp > aux_start);
-	}
-}
-
-/*
  * Set up a thread for executing a new program
  */
 void start_thread(struct pt_regs *regs, unsigned long nip, unsigned long sp)
@@ -425,7 +386,6 @@
 	regs->nip = nip;
 	regs->gpr[1] = sp;
 	regs->msr = MSR_USER;
-	shove_aux_table(sp);
 	if (last_task_used_math == current)
 		last_task_used_math = 0;
 	if (last_task_used_altivec == current)
--- linuxppc_2_4_orig/include/asm-ppc/elf.h	Mon Apr  2 19:24:39 2001
+++ linuxppc_2_4/include/asm-ppc/elf.h	Wed Apr 11 21:25:00 2001
@@ -74,20 +74,46 @@
  * We need to put in some extra aux table entries to tell glibc what
  * the cache block size is, so it can use the dcbz instruction safely.
  */
-#define AT_DCACHEBSIZE		17
-#define AT_ICACHEBSIZE		18
-#define AT_UCACHEBSIZE		19
+#define AT_DCACHEBSIZE		19
+#define AT_ICACHEBSIZE		20
+#define AT_UCACHEBSIZE		21
+/* A special ignored type value for PPC, for glibc compatibility.  */
+#define AT_IGNOREPPC		22
 
 extern int dcache_bsize;
 extern int icache_bsize;
 extern int ucache_bsize;
 
-#define DLINFO_EXTRA_ITEMS	3
-#define EXTRA_DLINFO		do {			\
-	NEW_AUX_ENT(0, AT_DCACHEBSIZE, dcache_bsize);	\
-	NEW_AUX_ENT(1, AT_ICACHEBSIZE, icache_bsize);	\
-	NEW_AUX_ENT(2, AT_UCACHEBSIZE, ucache_bsize);	\
-} while (0)
+/*
+ * The requirements here are:
+ * - keep the final alignment of sp (sp & 0xf)
+ * - make sure the 32-bit value at the first 16 byte aligned position of
+ *   AUXV is greater than 16 for glibc compatibility.
+ *   AT_IGNOREPPC is used for that.
+ * - for compatibility with glibc ARCH_DLINFO must always be defined on PPC,
+ *   even if DLINFO_ARCH_ITEMS goes to zero or is undefined.
+ */
+#define DLINFO_ARCH_ITEMS	3
+#define ARCH_DLINFO							\
+do {									\
+	sp -= DLINFO_ARCH_ITEMS * 2;					\
+	NEW_AUX_ENT(0, AT_DCACHEBSIZE, dcache_bsize);			\
+	NEW_AUX_ENT(1, AT_ICACHEBSIZE, icache_bsize);			\
+	NEW_AUX_ENT(2, AT_UCACHEBSIZE, ucache_bsize);			\
+	/*								\
+	 * Keep the final alignment of sp.				\
+	 */								\
+	if (DLINFO_ARCH_ITEMS & 1) {					\
+		sp -= 2;						\
+		NEW_AUX_ENT(0, AT_IGNOREPPC, AT_IGNOREPPC);		\
+	}								\
+	/*								\
+	 * Now handle glibc compatibility.				\
+	 */								\
+	sp -= 2*2;							\
+	NEW_AUX_ENT(0, AT_IGNOREPPC, AT_IGNOREPPC);			\
+	NEW_AUX_ENT(1, AT_IGNOREPPC, AT_IGNOREPPC);			\
+ } while (0)
 
 #endif /* __KERNEL__ */
 #endif


