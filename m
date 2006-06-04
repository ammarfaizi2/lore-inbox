Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWFDEUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWFDEUf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jun 2006 00:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWFDEUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 00:20:35 -0400
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:45975 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932108AbWFDEUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 00:20:34 -0400
Message-ID: <44825E42.5090902@comcast.net>
Date: Sun, 04 Jun 2006 00:14:58 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060522)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC] Per-architecture randomization
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB423EF80CDA8FC663999BDD2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB423EF80CDA8FC663999BDD2
Content-Type: multipart/mixed;
 boundary="------------000206090105090003060902"

This is a multi-part message in MIME format.
--------------000206090105090003060902
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Pavel Machek recommended per-architecture randomization defaults when I
poked a (very hackish) patch up here.  As follow-up, I have taken out
the command line parameter code and used the infrastructure I wrote to
implement per-architecture randomization settings.

Three #defines are needed per architecture, preferably in
include/asm-ARCH/processor.h or equivalent.  These defines are as follows=
:

 STACK_ALIGN -- Alignment of the stack, typically 16 (bytes).
    If not defined, stack randomization is carried out to page
    granularity
 ARCH_RANDOM_STACK_BITS -- Bits of entropy to apply to the stack.
    If not defined, stack randomization is disabled by defining this
    as 0.
 ARCH_RANDOM_MMAP_BITS -- Bits of entropy to apply to the mmap() base.
    If not defined, mmap() randomization is disabled by defining this
    as 0.

I have added these for each of i386 and x86-64.  In the case of x86-64,
the last two are complex ones similar to how TASK_SIZE is done.  Other
architectures need these defines, and I am certain I disabled
randomization everywhere else doing this; but as far as I can tell, the
code only was randomizing the stack at page-granularity anyway
everywhere else, since there were no randomized mmap_base() or
arch_align_stack() functions.

My arch_align_stack(), now in fs/exec.c, should be portable to all
platforms now.  Assuming my code works as intended, it's safe to enable
this on non-randomized archs; STACK_ALIGN will be PAGE_SIZE and so
arch_align_stack() effectively becomes an expensive NOP.  This also
happens if ARCH_RANDOM_STACK_BITS is 0.

This code probably makes it possible to collapse mmap_base() in
arch/x86_64/ia32/mmap32.c into arch_pick_mmap_layout() in
arch/x86_64/mm/mmap.c; as far as I can tell, there are 2 functions
because one applies 28 bits of entropy and one applies 8.  This patch
defines ARCH_RANDOM_MMAP_BITS as being based on the task type (32 or 64
bit), so the same function can complete the same randomization (I think..=
=2E).

As before, this code makes it possible to insert hooks at a few key
points to control mmap() and stack entropy per-execution.  This could
later be added as SELinux policy controls if anyone is interested in
doing so.

This patch was coded very at-face and defines too many variables that
are used once in a couple functions.  I can probably rewrite those
sections to do the calculation steps in the same variable, and just note
what it's doing in comments.

This has yet to be compile-tested.

Questions?  Comments?  Flames?

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

--------------000206090105090003060902
Content-Type: text/x-patch;
 name="patch-2.6.16.16-rand_perarch-v1.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="patch-2.6.16.16-rand_perarch-v1.diff"

