Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVGYRQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVGYRQy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 13:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVGYRQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 13:16:54 -0400
Received: from [194.90.237.34] ([194.90.237.34]:44586 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261392AbVGYRQx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 13:16:53 -0400
Date: Mon, 25 Jul 2005 20:19:28 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Roland Dreier <roland@topspin.com>, openib-general@openib.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH repost] PROT_DONTCOPY: ifiniband uverbs fork support
Message-ID: <20050725171928.GC12206@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20050719165542.GB16028@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050719165542.GB16028@mellanox.co.il>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I posted this before but got no comments.
Here it is again, in case the reason was OLS.

---

This patch adds PROT_DONTCOPY to mmap and mprotect, to set VM_DONTCOPY on vma.
This is needed for infiniband userspace i/o, where we need to protect against
  - the child process accessing the parent hardware page
  - the parent registered address (on which the driver did get_user_pages)
    getting remapped to another page by COW
One can imagine other uses, e.g. combined with mlock for real-time or security.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

Index: linux-2.6.12.2/include/asm-ppc64/mman.h
===================================================================
--- linux-2.6.12.2.orig/include/asm-ppc64/mman.h
+++ linux-2.6.12.2/include/asm-ppc64/mman.h
@@ -15,6 +15,7 @@
 #define PROT_NONE	0x0		/* page can not be accessed */
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
+#define PROT_DONTCOPY	0x04000000	/* dont copy to child on fork */
 
 #define MAP_SHARED	0x01		/* Share changes */
 #define MAP_PRIVATE	0x02		/* Changes are private */
Index: linux-2.6.12.2/include/asm-cris/mman.h
===================================================================
--- linux-2.6.12.2.orig/include/asm-cris/mman.h
+++ linux-2.6.12.2/include/asm-cris/mman.h
@@ -10,6 +10,7 @@
 #define PROT_NONE	0x0		/* page can not be accessed */
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
+#define PROT_DONTCOPY	0x04000000	/* dont copy to child on fork */
 
 #define MAP_SHARED	0x01		/* Share changes */
 #define MAP_PRIVATE	0x02		/* Changes are private */
Index: linux-2.6.12.2/include/asm-arm26/mman.h
===================================================================
--- linux-2.6.12.2.orig/include/asm-arm26/mman.h
+++ linux-2.6.12.2/include/asm-arm26/mman.h
@@ -8,6 +8,7 @@
 #define PROT_NONE	0x0		/* page can not be accessed */
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
+#define PROT_DONTCOPY	0x04000000	/* dont copy to child on fork */
 
 #define MAP_SHARED	0x01		/* Share changes */
 #define MAP_PRIVATE	0x02		/* Changes are private */
Index: linux-2.6.12.2/include/asm-alpha/mman.h
===================================================================
--- linux-2.6.12.2.orig/include/asm-alpha/mman.h
+++ linux-2.6.12.2/include/asm-alpha/mman.h
@@ -8,6 +8,7 @@
 #define PROT_NONE	0x0		/* page can not be accessed */
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
+#define PROT_DONTCOPY	0x04000000	/* dont copy to child on fork */
 
 #define MAP_SHARED	0x01		/* Share changes */
 #define MAP_PRIVATE	0x02		/* Changes are private */
Index: linux-2.6.12.2/include/asm-m68k/mman.h
===================================================================
--- linux-2.6.12.2.orig/include/asm-m68k/mman.h
+++ linux-2.6.12.2/include/asm-m68k/mman.h
@@ -8,6 +8,7 @@
 #define PROT_NONE	0x0		/* page can not be accessed */
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
+#define PROT_DONTCOPY	0x04000000	/* dont copy to child on fork */
 
 #define MAP_SHARED	0x01		/* Share changes */
 #define MAP_PRIVATE	0x02		/* Changes are private */
