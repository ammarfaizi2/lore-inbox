Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbWETBF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWETBF3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 21:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWETBF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 21:05:29 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:26550 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751458AbWETBF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 21:05:28 -0400
Message-ID: <446E6A3B.8060100@comcast.net>
Date: Fri, 19 May 2006 21:00:43 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060518)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.16.16 Parameter-controlled mmap/stack randomization
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8714B00EF5FB7E53383FD04F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8714B00EF5FB7E53383FD04F
Content-Type: multipart/mixed;
 boundary="------------020902070002080108030107"

This is a multi-part message in MIME format.
--------------020902070002080108030107
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Any comments on this one?

I'm trying to control the stack and heap randomization via command-line
parameters.  I wrote this in a 2.6.15 Ubuntu Dapper kernel and then
patched it into a 2.6.16.16 tree and cleaned it up.  It does a few
simple things:

 - mmap_random_bits is used to calculate how many pages to shift the
mmap() base around for; I've tested this with 16 bits.
 - stack_random_bits is used to calculate how to shift the stack around.
 If it's >8, then stack_random_bits - 8 is used to shift the page
alignment of the stack.  if it's >0, then its value (or 8 if it's >8) is
used to calculate the interval on which to align the randomly-placed
stack pointer within the first page.  If it's 0, no randomization happens=
=2E

I boot tested on Dapper and compared paxtest output.  Here are the
results on a stock Dapper 2.6.15 kernel on i386:

Anonymous mapping randomisation test     : 9 bits (guessed)
Shared library randomisation test        : 10 bits (guessed)
Stack randomisation test (SEGMEXEC)      : 19 bits (guessed)
Stack randomisation test (PAGEEXEC)      : 19 bits (guessed)

This tells me mmap() randomization is about 10 bits, i.e. randomized
over 4 megabytes.  This is a bit off... the code says it's really 8
bits, 1024*1024 (1MiB) aligned to a 4096 byte page.  It also tells me
the stack is 19 bits, i.e. randomized inside 8MiB, which is correct.

I did a boot with 'mmap_random_bits=3D16 stack_random_bits=3D22' with MY
version of the kernel, and got the following results:

Anonymous mapping randomisation test     : 17 bits (guessed)
Shared library randomisation test        : 17 bits (guessed)
Stack randomisation test (SEGMEXEC)      : 22 bits (guessed)
Stack randomisation test (PAGEEXEC)      : 22 bits (guessed)

As shown above, the mmap() randomization test (anonmap, shared libs) is
a bit wonky... the stack test is about right.  In any case, it looks
like it worked.

Just to make sure, I rebooted and tried the test again on my kernel
without passing parameters, with the following results:

Anonymous mapping randomisation test     : 8 bits (guessed)
Shared library randomisation test        : 10 bits (guessed)
Stack randomisation test (SEGMEXEC)      : 19 bits (guessed)
Stack randomisation test (PAGEEXEC)      : 19 bits (guessed)

So it looks to work.


There's a few other things I want to get done, but I'll worry about
those later.  They are:

 - Take care of the FIXME in that __init code in fs/exec.c to use
architecture-specific #defines for the maximum values of these
parameters, probably in asm-* somewhere.
 - Add /proc controls to tweak system-wide randomization on new processes=
=2E
 - Add LSM/SELinux hooks to let policy tweak randomization per-binary,
so high-order randomization can be used except for with i.e. Oracle
(which tries to mmap() 2GiB in at once and can thus die from VMA
fragmentation).
 - Figure out exactly what affects what architecture, and which
architectures react differently in terms of randomization; correct the
calculations in these cases, i.e. if the stack can't be randomized
within the page, stack_random_bits should apply to page randomization.
 - Try getting randomization working in other architectures where it's
not right now.  I don't see anything obvious to me that shows i.e. Sparc
having randomization.. but I'm not much of a kernel hacker....
 - Get somebody to get some sort of heap randomization in here, and do
the same deal.  Doesn't Fedora do heap randomization?



In case anyone is wondering, I did this because when this got in I
complained about it not being anywhere near as good as PaX for entropy;
and I got a lot of replies back about how that kind of randomization
fragments VM *and* *breaks* *stuff*.  This raises two questions:

 - PaX never broke anything I have, so why should I stick with something
weaker?
 - On the other hand, if we move to something with that level of entropy
in mainline, some other people who aren't me break.  How do we deal with
this?

The solution is simple:  I'll use this much entropy, you use that much
entropy, and you can even turn it off if you want to.  That's what this
patch does.  If you want more or need less, turn the knobs up and down.


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

