Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265225AbUAJQzk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 11:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265227AbUAJQzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 11:55:40 -0500
Received: from [193.138.115.2] ([193.138.115.2]:28432 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S265225AbUAJQze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 11:55:34 -0500
Date: Sat, 10 Jan 2004 17:52:30 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
cc: Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] First patch to improve ELF sanity checks
Message-ID: <8A43C34093B3D5119F7D0004AC56F4BC0752714F@difpst1a.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Andrew, please consider including the patch below in -mm for testing.
The patch works nicely here, but broader testing and review would be good.
An explanation of the patch can be found below.

This is only a first version, and it does not yet check all I want it to,
but the checks it does add should be valid. As far as I've been able to
tell, the checks it makes are valid according to the ELF spec, and it does
not seem to break anything. I'm currently using it on my own box and I
have not yet seen a single binary fail to load - I've also been testing by
modifying a valid ELF binary to contain invalid info in the fields that
are checked, and all my test-cases fail as expected.

This patch /should/ work on all archs. It adds a check to asm-i386/elf.h
that I've not added to any other archs for the simple reason that I don't
know what a valid check would be on anything but x86 32 bit atm, but I'll
be looking into that, and the additional check for i386 should not harm
other archs - their checking will just be a little weaker than i386.

So far I've only added these checks to load_elf_binary , but Jakub pointed
out to me that they would need to go into load_elf_interp as well. I will
add the checks there as well as soon as I convince myself that they really
are needed there. So far I only see load_elf_binary calling
load_elf_interp, and since load_elf_binary does the checks and abort if
they fail before calling load_elf_interp I don't (yet) see why they would
be needed there as well. I'm sure Jakub is probably right, and I'm looking
for other paths that could take us into load_elf_interp. But the checks in
load_elf_binary should be valid by them selves none the less and improve
the current situation a bit even if they are not (yet) perfect.


Ok, here goes the patch and a description:

What version of the kernel is this patch against?
---
Patch is against 2.6.1-mm1 and applies cleanly to a fresh version of that
kernel source.

What does the patch do, and why?
---
The patch adds the following checks to fs/binfmt_elf.c :

- it checks all entries in the e_ident array in the elf header,
specifically the patch adds these checks :
  - check EI_CLASS to ensure the file matches the current (32bit/64bit) architecture
  - check EI_DATA to ensure that the endianness of the binary matches the machine it's trying to execute on
  - check EI_VERSION to ensure the binary claims a valid ELF version

  e_ident[EI_PAD] is ignored on purpose since the ELF spec specified that
  these bytes should be ignored when reading ELF binaries.

- It checks e_version to ensure the binary claims a valid ELF version. I
  think checking that e_version == e_ident[EI_VERSION] is also a valid
  check, but I haven't included that in this version. I'll include it in
  the next version of the patch if I convince myself it's a valid check to
  make.

- e_ehsize is checked to ensure it matches the expected size of a valid ELF header

- a weak check of e_shstrndx is added. This check needs to be improved.
  The current check I've added just ensures that if the binary claims to
  not have a an index in the section header for a 'section name string
  table' that this claim then corresponds to the (in that case) expected
  value (zero) of e_shnum.  This check can most likely be made stronger,
  but should be valid as-is - if this check is not 100% valid in its
  current form, then I'd appreciate feedback.

The patch adds the following checks to asm-i386/elf.h :

- The validity check in the elf_check_arch macro is improved to also take
  e_flags into account - e_flags should be zero on Intel 32 bit archs.

All existing sanity checks already present are all preserved.

The patch also adds a number of new comments. Some of these are there
mainly for my own bennefit and for the bennefit of people trying to help
me improve these sanity checks - they point out some of the checks I don't
currently make and will be removed in future versions of the patch as
those checks get implemented. And a few of the comments are there to point
out things that need to be paid attention to in the case new versions of
ELF appear.
I've also taken the liberty to add my own name to the files to show who
added the additional checks so people know who to contact if they should
turn out to be buggy or insufficient in some way.


Here is the current version (1) of my elf-sanity-checks-1.patch :


diff -upr linux-2.6.1-mm1-orig/fs/binfmt_elf.c linux-2.6.1-mm1-juhl/fs/binfmt_elf.c
--- linux-2.6.1-mm1-orig/fs/binfmt_elf.c	2004-01-09 07:59:27.000000000 +0100
+++ linux-2.6.1-mm1-juhl/fs/binfmt_elf.c	2004-01-10 16:23:50.000000000 +0100
@@ -6,7 +6,14 @@
  * "UNIX SYSTEM V RELEASE 4 Programmers Guide: Ansi C and Programming
