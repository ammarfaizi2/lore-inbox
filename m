Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268758AbUILRYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268758AbUILRYK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 13:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268759AbUILRYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 13:24:10 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:38074 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S268758AbUILRX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 13:23:58 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] nptl/sys_clone fix for i386/ppc
Date: Sun, 12 Sep 2004 17:52:44 +0200
User-Agent: KMail/1.6.1
Cc: Jeff Dike <jdike@addtoit.com>, David Jeffery <djeffery@britsys.net>,
       linux-kernel@vger.kernel.org
References: <20040826020626.GA28471@malice.crymeariver.org> <200409111745.18659.blaisorblade_spam@yahoo.it> <20040911182615.GB2966@ccure.user-mode-linux.org>
In-Reply-To: <20040911182615.GB2966@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200409121752.07398.blaisorblade_spam@yahoo.it>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_MDHRBeb9DAvNJSw"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_MDHRBeb9DAvNJSw
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

[For LKML: CC me on replies, I'm not subscribed]
On Saturday 11 September 2004 20:26, Jeff Dike wrote:
> > Jeff, please fix your patch again - the unused argument is the fourth,
> > not the third:
>
> Crap, I went to the trouble of confirming this in the i386 code, and
> ended up miscounting arguments.  It still worked, though.

It worked no worse than current version (which is broken). In fact the 2.4 
clone had 2 arguments. So it's obvious.

I checked in the i386 code (the _syscall5 macro and the sys_clone definition). 
And the patch from David is the correct one:

This says where args go (from unistd.h, macro _syscall5):
        : "0" (__NR_##name),"b" ((long)(arg1)),"c" ((long)(arg2)), \
          "d" ((long)(arg3)),"S" ((long)(arg4)),"D" ((long)(arg5))); \

And this is the i386 code, with some comments, especially about the three 
remaining problems:

asmlinkage int sys_clone(struct pt_regs regs)
{
        unsigned long clone_flags;
        unsigned long newsp;
        int __user *parent_tidptr, *child_tidptr;

        clone_flags = regs.ebx; //arg1
        newsp = regs.ecx; //arg2
        parent_tidptr = (int __user *)regs.edx; //arg3
        child_tidptr = (int __user *)regs.edi; //arg5
/*XXX: Shouldn't UML implement this?*/
        if (!newsp)
                newsp = regs.esp;
/*XXX: UML forgets the "& ~ CLONE_IDLETASK". */
/*And also UML does not pass regs.*/
        return do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0, 
parent_tidptr, child_tidptr);
}

Now, the CLONE_IDLETASK must be copied straight into our version. Pretty 
clear, that flag is for kernelspace callers of do_fork() only.

Security problem? I guess possibly (in the meaning used by OpenBSD, i.e. it is 
a security concern, because somehow could discover that this is exploitable).

Instead, luckily, both newsp and regs are passed unchanged to the arch code 
(the arch-independent code ignores them), and exactly to copy_thread. And the 
Uml version is ready to deal with this API, luckily.

However, this is non-standard. I've added just a comment for now, since you 
may have reason to keep the current code, but such behaviour calls for 
breakage when things change.

The attached patch replaces the one on your page.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



--Boundary-00=_MDHRBeb9DAvNJSw
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="uml-fix-sys-clone-NPTL.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="uml-fix-sys-clone-NPTL.patch"


* Make sys_clone subarch-dependant
* Since i386 sys_clone skips reading %edi, the third param is unused
* Also, avoid passing to do_fork the CLONE_IDLETASK flag.
* Add a comment about the special calling convention used by UML for
do_fork and copy_thread.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/kernel/syscall_kern.c |   11 ---------
 uml-linux-2.6.8.1-paolo/arch/um/sys-i386/syscalls.c   |   20 ++++++++++++++++++
 2 files changed, 20 insertions(+), 11 deletions(-)

diff -puN arch/um/kernel/syscall_kern.c~uml-fix-sys-clone-NPTL arch/um/kernel/syscall_kern.c
--- uml-linux-2.6.8.1/arch/um/kernel/syscall_kern.c~uml-fix-sys-clone-NPTL	2004-09-12 17:36:49.061595744 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/syscall_kern.c	2004-09-12 17:36:49.064595288 +0200
@@ -44,17 +44,6 @@ long sys_fork(void)
 	return(ret);
 }
 
-long sys_clone(unsigned long clone_flags, unsigned long newsp, 
-	       int *parent_tid, int *child_tid)
-{
-	long ret;
-
-	current->thread.forking = 1;
-	ret = do_fork(clone_flags, newsp, NULL, 0, parent_tid, child_tid);
-	current->thread.forking = 0;
-	return(ret);
-}
-
 long sys_vfork(void)
 {
 	long ret;
diff -puN arch/um/sys-i386/syscalls.c~uml-fix-sys-clone-NPTL arch/um/sys-i386/syscalls.c
--- uml-linux-2.6.8.1/arch/um/sys-i386/syscalls.c~uml-fix-sys-clone-NPTL	2004-09-12 17:36:49.062595592 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/sys-i386/syscalls.c	2004-09-12 17:36:49.065595136 +0200
@@ -3,6 +3,7 @@
  * Licensed under the GPL
  */
 
+#include "linux/sched.h"
 #include "asm/mman.h"
 #include "asm/uaccess.h"
 #include "asm/unistd.h"
@@ -56,6 +57,25 @@ int old_select(struct sel_arg_struct *ar
 	return sys_select(a.n, a.inp, a.outp, a.exp, a.tvp);
 }
 
+/* The i386 version skips reading from %esi, the fourth argument. So we must do
+ * this, too.*/
+int sys_clone(unsigned long clone_flags, unsigned long newsp, int *parent_tid,
+		int unused, int *child_tid)
+{
+	long ret;
+
+	/* XXX: normal arch do here this pass, and also pass the regs to do_fork,
+	 * instead of NULL. Currently the arch-independent code ignores these
+	 * values, while the UML code (actually it's copy_thread) does the right
+	 * thing. But this should change, probably. */
+	/*if (!newsp)
+		newsp = UPT_SP(current->thread.regs);*/
+	current->thread.forking = 1;
+	ret = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, NULL, 0, parent_tid, child_tid);
+	current->thread.forking = 0;
+	return(ret);
+}
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
_

--Boundary-00=_MDHRBeb9DAvNJSw--

