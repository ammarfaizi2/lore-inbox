Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbULNQL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbULNQL7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 11:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbULNQL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 11:11:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5060 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261537AbULNQLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 11:11:44 -0500
From: David Howells <dhowells@redhat.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FRV debugging fixes
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.3
Date: Tue, 14 Dec 2004 16:11:39 +0000
Message-ID: <9348.1103040699@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch fixes three debugging problems in the frv arch:

 (1) Single-stepping in userspace steps through into the kernel-mode interrupt
     handler when a hardware interrupt happens, and sometimes it gets past
     where the debug-mode handler would normally catch it. This patch extends
     the range of detected PC values.

 (2) When setting up the kernel-mode exception frame from the debug-mode
     handler for a userspace debugging event, we weren't setting the LR
     register to generate a return to the exception handler epilogue.

 (3) sys_ptrace() now needs to "put" the inferior task_struct not "free" it as
     was done in 2.4.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat frv-debug-2610rc3.diff 
 break.S  |    7 +++++++
 ptrace.c |    2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff -uNr linux-2.6.10-rc3-mm1-mmcleanup/arch/frv/kernel/break.S linux-2.6.10-rc3-mm1-misc/arch/frv/kernel/break.S
--- linux-2.6.10-rc3-mm1-mmcleanup/arch/frv/kernel/break.S	2004-12-13 17:33:50.000000000 +0000
+++ linux-2.6.10-rc3-mm1-misc/arch/frv/kernel/break.S	2004-12-13 19:28:04.000000000 +0000
@@ -202,6 +202,10 @@
 	setlo		%lo(__entry_kernel_external_interrupt),gr3
 	subcc		gr2,gr3,gr0,icc0
 	beq		icc0,#2,__break_step_kernel_external_interrupt
+	sethi.p		%hi(__entry_uspace_external_interrupt),gr3
+	setlo		%lo(__entry_uspace_external_interrupt),gr3
+	subcc		gr2,gr3,gr0,icc0
+	beq		icc0,#2,__break_step_uspace_external_interrupt
 
 	LEDS		0x2007,gr2
 
@@ -483,6 +487,9 @@
 	movgs		gr2,bpsr
 
 	# return through remainder of the exception prologue
+	# - need to load gr23 with return handler address
+	sethi.p		%hi(__entry_return_from_user_exception),gr23
+	setlo		%lo(__entry_return_from_user_exception),gr23
 	sethi.p		%hi(__entry_common),gr3
 	setlo		%lo(__entry_common),gr3
 	movgs		gr3,bpcsr
diff -uNr linux-2.6.10-rc3-mm1-mmcleanup/arch/frv/kernel/ptrace.c linux-2.6.10-rc3-mm1-misc/arch/frv/kernel/ptrace.c
--- linux-2.6.10-rc3-mm1-mmcleanup/arch/frv/kernel/ptrace.c	2004-12-13 17:33:50.000000000 +0000
+++ linux-2.6.10-rc3-mm1-misc/arch/frv/kernel/ptrace.c	2004-12-13 19:28:11.000000000 +0000
@@ -358,7 +358,7 @@
 		break;
 	}
 out_tsk:
-	free_task_struct(child);
+	put_task_struct(child);
 out:
 	unlock_kernel();
 	return ret;