Index: linux-2.6.12.2/include/asm-mips/mman.h
===================================================================
--- linux-2.6.12.2.orig/include/asm-mips/mman.h
+++ linux-2.6.12.2/include/asm-mips/mman.h
@@ -22,6 +22,7 @@
 #define PROT_SEM	0x10		/* page may be used for atomic ops */
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
+#define PROT_DONTCOPY	0x04000000	/* dont copy to child on fork */
 
 /*
  * Flags for mmap
Index: linux-2.6.12.2/include/asm-sparc64/mman.h
===================================================================
--- linux-2.6.12.2.orig/include/asm-sparc64/mman.h
+++ linux-2.6.12.2/include/asm-sparc64/mman.h
@@ -11,6 +11,7 @@
 #define PROT_NONE	0x0		/* page can not be accessed */
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
+#define PROT_DONTCOPY	0x04000000	/* dont copy to child on fork */
 
 #define MAP_SHARED	0x01		/* Share changes */
 #define MAP_PRIVATE	0x02		/* Changes are private */
Index: linux-2.6.12.2/include/asm-v850/mman.h
===================================================================
--- linux-2.6.12.2.orig/include/asm-v850/mman.h
+++ linux-2.6.12.2/include/asm-v850/mman.h
@@ -7,6 +7,7 @@
 #define PROT_NONE	0x0		/* page can not be accessed */
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
+#define PROT_DONTCOPY	0x04000000	/* dont copy to child on fork */
 
 #define MAP_SHARED	0x01		/* Share changes */
 #define MAP_PRIVATE	0x02		/* Changes are private */
Index: linux-2.6.12.2/include/asm-s390/mman.h
===================================================================
--- linux-2.6.12.2.orig/include/asm-s390/mman.h
+++ linux-2.6.12.2/include/asm-s390/mman.h
@@ -16,6 +16,7 @@
 #define PROT_NONE	0x0		/* page can not be accessed */
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
+#define PROT_DONTCOPY	0x04000000	/* dont copy to child on fork */
 
 #define MAP_SHARED	0x01		/* Share changes */
 #define MAP_PRIVATE	0x02		/* Changes are private */
Index: linux-2.6.12.2/include/asm-parisc/mman.h
===================================================================
--- linux-2.6.12.2.orig/include/asm-parisc/mman.h
+++ linux-2.6.12.2/include/asm-parisc/mman.h
@@ -8,6 +8,7 @@
 #define PROT_NONE	0x0		/* page can not be accessed */
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
+#define PROT_DONTCOPY	0x04000000	/* dont copy to child on fork */
 
 #define MAP_SHARED	0x01		/* Share changes */
 #define MAP_PRIVATE	0x02		/* Changes are private */
Index: linux-2.6.12.2/include/asm-ppc/mman.h
===================================================================
--- linux-2.6.12.2.orig/include/asm-ppc/mman.h
+++ linux-2.6.12.2/include/asm-ppc/mman.h
@@ -8,6 +8,7 @@
 #define PROT_NONE	0x0		/* page can not be accessed */
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
+#define PROT_DONTCOPY	0x04000000	/* dont copy to child on fork */
 
 #define MAP_SHARED	0x01		/* Share changes */
 #define MAP_PRIVATE	0x02		/* Changes are private */
Index: linux-2.6.12.2/include/asm-i386/mman.h
===================================================================
--- linux-2.6.12.2.orig/include/asm-i386/mman.h
+++ linux-2.6.12.2/include/asm-i386/mman.h
@@ -8,6 +8,7 @@
 #define PROT_NONE	0x0		/* page can not be accessed */
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
+#define PROT_DONTCOPY	0x04000000	/* dont copy to child on fork */
 
 #define MAP_SHARED	0x01		/* Share changes */
 #define MAP_PRIVATE	0x02		/* Changes are private */
Index: linux-2.6.12.2/include/asm-sh/mman.h
===================================================================
--- linux-2.6.12.2.orig/include/asm-sh/mman.h
+++ linux-2.6.12.2/include/asm-sh/mman.h
@@ -8,6 +8,7 @@
 #define PROT_NONE	0x0		/* page can not be accessed */
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
+#define PROT_DONTCOPY	0x04000000	/* dont copy to child on fork */
 
 #define MAP_SHARED	0x01		/* Share changes */
 #define MAP_PRIVATE	0x02		/* Changes are private */
