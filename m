Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262424AbVAQDdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbVAQDdi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 22:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbVAQDdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 22:33:37 -0500
Received: from pool-151-203-218-166.bos.east.verizon.net ([151.203.218.166]:12548
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262424AbVAQDdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 22:33:33 -0500
Message-Id: <200501170555.j0H5twkY006042@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, Blaisorblade <blaisorblade@yahoo.it>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/10] UML - Provide an arch-specific define for register file size
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 17 Jan 2005 00:55:58 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace FRAME_SIZE_OFFSET with MAX_REG_OFFSET because different arches have
different ideas of what it means.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/arch/um/include/sysdep-i386/ptrace_user.h
===================================================================
--- 2.6.10.orig/arch/um/include/sysdep-i386/ptrace_user.h	2005-01-13 18:17:25.000000000 -0500
+++ 2.6.10/arch/um/include/sysdep-i386/ptrace_user.h	2005-01-13 19:02:33.000000000 -0500
@@ -33,6 +33,9 @@
 #define FP_FRAME_SIZE (27)
 #define FPX_FRAME_SIZE (128)
 
+#define MAX_REG_OFFSET (FRAME_SIZE_OFFSET)
+#define MAX_REG_NR (FRAME_SIZE)
+
 #ifdef PTRACE_GETREGS
 #define UM_HAVE_GETREGS
 #endif
Index: 2.6.10/arch/um/kernel/ptrace.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/ptrace.c	2005-01-13 18:35:19.000000000 -0500
+++ 2.6.10/arch/um/kernel/ptrace.c	2005-01-13 19:03:53.000000000 -0500
@@ -94,7 +94,7 @@
 			break;
 
 		tmp = 0;  /* Default return condition */
-		if(addr < FRAME_SIZE_OFFSET){
+		if(addr < MAX_REG_OFFSET){
 			tmp = getreg(child, addr);
 		}
 		else if((addr >= offsetof(struct user, u_debugreg[0])) &&
@@ -122,10 +122,11 @@
 		if ((addr & 3) || addr < 0)
 			break;
 
-		if (addr < FRAME_SIZE_OFFSET) {
+		if (addr < MAX_REG_OFFSET) {
 			ret = putreg(child, addr, data);
 			break;
 		}
+#if 0 /* XXX x86_64 */
 		else if((addr >= offsetof(struct user, u_debugreg[0])) &&
 			(addr <= offsetof(struct user, u_debugreg[7]))){
 			  addr -= offsetof(struct user, u_debugreg[0]);
@@ -134,6 +135,7 @@
 			  child->thread.arch.debugregs[addr] = data;
 			  ret = 0;
 		}
+#endif
 
 		break;
 
@@ -196,11 +198,11 @@
 #ifdef PTRACE_GETREGS
 	case PTRACE_GETREGS: { /* Get all gp regs from the child. */
 	  	if (!access_ok(VERIFY_WRITE, (unsigned long *)data, 
-			       FRAME_SIZE_OFFSET)) {
+			       MAX_REG_OFFSET)) {
 			ret = -EIO;
 			break;
 		}
-		for ( i = 0; i < FRAME_SIZE_OFFSET; i += sizeof(long) ) {
+		for ( i = 0; i < MAX_REG_OFFSET; i += sizeof(long) ) {
 			__put_user(getreg(child, i),
 				   (unsigned long __user *) data);
 			data += sizeof(long);
@@ -213,11 +215,11 @@
 	case PTRACE_SETREGS: { /* Set all gp regs in the child. */
 		unsigned long tmp = 0;
 	  	if (!access_ok(VERIFY_READ, (unsigned *)data, 
-			       FRAME_SIZE_OFFSET)) {
+			       MAX_REG_OFFSET)) {
 			ret = -EIO;
 			break;
 		}
-		for ( i = 0; i < FRAME_SIZE_OFFSET; i += sizeof(long) ) {
+		for ( i = 0; i < MAX_REG_OFFSET; i += sizeof(long) ) {
 			__get_user(tmp, (unsigned long __user *) data);
 			putreg(child, i, tmp);
 			data += sizeof(long);

