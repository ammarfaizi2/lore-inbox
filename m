Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265809AbUFDP3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265809AbUFDP3n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 11:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265803AbUFDP3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 11:29:43 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:41416 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S265823AbUFDP0t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 11:26:49 -0400
From: Andy Lutomirski <luto@myrealbox.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,   2.6.7-rc2-bk2
Date: Fri, 4 Jun 2004 08:26:15 -0700
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@suse.de>, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org, arjanv@redhat.com, suresh.b.siddha@intel.com,
       jun.nakajima@intel.com
References: <20040602205025.GA21555@elte.hu> <20040603230834.GF868@wotan.suse.de> <20040604092552.GA11034@elte.hu>
In-Reply-To: <20040604092552.GA11034@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406040826.15427.luto@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 June 2004 02:25, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > > The whole point of NX, though, is that it prevents certain classes of 
> > > exploits.  If a setuid binary is vulnerable to one of these, then Ingo's 
> > > patch "fixes" it.  Your approach breaks that.
> > 
> > Good point.
> > 
> > But that only applies to the NX personality bit. For the uname
> > emulation it is not an issue.
> > 
> > So maybe the dropping on exec should only zero a few selected
> > personality bits, but not all.
> 
> ok, how about the attached patch then? There's a PERS_DROP_ON_SUID mask
> that we drop upon setuid - all the other personality bits get inherited.
> 
> 	Ingo

This is wrong on SELinux (and presumably with other LSMs). It also does
unexpected things if you fail to exec a setuid executable.

Here's a (completely untested, applies-with-some-offset-on-non-mm) version
that's less wrong.

Note the less.  It will at least do funny things to your audit log on
SELinux -- I don't like it _that_ much.

--Andy


 fs/binfmt_elf.c             |   22 ++++++++++++++--------
 fs/exec.c                   |    3 +++
 include/asm-i386/elf.h      |    3 ++-
 include/linux/personality.h |    3 +++
 4 files changed, 22 insertions(+), 9 deletions(-)

--- 2.6.7-rc1-mm1/fs/binfmt_elf.c~ingo	2004-05-28 09:02:06.000000000 -0700
+++ 2.6.7-rc1-mm1/fs/binfmt_elf.c	2004-06-04 08:13:33.192127641 -0700
@@ -487,7 +487,7 @@ static int load_elf_binary(struct linux_
   	struct exec interp_ex;
 	char passed_fileno[6];
 	struct files_struct *files;
-	int executable_stack = EXSTACK_DEFAULT;
+	int executable_stack;
 	
 	/* Get the exec-header */
 	elf_ex = *((struct elfhdr *) bprm->buf);
@@ -613,13 +613,19 @@ static int load_elf_binary(struct linux_
 	}
 
 	elf_ppnt = elf_phdata;
-	for (i = 0; i < elf_ex.e_phnum; i++, elf_ppnt++)
-		if (elf_ppnt->p_type == PT_GNU_STACK) {
-			if (elf_ppnt->p_flags & PF_X)
-				executable_stack = EXSTACK_ENABLE_X;
-			else
-				executable_stack = EXSTACK_DISABLE_X;
-		}
+	if (current->personality & ADDR_SPACE_EXECUTABLE)
+		executable_stack = EXSTACK_ENABLE_X;
+	else {
+		executable_stack = EXSTACK_DEFAULT;
+		for (i = 0; i < elf_ex.e_phnum; i++, elf_ppnt++)
+			if (elf_ppnt->p_type == PT_GNU_STACK) {
+				if (elf_ppnt->p_flags & PF_X)
+					executable_stack = EXSTACK_ENABLE_X;
+				else
+					executable_stack = EXSTACK_DISABLE_X;
+				break;
+			}
+	}
 
 	/* Some simple consistency checks for the interpreter */
 	if (elf_interpreter) {
--- 2.6.7-rc1-mm1/fs/exec.c~ingo	2004-06-04 08:12:26.347465895 -0700
+++ 2.6.7-rc1-mm1/fs/exec.c	2004-06-04 08:19:43.226203330 -0700
@@ -934,6 +934,9 @@ void compute_creds(struct linux_binprm *
 	unsafe = unsafe_exec(current);
 	security_bprm_apply_creds(bprm, unsafe);
 	task_unlock(current);
+
+	if (security_bprm_secureexec(bprm))
+		current->personality &= ~PERS_DROP_ON_SUID;
 }
 
 EXPORT_SYMBOL(compute_creds);
--- 2.6.7-rc1-mm1/include/linux/personality.h~ingo	2004-05-09 19:32:37.000000000 -0700
+++ 2.6.7-rc1-mm1/include/linux/personality.h	2004-06-04 08:13:33.166133605 -0700
@@ -30,6 +30,7 @@ extern int abi_fake_utsname;
  */
 enum {
 	MMAP_PAGE_ZERO =	0x0100000,
+	ADDR_SPACE_EXECUTABLE =	0x0200000,
 	ADDR_LIMIT_32BIT =	0x0800000,
 	SHORT_INODE =		0x1000000,
 	WHOLE_SECONDS =		0x2000000,
@@ -37,6 +38,8 @@ enum {
 	ADDR_LIMIT_3GB = 	0x8000000,
 };
 
+#define PERS_DROP_ON_SUID (MMAP_PAGE_ZERO|ADDR_SPACE_EXECUTABLE)
+
 /*
  * Personality types.
  *
--- 2.6.7-rc1-mm1/include/asm-i386/elf.h~ingo	2004-05-09 19:32:53.000000000 -0700
+++ 2.6.7-rc1-mm1/include/asm-i386/elf.h	2004-06-04 08:13:33.182129935 -0700
@@ -117,7 +117,8 @@ typedef struct user_fxsr_struct elf_fpxr
 #define AT_SYSINFO_EHDR		33
 
 #ifdef __KERNEL__
-#define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
+/* child inherits the personality of the parent */
+#define SET_PERSONALITY(ex, ibcs2) do { } while (0)
 
 extern int dump_task_regs (struct task_struct *, elf_gregset_t *);
 extern int dump_task_fpu (struct task_struct *, elf_fpregset_t *);