Index: linux-2.6.12.2/include/asm-x86_64/mman.h
===================================================================
--- linux-2.6.12.2.orig/include/asm-x86_64/mman.h
+++ linux-2.6.12.2/include/asm-x86_64/mman.h
@@ -8,6 +8,7 @@
 #define PROT_SEM	0x8
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
+#define PROT_DONTCOPY	0x04000000	/* dont copy to child on fork */
 
 #define MAP_SHARED	0x01		/* Share changes */
 #define MAP_PRIVATE	0x02		/* Changes are private */
Index: linux-2.6.12.2/include/asm-ia64/mman.h
===================================================================
--- linux-2.6.12.2.orig/include/asm-ia64/mman.h
+++ linux-2.6.12.2/include/asm-ia64/mman.h
@@ -15,6 +15,7 @@
 #define PROT_NONE	0x0		/* page can not be accessed */
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
+#define PROT_DONTCOPY	0x04000000	/* dont copy to child on fork */
 
 #define MAP_SHARED	0x01		/* Share changes */
 #define MAP_PRIVATE	0x02		/* Changes are private */
Index: linux-2.6.12.2/include/asm-sparc/mman.h
===================================================================
--- linux-2.6.12.2.orig/include/asm-sparc/mman.h
+++ linux-2.6.12.2/include/asm-sparc/mman.h
@@ -11,6 +11,7 @@
 #define PROT_NONE	0x0		/* page can not be accessed */
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
+#define PROT_DONTCOPY	0x04000000	/* dont copy to child on fork */
 
 #define MAP_SHARED	0x01		/* Share changes */
 #define MAP_PRIVATE	0x02		/* Changes are private */
Index: linux-2.6.12.2/include/asm-m32r/mman.h
===================================================================
--- linux-2.6.12.2.orig/include/asm-m32r/mman.h
+++ linux-2.6.12.2/include/asm-m32r/mman.h
@@ -10,6 +10,7 @@
 #define PROT_NONE	0x0		/* page can not be accessed */
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
+#define PROT_DONTCOPY	0x04000000	/* dont copy to child on fork */
 
 #define MAP_SHARED	0x01		/* Share changes */
 #define MAP_PRIVATE	0x02		/* Changes are private */
Index: linux-2.6.12.2/include/asm-frv/mman.h
===================================================================
--- linux-2.6.12.2.orig/include/asm-frv/mman.h
+++ linux-2.6.12.2/include/asm-frv/mman.h
@@ -8,6 +8,7 @@
 #define PROT_NONE	0x0		/* page can not be accessed */
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
+#define PROT_DONTCOPY	0x04000000	/* dont copy to child on fork */
 
 #define MAP_SHARED	0x01		/* Share changes */
 #define MAP_PRIVATE	0x02		/* Changes are private */
