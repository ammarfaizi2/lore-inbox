Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263369AbTEOAwJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 20:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263373AbTEOAwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 20:52:08 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:48077 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263369AbTEOAwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 20:52:06 -0400
Date: Wed, 14 May 2003 18:04:34 -0700
Message-Id: <200305150104.h4F14YD16313@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix elf_core_dump bug when writing xfpregs and not fpregs
X-Fcc: ~/Mail/linus
X-Antipastobozoticataclysm: When George Bush projectile vomits antipasto on the Japanese.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason an ia32-mode core dump on amd64 for me wanted to include
the NT_PRXFPREG note but not the NT_PRFPREG note.  elf_core_dump is buggy
in this case and will try to use an initialized structure later on (notes[3]).

The patch vs 2.5.69 plus the cset-1.1042.114.10-to-1.1117.txt patch fixes it.


Thanks,
Roland


--- linux-2.5.69-1.1117/fs/binfmt_elf.c.~1~	Wed May 14 17:59:07 2003
+++ linux-2.5.69-1.1117/fs/binfmt_elf.c	Wed May 14 18:00:47 2003
@@ -1191,7 +1191,7 @@ static int elf_core_dump(long signr, str
 	struct elfhdr *elf = NULL;
 	off_t offset = 0, dataoff;
 	unsigned long limit = current->rlim[RLIMIT_CORE].rlim_cur;
-	int numnote = NUM_NOTES;
+	int numnote;
 	struct memelfnote *notes = NULL;
 	struct elf_prstatus *prstatus = NULL;	/* NT_PRSTATUS */
 	struct elf_prpsinfo *psinfo = NULL;	/* NT_PRPSINFO */
@@ -1282,18 +1282,16 @@ static int elf_core_dump(long signr, str
 	
 	fill_note(notes +2, "CORE", NT_TASKSTRUCT, sizeof(*current), current);
   
+	numnote = 3;
+
   	/* Try to dump the FPU. */
 	if ((prstatus->pr_fpvalid = elf_core_copy_task_fpregs(current, fpu)))
-		fill_note(notes +3, "CORE", NT_PRFPREG, sizeof(*fpu), fpu);
-	else
-		--numnote;
+		fill_note(notes + numnote++,
+			  "CORE", NT_PRFPREG, sizeof(*fpu), fpu);
 #ifdef ELF_CORE_COPY_XFPREGS
 	if (elf_core_copy_task_xfpregs(current, xfpu))
-		fill_note(notes +4, "LINUX", NT_PRXFPREG, sizeof(*xfpu), xfpu);
-	else
-		--numnote;
-#else
-	numnote--;
+		fill_note(notes + numnote++,
+			  "LINUX", NT_PRXFPREG, sizeof(*xfpu), xfpu);
 #endif	
   
 	fs = get_fs();
