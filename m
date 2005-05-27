Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVE0BOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVE0BOz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 21:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVE0BOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 21:14:18 -0400
Received: from [151.97.230.9] ([151.97.230.9]:58385 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261865AbVE0BFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 21:05:35 -0400
Subject: [patch 5/8] uml: fixlet for arch_prctl_skas
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 27 May 2005 02:38:46 +0200
Message-Id: <20050527003846.909B81AEE8A@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix it a bit (after some cross checking with "man arch_prctl"). There were:
*) typos FS/GS and back
*) FS in place of FS_BASE (and the same for GS)
*) the procedure used put_user on &addr, where addr was the parameter (i.e.
changed its param with put_user, completely useless) rather than interpreting
addr as a pointer, as requested in this case (see the man page).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/sys-x86_64/syscalls.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff -puN arch/um/sys-x86_64/syscalls.c~uml-fixlet-arch-prctl arch/um/sys-x86_64/syscalls.c
--- linux-2.6.git/arch/um/sys-x86_64/syscalls.c~uml-fixlet-arch-prctl	2005-05-25 01:13:20.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/sys-x86_64/syscalls.c	2005-05-25 01:14:05.000000000 +0200
@@ -133,23 +133,27 @@ static long arch_prctl_tt(int code, unsi
 
 #ifdef CONFIG_MODE_SKAS
 
+/* XXX: Must also call arch_prctl in the host, beside saving the segment bases! */
 static long arch_prctl_skas(int code, unsigned long addr)
 {
 	long ret = 0;
 
 	switch(code){
-	case ARCH_SET_GS:
-		current->thread.regs.regs.skas.regs[GS_BASE / sizeof(unsigned long)] = addr;
-		break;
 	case ARCH_SET_FS:
 		current->thread.regs.regs.skas.regs[FS_BASE / sizeof(unsigned long)] = addr;
 		break;
+	case ARCH_SET_GS:
+		current->thread.regs.regs.skas.regs[GS_BASE / sizeof(unsigned long)] = addr;
+		break;
 	case ARCH_GET_FS:
-		ret = put_user(current->thread.regs.regs.skas.regs[GS / sizeof(unsigned long)], &addr);
+		ret = put_user(current->thread.regs.regs.skas.
+				regs[FS_BASE / sizeof(unsigned long)],
+				(unsigned long __user *)addr);
 	        break;
 	case ARCH_GET_GS:
-		ret = put_user(current->thread.regs.regs.skas.regs[FS / sizeof(unsigned \
-long)], &addr);
+		ret = put_user(current->thread.regs.regs.skas.
+				regs[GS_BASE / sizeof(unsigned long)],
+				(unsigned long __user *)addr);
 	        break;
 	default:
 		ret = -EINVAL;
_
