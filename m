Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279715AbRJYHrQ>; Thu, 25 Oct 2001 03:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279718AbRJYHrG>; Thu, 25 Oct 2001 03:47:06 -0400
Received: from are.twiddle.net ([64.81.246.98]:20914 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S279715AbRJYHqq>;
	Thu, 25 Oct 2001 03:46:46 -0400
Date: Thu, 25 Oct 2001 00:47:18 -0700
From: Richard Henderson <rth@twiddle.net>
To: Jay Estabrook <Jay.Estabrook@compaq.com>
Cc: torvalds@transmeta.com, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: alpha 2.4.13, fix get_unmapped_area for 32-bit processes
Message-ID: <20011025004718.A8855@twiddle.net>
Mail-Followup-To: Jay Estabrook <Jay.Estabrook@compaq.com>,
	torvalds@transmeta.com, alan@redhat.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011023210346.B6122@linux04.mro.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011023210346.B6122@linux04.mro.cpqcorp.net>; from Jay.Estabrook@compaq.com on Tue, Oct 23, 2001 at 09:03:46PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2001 at 09:03:46PM -0400, Jay Estabrook wrote:
> diff -ur LINUX/pre6-2.4.13/mm/mmap.c PATCH/pre6-2.4.13/mm/mmap.c
> --- LINUX/pre6-2.4.13/mm/mmap.c	Thu Oct 11 17:31:55 2001
> +++ PATCH/pre6-2.4.13/mm/mmap.c	Tue Oct 23 13:38:38 2001
> @@ -600,8 +600,11 @@ arch_get_unmapped_area

This should fix the problem, as discussed previously.


r~



diff -rup linux/include/asm-alpha/pgtable.h 2.4.13/include/asm-alpha/pgtable.h
--- linux/include/asm-alpha/pgtable.h	Thu Oct  4 18:47:08 2001
+++ 2.4.13/include/asm-alpha/pgtable.h	Wed Oct 24 16:21:38 2001
@@ -363,4 +363,7 @@ extern void paging_init(void);
  */
 #define pgtable_cache_init()	do { } while (0)
 
+/* We have our own get_unmapped_area to cope with ADDR_LIMIT_32BIT.  */
+#define HAVE_ARCH_UNMAPPED_AREA
+
 #endif /* _ALPHA_PGTABLE_H */
Only in 2.4.13/include/asm-alpha: pgtable.h.orig
diff -rup linux/arch/alpha/kernel/osf_sys.c 2.4.13/arch/alpha/kernel/osf_sys.c
--- linux/arch/alpha/kernel/osf_sys.c	Sun Aug 12 15:04:07 2001
+++ 2.4.13/arch/alpha/kernel/osf_sys.c	Wed Oct 24 17:05:17 2001
@@ -1320,3 +1320,62 @@ asmlinkage int sys_old_adjtimex(struct t
 
 	return ret;
 }
+
+/* Get an address range which is currently unmapped.  Similar to the
+   generic version except that we know how to honor ADDR_LIMIT_32BIT.  */
+
+static unsigned long
+arch_get_unmapped_area_1(unsigned long addr, unsigned long len,
+		         unsigned long limit)
+{
+	struct vm_area_struct *vma = find_vma(current->mm, addr);
+
+	while (1) {
+		/* At this point:  (!vma || addr < vma->vm_end). */
+		if (limit - len < addr)
+			return -ENOMEM;
+		if (!vma || addr + len <= vma->vm_start)
+			return addr;
+		addr = vma->vm_end;
+		vma = vma->vm_next;
+	}
+}
+
+unsigned long
+arch_get_unmapped_area(struct file *filp, unsigned long addr,
+		       unsigned long len, unsigned long pgoff,
+		       unsigned long flags)
+{
+	unsigned long limit;
+
+	/* "32 bit" actually means 31 bit, since pointers sign extend.  */
+	if (current->personality & ADDR_LIMIT_32BIT)
+		limit = 0x80000000;
+	else
+		limit = TASK_SIZE;
+
+	if (len > limit)
+		return -ENOMEM;
+
+	/* First, see if the given suggestion fits.  */
+	if (addr) {
+		struct vm_area_struct *vma;
+
+		addr = PAGE_ALIGN(addr);
+		vma = find_vma(current->mm, addr);
+		if (limit - len >= addr &&
+		    (!vma || addr + len <= vma->vm_start))
+			return addr;
+	}
+
+	/* Next, try allocating at TASK_UNMAPPED_BASE.  */
+	addr = arch_get_unmapped_area_1 (PAGE_ALIGN(TASK_UNMAPPED_BASE),
+					 len, limit);
+	if (addr != -ENOMEM)
+		return addr;
+
+	/* Finally, try allocating in low memory.  */
+	addr = arch_get_unmapped_area_1 (PAGE_SIZE, len, limit);
+
+	return addr;
+}
