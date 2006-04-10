Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751015AbWDJFwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWDJFwY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 01:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWDJFwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 01:52:24 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:8407
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751011AbWDJFwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 01:52:24 -0400
Date: Sun, 09 Apr 2006 22:52:19 -0700 (PDT)
Message-Id: <20060409.225219.11550929.davem@davemloft.net>
To: linux-kernel@vger.kernel.org
Subject: Re: /proc/${pid}/auxv
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060402.011430.02794933.davem@davemloft.net>
References: <20060402.011430.02794933.davem@davemloft.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>
Date: Sun, 02 Apr 2006 01:14:30 -0800 (PST)

> I think this needs to be handled by the binfmt of the current thread
> because the size of the auxv words themselves is binfmt dependent.
> 
> For core file output, the binfmt handler does the auxv writing and
> it interpretes the type of the entry words correctly.
> 
> So what happens now is that, for a 32-bit ELF binary executing on
> 64-bit kernel, /proc/${pid}/auxv will report an extra AT_NULL entry or
> garbage at the end (because it's interpreting 32-bit words as 64-bit
> words when trying to find the AT_NULL that ends the auxv vector).
> Whereas core file generation will find the end accurately and place
> only the exact number of AUXV entries into the core file.

Here is a patch that implements the fix since nobody has gotten
to it yet:

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 537893a..16aa604 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -63,6 +63,7 @@ static int elf_core_dump(long signr, str
 #else
 #define elf_core_dump	NULL
 #endif
+static int elf_auxv_size(struct mm_struct *mm);
 
 #if ELF_EXEC_PAGESIZE > PAGE_SIZE
 # define ELF_MIN_ALIGN	ELF_EXEC_PAGESIZE
@@ -83,6 +84,7 @@ static struct linux_binfmt elf_format = 
 		.load_binary	= load_elf_binary,
 		.load_shlib	= load_elf_library,
 		.core_dump	= elf_core_dump,
+		.auxv_size	= elf_auxv_size,
 		.min_coredump	= ELF_EXEC_PAGESIZE
 };
 
@@ -1672,6 +1674,18 @@ #undef NUM_NOTES
 }
 
 #endif		/* USE_ELF_CORE_DUMP */
+
+static int elf_auxv_size(struct mm_struct *mm)
+{
+	elf_addr_t *auxv = (elf_addr_t *) mm->saved_auxv;
+	int sz = 0;
+
+	do
+		sz += 2;
+	while (auxv[sz - 2] != AT_NULL);
+
+	return sz * sizeof (elf_addr_t);
+}
 
 static int __init init_elf_binfmt(void)
 {
diff --git a/fs/proc/base.c b/fs/proc/base.c
index a3a3eec..4810e89 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -466,11 +466,8 @@ static int proc_pid_auxv(struct task_str
 	int res = 0;
 	struct mm_struct *mm = get_task_mm(task);
 	if (mm) {
-		unsigned int nwords = 0;
-		do
-			nwords += 2;
-		while (mm->saved_auxv[nwords - 2] != 0); /* AT_NULL */
-		res = nwords * sizeof(mm->saved_auxv[0]);
+		if (task->binfmt && task->binfmt->auxv_size)
+			res = task->binfmt->auxv_size(mm);
 		if (res > PAGE_SIZE)
 			res = PAGE_SIZE;
 		memcpy(buffer, mm->saved_auxv, res);
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index c1e82c5..390a879 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -52,12 +52,14 @@ #define BINPRM_FLAGS_EXECFD (1 << BINPRM
  * This structure defines the functions that are used to load the binary formats that
  * linux accepts.
  */
+struct task_struct;
 struct linux_binfmt {
 	struct linux_binfmt * next;
 	struct module *module;
 	int (*load_binary)(struct linux_binprm *, struct  pt_regs * regs);
 	int (*load_shlib)(struct file *);
 	int (*core_dump)(long signr, struct pt_regs * regs, struct file * file);
+	int (*auxv_size)(struct mm_struct *mm);
 	unsigned long min_coredump;	/* minimal dump size */
 };
 
