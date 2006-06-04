Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750969AbWFDSu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWFDSu3 (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 14:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWFDSu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 14:50:29 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:59598 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750957AbWFDSu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 14:50:28 -0400
Message-ID: <44832A25.30307@comcast.net>
Date: Sun, 04 Jun 2006 14:44:53 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060522)
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Per-architecture randomization
References: <44825E42.5090902@comcast.net>
In-Reply-To: <44825E42.5090902@comcast.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1C1543A70EA0FDBA654BA1F5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1C1543A70EA0FDBA654BA1F5
Content-Type: multipart/mixed;
 boundary="------------070901050505070503020309"

This is a multi-part message in MIME format.
--------------070901050505070503020309
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Alright, trying again.  This patch is a bit smaller, easier to read,
more streamline.  randomize_stack_top() had code pulled out and put into
a static inline just before it; and the mmap() randomization
calculations are in fs/exec.c now. arch_align_stack() should also work
on stack-grows-up architectures like HPPA, not that it'll be used there
right now.


I am considering the following changes:

 - Base randomization on ranges, as suggested by Arjan van de Ven.  That
supersets current functionality, and we can implement entropy in bits
abstractly anyway (i.e. range =3D PAGE_SIZE * powr(2,ENTROPY_IN_BITS)).

 - Remove validation like 'if (random_bits > MAX_RANDOM_STACK_BITS)'.
These are not immediately useful; if SELinux hooks are added or such,
they would be, but they could also be added into the SELinux code for
those policy elements anyway.

 - Remove /*XXX: Put SELinux hooks here*/ comments.  This isn't hard to
figure out, anyone who wants to add SELinux hooks can figure this out the=
n.

So before doing that, here's the current version.  Again, this has not
yet been compile tested, it's just scribbled out on paper.

Questions?  Comments?  Flames?  Pictures of your girlfriends?

--=20
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension

--------------070901050505070503020309
Content-Type: text/x-patch;
 name="patch-2.6.16.16-rand_perarch-v2.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="patch-2.6.16.16-rand_perarch-v2.diff"

