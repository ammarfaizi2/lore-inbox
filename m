Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVCOTEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVCOTEA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 14:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVCOTB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 14:01:28 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:32902 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261793AbVCOS4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 13:56:34 -0500
Subject: [patch 1/1] uml: fixlet for arch_prctl_skas
To: jdike@addtoit.com
Cc: bstroesser@fujitsu-siemens.com,
       user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Sat, 12 Mar 2005 19:04:35 +0100
Message-Id: <20050312180438.AFC16647B@zion>
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

 linux-2.6.11-paolo/arch/um/sys-x86_64/syscalls.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff -puN arch/um/sys-x86_64/syscalls.c~uml-fixlet-arch-prctl arch/um/sys-x86_64/syscalls.c
--- linux-2.6.11/arch/um/sys-x86_64/syscalls.c~uml-fixlet-arch-prctl	2005-03-10 17:25:56.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/sys-x86_64/syscalls.c	2005-03-10 17:32:05.000000000 +0100
@@ -129,23 +129,27 @@ static long arch_prctl_tt(int code, unsi
 
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
+		ret = put_user(current->thread.regs.regs.skas.regs[
+				FS_BASE / sizeof(unsigned long)],
+				(unsigned long __user *)addr);
 	        break;
 	case ARCH_GET_GS:
-		ret = put_user(current->thread.regs.regs.skas.regs[FS / sizeof(unsigned \
-long)], &addr);
+		ret = put_user(current->thread.regs.regs.skas.regs[
+				GS_BASE / sizeof(unsigned long)],
+				(unsigned long __user *)addr);
 	        break;
 	default:
 		ret = -EINVAL;
_
