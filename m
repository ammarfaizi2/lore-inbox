Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAKCmo>; Wed, 10 Jan 2001 21:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130105AbRAKCmf>; Wed, 10 Jan 2001 21:42:35 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:59922 "EHLO
	mf1.private") by vger.kernel.org with ESMTP id <S129431AbRAKCmR>;
	Wed, 10 Jan 2001 21:42:17 -0500
Date: Wed, 10 Jan 2001 18:46:33 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: Szabolcs Szakacsits <szaka@f-secure.com>
cc: LKML <linux-kernel@vger.kernel.org>,
        "William A. Stein" <was@math.harvard.edu>, Dan Maas <dmaas@dcine.com>
Subject: [2.4.0 pre-PATCH] 830MB barrier (was: Subtle MM bug)
In-Reply-To: <Pine.LNX.4.30.0101092109580.1092-100000@fs129-124.f-secure.com>
Message-ID: <Pine.LNX.4.30.0101101753400.27667-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, Szabolcs Szakacsits wrote:

> 3) ask kernel developers to get rid of this "brk hits the fixed start
> address of mmapped areas" or the other way around complaints "mmapped
> area should start at lower address" limitation. E.g. Solaris does
> growing up heap, growing down mmap and fixed size stack at the top.

OK, I attempted this myself, it boots fine and seems to work!

The basic idea is to define TASK_UNMAPPED_CEILING in
include/asm-i386/processor.h, and then modify get_unmapped_area() in
mm/mmap.c to search downards from TASK_UNMAPPED_CEILING, rather than
upwards from TASK_UNMAPPED_BASE. But this is my first ever linux kernel
patch (included below), so it has several rough edges:

(1) I don't have any idea what happens on architectures other than i386,
so if TASK_UNMAPPED_CEILING is undefined, get_unmapped_area() behaves as
before.  I used #ifdef to do this, I don't know if that is considered
proper style.

(2) I have no idea how much room to allow for the stack on i386, so I
arbitrarily picked 128MB.  Is this way overkill?

(3) The (original) search upwards version of get_unmapped_area only calls
find_vma once, and then it uses vmm->vm_next in the main loop to get the
next vm_area_struct.  My search downwards version calls find_vma once
every loop, as I don't understand the connectivity of the vma_structs, but
find_vma is documented.

Is the overhead of calling find_vma every time a problem?  If so, is there
a better way of doing this without changing the vm_area_struct structure
to be a doubly linked list?

(4) Lastly, I terminate the downwards search at TASK_UNMAPPED_BASE, but
this is just wrong, as part of the point is that we should allow mmap's to
go all the way down to the top of the heap.  What is the correct
termination condition?  If the heap is just another vm_area_struct, then I
would think it would be checking against where the executable is loaded,
is their kernel macro for this?

Any comments would be extremely welcome!!  As is, it serves my purposes
(allowing a non mmap'ing program to brk() up to TASK_SIZE), but I'd be
happy to "do it right".

Cheers,
Wayne


diff -ru -x *.o -x .config linux-2.4.0-pizza/include/asm-i386/processor.h linux-2.4.0-hack/include/asm-i386/processor.h
--- linux-2.4.0-pizza/include/asm-i386/processor.h	Sat Jan  6 16:46:21 2001
+++ linux-2.4.0-hack/include/asm-i386/processor.h	Wed Jan 10 17:22:30 2001
@@ -260,10 +260,20 @@
  */
 #define TASK_SIZE	(PAGE_OFFSET)

-/* This decides where the kernel will search for a free chunk of vm
- * space during mmap's.
+/*
+ * When looking for a free chunk of vm space during mmap's, the kernel
+ * will search upwards from TASK_UNMAPPED_BASE, unless
+ * TASK_UNMAPPED_CEILING is defined, in which case it will search
+ * downwards from that address.
  */
 #define TASK_UNMAPPED_BASE	(TASK_SIZE / 3)
+
+/*
+ * We need to allow room for the stack to grow downard from TASK_SIZE,
+ * I really have no idea how large it can get, so I arbitrarily picked
+ * 128MB.
+ */
+#define TASK_UNMAPPED_CEILING   (TASK_SIZE - 128 * 1024 * 1024)

 /*
  * Size of io_bitmap in longwords: 32 is ports 0-0x3ff.
diff -ru -x *.o -x .config linux-2.4.0-pizza/mm/mmap.c linux-2.4.0-hack/mm/mmap.c
--- linux-2.4.0-pizza/mm/mmap.c	Sat Dec 30 12:35:19 2000
+++ linux-2.4.0-hack/mm/mmap.c	Wed Jan 10 17:24:08 2001
@@ -382,6 +382,22 @@

 	if (len > TASK_SIZE)
 		return 0;
+#ifdef TASK_UNMAPPED_CEILING
+	if (!addr)
+		addr = TASK_UNMAPPED_CEILING - len;
+
+	do {
+		/* align addr _downards_; PAGE_ALIGN aligns it upwards */
+		addr = addr&PAGE_MASK;
+		vmm = find_vma(current->mm,addr);
+		/* At this point:  (!vmm || addr < vmm->vm_end). */
+		if (!vmm || addr + len <= vmm->vm_start)
+			return addr;
+		addr = vmm->vm_start - len;
+	} while (addr >= TASK_UNMAPPED_BASE);
+
+	return 0;
+#else
 	if (!addr)
 		addr = TASK_UNMAPPED_BASE;
 	addr = PAGE_ALIGN(addr);
@@ -394,6 +410,7 @@
 			return addr;
 		addr = vmm->vm_end;
 	}
+#endif
 }
 #endif


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