diff -urNp linux-2.6.16.16/Documentation/aslr.txt linux-2.6.16.16-randpar=
am/Documentation/aslr.txt
--- linux-2.6.16.16/Documentation/aslr.txt	1969-12-31 19:00:00.000000000 =
-0500
+++ linux-2.6.16.16-randparam/Documentation/aslr.txt	2006-06-04 14:35:15.=
000000000 -0400
@@ -0,0 +1,111 @@
+Address space layout randomization is randomly selecting the base
+offsets of segments of memory in VMA.  It is used as a security tool
+to prevent sensitive attacks from being carried out by making important
+parameters to those attacks volatile and non-discoverable.
+
+Linux currently employs address space randomization in two places:
+
+1.  mmap() base
+ The base offset of libraries and anonymous mappings.  Randomization is
+ currently taken to the following degrees by default:
+
+  32-bit:  i386
+   Over 1MiB of VMA, giving 8 bits of entropy for 4096 byte pages.
+  64-bit:  x86-64
+   Over 1TiB of VMA, giving 28 bits of entropy for 4096 byte pages.
+
+ The maximum is over an area the size of TASK_SIZE / 12
+2.  stack base
+ The base offset of the stack.  Randomization is currently taken to the
+ following degrees by default:
+
+  32-bit:  i386
+   Over 8MiB of VMA, giving 19 bits of entropy, aligned to 16 bytes.
+  64-bit:  x86-64
+   Over 1TiB of VMA, giving 28 bits of entropy, aligned to 16 bytes.
+
+ The maximum allowed is over an area the size of TASK_SIZE / 12
+
+Linux does not employ heap randomization.
+
+Randomization is applied in the following places.
+
+
+STACK RANDOMIZATION
+
+fs/exec.c
+unsigned long arch_align_stack(unsigned long sp)
+
+ This function is called during process initialization to shuffle the
+ stack pointer to sub-page granularity.  It applies a portion of the
+ stack entropy.
+
+ This function calculates how much randomization to apply in the
+ following way:
+
+  - Divide PAGE_SIZE by STACK_ALIGN
+  - Take the long_log2() of that to get MAX_RANDOM_STACK_BITS_PER_PAGE
+  + If MAX_RANDOM_STACK_BITS_PER_PAGE > total bits of entropy
+   - page_random_bits =3D total bits of entropy
+  + If MAX_RANDOM_STACK_BITS_PER_PAGE <=3D total bits of entropy
+   - page_random_bits =3D MAX_RANDOM_STACK_BITS_PER_PAGE
+  - Raise 2^page_random_bits to get random_places
+  - Divide PAGE_SIZE by random_places to get random_interval
+  - (get_random_int() % random_places) * random_interval =3D offset
+  + If stack grows down
+   - Subtract offset from the stack pointer
+  + If stack grows up
+   - Add offset to the stack pointer
+
+
+fs/binfmt_elf.c
+static unsigned long randomize_stack_top(unsigned long stack_top)
+
+ This function is called during process initialization to shuffle the
+ stack pointer to page granularity.  It applies a portion of the stack
+ entropy.
+
+ This function gets the number of possible states, i.e. positions the
+ stack can be in, and choses a random number in that range.  It then
+ multiplies the result by PAGE_SIZE to get the stack offset.
+
+
+fs/binfmt_elf.c
+static inline unsigned long randomize_stack_top_states()
+
+ This function is used by randomize_stack_top() to get how many
+ states stack randomization supplies.
+
+ This function calculates how much randomization to apply in the
+ following way:
+
+  - Divide PAGE_SIZE by STACK_ALIGN
+  - Take the long_log2() of that to get MAX_RANDOM_STACK_BITS_PER_PAGE
+  + If MAX_RANDOM_STACK_BITS_PER_PAGE > total bits of entropy
+   - vma_random_bits =3D 0
+  + If MAX_RANDOM_STACK_BITS_PER_PAGE <=3D total bits of entropy
+   - vma_random_bits =3D
+               total bits entropy - MAX_RANDOM_STACK_BITS_PER_PAGE
+  - Multiply PAGE_SIZE by 2^random_bits to get random_range
+  - random_variable =3D get_random_int() % random_range
+  - Offset stack in VMA by random_variable and PAGE_ALIGN() result
+
+
+MMAP RANDOMIZATION
+
+fs/exec.c
+unsigned long mmap_base_random_factor()
+
+ This function is called during process initialization to shuffle the
+ mmap() baser to page granularity.  It applies full mmap() entropy.
+
+Also note the following:
+
+ - STACK_ALIGN is defined in include/asm-*/processor.h
+ - include/linux/mm.h defines STACK_ALIGN as PAGE_SIZE if it is not
+   defined
+ - ARCH_RANDOM_STACK_BITS and MMAP_RANDOM_STACK_BITS are defined in
+   include/arch-*/processor.h
+ - ARCH_RANDOM_STACK_BITS and MMAP_RANDOM_STACK_BITS are defined as
+   0 in include/linux/mm.h if not otherwise defined
+
diff -urNp linux-2.6.16.16/arch/i386/kernel/process.c linux-2.6.16.16-ran=
dparam/arch/i386/kernel/process.c
--- linux-2.6.16.16/arch/i386/kernel/process.c	2006-05-10 21:56:24.000000=
000 -0400
+++ linux-2.6.16.16-randparam/arch/i386/kernel/process.c	2006-05-21 03:23=
:40.000000000 -0400
@@ -905,9 +905,3 @@ asmlinkage int sys_get_thread_area(struc
 	return 0;
 }
=20
-unsigned long arch_align_stack(unsigned long sp)
-{
-	if (randomize_va_space)
-		sp -=3D get_random_int() % 8192;
-	return sp & ~0xf;
-}
diff -urNp linux-2.6.16.16/arch/i386/mm/mmap.c linux-2.6.16.16-randparam/=
arch/i386/mm/mmap.c
--- linux-2.6.16.16/arch/i386/mm/mmap.c	2006-05-10 21:56:24.000000000 -04=
00
+++ linux-2.6.16.16-randparam/arch/i386/mm/mmap.c	2006-06-04 13:11:17.000=
000000 -0400
@@ -41,8 +41,7 @@ static inline unsigned long mmap_base(st
 	unsigned long gap =3D current->signal->rlim[RLIMIT_STACK].rlim_cur;
 	unsigned long random_factor =3D 0;
=20
-	if (current->flags & PF_RANDOMIZE)
-		random_factor =3D get_random_int() % (1024*1024);
+	random_factor =3D mmap_base_random_factor();
=20
 	if (gap < MIN_GAP)
 		gap =3D MIN_GAP;
diff -urNp linux-2.6.16.16/arch/um/kernel/process_kern.c linux-2.6.16.16-=
randparam/arch/um/kernel/process_kern.c
--- linux-2.6.16.16/arch/um/kernel/process_kern.c	2006-05-10 21:56:24.000=
000000 -0400
+++ linux-2.6.16.16-randparam/arch/um/kernel/process_kern.c	2006-05-21 03=
:24:19.000000000 -0400
@@ -454,18 +454,3 @@ int singlestepping(void * t)
 	return 2;
 }
