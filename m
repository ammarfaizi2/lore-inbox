Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbUKDBzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbUKDBzL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 20:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbUKDBzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 20:55:11 -0500
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:55955
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S262039AbUKDBzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 20:55:00 -0500
Subject: [patch 02/20] Uml: add startup check for mmap(...PROT_EXEC...) from /tmp.
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org,
       blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 04 Nov 2004 00:17:18 +0100
Message-Id: <20041103231719.0CC3A36389@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This adds a check that /tmp is not mounted noexec.  UML needs to be able
to do PROT_EXEC mmaps of temp files.  Previously, a noexec /tmp would
cause an early mysterious UML crash.
(Actually, not /tmp but $TMP, which often is the same).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/include/mem_user.h |    1 
 vanilla-linux-2.6.9-paolo/arch/um/kernel/mem_user.c  |   22 ++++++++++++++++++-
 vanilla-linux-2.6.9-paolo/arch/um/kernel/um_arch.c   |    5 ++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff -puN arch/um/include/mem_user.h~uml-tmp-exec arch/um/include/mem_user.h
--- vanilla-linux-2.6.9/arch/um/include/mem_user.h~uml-tmp-exec	2004-11-03 23:44:37.382877056 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/include/mem_user.h	2004-11-03 23:44:37.387876296 +0100
@@ -67,6 +67,7 @@ extern void map_memory(unsigned long vir
 extern int protect_memory(unsigned long addr, unsigned long len, 
 			  int r, int w, int x, int must_succeed);
 extern unsigned long get_kmem_end(void);
+extern void check_tmpexec(void);
 
 #endif
 
diff -puN arch/um/kernel/mem_user.c~uml-tmp-exec arch/um/kernel/mem_user.c
--- vanilla-linux-2.6.9/arch/um/kernel/mem_user.c~uml-tmp-exec	2004-11-03 23:44:37.383876904 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/mem_user.c	2004-11-03 23:44:37.388876144 +0100
@@ -83,6 +83,26 @@ static int create_tmp_file(unsigned long
 	return(fd);
 }
 
+void check_tmpexec(void)
+{
+	void *addr;
+	int err, fd = create_tmp_file(UM_KERN_PAGE_SIZE);
+
+	addr = mmap(NULL, UM_KERN_PAGE_SIZE,
+		    PROT_READ | PROT_WRITE | PROT_EXEC, MAP_PRIVATE, fd, 0);
+	printf("Checking PROT_EXEC mmap in /tmp...");
+	fflush(stdout);
+	if(addr == MAP_FAILED){
+		err = errno;
+		perror("failed");
+		if(err == EPERM)
+			printf("/tmp must be not mounted noexec\n");
+		exit(1);
+	}
+	printf("OK\n");
+	munmap(addr, UM_KERN_PAGE_SIZE);
+}
+
 static int have_devanon = 0;
 
 void check_devanon(void)
@@ -111,7 +131,7 @@ static int create_anon_file(unsigned lon
 		exit(1);
 	}
 
-	addr = mmap(NULL, len, PROT_READ | PROT_WRITE , MAP_PRIVATE, fd, 0);
+	addr = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	if(addr == MAP_FAILED){
 		os_print_error((int) addr, "mapping physmem file");
 		exit(1);
diff -puN arch/um/kernel/um_arch.c~uml-tmp-exec arch/um/kernel/um_arch.c
--- vanilla-linux-2.6.9/arch/um/kernel/um_arch.c~uml-tmp-exec	2004-11-03 23:44:37.385876600 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/um_arch.c	2004-11-03 23:44:37.388876144 +0100
@@ -321,6 +321,11 @@ int linux_main(int argc, char **argv)
 	uml_start = CHOOSE_MODE_PROC(set_task_sizes_tt, set_task_sizes_skas, 0,
 				     &host_task_size, &task_size);
 
+	/* Need to check this early because mmapping happens before the
+	 * kernel is running.
+	 */
+	check_tmpexec();
+
 	brk_start = (unsigned long) sbrk(0);
 	CHOOSE_MODE_PROC(before_mem_tt, before_mem_skas, brk_start);
 	/* Increase physical memory size for exec-shield users
_