Support
  * Tools".
  *
+ * More info on ELF can be found online at
+ * http://www.muppetlabs.com/~breadbox/software/ELF.txt
+ *
  * Copyright 1993, 1994: Eric Youngdale (ericy@cais.com).
+ *
+ * January 2004
+ *    stronger sanity checks on the ELF header: Jesper Juhl <juhl-lkml@dif.dk>
+ *
  */

 #include <linux/module.h>
@@ -301,7 +308,7 @@ static unsigned long load_elf_interp(str
 	unsigned long error = ~0UL;
 	int retval, i, size;

-	/* First of all, some simple consistency checks */
+	/* First of all, ELF header consistency checks */
 	if (interp_elf_ex->e_type != ET_EXEC &&
 	    interp_elf_ex->e_type != ET_DYN)
 		goto out;
@@ -479,14 +486,44 @@ static int load_elf_binary(struct linux_
 	elf_ex = *((struct elfhdr *) bprm->buf);

 	retval = -ENOEXEC;
-	/* First of all, some simple consistency checks */
-	if (memcmp(elf_ex.e_ident, ELFMAG, SELFMAG) != 0)
-		goto out;

-	if (elf_ex.e_type != ET_EXEC && elf_ex.e_type != ET_DYN)
-		goto out;
-	if (!elf_check_arch(&elf_ex))
+	/* First of all, ELF header consistency checks */
+	    /* first check things most likely to fail;
+	       magic number, type and architecture, so we bail out
+	       early in the common case.
+	     */
+	if (((memcmp(elf_ex.e_ident, ELFMAG, SELFMAG) != 0)) ||
+	    (elf_ex.e_type != ET_EXEC && elf_ex.e_type != ET_DYN) ||
+	    (!elf_check_arch(&elf_ex)) ||
+
+	    /* check all remaining entries in e_ident[] */
+	    (elf_ex.e_ident[EI_CLASS] != ELF_CLASS) ||
+	    (elf_ex.e_ident[EI_DATA] != ELF_DATA) ||
+	    (elf_ex.e_ident[EI_VERSION] != EV_CURRENT) || /* see comment for e_version */
+	    /* we don't check anything in e_ident[EI_PAD]
+	       the ELF spec states that when reading object files, these
+	       bytes should be ignored - reserved for future use.
+	     */
+
+	    /* check remaining ELF header fields */
+	    /*
+	      The value 1 signifies the original file format; extensions will
+	      create new versions with higher numbers. The value of EV_CURRENT,
+	      though being 1 currently , will change as necessary to reflect the
+	      current version number. This needs to be kept in mind when new ELF
+	      versions come out and we want to support new and old versions.
+	     */
+	     (elf_ex.e_version != EV_CURRENT) ||
+	     /* how can we check e_entry? any guarenteed invalid entry points? */
+	     /* need to come up with valid checks for e_phoff & e_shoff */
+	     /* e_flags is checked by elf_check_arch */
+	     (elf_ex.e_ehsize != sizeof(Elf_Ehdr)) ||
+	     /* e_phentsize checked below */
+	     /* how can we check e_phnum, e_shentsize & e_shnum ? */
+	     /* check for e_shstrndx needs to improve */
+	     ((elf_ex.e_shstrndx == SHN_UNDEF) && (elf_ex.e_shnum != 0)))
 		goto out;
+
 	if (!bprm->file->f_op||!bprm->file->f_op->mmap)
 		goto out;

diff -upr linux-2.6.1-mm1-orig/include/asm-i386/elf.h linux-2.6.1-mm1-juhl/include/asm-i386/elf.h
--- linux-2.6.1-mm1-orig/include/asm-i386/elf.h	2004-01-09 07:59:46.000000000 +0100
+++ linux-2.6.1-mm1-juhl/include/asm-i386/elf.h	2004-01-10 15:50:01.000000000 +0100
@@ -35,9 +35,10 @@ typedef struct user_fxsr_struct elf_fpxr

 /*
  * This is used to ensure we don't load something for the wrong architecture.
+ * Include a check of e_flags - Jesper Juhl <juhl-lkml@dif.dk>
  */
 #define elf_check_arch(x) \
-	(((x)->e_machine == EM_386) || ((x)->e_machine == EM_486))
+	((((x)->e_machine == EM_386) || ((x)->e_machine == EM_486)) && ((x)->e_flags == 0))

 /*
  * These are used to set parameters in the core dumps.




Any and all comments are appreciated - as always.


-- Jesper Juhl

