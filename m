Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbVAMWEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVAMWEG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVAMWDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:03:24 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:44293 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261748AbVAMV63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:58:29 -0500
Subject: [patch 04/11] uml: refuse to run without skas if no tt mode in
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 13 Jan 2005 22:00:56 +0100
Message-Id: <20050113210056.465BEBAB5@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>

Return an early error message when no TT support is compiled in and no SKAS
support is detected.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/kernel/process.c |   35 ++++++++++++++++++++--------
 linux-2.6.11-paolo/arch/um/kernel/um_arch.c |   10 +++++++-
 2 files changed, 35 insertions(+), 10 deletions(-)

diff -puN arch/um/kernel/um_arch.c~uml-refuse-to-run-without-skas-if-no-tt-mode-in arch/um/kernel/um_arch.c
--- linux-2.6.11/arch/um/kernel/um_arch.c~uml-refuse-to-run-without-skas-if-no-tt-mode-in	2005-01-13 21:25:17.601847632 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/um_arch.c	2005-01-13 21:25:17.605847024 +0100
@@ -198,7 +198,7 @@ __uml_setup("ncpus=", uml_ncpus_setup,
 );
 #endif
 
-int force_tt = 0;
+static int force_tt = 0;
 
 #if defined(CONFIG_MODE_TT) && defined(CONFIG_MODE_SKAS)
 #define DEFAULT_TT 0
@@ -319,6 +319,14 @@ int linux_main(int argc, char **argv)
 	if(have_root == 0) add_arg(saved_command_line, DEFAULT_COMMAND_LINE);
 
 	mode_tt = force_tt ? 1 : !can_do_skas();
+#ifndef CONFIG_MODE_TT
+	if (mode_tt) {
+		/*Since CONFIG_MODE_TT is #undef'ed, force_tt cannot be 1. So,
+		 * can_do_skas() returned 0, and the message is correct. */
+		printf("Support for TT mode is disabled, and no SKAS support is present on the host.\n");
+		exit(1);
+	}
+#endif
 	uml_start = CHOOSE_MODE_PROC(set_task_sizes_tt, set_task_sizes_skas, 0,
 				     &host_task_size, &task_size);
 
diff -puN arch/um/kernel/process.c~uml-refuse-to-run-without-skas-if-no-tt-mode-in arch/um/kernel/process.c
--- linux-2.6.11/arch/um/kernel/process.c~uml-refuse-to-run-without-skas-if-no-tt-mode-in	2005-01-13 21:25:17.602847480 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/process.c	2005-01-13 21:25:17.605847024 +0100
@@ -375,9 +375,9 @@ void forward_pending_sigio(int target)
 		kill(target, SIGIO);
 }
 
-int can_do_skas(void)
-{
 #ifdef UML_CONFIG_MODE_SKAS
+static inline int check_skas3_ptrace_support(void)
+{
 	struct ptrace_faultinfo fi;
 	void *stack;
 	int pid, n, ret = 1;
@@ -386,29 +386,46 @@ int can_do_skas(void)
 	pid = start_ptraced_child(&stack);
 
 	n = ptrace(PTRACE_FAULTINFO, pid, 0, &fi);
-	if(n < 0){
+	if (n < 0) {
 		if(errno == EIO)
 			printf("not found\n");
-		else printf("No (unexpected errno - %d)\n", errno);
+		else {
+			perror("not found");
+		}
 		ret = 0;
+	} else {
+		printf("found\n");
 	}
-	else printf("found\n");
 
 	init_registers(pid);
 	stop_ptraced_child(pid, stack, 1, 1);
 
+	return(ret);
+}
+
+int can_do_skas(void)
+{
+	int ret = 1;
+
 	printf("Checking for /proc/mm...");
-	if(os_access("/proc/mm", OS_ACC_W_OK) < 0){
+	if (os_access("/proc/mm", OS_ACC_W_OK) < 0) {
 		printf("not found\n");
 		ret = 0;
+		goto out;
+	} else {
+		printf("found\n");
 	}
-	else printf("found\n");
 
-	return(ret);
+	ret = check_skas3_ptrace_support();
+out:
+	return ret;
+}
 #else
+int can_do_skas(void)
+{
 	return(0);
-#endif
 }
+#endif
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
_
