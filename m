Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbVAJFlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbVAJFlA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 00:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVAJFka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 00:40:30 -0500
Received: from pool-151-203-193-191.bos.east.verizon.net ([151.203.193.191]:23556
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262100AbVAJFOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 00:14:23 -0500
Message-Id: <200501100735.j0A7ZkPW005800@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, bstroesser@fujitsu-siemens.com
Subject: [PATCH 14/28] UML - Don't use __NR_waitpid on arches which don't have it
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jan 2005 02:35:46 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Some architectures (e.g. s390) don't have __NR_waitpid.
Thus, it must not be used in arch/um/kernel/tt/ptproxy/proxy.c

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

diff -puN arch/um/kernel/tt/ptproxy/proxy.c~no-__NR_waitpid arch/um/kernel/tt/ptproxy/proxy.c
--- linux-2.6.10-rc2-mm4/arch/um/kernel/tt/ptproxy/proxy.c~no-__NR_waitpid	2004-12-14 16:38:14.000000000 +0100
+++ linux-2.6.10-rc2-mm4-root/arch/um/kernel/tt/ptproxy/proxy.c	2004-12-14 16:40:26.000000000 +0100
@@ -94,7 +94,9 @@ int debugger_syscall(debugger_state *deb
 		debugger->handle_trace = debugger_syscall;
 		return(ret);
 
+#ifdef __NR_waitpid
 	case __NR_waitpid:
+#endif
 	case __NR_wait4:
 		if(!debugger_wait(debugger, (int *) arg2, arg3, 
 				  debugger_syscall, debugger_normal_return, 
@@ -153,7 +155,11 @@ static int parent_syscall(debugger_state
 
 	syscall = get_syscall(pid, &arg1, &arg2, &arg3, &arg4, &arg5);
 		
-	if((syscall == __NR_waitpid) || (syscall == __NR_wait4)){
+	if((syscall == __NR_wait4)
+#ifdef __NR_waitpid
+	   || (syscall == __NR_waitpid)
+#endif
+	){
 		debugger_wait(&parent, (int *) arg2, arg3, parent_syscall,
 			      parent_normal_return, parent_wait_return);
 	}
_