=20
-/*
- * Only x86 and x86_64 have an arch_align_stack().
- * All other arches have "#define arch_align_stack(x) (x)"
- * in their asm/system.h
- * As this is included in UML from asm-um/system-generic.h,
- * we can use it to behave as the subarch does.
- */
-#ifndef arch_align_stack
-unsigned long arch_align_stack(unsigned long sp)
-{
-	if (randomize_va_space)
-		sp -=3D get_random_int() % 8192;
-	return sp & ~0xf;
-}
-#endif
diff -urNp linux-2.6.16.16/arch/x86_64/ia32/mmap32.c linux-2.6.16.16-rand=
param/arch/x86_64/ia32/mmap32.c
--- linux-2.6.16.16/arch/x86_64/ia32/mmap32.c	2006-05-10 21:56:24.0000000=
00 -0400
+++ linux-2.6.16.16-randparam/arch/x86_64/ia32/mmap32.c	2006-06-04 13:14:=
12.000000000 -0400
@@ -43,8 +43,7 @@ static inline unsigned long mmap_base(st
 	unsigned long gap =3D current->signal->rlim[RLIMIT_STACK].rlim_cur;
 	unsigned long random_factor =3D 0;
=20
-	if (current->flags & PF_RANDOMIZE)
-		random_factor =3D get_random_int() % (1024*1024);
+	random_factor =3D mmap_base_random_factor();
=20
 	if (gap < MIN_GAP)
 		gap =3D MIN_GAP;
diff -urNp linux-2.6.16.16/arch/x86_64/kernel/process.c linux-2.6.16.16-r=
andparam/arch/x86_64/kernel/process.c
--- linux-2.6.16.16/arch/x86_64/kernel/process.c	2006-05-10 21:56:24.0000=
00000 -0400
+++ linux-2.6.16.16-randparam/arch/x86_64/kernel/process.c	2006-05-21 03:=
24:06.000000000 -0400
@@ -839,9 +839,3 @@ int dump_task_regs(struct task_struct *t
 	return 1;
 }
=20
-unsigned long arch_align_stack(unsigned long sp)
-{
-	if (randomize_va_space)
-		sp -=3D get_random_int() % 8192;
-	return sp & ~0xf;
-}
diff -urNp linux-2.6.16.16/arch/x86_64/mm/mmap.c linux-2.6.16.16-randpara=
m/arch/x86_64/mm/mmap.c
--- linux-2.6.16.16/arch/x86_64/mm/mmap.c	2006-05-10 21:56:24.000000000 -=
0400
+++ linux-2.6.16.16-randparam/arch/x86_64/mm/mmap.c	2006-06-04 13:17:49.0=
00000000 -0400
@@ -15,14 +15,14 @@ void arch_pick_mmap_layout(struct mm_str
 	if (current_thread_info()->flags & _TIF_IA32)
 		return ia32_pick_mmap_layout(mm);
 #endif
+
 	mm->mmap_base =3D TASK_UNMAPPED_BASE;
+=09
 	if (current->flags & PF_RANDOMIZE) {
-		/* Add 28bit randomness which is about 40bits of address space
-		   because mmap base has to be page aligned.
- 		   or ~1/128 of the total user VM
-	   	   (total user address space is 47bits) */
-		unsigned rnd =3D get_random_int() & 0xfffffff;
-		mm->mmap_base +=3D ((unsigned long)rnd) << PAGE_SHIFT;
+		unsigned long random_factor =3D 0;
+		/* Add our randomness. */
+		random_factor =3D mmap_base_random_factor();
+		mm->mmap_base +=3D random_factor;
 	}
 	mm->get_unmapped_area =3D arch_get_unmapped_area;
 	mm->unmap_area =3D arch_unmap_area;
diff -urNp linux-2.6.16.16/fs/binfmt_elf.c linux-2.6.16.16-randparam/fs/b=
infmt_elf.c
--- linux-2.6.16.16/fs/binfmt_elf.c	2006-05-10 21:56:24.000000000 -0400
+++ linux-2.6.16.16-randparam/fs/binfmt_elf.c	2006-06-04 14:36:21.0000000=
00 -0400
@@ -500,13 +500,42 @@ out:
 #define INTERPRETER_AOUT 1
 #define INTERPRETER_ELF 2
=20
+/* number of states accounted for by the stack, i.e.
+ * the number of random positions it can be in.
+ * Currently we find this via bits of entropy. */
+static inline unsigned long randomize_stack_top_states() {
+	long vma_random_bits =3D 0;
+	long random_bits =3D ARCH_RANDOM_STACK_BITS;
+
+	/* XXX: Place a hook here to adjust stack randomization;
+	 * this hook will change the value of random_bits */
+
+	if (random_bits > MAX_RANDOM_STACK_BITS)
+		random_bits =3D MAX_RANDOM_STACK_BITS;
+
+	/* Cut the bits in the sub-page randomization out */
+	if (random_bits <=3D MAX_RANDOM_STACK_BITS_PER_PAGE)
+		vma_random_bits =3D 0;
+	else
+		vma_random_bits =3D random_bits
+		       	- MAX_RANDOM_STACK_BITS_PER_PAGE;
+
+	/* 2^vma_random_bits */
+	return (1 << vma_random_bits);
+}
=20
 static unsigned long randomize_stack_top(unsigned long stack_top)
 {
 	unsigned int random_variable =3D 0;
=20
-	if (current->flags & PF_RANDOMIZE)
-		random_variable =3D get_random_int() % (8*1024*1024);
+	/*Randomization
+	 * Pick from 0 to how many states there are and multiply
+	 * PAGE_SIZE to get an aligned random stack base.
+	 */
+	if (current->flags & PF_RANDOMIZE) {
+		random_variable =3D get_random_int() % (randomize_stack_top_states());=

+		random_variable *=3D PAGE_SIZE;
+	}
 #ifdef CONFIG_STACK_GROWSUP
 	return PAGE_ALIGN(stack_top + random_variable);
 #else
diff -urNp linux-2.6.16.16/fs/exec.c linux-2.6.16.16-randparam/fs/exec.c
--- linux-2.6.16.16/fs/exec.c	2006-05-10 21:56:24.000000000 -0400
+++ linux-2.6.16.16-randparam/fs/exec.c	2006-06-04 14:38:23.000000000 -04=
00
@@ -49,6 +49,7 @@
 #include <linux/rmap.h>
 #include <linux/acct.h>
 #include <linux/cn_proc.h>
+#include <linux/random.h>
=20
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1526,3 +1527,69 @@ fail_unlock:
 fail:
 	return retval;
 }
+
+/*
+ * This arch_align_stack() is universal and should work across all
+ * architectures.  Most architectures still have a
+ * '#define arch_align_stack(x) (x)' somewhere anyway.
+ */
+#ifndef arch_align_stack
+unsigned long arch_align_stack(unsigned long sp)
+{
+	long page_random_bits =3D 0;
+	unsigned long random_factor =3D 0;
+	long random_bits =3D ARCH_RANDOM_STACK_BITS;
+
+	if (randomize_va_space && (page_random_bits > 0)) {
+		/*XXX: Place a hook here to adjust stack randomization;
+		 * this hook will change the value of random_bits */
+
+		/*What's the most randomness we can get in the page*/
+		page_random_bits =3D MAX_RANDOM_STACK_BITS_PER_PAGE;
+
+		/*Are we using less entropy than that?*/
+		if (page_random_bits > random_bits)
+			page_random_bits =3D random_bits;
+
+		/*
+		 * The stack is shifted around within PAGE_SIZE in
+		 * intervals of STACK_ALIGN bytes.  Intervals may be
+		 * bigger than STACK_ALIGN if entropy is less than
+		 * MAX_RANDOM_STACK_BITS_PER_PAGE.
+		 *
+		 * The position of the stack in VMA is set in binfmt_elf.c
+		 *
+		 * We can have (1 << page_random_bits) positions,
+		 * aligned to PAGE_SIZE / (1 << page_random_bits)
+		 */
+		random_factor =3D (get_random_int() % (1 << page_random_bits))
+			* (PAGE_SIZE / (1 << page_random_bits));
+#ifdef CONFIG_STACK_GROWSUP
+		sp +=3D random_factor;
+#else
+		sp -=3D random_factor;
+#endif
+	}
+	return sp; /*Should already be aligned*/
+}
+#endif
+
+/* Produce a random shift for mmap() base
+ * The output of this function should always be page aligned*/
+unsigned long mmap_base_random_factor() {
+	unsigned long random_factor =3D 0;
+	unsigned long random_bits =3D ARCH_RANDOM_MMAP_BITS;
+
+	/*XXX:  Place a hook here to adjust mmap() randomization;
+	 * this hook will change the value of random_bits */
+
+	if (random_bits > MAX_RANDOM_MMAP_BITS)
+		random_bits =3D MAX_RANDOM_MMAP_BITS;
+
+	/* randomize in range 2^random_bits * PAGE_SIZE */
+	if (current->flags & PF_RANDOMIZE)
+		random_factor =3D get_random_int() % (1 << random_bits);
+	random_factor *=3D PAGE_SIZE;
+
+	return PAGE_ALIGN(random_factor);
+}
diff -urNp linux-2.6.16.16/include/asm-i386/processor.h linux-2.6.16.16-r=
andparam/include/asm-i386/processor.h
--- linux-2.6.16.16/include/asm-i386/processor.h	2006-05-10 21:56:24.0000=
00000 -0400
+++ linux-2.6.16.16-randparam/include/asm-i386/processor.h	2006-06-03 23:=
09:26.000000000 -0400
@@ -320,6 +320,13 @@ extern int bootloader_type;
  */
 #define TASK_SIZE	(PAGE_OFFSET)
=20
+/*Interval in bytes to align the stack to*/
+#define STACK_ALIGN	16
+
+/*Random bits of stack and mmap()*/
+#define ARCH_RANDOM_STACK_BITS	19
+#define ARCH_RANDOM_MMAP_BITS	8
+
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
diff -urNp linux-2.6.16.16/include/asm-x86_64/processor.h linux-2.6.16.16=
-randparam/include/asm-x86_64/processor.h
--- linux-2.6.16.16/include/asm-x86_64/processor.h	2006-05-10 21:56:24.00=
0000000 -0400
+++ linux-2.6.16.16-randparam/include/asm-x86_64/processor.h	2006-06-03 2=
3:56:22.000000000 -0400
@@ -172,6 +172,23 @@ static inline void clear_in_cr4 (unsigne
 #define TASK_SIZE 		(test_thread_flag(TIF_IA32) ? IA32_PAGE_OFFSET : TAS=
K_SIZE64)
 #define TASK_SIZE_OF(child) 	((test_tsk_thread_flag(child, TIF_IA32)) ? =
IA32_PAGE_OFFSET : TASK_SIZE64)
=20
+/*Interval in bytes to align the stack to*/
+#define STACK_ALIGN	16
+
+/*Random bits of stack and mmap() in IA-32*/
+#define IA32_ARCH_RANDOM_STACK_BITS	19
+#define IA32_ARCH_RANDOM_MMAP_BITS	8
+
+/* Random bits of stack and mmap() in 64-bit mode.
+ * 28 bits is 40 bits of VMA, which is 1TiB, roughly 1/128
+ * of the address space. */
+#define ARCH_RANDOM_STACK_BITS64	28
+#define ARCH_RANDOM_MMAP_BITS64		28
+
+/*Random bits of stack and mmap()*/
+#define ARCH_RANDOM_STACK_BITS  (test_thread_flag(TIF_IA32) ? IA32_ARCH_=
RANDOM_STACK_BITS : ARCH_RANDOM_STACK_BITS64)
+#define ARCH_RANDOM_MMAP_BITS   (test_thread_flag(TIF_IA32) ? IA32_ARCH_=
RANDOM_MMAP_BITS : ARCH_RANDOM_MMAP_BITS64)
+
 #define TASK_UNMAPPED_BASE	PAGE_ALIGN(TASK_SIZE/3)
