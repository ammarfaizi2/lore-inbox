Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWDGOdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWDGOdh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 10:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWDGOcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 10:32:33 -0400
Received: from [151.97.230.9] ([151.97.230.9]:36572 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932347AbWDGOcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 10:32:24 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 05/17] uml: fix format errors
Date: Fri, 07 Apr 2006 16:31:00 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060407143059.19201.58265.stgit@zion.home.lan>
In-Reply-To: <20060407142709.19201.99196.stgit@zion.home.lan>
References: <20060407142709.19201.99196.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Now that GCC warns about format errors, fix them. Nothing able to cause a crash,
however.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/slirp_user.c             |    2 +-
 arch/um/os-Linux/drivers/ethertap_user.c |    2 +-
 arch/um/os-Linux/skas/mem.c              |    4 ++--
 arch/um/os-Linux/skas/process.c          |    4 ++--
 arch/um/sys-i386/ptrace_user.c           |    2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/um/drivers/slirp_user.c b/arch/um/drivers/slirp_user.c
index b94c661..33c5f6e 100644
--- a/arch/um/drivers/slirp_user.c
+++ b/arch/um/drivers/slirp_user.c
@@ -104,7 +104,7 @@ static void slirp_close(int fd, void *da
 	}
 
 	if(err == 0) {
-		printk("slirp_close: process %d has not exited\n");
+		printk("slirp_close: process %d has not exited\n", pri->pid);
 		return;
 	}
 
diff --git a/arch/um/os-Linux/drivers/ethertap_user.c b/arch/um/os-Linux/drivers/ethertap_user.c
index 901b85e..8f49507 100644
--- a/arch/um/os-Linux/drivers/ethertap_user.c
+++ b/arch/um/os-Linux/drivers/ethertap_user.c
@@ -40,7 +40,7 @@ static void etap_change(int op, unsigned
 			int fd)
 {
 	struct addr_change change;
-	void *output;
+	char *output;
 	int n;
 
 	change.what = op;
diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-Linux/skas/mem.c
index fbb080c..b3c11cf 100644
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -82,8 +82,8 @@ static inline long do_syscall_stub(struc
 	if (offset) {
 		data = (unsigned long *)(mm_idp->stack +
 					 offset - UML_CONFIG_STUB_DATA);
-		printk("do_syscall_stub : ret = %d, offset = %d, "
-		       "data = 0x%x\n", ret, offset, data);
+		printk("do_syscall_stub : ret = %ld, offset = %ld, "
+		       "data = %p\n", ret, offset, data);
 		syscall = (unsigned long *)((unsigned long)data + data[0]);
 		printk("do_syscall_stub: syscall %ld failed, return value = "
 		       "0x%lx, expected return value = 0x%lx\n",
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index bbf34cb..045ae00 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -265,7 +265,7 @@ void userspace(union uml_pt_regs *regs)
 		if(err)
 			panic("userspace - could not resume userspace process, "
 			      "pid=%d, ptrace operation = %d, errno = %d\n",
-			      op, errno);
+			      pid, op, errno);
 
 		CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED));
 		if(err < 0)
@@ -369,7 +369,7 @@ int copy_context_skas0(unsigned long new
 	 */
 	wait_stub_done(pid, -1, "copy_context_skas0");
 	if (child_data->err != UML_CONFIG_STUB_DATA)
-		panic("copy_context_skas0 - stub-child reports error %d\n",
+		panic("copy_context_skas0 - stub-child reports error %ld\n",
 		      child_data->err);
 
 	if (ptrace(PTRACE_OLDSETOPTIONS, pid, NULL,
diff --git a/arch/um/sys-i386/ptrace_user.c b/arch/um/sys-i386/ptrace_user.c
index 9f3bd8e..40aa885 100644
--- a/arch/um/sys-i386/ptrace_user.c
+++ b/arch/um/sys-i386/ptrace_user.c
@@ -57,7 +57,7 @@ static void write_debugregs(int pid, uns
 		if(ptrace(PTRACE_POKEUSR, pid, &dummy->u_debugreg[i],
 			  regs[i]) < 0)
 			printk("write_debugregs - ptrace failed on "
-			       "register %d, value = 0x%x, errno = %d\n", i,
+			       "register %d, value = 0x%lx, errno = %d\n", i,
 			       regs[i], errno);
 	}
 }
