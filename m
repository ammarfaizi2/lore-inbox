Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287395AbRL3Myj>; Sun, 30 Dec 2001 07:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287398AbRL3Mya>; Sun, 30 Dec 2001 07:54:30 -0500
Received: from ns.caldera.de ([212.34.180.1]:37306 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S287395AbRL3MyR>;
	Sun, 30 Dec 2001 07:54:17 -0500
Date: Sun, 30 Dec 2001 13:53:24 +0100
Message-Id: <200112301253.fBUCrOx28796@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: viro@math.psu.edu (Alexander Viro)
Cc: marcelo@conectiva.com.br, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [PATCH] fix to oopsable race in binfmt_elf.c
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <Pine.GSO.4.21.0112291655390.7103-100000@weyl.math.psu.edu>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.13 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.GSO.4.21.0112291655390.7103-100000@weyl.math.psu.edu> you wrote:
> 	Changing current->fs requires task_lock(current) if old value
> is non-NULL.  Otherwise we are risking oops on access to /proc/<pid>/{cwd,root}

The code this is in is sparc64-specific and rather bad.  The attached
patch has been submitted to Linus & Marcelo several times in the past.

It replaces this personality forth and back hack with the much cleaner
early setting of the personality.  I need this for Linux-ABI on i386 and
unlike the old version it allows finding interpreters for alternative
roots for more personalities than just the sparc PER_SVR4, which really
should be PER_SOLARIS, btw as real SVR4 exists on sparc..

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.

diff -uNr -Xdontdiff ../master/linux-2.4.14-pre1/fs/binfmt_elf.c linux/fs/binfmt_elf.c
--- ../master/linux-2.4.14-pre1/fs/binfmt_elf.c	Thu Oct 25 19:05:47 2001
+++ linux/fs/binfmt_elf.c	Thu Oct 25 19:18:28 2001
@@ -505,30 +505,10 @@
 #if 0
 			printk("Using ELF interpreter %s\n", elf_interpreter);
 #endif
-#ifdef __sparc__
-			if (ibcs2_interpreter) {
-				unsigned long old_pers = current->personality;
-				struct exec_domain *old_domain = current->exec_domain;
-				struct exec_domain *new_domain;
-				struct fs_struct *old_fs = current->fs, *new_fs;
-				get_exec_domain(old_domain);
-				atomic_inc(&old_fs->count);
-
-				set_personality(PER_SVR4);
-				interpreter = open_exec(elf_interpreter);
-
-				new_domain = current->exec_domain;
-				new_fs = current->fs;
-				current->personality = old_pers;
-				current->exec_domain = old_domain;
-				current->fs = old_fs;
-				put_exec_domain(new_domain);
-				put_fs_struct(new_fs);
-			} else
-#endif
-			{
-				interpreter = open_exec(elf_interpreter);
-			}
+
+			SET_PERSONALITY(elf_ex, ibcs2_interpreter);
+
+			interpreter = open_exec(elf_interpreter);
 			retval = PTR_ERR(interpreter);
 			if (IS_ERR(interpreter))
 				goto out_free_interp;
@@ -602,10 +582,6 @@
 	current->flags &= ~PF_FORKNOEXEC;
 	elf_entry = (unsigned long) elf_ex.e_entry;
 
-	/* Do this immediately, since STACK_TOP as used in setup_arg_pages
-	   may depend on the personality.  */
-	SET_PERSONALITY(elf_ex, ibcs2_interpreter);
-
 	/* Do this so that we can load the interpreter, if need be.  We will
 	   change some of these later */
 	current->mm->rss = 0;