=20
 /*
diff -urNp linux-2.6.16.16/include/linux/mm.h linux-2.6.16.16-randparam/i=
nclude/linux/mm.h
--- linux-2.6.16.16/include/linux/mm.h	2006-05-10 21:56:24.000000000 -040=
0
+++ linux-2.6.16.16-randparam/include/linux/mm.h	2006-06-04 13:11:09.0000=
00000 -0400
@@ -23,6 +23,44 @@ struct anon_vma;
 extern unsigned long max_mapnr;
 #endif
=20
+/* Any arch not defining this is assumed to not know of
+ * sub-page stack alignment.
+ * Be sure to define these for each arch in
+ * include/asm-arch/processor.h */
+#ifndef STACK_ALIGN
+# define STACK_ALIGN	PAGE_SIZE
+#endif
+
+/* If these are not defined, disable randomization.
+ * Be sure to define these for each arch in
+ * include/asm-arch/processor.h */
+#ifndef ARCH_RANDOM_STACK_BITS
+# define ARCH_RANDOM_STACK_BITS	0
+#endif
+#ifndef ARCH_RANDOM_MMAP_BITS
+# define ARCH_RANDOM_MMAP_BITS	0
+#endif
+
+/*
+ * These are the biggest entropies we can have.
+ * Our original MAX_RANDOM_STACK_BITS was as below:
+ * 	long_log2((PAGE_SIZE / STACK_ALIGN) * (TASK_SIZE / 12) / PAGE_SIZE)
+ * This simplifies algebraicly to the below:
+ *   long_log2(TASK_SIZE / (12 * STACK_ALIGN))
+ *
+ * At most we should shift by 1/12 TASK_SIZE.  This is 256M on
+ * 3GiB i386; 85M (64M, 14 bits) on 1GiB i386; 8TiB (31 bits)
+ * on x86-64 with 47 bits of user VMA...
+ */
+#define MAX_RANDOM_STACK_BITS \
+	long_log2(TASK_SIZE / (12 * STACK_ALIGN))
+#define MAX_RANDOM_STACK_BITS_PER_PAGE \
+	long_log2(PAGE_SIZE / STACK_ALIGN)
+#define MAX_RANDOM_MMAP_BITS \
+	long_log2((TASK_SIZE / 12) / PAGE_SIZE)
+
+unsigned long mmap_base_random_factor();
+
 extern unsigned long num_physpages;
 extern void * high_memory;
 extern unsigned long vmalloc_earlyreserve;

