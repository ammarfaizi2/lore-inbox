Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <971927-18554>; Thu, 9 Jul 1998 20:23:32 -0400
Received: from neon-best.transmeta.com ([206.184.214.10]:17902 "EHLO neon.transmeta.com" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <971912-18554>; Thu, 9 Jul 1998 20:20:44 -0400
Date: Thu, 9 Jul 1998 18:26:26 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: ganesh.sittampalam@magd.ox.ac.uk
cc: "Stephen C. Tweedie" <sct@redhat.com>, Virtual Memory problem report list <linux-kernel@vger.rutgers.edu>, mingo@valerie.inf.elte.hu, Bill Hawes <whawes@star.net>, Alan Cox <number6@the-village.bc.nu>, "David S. Miller" <davem@dm.cobaltmicro.com>
Subject: Re: Progress! was: Re: Yet more VM writable swap-cached pages
In-Reply-To: <Pine.LNX.3.95.980710021356.10100A-100000@fishy>
Message-ID: <Pine.LNX.3.96.980709182436.431F-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu



On Fri, 10 Jul 1998, Ganesh Sittampalam wrote:
> 
> Since this is now 100% reproducible on my system, I'd be happy to
> guinea-pig any fixes, however experimental.

Does this fix it dor you?

		Linus
-----
diff -u --recursive --new-file v2.1.108/linux/include/asm-i386/pgtable.h linux/include/asm-i386/pgtable.h
--- v2.1.108/linux/include/asm-i386/pgtable.h	Wed Jun 24 22:54:10 1998
+++ linux/include/asm-i386/pgtable.h	Thu Jul  9 18:13:50 1998
@@ -225,6 +225,9 @@
 #define _PAGE_4M	0x080	/* 4 MB page, Pentium+.. */
 #define _PAGE_GLOBAL	0x100	/* Global TLB entry PPro+ */
 
+#define _PAGE_READABLE  (_PAGE_PRESENT)             
+#define _PAGE_WRITABLE  (_PAGE_PRESENT | _PAGE_RW)
+
 #define _PAGE_TABLE	(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER | _PAGE_ACCESSED | _PAGE_DIRTY)
 #define _KERNPG_TABLE	(_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
 #define _PAGE_CHG_MASK	(PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY)
@@ -330,21 +333,25 @@
  * Undefined behaviour if not..
  */
 extern inline int pte_read(pte_t pte)		{ return pte_val(pte) & _PAGE_USER; }
-extern inline int pte_write(pte_t pte)		{ return pte_val(pte) & _PAGE_RW; }
 extern inline int pte_exec(pte_t pte)		{ return pte_val(pte) & _PAGE_USER; }
 extern inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
 extern inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; }
 
-extern inline pte_t pte_wrprotect(pte_t pte)	{ pte_val(pte) &= ~_PAGE_RW; return pte; }
 extern inline pte_t pte_rdprotect(pte_t pte)	{ pte_val(pte) &= ~_PAGE_USER; return pte; }
 extern inline pte_t pte_exprotect(pte_t pte)	{ pte_val(pte) &= ~_PAGE_USER; return pte; }
 extern inline pte_t pte_mkclean(pte_t pte)	{ pte_val(pte) &= ~_PAGE_DIRTY; return pte; }
 extern inline pte_t pte_mkold(pte_t pte)	{ pte_val(pte) &= ~_PAGE_ACCESSED; return pte; }
-extern inline pte_t pte_mkwrite(pte_t pte)	{ pte_val(pte) |= _PAGE_RW; return pte; }
 extern inline pte_t pte_mkread(pte_t pte)	{ pte_val(pte) |= _PAGE_USER; return pte; }
 extern inline pte_t pte_mkexec(pte_t pte)	{ pte_val(pte) |= _PAGE_USER; return pte; }
 extern inline pte_t pte_mkdirty(pte_t pte)	{ pte_val(pte) |= _PAGE_DIRTY; return pte; }
 extern inline pte_t pte_mkyoung(pte_t pte)	{ pte_val(pte) |= _PAGE_ACCESSED; return pte; }
+
+/*
+ * These are harder, as writability is two bits, not one..
+ */
+extern inline int pte_write(pte_t pte)		{ return (pte_val(pte) & _PAGE_WRITABLE) == _PAGE_WRITABLE; }
+extern inline pte_t pte_wrprotect(pte_t pte)	{ pte_val(pte) &= ~((pte_val(pte) & _PAGE_PRESENT) << 1); return pte; }
+extern inline pte_t pte_mkwrite(pte_t pte)	{ pte_val(pte) |= _PAGE_RW; return pte; }
 
 /*
  * Conversion functions: convert a page and protection to a page entry,



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
