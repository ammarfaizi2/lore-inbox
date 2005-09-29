Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbVI2Tc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbVI2Tc5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbVI2Tc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:32:57 -0400
Received: from ppp-62-11-74-97.dialup.tiscali.it ([62.11.74.97]:50333 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932445AbVI2Tc4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:32:56 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 3/5] uml: clear SKAS0/3 flags when running in TT mode
Date: Thu, 29 Sep 2005 21:30:44 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20050929193044.14528.13150.stgit@zion.home.lan>
In-Reply-To: <200509292102.44942.blaisorblade@yahoo.it>
References: <200509292102.44942.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

SEGV_MAYBE_FIXABLE tests ptrace_faultinfo, and depends on it being 1 only in
SKAS3 mode, while currently when running with mode=tt it will be 1 anyway. Fix
this, and do the same for proc_mm.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/os.h     |    4 ++++
 arch/um/kernel/um_arch.c |    2 ++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/um/include/os.h b/arch/um/include/os.h
--- a/arch/um/include/os.h
+++ b/arch/um/include/os.h
@@ -157,6 +157,10 @@ extern int os_lock_file(int fd, int excl
 extern void os_early_checks(void);
 extern int can_do_skas(void);
 
+/* Make sure they are clear when running in TT mode. Required by
+ * SEGV_MAYBE_FIXABLE */
+#define clear_can_do_skas() do { ptrace_faultinfo = proc_mm = 0; } while (0)
+
 /* mem.c */
 extern int create_mem_file(unsigned long len);
 
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -334,6 +334,8 @@ int linux_main(int argc, char **argv)
 		add_arg(DEFAULT_COMMAND_LINE);
 
 	os_early_checks();
+	if (force_tt)
+		clear_can_do_skas();
 	mode_tt = force_tt ? 1 : !can_do_skas();
 #ifndef CONFIG_MODE_TT
 	if (mode_tt) {

