Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282000AbRKVAac>; Wed, 21 Nov 2001 19:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282003AbRKVAaX>; Wed, 21 Nov 2001 19:30:23 -0500
Received: from t2.redhat.com ([199.183.24.243]:13043 "EHLO dot.cygnus.com")
	by vger.kernel.org with ESMTP id <S282000AbRKVAaQ>;
	Wed, 21 Nov 2001 19:30:16 -0500
Date: Wed, 21 Nov 2001 16:30:11 -0800
From: Richard Henderson <rth@redhat.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [alpha] emulate osf/1 sys_indirect
Message-ID: <20011121163011.A793@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed that Netscape wanted to use it.


r~



--- arch/alpha/kernel/entry.S.orig	Wed Nov 21 15:59:16 2001
+++ arch/alpha/kernel/entry.S	Wed Nov 21 16:22:09 2001
@@ -488,6 +488,26 @@ entUnaUser:
 .end	entUnaUser
 
 /*
+ * No idea why OSF/1 didn't implement syscall(3) in userland.
+ * Implement this by shifting the registers around, backing up
+ * the pc to the callsys, and returning to usermode.
+ */
+.align 3
+.ent	sys_indirect
+sys_indirect:
+	ldq	$1, SP_OFF+8($30)
+	stq	$16, 0($30)
+	stq	$17, SP_OFF+24($30)
+	stq	$18, SP_OFF+32($30)
+	stq	$19, SP_OFF+40($30)
+	stq	$20, 72($30)
+	stq	$21, 80($30)
+	subq	$1, 4, $1
+	stq	$1, SP_OFF+8($30)
+	br	restore_all
+.end sys_indirect
+
+/*
  * A fork is the same as clone(SIGCHLD, 0);
  */
 .align 3
@@ -765,7 +785,7 @@ sys_rt_sigsuspend:
 	.align 3
 	.globl sys_call_table
 sys_call_table:
-	.quad alpha_ni_syscall			/* 0 */
+	.quad sys_indirect			/* 0 */
 	.quad sys_exit
 	.quad sys_fork
 	.quad sys_read
