Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275424AbRJYRWR>; Thu, 25 Oct 2001 13:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275680AbRJYRWG>; Thu, 25 Oct 2001 13:22:06 -0400
Received: from ns.caldera.de ([212.34.180.1]:28107 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S275424AbRJYRWD>;
	Thu, 25 Oct 2001 13:22:03 -0400
Date: Thu, 25 Oct 2001 19:22:25 +0200
From: Christoph Hellwig <hch@caldera.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ELF personality setting fixes
Message-ID: <20011025192225.A10880@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

the appended patch fixes binfmt_elf to always set the
personality before looking up the ELF interpreter, thus
enabling it to find the interpreterusing the alternate
root.

Also remove a sparc-specific hack to archive the goal.

Please apply,

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
