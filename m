Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264828AbTFBSRZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 14:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264829AbTFBSRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 14:17:25 -0400
Received: from dp.samba.org ([66.70.73.150]:30151 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264828AbTFBSRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 14:17:24 -0400
Date: Tue, 3 Jun 2003 04:30:47 +1000
From: Anton Blanchard <anton@samba.org>
To: roland@redhat.com, mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: FP state in threaded coredumps
Message-ID: <20030602183047.GF1169@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I was adding threaded coredump support to ppc64 and noticed that the
ELF_CORE_SYNC hook was never called. It looks like we need something
like this on archs that do lazy FP save/restore to ensure the FP state
for threads running on other cpus is up to date.

On ppc64 ELF_CORE_SYNC does an IPI to all cpus that copies FP state into
the thread struct.

I also got rid of an old function prototype that isnt used in
binfmt_elf, dump_fpu.

Anton

===== fs/binfmt_elf.c 1.45 vs edited =====
--- 1.45/fs/binfmt_elf.c	Tue May  6 23:16:37 2003
+++ edited/fs/binfmt_elf.c	Sun Jun  1 09:02:22 2003
@@ -45,7 +45,6 @@
 static int load_elf_binary(struct linux_binprm * bprm, struct pt_regs * regs);
 static int load_elf_library(struct file*);
 static unsigned long elf_map (struct file *, unsigned long, struct elf_phdr *, int, int);
-extern int dump_fpu (struct pt_regs *, elf_fpregset_t *);
 
 #ifndef elf_addr_t
 #define elf_addr_t unsigned long
@@ -1203,6 +1202,10 @@
 	elf_fpxregset_t *xfpu = NULL;
 #endif
 	int thread_status_size = 0;
+
+#ifdef ELF_CORE_SYNC
+	ELF_CORE_SYNC();
+#endif
 
 	/*
 	 * We no longer stop all VM operations.
