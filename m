Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTHOKpX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 06:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275895AbTHOKpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 06:45:23 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:36614 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262273AbTHOKpT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 06:45:19 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] thread coredump oops fix
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 15 Aug 2003 19:45:06 +0900
Message-ID: <87ekznfbd9.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If ->group_leader of current thread already was exiting,
group_leader's ->mm is NULL in fill_psinfo(). Then I got Oops.

This uses current->mm instead of ->group_leader->mm to dump args.


 fs/binfmt_elf.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff -puN fs/binfmt_elf.c~thread_coredump-fix fs/binfmt_elf.c
--- linux-2.6.0-test3/fs/binfmt_elf.c~thread_coredump-fix	2003-08-15 05:41:44.000000000 +0900
+++ linux-2.6.0-test3-hirofumi/fs/binfmt_elf.c	2003-08-15 07:09:45.000000000 +0900
@@ -1084,18 +1084,19 @@ static void fill_prstatus(struct elf_prs
 	jiffies_to_timeval(p->cstime, &prstatus->pr_cstime);
 }
 
-static void fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p)
+static void fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
+			struct mm_struct *mm)
 {
 	int i, len;
 	
 	/* first copy the parameters from user space */
 	memset(psinfo, 0, sizeof(struct elf_prpsinfo));
 
-	len = p->mm->arg_end - p->mm->arg_start;
+	len = mm->arg_end - mm->arg_start;
 	if (len >= ELF_PRARGSZ)
 		len = ELF_PRARGSZ-1;
 	copy_from_user(&psinfo->pr_psargs,
-		      (const char *)p->mm->arg_start, len);
+		       (const char *)mm->arg_start, len);
 	for(i = 0; i < len; i++)
 		if (psinfo->pr_psargs[i] == 0)
 			psinfo->pr_psargs[i] = ' ';
@@ -1280,7 +1281,7 @@ static int elf_core_dump(long signr, str
 
 	fill_note(notes +0, "CORE", NT_PRSTATUS, sizeof(*prstatus), prstatus);
 	
-	fill_psinfo(psinfo, current->group_leader);
+	fill_psinfo(psinfo, current->group_leader, current->mm);
 	fill_note(notes +1, "CORE", NT_PRPSINFO, sizeof(*psinfo), psinfo);
 	
 	fill_note(notes +2, "CORE", NT_TASKSTRUCT, sizeof(*current), current);

_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
