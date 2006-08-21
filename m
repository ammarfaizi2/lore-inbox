Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWHUSxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWHUSxJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 14:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWHUSwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 14:52:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:10173 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750742AbWHUStG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 14:49:06 -0400
Date: Mon, 21 Aug 2006 11:47:30 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Pavel Emelianov <xemul@openvz.org>, Kirill Korotaev <dev@openvz.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 15/20] IA64: local DoS with corrupted ELFs
Message-ID: <20060821184730.GP21938@kroah.com>
References: <20060821183818.155091391@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ia64-local-dos-with-corrupted-elfs.patch"
In-Reply-To: <20060821184527.GA21938@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Kirill Korotaev <dev@sw.ru>

This patch prevents cross-region mappings
on IA64 and SPARC which could lead to system crash.

davem@ confirmed: "This looks fine to me." :)

Signed-Off-By: Pavel Emelianov <xemul@openvz.org>
Signed-Off-By: Kirill Korotaev <dev@openvz.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 arch/ia64/kernel/sys_ia64.c     |   28 ++++++++++++++++------------
 arch/sparc/kernel/sys_sparc.c   |   27 +++++++++++++++------------
 arch/sparc64/kernel/sys_sparc.c |   36 ++++++++++++++++++++----------------
 include/asm-generic/mman.h      |    6 ++++++
 include/asm-ia64/mman.h         |    6 ++++++
 include/asm-sparc/mman.h        |    6 ++++++
 include/asm-sparc64/mman.h      |    6 ++++++
 mm/mmap.c                       |   13 +++++++++++--
 8 files changed, 86 insertions(+), 42 deletions(-)

--- linux-2.6.17.9.orig/arch/ia64/kernel/sys_ia64.c
+++ linux-2.6.17.9/arch/ia64/kernel/sys_ia64.c
@@ -164,10 +164,25 @@ sys_pipe (void)
 	return retval;
 }
 
+int ia64_map_check_rgn(unsigned long addr, unsigned long len,
+		unsigned long flags)
+{
+	unsigned long roff;
+
+	/*
+	 * Don't permit mappings into unmapped space, the virtual page table
+	 * of a region, or across a region boundary.  Note: RGN_MAP_LIMIT is
+	 * equal to 2^n-PAGE_SIZE (for some integer n <= 61) and len > 0.
+	 */
+	roff = REGION_OFFSET(addr);
+	if ((len > RGN_MAP_LIMIT) || (roff > (RGN_MAP_LIMIT - len)))
+		return -EINVAL;
+	return 0;
+}
+
 static inline unsigned long
 do_mmap2 (unsigned long addr, unsigned long len, int prot, int flags, int fd, unsigned long pgoff)
 {
-	unsigned long roff;
 	struct file *file = NULL;
 
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
@@ -189,17 +204,6 @@ do_mmap2 (unsigned long addr, unsigned l
 		goto out;
 	}
 
-	/*
-	 * Don't permit mappings into unmapped space, the virtual page table of a region,
-	 * or across a region boundary.  Note: RGN_MAP_LIMIT is equal to 2^n-PAGE_SIZE
-	 * (for some integer n <= 61) and len > 0.
-	 */
-	roff = REGION_OFFSET(addr);
-	if ((len > RGN_MAP_LIMIT) || (roff > (RGN_MAP_LIMIT - len))) {
-		addr = -EINVAL;
-		goto out;
-	}
-
 	down_write(&current->mm->mmap_sem);
 	addr = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
 	up_write(&current->mm->mmap_sem);
--- linux-2.6.17.9.orig/arch/sparc/kernel/sys_sparc.c
+++ linux-2.6.17.9/arch/sparc/kernel/sys_sparc.c
@@ -219,6 +219,21 @@ out:
 	return err;
 }
 