Index: linux-2.6.12.2/include/linux/mman.h
===================================================================
--- linux-2.6.12.2.orig/include/linux/mman.h
+++ linux-2.6.12.2/include/linux/mman.h
@@ -47,9 +47,10 @@ static inline void vm_unacct_memory(long
 static inline unsigned long
 calc_vm_prot_bits(unsigned long prot)
 {
-	return _calc_vm_trans(prot, PROT_READ,  VM_READ ) |
-	       _calc_vm_trans(prot, PROT_WRITE, VM_WRITE) |
-	       _calc_vm_trans(prot, PROT_EXEC,  VM_EXEC );
+	return _calc_vm_trans(prot, PROT_READ,     VM_READ ) |
+	       _calc_vm_trans(prot, PROT_WRITE,    VM_WRITE) |
+	       _calc_vm_trans(prot, PROT_EXEC,     VM_EXEC ) |
+	       _calc_vm_trans(prot, PROT_DONTCOPY, VM_DONTCOPY );
 }
 
 /*
Index: linux-2.6.12.2/include/asm-h8300/mman.h
===================================================================
--- linux-2.6.12.2.orig/include/asm-h8300/mman.h
+++ linux-2.6.12.2/include/asm-h8300/mman.h
@@ -8,6 +8,7 @@
 #define PROT_NONE	0x0		/* page can not be accessed */
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
+#define PROT_DONTCOPY	0x04000000	/* dont copy to child on fork */
 
 #define MAP_SHARED	0x01		/* Share changes */
 #define MAP_PRIVATE	0x02		/* Changes are private */
Index: linux-2.6.12.2/include/asm-arm/mman.h
===================================================================
--- linux-2.6.12.2.orig/include/asm-arm/mman.h
+++ linux-2.6.12.2/include/asm-arm/mman.h
@@ -8,6 +8,7 @@
 #define PROT_NONE	0x0		/* page can not be accessed */
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
+#define PROT_DONTCOPY	0x04000000	/* dont copy to child on fork */
 
 #define MAP_SHARED	0x01		/* Share changes */
 #define MAP_PRIVATE	0x02		/* Changes are private */
Index: linux-2.6.12.2/mm/mprotect.c
===================================================================
--- linux-2.6.12.2.orig/mm/mprotect.c
+++ linux-2.6.12.2/mm/mprotect.c
@@ -196,7 +196,7 @@ sys_mprotect(unsigned long start, size_t
 	end = start + len;
 	if (end <= start)
 		return -ENOMEM;
-	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM))
+	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM | PROT_DONTCOPY))
 		return -EINVAL;
 
 	reqprot = prot;
@@ -246,7 +246,7 @@ sys_mprotect(unsigned long start, size_t
 			goto out;
 		}
 
-		newflags = vm_flags | (vma->vm_flags & ~(VM_READ | VM_WRITE | VM_EXEC));
+		newflags = vm_flags | (vma->vm_flags & ~(VM_READ | VM_WRITE | VM_EXEC | VM_DONTCOPY));
 
 		if ((newflags & ~(newflags >> 4)) & 0xf) {
 			error = -EACCES;
Index: linux-2.6.12.2/mm/mmap.c
===================================================================
--- linux-2.6.12.2.orig/mm/mmap.c
+++ linux-2.6.12.2/mm/mmap.c
@@ -792,8 +792,8 @@ struct anon_vma *find_mergeable_anon_vma
 	 * Neither mlock nor madvise tries to remerge at present,
 	 * so leave their flags as obstructing a merge.
 	 */
-	vm_flags = vma->vm_flags & ~(VM_READ|VM_WRITE|VM_EXEC);
-	vm_flags |= near->vm_flags & (VM_READ|VM_WRITE|VM_EXEC);
+	vm_flags = vma->vm_flags & ~(VM_READ|VM_WRITE|VM_EXEC|VM_DONTCOPY);
+	vm_flags |= near->vm_flags & (VM_READ|VM_WRITE|VM_EXEC|VM_DONTCOPY);
 
 	if (near->anon_vma && vma->vm_end == near->vm_start &&
  			mpol_equal(vma_policy(vma), vma_policy(near)) &&
@@ -814,8 +814,8 @@ try_prev:
 	if (!near)
 		goto none;
 
-	vm_flags = vma->vm_flags & ~(VM_READ|VM_WRITE|VM_EXEC);
-	vm_flags |= near->vm_flags & (VM_READ|VM_WRITE|VM_EXEC);
+	vm_flags = vma->vm_flags & ~(VM_READ|VM_WRITE|VM_EXEC|VM_DONTCOPY);
+	vm_flags |= near->vm_flags & (VM_READ|VM_WRITE|VM_EXEC|VM_DONTCOPY);
 
 	if (near->anon_vma && near->vm_end == vma->vm_start &&
   			mpol_equal(vma_policy(near), vma_policy(vma)) &&

-- 
MST
