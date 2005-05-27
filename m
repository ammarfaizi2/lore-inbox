Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVE0BPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVE0BPK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 21:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVE0BPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 21:15:05 -0400
Received: from [151.97.230.9] ([151.97.230.9]:60177 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261612AbVE0BFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 21:05:36 -0400
Subject: [patch 8/8] uml: remove jail mode + other leftovers
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 27 May 2005 02:38:54 +0200
Message-Id: <20050527003854.C1C351AEE90@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This var is currently useless, as it's apparent from reading the code. Until
2.6.11 it was used in some code related to jail mode, in the same proc.:

        if(jail){
		while(!reading) sched_yield();
	}

jail mode has been dropped, together with that use, so let's finish dropping
this.

Also, remove some other useless definitions I met.

Acked-by: Jeff Dike <jdike@addtoit.com>

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/kernel/tt/process_kern.c |    8 +-------
 linux-2.6.git-paolo/arch/um/kernel/um_arch.c         |    6 ------
 linux-2.6.git-paolo/include/asm-um/pgtable.h         |    8 --------
 3 files changed, 1 insertion(+), 21 deletions(-)

diff -puN arch/um/kernel/tt/process_kern.c~uml-remove-jail-rem arch/um/kernel/tt/process_kern.c
--- linux-2.6.git/arch/um/kernel/tt/process_kern.c~uml-remove-jail-rem	2005-05-10 00:06:20.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/tt/process_kern.c	2005-05-10 00:06:42.000000000 +0200
@@ -32,10 +32,6 @@ void *switch_to_tt(void *prev, void *nex
 	unsigned long flags;
 	int err, vtalrm, alrm, prof, cpu;
 	char c;
-	/* jailing and SMP are incompatible, so this doesn't need to be 
-	 * made per-cpu 
-	 */
-	static int reading;
 
 	from = prev;
 	to = next;
@@ -59,13 +55,11 @@ void *switch_to_tt(void *prev, void *nex
 	c = 0;
 	set_current(to);
 
-	reading = 0;
 	err = os_write_file(to->thread.mode.tt.switch_pipe[1], &c, sizeof(c));
 	if(err != sizeof(c))
 		panic("write of switch_pipe failed, err = %d", -err);
 
-	reading = 1;
-        if(from->thread.mode.tt.switch_pipe[0] == -1)
+	if(from->thread.mode.tt.switch_pipe[0] == -1)
 		os_kill_process(os_getpid(), 0);
 
 	err = os_read_file(from->thread.mode.tt.switch_pipe[0], &c, sizeof(c));
diff -puN arch/um/kernel/um_arch.c~uml-remove-jail-rem arch/um/kernel/um_arch.c
--- linux-2.6.git/arch/um/kernel/um_arch.c~uml-remove-jail-rem	2005-05-10 00:06:20.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/um_arch.c	2005-05-10 00:06:20.000000000 +0200
@@ -111,12 +111,6 @@ struct seq_operations cpuinfo_op = {
 	.show	= show_cpuinfo,
 };
 
-pte_t * __bad_pagetable(void)
-{
-	panic("Someone should implement __bad_pagetable");
-	return(NULL);
-}
-
 /* Set in linux_main */
 unsigned long host_task_size;
 unsigned long task_size;
diff -puN include/asm-um/pgtable.h~uml-remove-jail-rem include/asm-um/pgtable.h
--- linux-2.6.git/include/asm-um/pgtable.h~uml-remove-jail-rem	2005-05-10 00:06:20.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-um/pgtable.h	2005-05-10 00:06:20.000000000 +0200
@@ -114,17 +114,9 @@ extern unsigned long end_iomem;
 extern unsigned long pg0[1024];
 
 /*
- * BAD_PAGETABLE is used when we need a bogus page-table, while
- * BAD_PAGE is used for a bogus page.
- *
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
  */
-extern pte_t __bad_page(void);
-extern pte_t * __bad_pagetable(void);
-
-#define BAD_PAGETABLE __bad_pagetable()
-#define BAD_PAGE __bad_page()
 
 #define ZERO_PAGE(vaddr) virt_to_page(empty_zero_page)
 
_
