Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263526AbUAMCBa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 21:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263742AbUAMCBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 21:01:30 -0500
Received: from [193.138.115.2] ([193.138.115.2]:46607 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S263526AbUAMB7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 20:59:05 -0500
Date: Tue, 13 Jan 2004 02:55:07 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Eric Youngdale <eric@andante.org>,
       Eric Youngdale <ericy@cais.com>
Subject: [PATCH] stronger ELF sanity checks v2
Message-ID: <Pine.LNX.4.56.0401130228490.2265@jju_lnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here's the second version of my patch to add better sanity checks for
binfmt_elf

The first patch can be found in the archives. Here's one online location :
http://lkml.org/lkml/2004/1/10/89  - that email contains a description of
the first version of the patch. Here follows a changelog for v1->v2 (this
patch includes everything v1 did)


Changes releative to v1:
-----
- Patch is against 2.6.1-mm2
- a test for e_version == e_ident[EI_VERSION] was added.
	This is redundant as long as there is only one ELF version in
	existance but as soon as two versions exist, checking consistency
	between the two places where the binary can claim a version is
	sensible. Redundant for now but a sane check none the less.
- A check has been added to verify that p_filesz is not larger than p_memsz.
	This is not allowed by ELF, and would not make sense in any case
	as we would then attempt to load more data into memory than we
	have room for.
- I moved the out: label below the other out_* labels. Seems more logical.
- Reformatted the huge if() that tests the header a bit - for readabillity.


I've been running with this patch for the better part of a day, and no
binaries have failed so far, so it seems OK.

I've had some feedback from 3 users who tested v1 of the patch, and all of
them reported that it didn't seem to cause any trouble.


Things I've got planned for v3
---
- I'll probably make elf_check_arch into an inline function rather than
the current macro which evaluates its argument multiple times.
- I'll move most of the checks into a sepperate function to be
called from both load_elf_binary() and load_elf_interp().
- There are still some header fields that are not checked, most of those
will hopefully be tested in v3 - we'll see, I want to do this in nice
small incremental steps.



Here's v2 - Andrew, please consider merging it into -mm for testing :


diff -up linux-2.6.1-mm2-orig/fs/binfmt_elf.c linux-2.6.1-mm2-juhl/fs/binfmt_elf.c
--- linux-2.6.1-mm2-orig/fs/binfmt_elf.c	2004-01-09 07:59:27.000000000 +0100
+++ linux-2.6.1-mm2-juhl/fs/binfmt_elf.c	2004-01-13 02:28:21.000000000 +0100
@@ -7,6 +7,13 @@
  * Tools".
  *
  * Copyright 1993, 1994: Eric Youngdale (ericy@cais.com).
+ *
+ * More info on ELF can be found online at
+ * http://x86.ddj.com/ftp/manuals/tools/elf.pdf
+ *
+ * January 2004
+ *    Implement stronger ELF sanity checks: Jesper Juhl <juhl-lkml@dif.dk>
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
@@ -479,15 +486,49 @@ static int load_elf_binary(struct linux_
 	elf_ex = *((struct elfhdr *) bprm->buf);

 	retval = -ENOEXEC;
-	/* First of all, some simple consistency checks */
-	if (memcmp(elf_ex.e_ident, ELFMAG, SELFMAG) != 0)
+
+	/* First of all, ELF header consistency checks */
+	    /* first check things most likely to fail;
+	       magic number, type and architecture, so we bail out
+	       early in the common case.
+	     */
+	if (((memcmp(elf_ex.e_ident, ELFMAG, SELFMAG) != 0)) ||
+	    (elf_ex.e_type != ET_EXEC && elf_ex.e_type != ET_DYN) ||
+	    (!elf_check_arch(&elf_ex)))
 		goto out;

-	if (elf_ex.e_type != ET_EXEC && elf_ex.e_type != ET_DYN)
+	/* check all remaining entries in e_ident[] */
+	if ((elf_ex.e_ident[EI_CLASS] != ELF_CLASS) ||
+	    (elf_ex.e_ident[EI_DATA] != ELF_DATA) ||
+	    (elf_ex.e_ident[EI_VERSION] != EV_CURRENT)) /* see comment for e_version */
+	    /* we don't check anything in e_ident[EI_PAD]
+	       the ELF spec states that when reading object files, these
+	       bytes should be ignored - reserved for future use.
+	     */
 		goto out;
-	if (!elf_check_arch(&elf_ex))
+
+	/* check remaining ELF header fields */
+	    /*
+	      The value 1 for e_version signifies the original file format;
+	      extensions will create new versions with higher numbers. The
+	      value of EV_CURRENT, though being 1 currently, will change as
+	      necessary to reflect the current version number.
+	      This needs to be kept in mind when new ELF versions come out and
+	      we want to support both new and old versions.
+	     */
+	if ((elf_ex.e_version != EV_CURRENT) ||
+	    (elf_ex.e_version != elf_ex.e_ident[EI_VERSION]) ||
+	    /* how can we check e_entry? any guarenteed invalid entry points? */
+	    /* need to come up with valid checks for e_phoff & e_shoff */
+	    /* e_flags is checked by elf_check_arch */
+	    (elf_ex.e_ehsize != sizeof(Elf_Ehdr)) ||
+	    /* e_phentsize checked below */
+	    /* how can we check e_phnum, e_shentsize & e_shnum ? */
+	    /* check for e_shstrndx needs to improve */
+	    ((elf_ex.e_shstrndx == SHN_UNDEF) && (elf_ex.e_shnum != 0)))
 		goto out;
-	if (!bprm->file->f_op||!bprm->file->f_op->mmap)
+
+	if (!bprm->file->f_op || !bprm->file->f_op->mmap)
 		goto out;

 	/* Now read in all of the header information */
@@ -506,6 +547,14 @@ static int load_elf_binary(struct linux_
 	if (retval < 0)
 		goto out_free_ph;

+	/* p_filesz must not exceed p_memsz.
+	   if it does then the binary is corrupt, hence -ENOEXEC
+	 */
+	if (elf_phdata->p_filesz > elf_phdata->p_memsz) {
+		retval = -ENOEXEC;
+		goto out_free_ph;
+	}
+
 	files = current->files;		/* Refcounted so ok */
 	if(unshare_files() < 0)
 		goto out_free_ph;
@@ -857,9 +906,8 @@ static int load_elf_binary(struct linux_
 			send_sig(SIGTRAP, current, 0);
 	}
 	retval = 0;
-out:
-	return retval;
-
+	goto out;
+
 	/* error cleanup */
 out_free_dentry:
 	allow_write_access(interpreter);
@@ -876,7 +924,8 @@ out_free_fh:
 	}
 out_free_ph:
 	kfree(elf_phdata);
-	goto out;
+out:
+	return retval;
 }

 /* This is really simpleminded and specialized - we are loading an
diff -up linux-2.6.1-mm2-orig/include/asm-i386/elf.h linux-2.6.1-mm2-juhl/include/asm-i386/elf.h
--- linux-2.6.1-mm2-orig/include/asm-i386/elf.h	2004-01-09 07:59:46.000000000 +0100
+++ linux-2.6.1-mm2-juhl/include/asm-i386/elf.h	2004-01-11 00:29:33.000000000 +0100
@@ -35,9 +35,11 @@ typedef struct user_fxsr_struct elf_fpxr

 /*
  * This is used to ensure we don't load something for the wrong architecture.
+ *
+ * Include a check of e_flags - Jesper Juhl <juhl-lkml@dif.dk>
  */
 #define elf_check_arch(x) \
-	(((x)->e_machine == EM_386) || ((x)->e_machine == EM_486))
+	((((x)->e_machine == EM_386) || ((x)->e_machine == EM_486)) && ((x)->e_flags == 0))

 /*
  * These are used to set parameters in the core dumps.



Kind regards,

Jesper Juhl


