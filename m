Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281854AbRLLUDM>; Wed, 12 Dec 2001 15:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281852AbRLLUDD>; Wed, 12 Dec 2001 15:03:03 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:52628 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S281856AbRLLUCs>; Wed, 12 Dec 2001 15:02:48 -0500
Date: Wed, 12 Dec 2001 12:02:42 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Repost: could ia32 mmap() allocations grow downward?
Message-ID: <Pine.LNX.4.33.0112121158110.18830-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I posted this message five days ago to nary a comment, so perhaps I did
something wrong.  Any comments would be appreciated, other than "go buy
64-bit hardware."  :-)

Cheers,
Wayne


Although pretty much a kernel newbie, I wanted to bring up an idea that I
first saw here a year ago but which received no commentary. 

Namely, from time to time an ia32 user will write about running out of
user address space in one way or another.  The standard answer is that
under ia32 Linux, the 32-bit address space for a program of size P is
carved up as follows:

Start Address	Map Contents			Growth Direction

0x08000000	the executable's code segment	upwards
0x08000000 + P	the executable's data segment	upwards
0x08000000 + 2P	the program's heap		upwards
0x40000000	mmap() without MAP_FIXED	upwards
0xBFFFFFFF	the stack			downards
0xC0000000	kernel space			upwards
0xFFFFFFFF	top of the addresss space

Thus a typical problem is that a program that wants to manage its own heap
(using the brk() system call instead of malloc() from libc) will have a
maximum heap size of 0x38000000 - 2P.  Or a program that heavily uses
mmap() will only have 0x80000000 of mmap() address space.

Various workaround are usually proposed, such as:

o Modify the program to use malloc(), or tune the malloc() allocation
  strategy parameters, as malloc() knows about the two distinct memory
  allocation mechanisms, brk() below 0x40000000 and mmap() above it.

o Change the value of TASK_UNMAPPED_BASE in the kernel from its default 
  of 0x40000000.

o Change __PAGE_OFFSET (and the associated value in vmlinux.lds) to 
  0xE0000000 to reduce the kernel space to 512MB.

The alternative idea (not mine) which I'm curious about is:

o Pick a maximum stack size S and change the kernel so the "mmap()
  without MAP_FIXED" region starts at 0xC0000000 - S and grows downwards. 

This seems ideal, as it allows the balance between the mmap() region and
the brk() region to vary for each process, automatically.  What changes
would be required to the kernel to implement this properly and
efficiently?  Is there some downside I am missing?

FWIW, I made a very simple, very naive attempt at doing this about a year
ago, against 2.2.19-prex.  The patch is included below, and it booted OK
for me at the time.  I'm sure I made various poor choices in the patch,
though, having not had the Big Picture.


diff -ru linux-2.2.19-pre7/include/asm-i386/processor.h linux-2.2.19-pre7-hack2/include/asm-i386/processor.h
--- linux-2.2.19-pre7/include/asm-i386/processor.h	Tue Jan  9 20:26:35 2001
+++ linux-2.2.19-pre7-hack2/include/asm-i386/processor.h	Sat Jan 13 11:58:00 2001
@@ -163,10 +163,22 @@
  */
 #define TASK_SIZE	(PAGE_OFFSET)
 
-/* This decides where the kernel will search for a free chunk of vm
- * space during mmap's.
+/* 
+ * When looking for a free chunk of vm space during mmap's, the kernel
+ * will search upwards from TASK_UNMAPPED_BASE (the usual algorithm),
+ * unless TASK_UNMAPPED_CEILING is defined, in which case it will
+ * search downwards from TASK_UNMAPPED_CEILING to TASK_UNMAPPED_FLOOR.
  */
 #define TASK_UNMAPPED_BASE	(TASK_SIZE / 3)
+
+/* 
+ * We need to allow room for the stack to grow downard from TASK_SIZE,
+ * I really have no idea how large it can get, so I arbitrarily picked
+ * 128MB.  Also, I'm not so sure where to stop searching and give up,
+ * so I pick 128MB, which seems to be where exectuables get loaded.
+ */
+#define TASK_UNMAPPED_CEILING   (TASK_SIZE - 128 * 1024 * 1024)
+#define TASK_UNMAPPED_FLOOR     (128 * 1024 * 1024)
 
 /*
  * Size of io_bitmap in longwords: 32 is ports 0-0x3ff.
diff -ru linux-2.2.19-pre7/mm/mmap.c linux-2.2.19-pre7-hack2/mm/mmap.c
--- linux-2.2.19-pre7/mm/mmap.c	Sat Dec  9 21:29:39 2000
+++ linux-2.2.19-pre7-hack2/mm/mmap.c	Sat Jan 13 11:58:00 2001
@@ -365,6 +365,22 @@
 
 	if (len > TASK_SIZE)
 		return 0;
+#ifdef TASK_UNMAPPED_CEILING
+	if (!addr)
+		addr = TASK_UNMAPPED_CEILING - len;
+
+	do { 
+		/* align addr downards; PAGE_ALIGN aligns it upwards */ 
+		addr = addr&PAGE_MASK; 
+		vmm = find_vma(current->mm,addr);
+		/* At this point:  (!vmm || addr < vmm->vm_end). */	  
+		if (!vmm || addr + len <= vmm->vm_start)
+			return addr;
+		addr = vmm->vm_start - len;
+	} while (addr >= TASK_UNMAPPED_FLOOR);
+
+	return 0;
+#else
 	if (!addr)
 		addr = TASK_UNMAPPED_BASE;
 	addr = PAGE_ALIGN(addr);
@@ -377,6 +393,7 @@
 			return addr;
 		addr = vmm->vm_end;
 	}
+#endif
 }
 
 #define vm_avl_empty	(struct vm_area_struct *) NULL





