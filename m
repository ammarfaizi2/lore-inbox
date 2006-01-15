Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWAOUsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWAOUsI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 15:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWAOUr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 15:47:57 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:29859 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750772AbWAOUrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 15:47:52 -0500
Message-Id: <200601152139.k0FLdm0G027742@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 8/11] UML - Eliminate some globals
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 15 Jan 2006 16:39:48 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stop using global variables to hold the file descriptor and offset used to
map the skas0 stubs.  Instead, calculate them using the page physical 
addresses.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/os-Linux/skas/process.c	2006-01-09 11:39:54.000000000 -0500
+++ linux-2.6.15-mm/arch/um/os-Linux/skas/process.c	2006-01-09 11:40:33.000000000 -0500
@@ -151,8 +151,6 @@ static void handle_trap(int pid, union u
 }
 
 extern int __syscall_stub_start;
-int stub_code_fd = -1;
-__u64 stub_code_offset;
 
 static int userspace_tramp(void *stack)
 {
@@ -167,30 +165,30 @@ static int userspace_tramp(void *stack)
 		/* This has a pte, but it can't be mapped in with the usual
 		 * tlb_flush mechanism because this is part of that mechanism
 		 */
+		int fd;
+		__u64 offset;
+		fd = phys_mapping(to_phys(&__syscall_stub_start), &offset);
 		addr = mmap64((void *) UML_CONFIG_STUB_CODE, page_size(),
-			      PROT_EXEC, MAP_FIXED | MAP_PRIVATE,
-			      stub_code_fd, stub_code_offset);
+			      PROT_EXEC, MAP_FIXED | MAP_PRIVATE, fd, offset);
 		if(addr == MAP_FAILED){
-			printk("mapping stub code failed, errno = %d\n",
+			printk("mapping mmap stub failed, errno = %d\n",
 			       errno);
 			exit(1);
 		}
 
 		if(stack != NULL){
-			int fd;
-			__u64 offset;
 			fd = phys_mapping(to_phys(stack), &offset);
 			addr = mmap((void *) UML_CONFIG_STUB_DATA, page_size(),
 				    PROT_READ | PROT_WRITE,
 				    MAP_FIXED | MAP_SHARED, fd, offset);
 			if(addr == MAP_FAILED){
-				printk("mapping stub stack failed, "
+				printk("mapping segfault stack failed, "
 				       "errno = %d\n", errno);
 				exit(1);
 			}
 		}
 	}
-	if(!ptrace_faultinfo){
+	if(!ptrace_faultinfo && (stack != NULL)){
 		unsigned long v = UML_CONFIG_STUB_CODE +
 				  (unsigned long) stub_segv_handler -
 				  (unsigned long) &__syscall_stub_start;
@@ -216,10 +214,6 @@ int start_userspace(unsigned long stub_s
 	unsigned long sp;
 	int pid, status, n, flags;
 
-	if ( stub_code_fd == -1 )
-		stub_code_fd = phys_mapping(to_phys(&__syscall_stub_start),
-					    &stub_code_offset);
-
 	stack = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
 		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	if(stack == MAP_FAILED)
@@ -306,7 +300,6 @@ void userspace(union uml_pt_regs *regs)
 			        printk("userspace - child stopped with signal "
 				       "%d\n", WSTOPSIG(status));
 			}
-		    again:
 			pid = userspace_pid[0];
 			interrupt_end();
 
@@ -395,6 +388,9 @@ void map_stub_pages(int fd, unsigned lon
 {
 	struct proc_mm_op mmop;
 	int n;
+	__u64 code_offset;
+	int code_fd = phys_mapping(to_phys((void *) &__syscall_stub_start),
+				   &code_offset);
 
 	mmop = ((struct proc_mm_op) { .op        = MM_MMAP,
 				      .u         =
@@ -403,8 +399,8 @@ void map_stub_pages(int fd, unsigned lon
 					  .len     = PAGE_SIZE,
 					  .prot    = PROT_EXEC,
 					  .flags   = MAP_FIXED | MAP_PRIVATE,
-					  .fd      = stub_code_fd,
-					  .offset  = stub_code_offset
+					  .fd      = code_fd,
+					  .offset  = code_offset
 	} } });
 	n = os_write_file(fd, &mmop, sizeof(mmop));
 	if(n != sizeof(mmop))