--------------070901050505070503020309--

--------------enig1C1543A70EA0FDBA654BA1F5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRIMqJQs1xW0HCTEFAQJTZw/+Pv79778wKW9p0vbGOEZgNmq5v+mcW8eO
1KzoMg60N7/MnPm+HXcHQLo/UmXMljjl/O13WSe/tM5lPjJ3Vgjm6Fz6pBQKvq+I
Urla5edCAuJhnscpfVhK2TE/zbjsW/27gS27A9UGA3d7nJRmgR7gzMTHSVL/6M6X
Ajett5fp/yE1lvBwI+ApUnxUlsPVI96utpLx4CBdgITwO5vmLHyEnNuoAE6tccr1
iwfUs7d7OjaYgF1pPzc6BKO6i2/2hbH79tCRhdVwIplViIu9oDklkgeqBhAfQqQU
uMTzJLP/I6Lvi54wEHphseqL+xNG77+69RUjTkkXTi6CN+9OrbnvCQV22siRehMO
gNniNvHrjYH+kcM3tQXC+R9h8GO+Ji+noEju6rx/OsnpDzmZ3NxPC/I48UG7X4Ib
pKhOZY2j5xyKGbB57v1V8RO0KPmUcuam/Sc0i6xd5DUXqbM5uzYtUqE58zoUX+cB
vrmhB9cz8tHpfCWXxj3AHB8B1Ca26B3+adYOJiKbq3be2k9Abzb0vxXGSuyM4UP5
MUzH7T1xThtGTjtT1SFdxXgtf1B4q+pQwDSqDdKweTnrMSUK1pJcqgIp4/mLWh8B
27ugM8M3nGgTP0J7BVi6PoH4HaLOnWuGuIRmQKxJ588Cu0wFOd0brwEegAUu/sCS
xFHN+3E04+c=
=QbcN
-----END PGP SIGNATURE-----

--------------enig1C1543A70EA0FDBA654BA1F5--
