Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262776AbVDYTWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbVDYTWH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 15:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbVDYTSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 15:18:30 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:2763 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S262756AbVDYTRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 15:17:37 -0400
Subject: [patch 1/1] uml: fix handling of no fpx_regs [critical, for 2.6.12]
To: akpm@osdl.org
Cc: jdike@addtoit.com, bstroesser@fujitsu-siemens.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       aleidenf@bigpond.net.au
From: blaisorblade@yahoo.it
Date: Mon, 25 Apr 2005 21:12:51 +0200
Message-Id: <20050425191253.B9FE045EBB@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Andree Leidenfrost <aleidenf@bigpond.net.au>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Fix the error path, which is triggered when the processor misses the fpx regs
(i.e. the "fxsr" cpuinfo feature). For instance by VIA C3 Samuel2. Tested and
obvious, please merge ASAP.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/arch/um/os-Linux/sys-i386/registers.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff -puN arch/um/os-Linux/sys-i386/registers.c~uml-fix-no_fpx_regs_handling arch/um/os-Linux/sys-i386/registers.c
--- linux-2.6.12/arch/um/os-Linux/sys-i386/registers.c~uml-fix-no_fpx_regs_handling	2005-04-25 21:03:11.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/os-Linux/sys-i386/registers.c	2005-04-25 21:08:07.000000000 +0200
@@ -105,14 +105,15 @@ void init_registers(int pid)
 		panic("check_ptrace : PTRACE_GETREGS failed, errno = %d",
 		      err);
 
+	errno = 0;
 	err = ptrace(PTRACE_GETFPXREGS, pid, 0, exec_fpx_regs);
 	if(!err)
 		return;
+	if(errno != EIO)
+		panic("check_ptrace : PTRACE_GETFPXREGS failed, errno = %d",
+		      errno);
 
 	have_fpx_regs = 0;
-	if(err != EIO)
-		panic("check_ptrace : PTRACE_GETFPXREGS failed, errno = %d",
-		      err);
 
 	err = ptrace(PTRACE_GETFPREGS, pid, 0, exec_fp_regs);
 	if(err)
_
