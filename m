Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVBHEHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVBHEHB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 23:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbVBHEHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 23:07:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:45268 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261458AbVBHEGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 23:06:41 -0500
Date: Mon, 7 Feb 2005 20:06:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: dsd@gentoo.org, pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3: Kylix application no longer works?
Message-Id: <20050207200627.51c029cd.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0502080154200.31698@alpha.polcom.net>
References: <20050207221107.GA1369@elf.ucw.cz>
	<20050207145100.6208b8b9.akpm@osdl.org>
	<420801D7.3020405@gentoo.org>
	<20050207161810.23fcc4f1.akpm@osdl.org>
	<Pine.LNX.4.61.0502080154200.31698@alpha.polcom.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Kulewski <kangur@polcom.net> wrote:
>
> On Mon, 7 Feb 2005, Andrew Morton wrote:
> 
>  > Daniel Drake <dsd@gentoo.org> wrote:
>  >>
>  >>> # fs/binfmt_elf.c
>  >>> #   2005/01/17 13:37:56-08:00 ecd@skynet.be +43 -19
>  >>> #   [SPARC64]: Missing user access return value checks in fs/binfmt_elf.c and fs/compat.c
>  >>> #
>  >>
>  >> I think so. For a short period we applied this patch to the Gentoo 2.6.10
>  >> kernel...
>  >>
>  >> http://dev.gentoo.org/~dsd/gentoo-dev-sources/release-10.01/dist/1900_umem_catch.patch
>  >>
>  >> ...but removed it once users complained it stopped kylix binaries from running.
>  >
>  > Bah.  That's what happens when you fix stuff.
>  >
>  > What's kylix?  The Borland C++ builder thing?
> 
>  Rather Delphi (== Object Pascal) thing.
> 
> 
>  > How should one set about reproducing this problem?
> 
>  IIRC, Some minimal "personal" version can be downloaded from borland.com.

Well I'd prefer that we not back out the whole patch.  Could someone please
test with something like the below, let us know exactly where it's falling
over?


--- 25/fs/binfmt_elf.c~a	2005-02-07 20:01:16.000000000 -0800
+++ 25-akpm/fs/binfmt_elf.c	2005-02-07 20:03:51.000000000 -0800
@@ -44,6 +44,8 @@
 
 #include <linux/elf.h>
 
+#define D() do { printk("%s:%d\n", __FILE__, __LINE__); dump_stack(); } while (0)
+
 static int load_elf_binary(struct linux_binprm * bprm, struct pt_regs * regs);
 static int load_elf_library(struct file*);
 static unsigned long elf_map (struct file *, unsigned long, struct elf_phdr *, int, int);
@@ -181,8 +183,10 @@ create_elf_tables(struct linux_binprm *b
 			STACK_ALLOC(p, ((current->pid % 64) << 7));
 #endif
 		u_platform = (elf_addr_t __user *)STACK_ALLOC(p, len);
-		if (__copy_to_user(u_platform, k_platform, len))
+		if (__copy_to_user(u_platform, k_platform, len)) {
+			D();
 			return -EFAULT;
+		}
 	}
 
 	/* Create the ELF interpreter info */
@@ -244,8 +248,10 @@ create_elf_tables(struct linux_binprm *b
 #endif
 
 	/* Now, let's put argc (and argv, envp if appropriate) on the stack */
-	if (__put_user(argc, sp++))
+	if (__put_user(argc, sp++)) {
+		D();
 		return -EFAULT;
+	}
 	if (interp_aout) {
 		argv = sp + 2;
 		envp = argv + argc + 1;
@@ -266,8 +272,10 @@ create_elf_tables(struct linux_binprm *b
 			return 0;
 		p += len;
 	}
-	if (__put_user(0, argv))
+	if (__put_user(0, argv)) {
+		D();
 		return -EFAULT;
+	}
 	current->mm->arg_end = current->mm->env_start = p;
 	while (envc-- > 0) {
 		size_t len;
@@ -277,14 +285,18 @@ create_elf_tables(struct linux_binprm *b
 			return 0;
 		p += len;
 	}
-	if (__put_user(0, envp))
+	if (__put_user(0, envp)) {
+		D();
 		return -EFAULT;
+	}
 	current->mm->env_end = p;
 
 	/* Put the elf_info on the stack in the right place.  */
 	sp = (elf_addr_t __user *)envp + 1;
-	if (copy_to_user(sp, elf_info, ei_index * sizeof(elf_addr_t)))
+	if (copy_to_user(sp, elf_info, ei_index * sizeof(elf_addr_t))) {
+		D();
 		return -EFAULT;
+	}
 	return 0;
 }
 
_

