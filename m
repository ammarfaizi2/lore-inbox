Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278038AbRJZIa6>; Fri, 26 Oct 2001 04:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278068AbRJZIat>; Fri, 26 Oct 2001 04:30:49 -0400
Received: from t2.redhat.com ([199.183.24.243]:43763 "EHLO dot.cygnus.com")
	by vger.kernel.org with ESMTP id <S278038AbRJZIaa>;
	Fri, 26 Oct 2001 04:30:30 -0400
Date: Fri, 26 Oct 2001 01:31:01 -0700
From: Richard Henderson <rth@redhat.com>
To: torvalds@transmeta.com, alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: alpha 2.4.13: fix taso osf emulation
Message-ID: <20011026013101.A1404@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Required to get a dynamicly linked osf taso application working.
Like netscape.  Which unfortunately still works better than mozilla
for many things.

Thoughts on changing all ports such that a mmap with a non-zero,
non-MAP_FIXED address starts the vma search at that address, 
rather than looking for that exact address then checking the
regular unmapped base?



r~



diff -rup linux/fs/binfmt_aout.c 2.4.13/fs/binfmt_aout.c
--- linux/fs/binfmt_aout.c	Sun Sep 30 12:26:08 2001
+++ 2.4.13/fs/binfmt_aout.c	Thu Oct 25 09:58:03 2001
@@ -285,13 +285,15 @@ static int load_aout_binary(struct linux
 		return retval;
 
 	/* OK, This is the point of no return */
-#if !defined(__sparc__)
-	set_personality(PER_LINUX);
-#else
+#if defined(__alpha__)
+	SET_AOUT_PERSONALITY(bprm, ex);
+#elif defined(__sparc__)
 	set_personality(PER_SUNOS);
 #if !defined(__sparc_v9__)
 	memcpy(&current->thread.core_exec, &ex, sizeof(struct exec));
 #endif
+#else
+	set_personality(PER_LINUX);
 #endif
 
 	current->mm->end_code = ex.a_text +
diff -rup linux/fs/exec.c 2.4.13/fs/exec.c
--- linux/fs/exec.c	Tue Sep 18 13:39:32 2001
+++ 2.4.13/fs/exec.c	Thu Oct 25 11:36:53 2001
@@ -770,7 +770,6 @@ int search_binary_handler(struct linux_b
 	    if (!bprm->loader && eh->fh.f_magic == 0x183 &&
 		(eh->fh.f_flags & 0x3000) == 0x3000)
 	    {
-		char * dynloader[] = { "/sbin/loader" };
 		struct file * file;
 		unsigned long loader;
 
@@ -780,10 +779,14 @@ int search_binary_handler(struct linux_b
 
 	        loader = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
 
-		file = open_exec(dynloader[0]);
+		file = open_exec("/sbin/loader");
 		retval = PTR_ERR(file);
 		if (IS_ERR(file))
 			return retval;
+
+		/* Remember if the application is TASO.  */
+		bprm->sh_bang = eh->ah.entry < 0x100000000;
+
 		bprm->file = file;
 		bprm->loader = loader;
 		retval = prepare_binprm(bprm);
diff -rup linux/arch/alpha/kernel/osf_sys.c 2.4.13/arch/alpha/kernel/osf_sys.c
--- linux/arch/alpha/kernel/osf_sys.c	Fri Oct 26 01:17:08 2001
+++ 2.4.13/arch/alpha/kernel/osf_sys.c	Thu Oct 25 12:10:52 2001
@@ -1357,14 +1357,19 @@ arch_get_unmapped_area(struct file *filp
 	if (len > limit)
 		return -ENOMEM;
 
-	/* First, see if the given suggestion fits.  */
-	if (addr) {
-		struct vm_area_struct *vma;
+	/* First, see if the given suggestion fits.
+
+	   The OSF/1 loader (/sbin/loader) relies on us returning an
+	   address larger than the requested if one exists, which is
+	   a terribly broken way to program.
 
-		addr = PAGE_ALIGN(addr);
-		vma = find_vma(current->mm, addr);
-		if (limit - len >= addr &&
-		    (!vma || addr + len <= vma->vm_start))
+	   That said, I can see the use in being able to suggest not
+	   merely specific addresses, but regions of memory -- perhaps
+	   this feature should be incorporated into all ports?  */
+
+	if (addr) {
+		addr = arch_get_unmapped_area_1 (PAGE_ALIGN(addr), len, limit);
+		if (addr != -ENOMEM)
 			return addr;
 	}
 
diff -rup linux/include/asm-alpha/a.out.h 2.4.13/include/asm-alpha/a.out.h
--- linux/include/asm-alpha/a.out.h	Fri Feb  6 10:06:55 1998
+++ 2.4.13/include/asm-alpha/a.out.h	Fri Oct 26 01:24:47 2001
@@ -90,8 +90,16 @@ struct exec
 
 #ifdef __KERNEL__
 
+/* Assume that start addresses below 4G belong to a TASO application.
+   Unfortunately, there is no proper bit in the exec header to check.
+   Worse, we have to notice the start address before swapping to use
+   /sbin/loader, which of course is _not_ a TASO application.  */
+#define SET_AOUT_PERSONALITY(BFPM, EX) \
+	set_personality (BFPM->sh_bang || EX.ah.entry < 0x100000000 \
+			 ? PER_LINUX_32BIT : PER_LINUX)
+
 #define STACK_TOP \
-  ((current->personality==PER_LINUX_32BIT) ? (0x80000000) : (0x00120000000UL))
+  (current->personality & ADDR_LIMIT_32BIT ? 0x80000000 : 0x00120000000UL)
 
 #endif
 
