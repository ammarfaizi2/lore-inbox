Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289883AbSAKFuY>; Fri, 11 Jan 2002 00:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289884AbSAKFuN>; Fri, 11 Jan 2002 00:50:13 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:40144 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S289883AbSAKFuE>;
	Fri, 11 Jan 2002 00:50:04 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15422.31996.630312.134775@napali.hpl.hp.com>
Date: Thu, 10 Jan 2002 21:49:48 -0800
To: torvalds@transmeta.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, davem@redhat.com, paulus@samba.org,
        rth@redhat.com, linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Re: can we make anonymous memory non-EXECUTABLE?
In-Reply-To: <E16NwDj-0006LP-00@the-village.bc.nu>
In-Reply-To: <200201080025.QAA26731@napali.hpl.hp.com>
	<E16NwDj-0006LP-00@the-village.bc.nu>
X-Mailer: VM 7.00 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about the attached patch?  It gives platform-dependent code the
option to turn off execute permission on data pages by defining a
suitable value for DATA_PAGE_DEFAULT_RIGHTS in asm/page.h.  If a
platform doesn't define this macro, the old behavior applies (data
pages continue to be executable by default).  For IA-64, the macro is
defined such that data pages will be executable by default only for
x86 processes (unlike real x86 CPUs, the x86 hardware emulator inside
Itanium does check the execute bit, so this is really needed).

I have booted an ia64 machine with this patch applied without any
problems and also tested an x86 program that does dynamic code
generation so the basics appear to be right.

Oh, I dropped the call to calc_vm_flags() in do_brk().  I didn't see
the point of it.  Perhaps I missed something, though.

If it looks OK to you, would you mind applying this for 2.5?  (The
patch is relative to 2.5.0, but it's trivial enough that this won't be
a problem, hopefully).

	--david

PS: Note that this patch does not solve the original bug I reported
    for platforms that do have an EXECUTABLE permission bit.  If you
    don't want to risk breaking backwards compatibility, your best bet
    is probably to follow Paul's suggestion and modify binutils so the
    data section gets mapped with RWX rights (won't help with existing
    binaries, of course).

--- linux-2.5.0/mm/mmap.c	Mon Nov  5 18:29:05 2001
+++ lia64-kdb/mm/mmap.c	Thu Jan 10 18:01:39 2002
@@ -1046,10 +1052,7 @@
 	if (!vm_enough_memory(len >> PAGE_SHIFT))
 		return -ENOMEM;
 
-	flags = calc_vm_flags(PROT_READ|PROT_WRITE|PROT_EXEC,
-				MAP_FIXED|MAP_PRIVATE) | mm->def_flags;
-
-	flags |= VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
+	flags = DATA_PAGE_DEFAULT_RIGHTS | mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 
 	/* Can we just expand an old anonymous mapping? */
 	if (rb_parent && vma_merge(mm, prev, rb_parent, addr, addr + len, flags))
--- linux-2.5.0/include/linux/mm.h	Mon Nov 26 21:29:07 2001
+++ lia64-kdb/include/linux/mm.h	Thu Jan 10 21:05:41 2002
@@ -103,7 +103,14 @@
 #define VM_DONTEXPAND	0x00040000	/* Cannot expand with mremap() */
 #define VM_RESERVED	0x00080000	/* Don't unmap it from swap_out */
 
-#define VM_STACK_FLAGS	0x00000177
+#ifndef DATA_PAGE_DEFAULT_RIGHTS
+  /* Historically, Linux mapped data with execute rights, but some
+     platforms (e.g., ia64) use non-executable data by default.  Those
+     platforms define their own value for this macro.  */
+# define DATA_PAGE_DEFAULT_RIGHTS	(VM_READ|VM_WRITE|VM_EXEC)
+#endif
+
+#define VM_STACK_FLAGS	(0x00000170 | DATA_PAGE_DEFAULT_RIGHTS)
 
 #define VM_READHINTMASK			(VM_SEQ_READ | VM_RAND_READ)
 #define VM_ClearReadHint(v)		(v)->vm_flags &= ~VM_READHINTMASK
--- linux-2.5.0/include/asm-ia64/page.h	Mon Nov 26 11:19:18 2001
+++ lia64-kdb/include/asm-ia64/page.h	Thu Jan 10 18:48:34 2002
@@ -148,6 +148,13 @@
 # define __pgprot(x)	(x)
 #endif /* !STRICT_MM_TYPECHECKS */
 
-#define PAGE_OFFSET		0xe000000000000000
+#define PAGE_OFFSET			0xe000000000000000
+
+#ifdef CONFIG_IA32_SUPPORT
+# define DATA_PAGE_DEFAULT_RIGHTS	(VM_READ|VM_WRITE |					\
+					 ((current->personality == PER_LINUX32) ? VM_EXEC : 0))
+#else
+# define DATA_PAGE_DEFAULT_RIGHTS	(VM_READ|VM_WRITE)
+#endif
 
 #endif /* _ASM_IA64_PAGE_H */
