Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135607AbRALWhL>; Fri, 12 Jan 2001 17:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135606AbRALWhB>; Fri, 12 Jan 2001 17:37:01 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:32262 "EHLO
	mf1.private") by vger.kernel.org with ESMTP id <S135556AbRALWgy>;
	Fri, 12 Jan 2001 17:36:54 -0500
Date: Fri, 12 Jan 2001 14:41:33 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [2.4.0-pre3] [prePATCH] mmap grows downward on i386
Message-ID: <Pine.LNX.4.30.0101121402300.29571-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As suggested in the thread "Subtle MM bug (really 830MB barrier
question)", it would be beneficial on 32-bit hardware for mmap()
allocations without MAP_FIXED to grow downward from TASK_SIZE, rather than
upwards from TASK_UNMAPPED_BASE.  This would allow both brk()-using and
mmap()-using programs to access almost 3GB (TASK_SIZE - some overhead).

So here is my first ever attempt at a kernel patch.  It compiles and boots
and seems to work OK.  Any comments would be very welcome, but please
excuse my ignorance of many things. :-)

A few comments:

(1) I have no idea how much room to allow for the stack on i386, so I
arbitrarily picked 128MB.

(2) I also have no idea what happens on architectures other than i386, so
I defined TASK_UNMAPPED_CEILING in include/asm-i386/processor.h.  Then in
mm/mmap.c, if TASK_UNMAPPED_CEILING is undefined, get_unmapped_area()
behaves as before.  I used #ifdef to do this, is that an OK style?

(3) The (original) search upwards version of get_unmapped_area() only
calls find_vma() once, and then it uses ->vm_next in the main loop to get
the next vm_area_struct.  My search downwards version calls find_vma()
once every loop, as there is no ->vm_previous member in vm_area_struct.
Is the overhead of calling find_vma() every loop a problem, and if so, is
there a better solution than modifying vm_area_struct to make it a doubly
linked list?

(4) Lastly, there is the question of when get_unmapped_area() should just
fail.  I notice that executables on i386 are loaded at 128MB, so I defined
TASK_UNMAPPED_FLOOR to be 128MB and I stop there.  Is this the right place
to stop, and if so is there some other #define I should be referencing
instead of adding one?

Cheers,
Wayne


diff -ru linux-2.4.0-pre3/include/asm-i386/processor.h linux-2.4.0-pre3-hack/include/asm-i386/processor.h
--- linux-2.4.0-pre3/include/asm-i386/processor.h	Thu Jan 11 12:56:05 2001
+++ linux-2.4.0-pre3-hack/include/asm-i386/processor.h	Fri Jan 12 13:51:16 2001
@@ -260,10 +260,22 @@
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
diff -ru linux-2.4.0-pre3/mm/mmap.c linux-2.4.0-pre3-hack/mm/mmap.c
--- linux-2.4.0-pre3/mm/mmap.c	Sat Dec 30 12:35:19 2000
+++ linux-2.4.0-pre3-hack/mm/mmap.c	Fri Jan 12 13:54:02 2001
@@ -382,6 +382,22 @@

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