diff -urNp linux-2.6.16.16/Documentation/aslr.txt linux-2.6.16.16-randpar=
am/Documentation/aslr.txt
--- linux-2.6.16.16/Documentation/aslr.txt	1969-12-31 19:00:00.000000000 =
-0500
+++ linux-2.6.16.16-randparam/Documentation/aslr.txt	2006-06-03 23:56:50.=
000000000 -0400
@@ -0,0 +1,119 @@
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
+  - Subtract offset from the stack pointer
+
+
+fs/binfmt_elf.c
+static unsigned long randomize_stack_top(unsigned long stack_top)
+
+ This function is called during process initialization to shuffle the
+ stack pointer to page granularity.  It applies a portion of the stack
+ entropy.
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
+arch/i386/mm/mmap.c
+static inline unsigned long mmap_base(struct mm_struct *mm)
+
+ This function is called during process initialization to shuffle the
+ mmap() baser to page granularity.  It applies full mmap() entropy.
+
+ This function is for i386 architectures.
+
+
+arch/x86_64/mm/mmap.c
+void arch_pick_mmap_layout(struct mm_struct *mm)
+
+ This function is called during process initialization to shuffle the
+ mmap() baser to page granularity.  It applies full mmap() entropy.
+ For IA-32 emulation it will call an IA-32 function.
+
+ This function is for x86-64 architectures.
+
+
+arch/x86_64/ia32/mmap32.c
+static inline unsigned long mmap_base(struct mm_struct *mm)
+
+
+ This function is called during process initialization to shuffle the
+ mmap() baser to page granularity.  It applies full mmap() entropy.
+
+ This function is for i386 architecture processes on x86-64.
+
+Also note the following:
+
+ - STACK_ALIGN is defined in include/arch-*/processor.h
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
+++ linux-2.6.16.16-randparam/arch/i386/mm/mmap.c	2006-06-03 23:40:38.000=
000000 -0400
@@ -40,9 +40,30 @@ static inline unsigned long mmap_base(st
 {
 	unsigned long gap =3D current->signal->rlim[RLIMIT_STACK].rlim_cur;
 	unsigned long random_factor =3D 0;
+	long max_random_bits;
+	unsigned long random_bits;
=20
-	if (current->flags & PF_RANDOMIZE)
-		random_factor =3D get_random_int() % (1024*1024);
+	random_bits =3D ARCH_RANDOM_MMAP_BITS;
+
+	/*XXX:  Place a hook here to adjust mmap() randomization;
+	 * this hook will change the value of random_bits */
+
+	/*
+	 * At most we should shift by 1/12 TASK_SIZE.  This is 256M on
+	 * 3GiB i386; 85M (64M, 14 bits) on 1GiB i386; 8TiB (31 bits)
+	 * on x86-64 with 47 bits of user VMA...
+	 */
+	max_random_bits =3D MAX_RANDOM_MMAP_BITS;
+	if (max_random_bits < random_bits)
+		random_bits =3D max_random_bits;
+
+	/*
+	 * PAGE_SIZE is 4096 usually.  mmap_random_bits means random bits
+	 * of entropy, not how long the range is.  If pages are suddenly
+	 * bigger some day, we're still randomizing this much....
+	 */
+	if (current->flags & PF_RANDOMIZE && (mmap_random_bits > 0))
+		random_factor =3D get_random_int() % (PAGE_SIZE << random_bits);
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
+++ linux-2.6.16.16-randparam/arch/x86_64/ia32/mmap32.c	2006-06-03 23:41:=
56.000000000 -0400
@@ -42,9 +42,30 @@ static inline unsigned long mmap_base(st
 {
 	unsigned long gap =3D current->signal->rlim[RLIMIT_STACK].rlim_cur;
 	unsigned long random_factor =3D 0;
+	long max_random_bits;
+	unsigned long random_bits;
=20
-	if (current->flags & PF_RANDOMIZE)
-		random_factor =3D get_random_int() % (1024*1024);
+	random_bits =3D ARCH_RANDOM_MMAP_BITS;
+
+	/*XXX:  Place a hook here to adjust mmap() randomization;
+	 * this hook will change the value of random_bits */
+
+	/*
+	 * At most we should shift by 1/12 TASK_SIZE.  This is 256M on
+	 * 3GiB i386; 85M (64M, 14 bits) on 1GiB i386; 8TiB (31 bits)
+	 * on x86-64 with 47 of user VMA...
+	 */
+	max_random_bits =3D MAX_RANDOM_MMAP_BITS;
+	if (max_random_bits < random_bits)
+		random_bits =3D max_random_bits;
+
+	/*
+	 * PAGE_SIZE is 4096 usually.  mmap_random_bits means random bits
+	 * of entropy, not how long the range is.  If pages are suddenly
+	 * bigger some day, we're still randomizing this much....
+	 */
+	if (current->flags & PF_RANDOMIZE && (mmap_random_bits > 0))
+		random_factor =3D get_random_int() % (PAGE_SIZE << random_bits);
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
+++ linux-2.6.16.16-randparam/arch/x86_64/mm/mmap.c	2006-06-03 23:42:44.0=
00000000 -0400
@@ -11,17 +11,44 @@
=20
 void arch_pick_mmap_layout(struct mm_struct *mm)
 {
+	unsigned long random_factor =3D 0;
+	long max_random_bits;
+	unsigned long random_bits;
+
 #ifdef CONFIG_IA32_EMULATION
 	if (current_thread_info()->flags & _TIF_IA32)
 		return ia32_pick_mmap_layout(mm);
 #endif
+
 	mm->mmap_base =3D TASK_UNMAPPED_BASE;
+=09
+	/*XXX:  I *think* this is right, but really I have no fucking
+	 * clue what I'm doing when we get around to 'rnd =3D'
+	 */
 	if (current->flags & PF_RANDOMIZE) {
-		/* Add 28bit randomness which is about 40bits of address space
+		unsigned rnd;
+		random_bits =3D ARCH_RANDOM_MMAP_BITS;
+
+		/*XXX:  Place a hook here to adjust mmap()
+		 * randomization; this hook will change the value of
+		 *  random_bits */
+
+		/*
+		 * At most we should shift by 1/12 TASK_SIZE.  This
+		 * is 256M on 3GiB i386; 85M (64M, 14 bits) on 1GiB
+		 * i386; 8TiB (31 bits) on x86-64 with 47 bits of user
+		 *  VMA...
+		 */
+		max_random_bits =3D MAX_RANDOM_MMAP_BITS;
+		if (max_random_bits < random_bits)
+			random_bits =3D max_random_bits;
+
+		/* Add our randomness.
+		   28 bits of randomness is about 40bits of address space
 		   because mmap base has to be page aligned.
  		   or ~1/128 of the total user VM
 	   	   (total user address space is 47bits) */
-		unsigned rnd =3D get_random_int() & 0xfffffff;
+		rnd =3D get_random_int() % (1 << random_bits);
 		mm->mmap_base +=3D ((unsigned long)rnd) << PAGE_SHIFT;
 	}
 	mm->get_unmapped_area =3D arch_get_unmapped_area;
diff -urNp linux-2.6.16.16/fs/binfmt_elf.c linux-2.6.16.16-randparam/fs/b=
infmt_elf.c
--- linux-2.6.16.16/fs/binfmt_elf.c	2006-05-10 21:56:24.000000000 -0400
+++ linux-2.6.16.16-randparam/fs/binfmt_elf.c	2006-06-03 23:14:33.0000000=
00 -0400
@@ -504,9 +504,49 @@ out:
 static unsigned long randomize_stack_top(unsigned long stack_top)
 {
 	unsigned int random_variable =3D 0;
+	unsigned int random_range =3D 0;
+	int page_random_bits =3D 0;
+	int vma_random_bits =3D 0;
+	long random_bits =3D 0;
+	long max_random_bits =3D 0;
=20
-	if (current->flags & PF_RANDOMIZE)
-		random_variable =3D get_random_int() % (8*1024*1024);
+	random_bits =3D ARCH_RANDOM_STACK_BITS;
+=09
+	/*XXX:  Place a hook here to adjust stack randomization;
+	 * this hook will change the value of random_bits */
+
+	/*
+	 * At most we should shift by 1/12 TASK_SIZE.  This is 256M on
+	 * 3GiB i386; 85M (64M, 14 bits) on 1GiB i386; 8TiB (31 bits)
+	 * on x86-64 with 47 bits of user VMA...
+	 */
+	max_random_bits =3D MAX_RANDOM_STACK_BITS;
+
+	if (max_random_bits < random_bits)
+		random_bits =3D max_random_bits;
+
+	/*
+	 * The code below relies on MAX_RANDOM_STACK_BITS_PER_PAGE,
+	 * which relies on STACK_ALIGN.  On architectures without
+	 * sub-page alignment, we're aligned to page boundaries.
+	 */
+	/*Cut the bits in the sub-page randomization out*/
+	page_random_bits =3D MAX_RANDOM_STACK_BITS_PER_PAGE;
+	if (random_bits <=3D page_random_bits)
+		vma_random_bits =3D 0;
+	else
+		vma_random_bits =3D random_bits - page_random_bits;
+
+	/*
+	 * Randomization happens here if doing more bits of entropy than
+	 * handled by sub-page randomization, otherwise look to process.c
+	 * only; the other bits are there.
+	 */
+	if (current->flags & PF_RANDOMIZE && vma_random_bits) {
+		/*Randomize with the bits we have times the page size*/
+		random_range =3D PAGE_SIZE * (1 << vma_random_bits);
+		random_variable =3D get_random_int() % (random_range);
+	}
 #ifdef CONFIG_STACK_GROWSUP
 	return PAGE_ALIGN(stack_top + random_variable);
 #else
diff -urNp linux-2.6.16.16/fs/exec.c linux-2.6.16.16-randparam/fs/exec.c
--- linux-2.6.16.16/fs/exec.c	2006-05-10 21:56:24.000000000 -0400
+++ linux-2.6.16.16-randparam/fs/exec.c	2006-06-03 23:15:09.000000000 -04=
00
@@ -49,6 +49,7 @@
 #include <linux/rmap.h>
 #include <linux/acct.h>
 #include <linux/cn_proc.h>
+#include <linux/random.h>
=20
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1526,3 +1527,65 @@ fail_unlock:
 fail:
 	return retval;
 }
+
+/*
+ * Only x86 and x86_64 have an arch_align_stack().
+ * All other arches have "#define arch_align_stack(x) (x)"
+ * in their asm/system.h
+ *=20
+ * In the case of UML, this is included from asm-um/system-generic.h;
+ * we can use it to behave as the subarch does.
+ */
+#ifndef arch_align_stack
+unsigned long arch_align_stack(unsigned long sp)
+{
+	unsigned int random_interval =3D 0;
+	unsigned int random_places =3D 0;
+	int page_random_bits =3D 0;
+	long random_bits =3D 0;
+	long max_random_bits =3D 0;
+
+	random_bits =3D ARCH_RANDOM_STACK_BITS;
+
+	/*XXX:  Place a hook here to adjust stack randomization;
+	 * this hook will change the value of random_bits */
+
+	/*
+	 * At most we should shift by 1/12 TASK_SIZE.  This is 256M on
+	 * 3GiB i386; 85M (64M, 14 bits) on 1GiB i386; 8TiB (31 bits)
+	 * on x86-64 with 47 bits of user VMA...
+	 */
+	max_random_bits =3D MAX_RANDOM_STACK_BITS;
+
+	if (random_bits > max_random_bits)
+		random_bits =3D max_random_bits;
+
+	/*What's the most randomness we can get in the page*/
+	page_random_bits =3D MAX_RANDOM_STACK_BITS_PER_PAGE;
+
+	/*Are we using less entropy than that?*/
+	if (page_random_bits > random_bits)
+		page_random_bits =3D random_bits;
+
+	/*
+	 * The stack is shifted around within PAGE_SIZE in intervals of
+	 * 16 bytes.
+	 *
+	 * The position of the stack in VMA is set in binfmt_elf.c
+	 */
+	if (randomize_va_space && (page_random_bits > 0)) {
+		/*Distance we move, typically 16 bytes unless less entropy*/
+		random_interval =3D PAGE_SIZE / (1 << page_random_bits);
+
+		/*How many positions can we have?*/
+		random_places =3D PAGE_SIZE / random_interval;
+
+		/*
+		 * get_random_int() % random_places =3D how many steps we move
+		 * Multiply this by random_interval to get our position.
+		 */
+		sp -=3D (get_random_int() % random_places) * random_interval;
+	}
+	return sp & ~0xf;
+}
+#endif
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
+++ linux-2.6.16.16-randparam/include/linux/mm.h	2006-06-03 23:49:39.0000=
00000 -0400
@@ -23,6 +23,38 @@ struct anon_vma;
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
+ */
+#define MAX_RANDOM_STACK_BITS \
+	long_log2(TASK_SIZE / (12 * STACK_ALIGN))
+#define MAX_RANDOM_STACK_BITS_PER_PAGE \
+	long_log2(PAGE_SIZE / STACK_ALIGN)
+#define MAX_RANDOM_MMAP_BITS \
+	long_log2((TASK_SIZE / 12) / PAGE_SIZE)
+
 extern unsigned long num_physpages;
 extern void * high_memory;
 extern unsigned long vmalloc_earlyreserve;

--------------000206090105090003060902--

--------------enigB423EF80CDA8FC663999BDD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRIJeRgs1xW0HCTEFAQKi+hAAm97naa3JAYYZXVV1FCf+baZ6WRN8ki4w
whrQmAfbDDzOH1xW4TI3wQuZfwzyq+mpkUMOGb35vQ1MUyaJLm+EIQHAyy4n/0Gb
VIchoK85kmlE3Coe1fG1rUYppCljCQhqOGWdZwvCl0R0Mk1kc+9rnBBsPd/MLt5B
xOEyocIBVegJpSjUxgz6uL8AX+47Tn48hyZQOkO0rZ7duiVrC/M/y0NxY0Ai4iID
lghf3XNPoY4rWOHP0iBbJorgpfDxG2kdGY4UXrY27i9icFUoCW7Z58TSZWC5ToAq
nO9+OOy2Qqv26jHGVfSUYp+CFPAS9h17yNzTaVQpqGfO1J/3ZmJCS4B9HZriPkea
XNxtY+4qTfq6OhNYZD52Bj2Zb0LDGjssCAnPGjeuj5RI4C4bpcFkEi0y1ydS8ECf
zbUkPmsjTtGzOTObQyJon1a9OoebEdtWcnv8DvOdjF9AGF3dGHvLOszZKGeIphlZ
sF1ADMrrHleMBTMSRfpQRUxlbMf8an2p8ykIxo6dR8f2CiwxCYIjro5w5A25huIp
hqMAeZ4MeZn9RNDZJ1S4FoukAFv0eiagwoe50m7JVUvcZr6PNj2JZ6p/tmHYePxz
RGhP4l8/1qSULtwglJiGQBBd79xIof7BOkVLgnPhYyHc8K9/b+q23CK1worIcilT
hPPrdw2swjA=
=i/f/
-----END PGP SIGNATURE-----

--------------enigB423EF80CDA8FC663999BDD2--
