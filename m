Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbVI2Tfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbVI2Tfs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbVI2Tc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:32:59 -0400
Received: from ppp-62-11-74-97.dialup.tiscali.it ([62.11.74.97]:50589 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932444AbVI2Tc5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:32:57 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 2/5] uml: fix page faults in SKAS3 mode.
Date: Thu, 29 Sep 2005 21:30:37 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20050929193036.14528.92621.stgit@zion.home.lan>
In-Reply-To: <200509292102.44942.blaisorblade@yahoo.it>
References: <200509292102.44942.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

I hadn't been running a SKAS3 host when testing the "uml: fix hang in TT mode on
fault" patch (commit 546fe1cbf91d4d62e3849517c31a2327c992e5c5), and I didn't
think enough to the missing trap_no in SKAS3 mode.

In fact, the resulting kernel doesn't work at all in SKAS3 mode.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/sysdep-i386/sigcontext.h   |   10 +++++++++-
 arch/um/include/sysdep-x86_64/sigcontext.h |    5 ++++-
 arch/um/kernel/trap_kern.c                 |    5 ++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/um/include/sysdep-i386/sigcontext.h b/arch/um/include/sysdep-i386/sigcontext.h
--- a/arch/um/include/sysdep-i386/sigcontext.h
+++ b/arch/um/include/sysdep-i386/sigcontext.h
@@ -6,6 +6,7 @@
 #ifndef __SYS_SIGCONTEXT_I386_H
 #define __SYS_SIGCONTEXT_I386_H
 
+#include "uml-config.h"
 #include <sysdep/sc.h>
 
 #define IP_RESTART_SYSCALL(ip) ((ip) -= 2)
@@ -26,7 +27,14 @@
 #define SC_START_SYSCALL(sc) do SC_EAX(sc) = -ENOSYS; while(0)
 
 /* This is Page Fault */
-#define SEGV_IS_FIXABLE(fi) ((fi)->trap_no == 14)
+#define SEGV_IS_FIXABLE(fi)	((fi)->trap_no == 14)
+
+/* SKAS3 has no trap_no on i386, but get_skas_faultinfo() sets it to 0. */
+#ifdef UML_CONFIG_MODE_SKAS
+#define SEGV_MAYBE_FIXABLE(fi)	((fi)->trap_no == 0 && ptrace_faultinfo)
+#else
+#define SEGV_MAYBE_FIXABLE(fi)	0
+#endif
 
 extern unsigned long *sc_sigmask(void *sc_ptr);
 extern int sc_get_fpregs(unsigned long buf, void *sc_ptr);
diff --git a/arch/um/include/sysdep-x86_64/sigcontext.h b/arch/um/include/sysdep-x86_64/sigcontext.h
--- a/arch/um/include/sysdep-x86_64/sigcontext.h
+++ b/arch/um/include/sysdep-x86_64/sigcontext.h
@@ -31,7 +31,10 @@
 #define SC_START_SYSCALL(sc) do SC_RAX(sc) = -ENOSYS; while(0)
 
 /* This is Page Fault */
-#define SEGV_IS_FIXABLE(fi) ((fi)->trap_no == 14)
+#define SEGV_IS_FIXABLE(fi)	((fi)->trap_no == 14)
+
+/* No broken SKAS API, which doesn't pass trap_no, here. */
+#define SEGV_MAYBE_FIXABLE(fi)	0
 
 extern unsigned long *sc_sigmask(void *sc_ptr);
 
diff --git a/arch/um/kernel/trap_kern.c b/arch/um/kernel/trap_kern.c
--- a/arch/um/kernel/trap_kern.c
+++ b/arch/um/kernel/trap_kern.c
@@ -26,6 +26,9 @@
 #include "mconsole_kern.h"
 #include "mem.h"
 #include "mem_kern.h"
+#ifdef CONFIG_MODE_SKAS
+#include "skas.h"
+#endif
 
 /* Note this is constrained to return 0, -EFAULT, -EACCESS, -ENOMEM by segv(). */
 int handle_page_fault(unsigned long address, unsigned long ip, 
@@ -134,7 +137,7 @@ unsigned long segv(struct faultinfo fi, 
 	else if(current->mm == NULL)
 		panic("Segfault with no mm");
 
-	if (SEGV_IS_FIXABLE(&fi))
+	if (SEGV_IS_FIXABLE(&fi) || SEGV_MAYBE_FIXABLE(&fi))
 		err = handle_page_fault(address, ip, is_write, is_user, &si.si_code);
 	else {
 		err = -EFAULT;