+int sparc_mmap_check(unsigned long addr, unsigned long len, unsigned long flags)
+{
+	if (ARCH_SUN4C_SUN4 &&
+	    (len > 0x20000000 ||
+	     ((flags & MAP_FIXED) &&
+	      addr < 0xe0000000 && addr + len > 0x20000000)))
+		return -EINVAL;
+
+	/* See asm-sparc/uaccess.h */
+	if (len > TASK_SIZE - PAGE_SIZE || addr + len > TASK_SIZE - PAGE_SIZE)
+		return -EINVAL;
+
+	return 0;
+}
+
 /* Linux version of mmap */
 static unsigned long do_mmap2(unsigned long addr, unsigned long len,
 	unsigned long prot, unsigned long flags, unsigned long fd,
@@ -233,25 +248,13 @@ static unsigned long do_mmap2(unsigned l
 			goto out;
 	}
 
-	retval = -EINVAL;
 	len = PAGE_ALIGN(len);
-	if (ARCH_SUN4C_SUN4 &&
-	    (len > 0x20000000 ||
-	     ((flags & MAP_FIXED) &&
-	      addr < 0xe0000000 && addr + len > 0x20000000)))
-		goto out_putf;
-
-	/* See asm-sparc/uaccess.h */
-	if (len > TASK_SIZE - PAGE_SIZE || addr + len > TASK_SIZE - PAGE_SIZE)
-		goto out_putf;
-
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
 
 	down_write(&current->mm->mmap_sem);
 	retval = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
 	up_write(&current->mm->mmap_sem);
 
-out_putf:
 	if (file)
 		fput(file);
 out:
--- linux-2.6.17.9.orig/arch/sparc64/kernel/sys_sparc.c
+++ linux-2.6.17.9/arch/sparc64/kernel/sys_sparc.c
@@ -549,6 +549,26 @@ asmlinkage long sparc64_personality(unsi
 	return ret;
 }
 
+int sparc64_mmap_check(unsigned long addr, unsigned long len,
+		unsigned long flags)
+{
+	if (test_thread_flag(TIF_32BIT)) {
+		if (len >= STACK_TOP32)
+			return -EINVAL;
+
+		if ((flags & MAP_FIXED) && addr > STACK_TOP32 - len)
+			return -EINVAL;
+	} else {
+		if (len >= VA_EXCLUDE_START)
+			return -EINVAL;
+
+		if ((flags & MAP_FIXED) && invalid_64bit_range(addr, len))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 /* Linux version of mmap */
 asmlinkage unsigned long sys_mmap(unsigned long addr, unsigned long len,
 	unsigned long prot, unsigned long flags, unsigned long fd,
@@ -564,27 +584,11 @@ asmlinkage unsigned long sys_mmap(unsign
 	}
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
 	len = PAGE_ALIGN(len);
-	retval = -EINVAL;
-
-	if (test_thread_flag(TIF_32BIT)) {
-		if (len >= STACK_TOP32)
-			goto out_putf;
-
-		if ((flags & MAP_FIXED) && addr > STACK_TOP32 - len)
-			goto out_putf;
-	} else {
-		if (len >= VA_EXCLUDE_START)
-			goto out_putf;
-
-		if ((flags & MAP_FIXED) && invalid_64bit_range(addr, len))
-			goto out_putf;
-	}
 
 	down_write(&current->mm->mmap_sem);
 	retval = do_mmap(file, addr, len, prot, flags, off);
 	up_write(&current->mm->mmap_sem);
 
-out_putf:
 	if (file)
 		fput(file);
 out:
--- linux-2.6.17.9.orig/include/asm-generic/mman.h
+++ linux-2.6.17.9/include/asm-generic/mman.h
@@ -39,4 +39,10 @@
 #define MAP_ANON	MAP_ANONYMOUS
 #define MAP_FILE	0
 
+#ifdef __KERNEL__
+#ifndef arch_mmap_check
+#define arch_mmap_check(addr, len, flags)	(0)
+#endif
+#endif
+
 #endif
--- linux-2.6.17.9.orig/include/asm-ia64/mman.h
+++ linux-2.6.17.9/include/asm-ia64/mman.h
@@ -8,6 +8,12 @@
  *	David Mosberger-Tang <davidm@hpl.hp.com>, Hewlett-Packard Co
  */
 
+#ifdef __KERNEL__
+#define arch_mmap_check	ia64_map_check_rgn
+int ia64_map_check_rgn(unsigned long addr, unsigned long len,
+		unsigned long flags);
+#endif
+
 #include <asm-generic/mman.h>
 
 #define MAP_GROWSDOWN	0x00100		/* stack-like segment */
--- linux-2.6.17.9.orig/include/asm-sparc/mman.h
+++ linux-2.6.17.9/include/asm-sparc/mman.h
@@ -2,6 +2,12 @@
 #ifndef __SPARC_MMAN_H__
 #define __SPARC_MMAN_H__
 
+#ifdef __KERNEL__
+#define arch_mmap_check	sparc_mmap_check
+int sparc_mmap_check(unsigned long addr, unsigned long len,
+		unsigned long flags);
+#endif
+
 #include <asm-generic/mman.h>
 
 /* SunOS'ified... */
--- linux-2.6.17.9.orig/include/asm-sparc64/mman.h
+++ linux-2.6.17.9/include/asm-sparc64/mman.h
@@ -2,6 +2,12 @@
 #ifndef __SPARC64_MMAN_H__
 #define __SPARC64_MMAN_H__
 
+#ifdef __KERNEL__
+#define arch_mmap_check	sparc64_mmap_check
+int sparc64_mmap_check(unsigned long addr, unsigned long len,
+		unsigned long flags);
+#endif
+
 #include <asm-generic/mman.h>
 
 /* SunOS'ified... */
--- linux-2.6.17.9.orig/mm/mmap.c
+++ linux-2.6.17.9/mm/mmap.c
@@ -913,6 +913,10 @@ unsigned long do_mmap_pgoff(struct file 
 	if (!len)
 		return -EINVAL;
 
+	error = arch_mmap_check(addr, len, flags);
+	if (error)
+		return error;
+
 	/* Careful about overflows.. */
 	len = PAGE_ALIGN(len);
 	if (!len || len > TASK_SIZE)
@@ -1852,6 +1856,7 @@ unsigned long do_brk(unsigned long addr,
 	unsigned long flags;
 	struct rb_node ** rb_link, * rb_parent;
 	pgoff_t pgoff = addr >> PAGE_SHIFT;
+	int error;
 
 	len = PAGE_ALIGN(len);
 	if (!len)
@@ -1860,6 +1865,12 @@ unsigned long do_brk(unsigned long addr,
 	if ((addr + len) > TASK_SIZE || (addr + len) < addr)
 		return -EINVAL;
 
+	flags = VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
+
+	error = arch_mmap_check(addr, len, flags);
+	if (error)
+		return error;
+
 	/*
 	 * mlock MCL_FUTURE?
 	 */
@@ -1900,8 +1911,6 @@ unsigned long do_brk(unsigned long addr,
 	if (security_vm_enough_memory(len >> PAGE_SHIFT))
 		return -ENOMEM;
 
-	flags = VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
-
 	/* Can we just expand an old private anonymous mapping? */
 	if (vma_merge(mm, prev, addr, addr + len, flags,
 					NULL, NULL, pgoff, NULL))

--
