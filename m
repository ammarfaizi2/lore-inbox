Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbVIWPTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbVIWPTM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 11:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbVIWPTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 11:19:12 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2993 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751076AbVIWPTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 11:19:10 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: "vgoyal@in.ibm.com Dave Anderson" <anderson@redhat.com>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Subject: [PATCH] Don't uselessly export task_struct to user space
 in core dumps.
References: <20050921065633.GC3780@in.ibm.com>
	<m1mzm6ebqn.fsf@ebiederm.dsl.xmission.com>
	<43317980.D6AEA859@redhat.com>
	<m1d5n1cw89.fsf@ebiederm.dsl.xmission.com>
	<20050922140824.GF3753@in.ibm.com> <4332C87C.9CE47E8D@redhat.com>
	<m1zmq5awsn.fsf@ebiederm.dsl.xmission.com>
	<20050923050950.GC3736@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 23 Sep 2005 09:17:50 -0600
In-Reply-To: <20050923050950.GC3736@in.ibm.com> (Vivek Goyal's message of
 "Fri, 23 Sep 2005 10:39:50 +0530")
Message-ID: <m1aci3byox.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


task_struct is an internal structure to the kernel with
a lot of good information, that is probably interesting in
core dumps.  However there is no way for user space to know
what format that information is in making it useless.

I grepped the GDB 6.3 source code and NT_TASKSTRUCT while
defined is not used anywhere else.  So I would be surprised
if anyone notices it is missing.

In addition exporting kernel pointers to all the interesting
kernel data structures sounds like the very definition of an
information leak.  I haven't a clue what someone with evil
intentions could do with that information, but in any attack
against the kernel it looks like this is the perfect tool for
aiming that attack.

So since NT_TASKSTRUCT is useless as currently defined and
is potentially dangerous, let's just not export it.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 arch/mips/kernel/irixelf.c |   17 ++++++-----------
 fs/binfmt_elf.c            |    4 +---
 2 files changed, 7 insertions(+), 14 deletions(-)

06d116247caa2fef10cb73c5d6042a5ff658b677
diff --git a/arch/mips/kernel/irixelf.c b/arch/mips/kernel/irixelf.c
--- a/arch/mips/kernel/irixelf.c
+++ b/arch/mips/kernel/irixelf.c
@@ -1064,8 +1064,8 @@ static int irix_core_dump(long signr, st
 	struct elfhdr elf;
 	off_t offset = 0, dataoff;
 	int limit = current->signal->rlim[RLIMIT_CORE].rlim_cur;
-	int numnote = 4;
-	struct memelfnote notes[4];
+	int numnote = 3;
+	struct memelfnote notes[3];
 	struct elf_prstatus prstatus;	/* NT_PRSTATUS */
 	elf_fpregset_t fpu;		/* NT_PRFPREG */
 	struct elf_prpsinfo psinfo;	/* NT_PRPSINFO */
@@ -1198,20 +1198,15 @@ static int irix_core_dump(long signr, st
 	}
 	strlcpy(psinfo.pr_fname, current->comm, sizeof(psinfo.pr_fname));
 
-	notes[2].name = "CORE";
-	notes[2].type = NT_TASKSTRUCT;
-	notes[2].datasz = sizeof(*current);
-	notes[2].data = current;
-
 	/* Try to dump the FPU. */
 	prstatus.pr_fpvalid = dump_fpu (regs, &fpu);
 	if (!prstatus.pr_fpvalid) {
 		numnote--;
 	} else {
-		notes[3].name = "CORE";
-		notes[3].type = NT_PRFPREG;
-		notes[3].datasz = sizeof(fpu);
-		notes[3].data = &fpu;
+		notes[2].name = "CORE";
+		notes[2].type = NT_PRFPREG;
+		notes[2].datasz = sizeof(fpu);
+		notes[2].data = &fpu;
 	}
 
 	/* Write notes phdr entry. */
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1503,9 +1503,7 @@ static int elf_core_dump(long signr, str
 	fill_psinfo(psinfo, current->group_leader, current->mm);
 	fill_note(notes +1, "CORE", NT_PRPSINFO, sizeof(*psinfo), psinfo);
 	
-	fill_note(notes +2, "CORE", NT_TASKSTRUCT, sizeof(*current), current);
-  
-	numnote = 3;
+	numnote = 2;
 
 	auxv = (elf_addr_t *) current->mm->saved_auxv;
 
