Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S157013AbPJLStZ>; Tue, 12 Oct 1999 14:49:25 -0400
Received: by vger.rutgers.edu id <S156943AbPJLStQ>; Tue, 12 Oct 1999 14:49:16 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:52681 "EHLO math.psu.edu") by vger.rutgers.edu with ESMTP id <S156942AbPJLSs4>; Tue, 12 Oct 1999 14:48:56 -0400
Date: Tue, 12 Oct 1999 14:48:46 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: manfreds <manfreds@colorfullife.com>
Cc: linux-kernel@vger.rutgers.edu, linux-mm@kvack.org
Subject: Re: vma_list_sem
In-Reply-To: <Pine.LNX.4.10.9910121943300.17128-100000@clmsdevli>
Message-ID: <Pine.GSO.4.10.9910121353330.22333-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu



On Tue, 12 Oct 1999, manfreds wrote:

> I've merged your patch and my patch, the result is below.
> It still contains the complete debugging code, and I've not
> yet performed any low-memory testing.
> 
> I found one more find_vma() caller which performs no locking:
> fs/super.c: copy_mount_options().
> 
> Unfortunately, I found no clean solution for this function, but
> I think my fix is acceptable. [there is an obscure race possible,
> a multi-threaded application could fail with -EFAULT although
> all parameters are valid].

a) you've missed several pieces in arch/* and drivers/*
b) correct code should not be punished. Ever. ASSERT is wrong.

Some of missing pieces (modulo binfmt-related stuff):

diff -urN linux-2.3.20/arch/mips/kernel/sysmips.c linux-bird.mm/arch/mips/kernel/sysmips.c
--- linux-2.3.20/arch/mips/kernel/sysmips.c	Sun Sep 12 05:54:08 1999
+++ linux-bird.mm/arch/mips/kernel/sysmips.c	Tue Oct 12 14:09:01 1999
@@ -23,29 +23,6 @@
 #include <asm/sysmips.h>
 #include <asm/uaccess.h>
 
-/*
- * How long a hostname can we get from user space?
- *  -EFAULT if invalid area or too long
- *  0 if ok
- *  >0 EFAULT after xx bytes
- */
-static inline int
-get_max_hostname(unsigned long address)
-{
-	struct vm_area_struct * vma;
-
-	vma = find_vma(current->mm, address);
-	if (!vma || vma->vm_start > address || !(vma->vm_flags & VM_READ))
-		return -EFAULT;
-	address = vma->vm_end - address;
-	if (address > PAGE_SIZE)
-		return 0;
-	if (vma->vm_next && vma->vm_next->vm_start == vma->vm_end &&
-	   (vma->vm_next->vm_flags & VM_READ))
-		return 0;
-	return address;
-}
-
 asmlinkage int
 sys_sysmips(int cmd, int arg1, int arg2, int arg3)
 {
diff -urN linux-2.3.20/arch/sparc64/kernel/sys_sparc32.c linux-bird.mm/arch/sparc64/kernel/sys_sparc32.c
--- linux-2.3.20/arch/sparc64/kernel/sys_sparc32.c	Sun Sep 12 13:27:24 1999
+++ linux-bird.mm/arch/sparc64/kernel/sys_sparc32.c	Tue Oct 12 14:31:18 1999
@@ -1331,26 +1331,34 @@
 	int i;
 	unsigned long page;
 	struct vm_area_struct *vma;
+	int err;
 
 	*kernel = 0;
 	if(!user)
 		return 0;
+	if(!(page = __get_free_page(GFP_KERNEL)))
+		return -ENOMEM;
+	down(&current->mm->mmap_sem);
 	vma = find_vma(current->mm, (unsigned long)user);
+	err = -EFAULT;
 	if(!vma || (unsigned long)user < vma->vm_start)
-		return -EFAULT;
+		goto out;
 	if(!(vma->vm_flags & VM_READ))
-		return -EFAULT;
+		goto out;
 	i = vma->vm_end - (unsigned long) user;
 	if(PAGE_SIZE <= (unsigned long) i)
 		i = PAGE_SIZE - 1;
-	if(!(page = __get_free_page(GFP_KERNEL)))
-		return -ENOMEM;
+	up(&current->mm->mmap_sem);
 	if(copy_from_user((void *) page, user, i)) {
 		free_page(page);
 		return -EFAULT;
 	}
 	*kernel = page;
 	return 0;
+out:
+	up(&current->mm->mmap_sem);
+	free_page(page);
+	return err;
 }
 
 extern asmlinkage int sys_mount(char * dev_name, char * dir_name, char * type,
diff -urN linux-2.3.20/drivers/char/drm/bufs.c linux-bird.mm/drivers/char/drm/bufs.c
--- linux-2.3.20/drivers/char/drm/bufs.c	Tue Sep 21 16:13:03 1999
+++ linux-bird.mm/drivers/char/drm/bufs.c	Tue Oct 12 14:10:51 1999
@@ -477,8 +477,10 @@
 			   -EFAULT);
 
 	if (request.count >= dma->buf_count) {
+		down(&current->mm->mmap_sem);
 		virtual = do_mmap(filp, 0, dma->byte_count,
 				  PROT_READ|PROT_WRITE, MAP_SHARED, 0);
+		up(&current->mm->mmap_sem);
 		if (virtual > -1024UL) {
 				/* Real error */
 			retcode = (signed long)virtual;
diff -urN linux-2.3.20/drivers/sgi/char/graphics.c linux-bird.mm/drivers/sgi/char/graphics.c
--- linux-2.3.20/drivers/sgi/char/graphics.c	Sun Sep 12 13:27:36 1999
+++ linux-bird.mm/drivers/sgi/char/graphics.c	Tue Oct 12 14:12:33 1999
@@ -150,9 +150,11 @@
 		 * sgi_graphics_mmap
 		 */
 		disable_gconsole ();
+		down(&current->mm->mmap_sem);
 		r = do_mmap (file, (unsigned long)vaddr,
 			     cards[board].g_regs_size, PROT_READ|PROT_WRITE,
 			     MAP_FIXED|MAP_PRIVATE, 0);
+		up(&current->mm->mmap_sem);
 		if (r)
 			return r;
 	}
diff -urN linux-2.3.20/drivers/sgi/char/shmiq.c linux-bird.mm/drivers/sgi/char/shmiq.c
--- linux-2.3.20/drivers/sgi/char/shmiq.c	Sun Sep 12 12:45:47 1999
+++ linux-bird.mm/drivers/sgi/char/shmiq.c	Tue Oct 12 14:07:48 1999
@@ -272,14 +272,17 @@
 		}
 
 		vaddr = (unsigned long) req.user_vaddr;
+		down(&current->mm->mmap_sem);
 		vma = find_vma (current->mm, vaddr);
 		if (!vma){
 			printk ("SHMIQ: could not find %lx the vma\n", vaddr);
+			up(&current->mm->mmap_sem);
 			return -EINVAL;
 		}
 		s = req.arg * sizeof (struct shmqevent) + sizeof (struct sharedMemoryInputQueue);
-		v = sys_munmap (vaddr, s);
+		v = do_munmap (vaddr, s);
 		do_mmap (filp, vaddr, s, PROT_READ | PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 0);
+		up(&current->mm->mmap_sem);
 		shmiqs [minor].events = req.arg;
 		shmiqs [minor].mapped = 1;
 		return 0;


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