--------------020902070002080108030107
Content-Type: text/x-patch;
 name="patch-2.6.16.16-rand_param.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="patch-2.6.16.16-rand_param.diff"

diff -urNp linux-2.6.16.16/arch/i386/kernel/process.c linux-2.6.16.16-ran=
dparam/arch/i386/kernel/process.c
--- linux-2.6.16.16/arch/i386/kernel/process.c	2006-05-10 21:56:24.000000=
000 -0400
+++ linux-2.6.16.16-randparam/arch/i386/kernel/process.c	2006-05-19 23:47=
:09.000000000 -0400
@@ -907,7 +907,30 @@ asmlinkage int sys_get_thread_area(struc
=20
 unsigned long arch_align_stack(unsigned long sp)
 {
-	if (randomize_va_space)
-		sp -=3D get_random_int() % 8192;
+	unsigned int random_interval =3D 0;
+	unsigned int random_places =3D 0;
+	/*
+	 * The stack is shifted around within 4k in intervals of
+	 * 16 bytes.
+	 *
+	 * The position of the stack in VMA is set in binfmt_elf.c
+	 */
+	if (randomize_va_space && (stack_random_bits > 0)) {
+		/*XXX:  Should we tune this for PAGE_SIZE instead of 4096?*/
+		if (stack_random_bits > 8)
+			random_interval =3D 4096 / (1 << 8);
+		else
+			random_interval =3D 4096 / (1 << stack_random_bits);
+
+		/*How many positions can we have?*/
+		random_places =3D 4096 / random_interval;
+
+		/*
+		 * get_random_int() % random_places =3D how many steps we move
+		 * Multiply this by random_interval to get our position.
+		 */
+		sp -=3D (get_random_int() % random_places) * random_interval;
+	}
 	return sp & ~0xf;
 }
+
diff -urNp linux-2.6.16.16/arch/i386/mm/mmap.c linux-2.6.16.16-randparam/=
arch/i386/mm/mmap.c
--- linux-2.6.16.16/arch/i386/mm/mmap.c	2006-05-10 21:56:24.000000000 -04=
00
+++ linux-2.6.16.16-randparam/arch/i386/mm/mmap.c	2006-05-19 23:51:52.000=
000000 -0400
@@ -41,8 +41,12 @@ static inline unsigned long mmap_base(st
 	unsigned long gap =3D current->signal->rlim[RLIMIT_STACK].rlim_cur;
 	unsigned long random_factor =3D 0;
=20
-	if (current->flags & PF_RANDOMIZE)
-		random_factor =3D get_random_int() % (1024*1024);
+	/*
+	 * Our page size is 4096, although we should use PAGE_SIZE
+	 * here instead really.
+	 */
+	if (current->flags & PF_RANDOMIZE && mmap_random_bits)
+		random_factor =3D get_random_int() % (4096 << mmap_random_bits);
=20
 	if (gap < MIN_GAP)
 		gap =3D MIN_GAP;
diff -urNp linux-2.6.16.16/arch/x86_64/kernel/process.c linux-2.6.16.16-r=
andparam/arch/x86_64/kernel/process.c
--- linux-2.6.16.16/arch/x86_64/kernel/process.c	2006-05-10 21:56:24.0000=
00000 -0400
+++ linux-2.6.16.16-randparam/arch/x86_64/kernel/process.c	2006-05-19 23:=
46:50.000000000 -0400
@@ -841,7 +841,30 @@ int dump_task_regs(struct task_struct *t
=20
 unsigned long arch_align_stack(unsigned long sp)
 {
-	if (randomize_va_space)
-		sp -=3D get_random_int() % 8192;
+	unsigned int random_interval =3D 0;
+	unsigned int random_places =3D 0;
+	/*
+	 * The stack is shifted around within 4k in intervals of
+	 * 16 bytes.
+	 *
+	 * The position of the stack in VMA is set in binfmt_elf.c
+	 */
+	if (randomize_va_space && (stack_random_bits > 0)) {
+		/*XXX:  Should we tune this for PAGE_SIZE instead of 4096?*/
+		if (stack_random_bits > 8)
+			random_interval =3D 4096 / (1 << 8);
+		else
+			random_interval =3D 4096 / (1 << stack_random_bits);
+
+		/*How many positions can we have?*/
+		random_places =3D 4096 / random_interval;
+
+		/*
+		 * get_random_int() % random_places =3D how many steps we move
+		 * Multiply this by random_interval to get our position.
+		 */
+		sp -=3D (get_random_int() % random_places) * random_interval;
+	}
 	return sp & ~0xf;
 }
+
diff -urNp linux-2.6.16.16/Documentation/kernel-parameters.txt linux-2.6.=
16.16-randparam/Documentation/kernel-parameters.txt
--- linux-2.6.16.16/Documentation/kernel-parameters.txt	2006-05-10 21:56:=
24.000000000 -0400
+++ linux-2.6.16.16-randparam/Documentation/kernel-parameters.txt	2006-05=
-19 23:39:07.000000000 -0400
@@ -918,6 +918,10 @@ running once the system is up.
 			scheduler performance, so it's only for scheduler
 			development purposes, not production environments.
=20
+	mmap_random_bits=3D
+			Control how much entropy is used for mmap() base
+			randomization.
+
 	mousedev.tap_time=3D
 			[MOUSE] Maximum time between finger touching and
 			leaving touchpad surface for touch to be considered
@@ -1549,6 +1553,10 @@ running once the system is up.
 	st0x=3D		[HW,SCSI]
 			See header of drivers/scsi/seagate.c.
=20
+	stack_random_bits=3D
+			Sets the number of bits of stack randomization to
+			perform.
+
 	sti=3D		[PARISC,HW]
 			Format: <num>
 			Set the STI (builtin display/keyboard on the HP-PARISC
diff -urNp linux-2.6.16.16/fs/binfmt_elf.c linux-2.6.16.16-randparam/fs/b=
infmt_elf.c
--- linux-2.6.16.16/fs/binfmt_elf.c	2006-05-10 21:56:24.000000000 -0400
+++ linux-2.6.16.16-randparam/fs/binfmt_elf.c	2006-05-19 23:57:25.0000000=
00 -0400
@@ -504,9 +504,16 @@ out:
 static unsigned long randomize_stack_top(unsigned long stack_top)
 {
 	unsigned int random_variable =3D 0;
-
-	if (current->flags & PF_RANDOMIZE)
-		random_variable =3D get_random_int() % (8*1024*1024);
+	unsigned int random_range =3D 0;
+	/*
+	 * Randomization happens here if doing more than 8 bits of entropy,
+	 * otherwise look to process.c only; the other 8 bits are there.
+	 */
+	if (current->flags & PF_RANDOMIZE && stack_random_bits > 8) {
+		/*XXX:  We should probably PAGE_SIZE instead of 4096 here*/
+		random_range =3D 4096 * (1 << (stack_random_bits - 8));
+		random_variable =3D get_random_int() % (random_range);
+	}
 #ifdef CONFIG_STACK_GROWSUP
 	return PAGE_ALIGN(stack_top + random_variable);
 #else
diff -urNp linux-2.6.16.16/fs/exec.c linux-2.6.16.16-randparam/fs/exec.c
--- linux-2.6.16.16/fs/exec.c	2006-05-10 21:56:24.000000000 -0400
+++ linux-2.6.16.16-randparam/fs/exec.c	2006-05-19 23:51:30.000000000 -04=
00
@@ -67,6 +67,81 @@ EXPORT_SYMBOL(suid_dumpable);
 static struct linux_binfmt *formats;
 static DEFINE_RWLOCK(binfmt_lock);
=20
+/*=20
+ * stack_random_bits:  How much stack randomization to apply.
+ * We default to 8iMiB on 16 byte intervals (19 bits).
+ *
+ * For any value over 8 bits, the higher order bits are used to
+ * apply page randomization; for example, our default of 19 supplies
+ * 11 bits of VMA randomization, giving 2048 possible positions in
+ * 4096 byte page interval, 8MiB.  The other 8 bits are covered by
+ * randomization inside the page, shifting sp by 16 byte intervals.
+ *
+ * For values under 8 bits, the size of a page is divided by
+ * (1 << stack_random_bits) and the stack is placed in one of those
+ * intervals.
+ */
+int stack_random_bits =3D 19;
+
+EXPORT_SYMBOL(stack_random_bits);
+
+/*
+ * Here we allow a command line setting to handle
+ * adjusting stack base randomization, based on bits
+ * of entropy.
+ */
+static int __init stack_random_bits_setup(char *str)
+{
+	get_option(&str, &stack_random_bits);
+	/*512M:  Maximum randomization for i386*/
+	/*
+	 * FIXME:  Use an arch-specific header and a construct
+	 * such as:
+	 *   if (stack_random_bits > STACK_RANDOM_BITS_MAX)
+	 *     stack_random_bits =3D STACK_RANDOM_BITS_MAX;
+	 */
+	if (stack_random_bits > 25)
+		stack_random_bits =3D 25;
+	/*If it's negative something is wrong, zero it*/
+	if (stack_random_bits < 1)
+		stack_random_bits =3D 0;
+	return 1;
+}
+
+__setup("stack_random_bits=3D", stack_random_bits_setup);
+
+/*=20
+ * mmap_random_bits:  How much mmap() randomization to apply.
+ * We default to 1 megabyte (8 bits)
+ */
+int mmap_random_bits =3D 8;
+
+EXPORT_SYMBOL(mmap_random_bits);
+
+/*
+ * Here we allow a command line setting to handle
+ * adjusting mmap() base randomization, based on bits
+ * of entropy.
+ */
+static int __init mmap_random_bits_setup(char *str)
+{
+	get_option(&str, &mmap_random_bits);
+	/*256M:  Maximum randomization for i386*/
+	/*FIXME:  Use a construct from a define in a header,
+	 * like:
+	 *   if (mmap_random_bits > MMAP_RANDOM_BITS_MAX)
+	 *     mmap_random_bits =3D MMAP_RANDOM_BITS_MAX;
+	 */
+	if (mmap_random_bits > 16)
+		mmap_random_bits =3D 16;
+	/*If it's negative something is wrong, zero it*/
+	if (mmap_random_bits < 1)
+		mmap_random_bits =3D 0;
+	return 1;
+}
+
+__setup("mmap_random_bits=3D", mmap_random_bits_setup);
+
 int register_binfmt(struct linux_binfmt * fmt)
 {
 	struct linux_binfmt ** tmp =3D &formats;
diff -urNp linux-2.6.16.16/include/linux/mm.h linux-2.6.16.16-randparam/i=
nclude/linux/mm.h
--- linux-2.6.16.16/include/linux/mm.h	2006-05-10 21:56:24.000000000 -040=
0
+++ linux-2.6.16.16-randparam/include/linux/mm.h	2006-05-19 23:46:27.0000=
00000 -0400
@@ -23,6 +23,17 @@ struct anon_vma;
 extern unsigned long max_mapnr;
 #endif
=20
+/*=20
+ * stack_random_bits:  how much entropy to apply to the stack
+ * 	- Currently only actually works (right) on IA-32 and x86-64
+ * 	- Defined in fs/exec.c
+ * mmap_random_bits:   how much entropy to apply to mmap()
+ * 	- Currently only used in arch/i386/mm/mmap.c
+ * 	- Defined in fs/exec.c for consistency
+ */
+extern int stack_random_bits;
+extern int mmap_random_bits;
+
 extern unsigned long num_physpages;
 extern void * high_memory;
 extern unsigned long vmalloc_earlyreserve;

--------------020902070002080108030107--

--------------enig8714B00EF5FB7E53383FD04F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRG5qQAs1xW0HCTEFAQIi+RAAjZBDBh6yAIjN6sZ9GrSDKwKII/BAQK/N
3gjWMiIl+Davs5LKO4Tn7/zmDmdCKr2UEvmuBsZkkbznMQ3FdP0LEOBfI8bErmKe
He+JEndIdMOLn+zorT4B+U2ctSkQ+bBeka+UiGaOayEDO+Atslb7Pk02JTkAAkG1
1h1CHtdCB8rcnGaThyhjfRpjv1uW9516+O1TTFn98CN9u3Gjzbx0LC+hONKP5DFB
pw0j59zfYH1uvn3npkHvCGSiV+t43LnfJPQgyxByEPeZsBmxDSWPxLzMBs3lS0D6
7ot457sB3CrfABitaP/bKie++p3p9ub16MxFK+G9R9Wmk1oVkGhCtqOJToPDKhmS
fBSWQ8rI2gDUT4Wul6hlMnKZnaAhk4mrY4fspHS5LpCuHARqJjc41l2kjj5TQJRT
ypoQsBFPX06f3p770I8Yto+lq90mFc7/2LZpz1WKpT7G9hGXD3bAGXTEr2kl6s66
46jvquls/G+FDcoug5MMb8NZXfDOAeh392AU8NQmGTaBRtwiekwPRLXaG/Nst81f
IlfckhJnaW2N/wY8bAPWcvVLrOPzNPxFmlV8/F/6VIdYKwEsbPHPxe3+wxPzrC2h
JTfLlk78W+4pJPbVQGet+xCQOcGrMqoGLZsUa4o35GyJYUIbJQoPflyjaQCxIuO+
CkrAZGeaP+I=
=buHz
-----END PGP SIGNATURE-----

--------------enig8714B00EF5FB7E53383FD04F--
