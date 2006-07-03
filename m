Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWGCJrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWGCJrX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 05:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWGCJrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 05:47:23 -0400
Received: from canuck.infradead.org ([205.233.218.70]:34993 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751046AbWGCJrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 05:47:23 -0400
Subject: [PATCH 2/2] pselect/ppoll support on x86_64
From: David Woodhouse <dwmw2@infradead.org>
To: ak@muc.de
Cc: drepper@redhat.com, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1151919711.3000.82.camel@pmac.infradead.org>
References: <1151919711.3000.82.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 10:47:15 +0100
Message-Id: <1151920035.3000.88.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the pselect and ppoll system calls on x86_64. 

Andi suggests that it might be too late for the 2.6.18 merge window -- I
disagree. I consider it a bug fix, since I don't think we intend x86_64
to be a secondary architecture and lag behind i386 and PowerPC in its
system call support. Andi's TIF_RESTORE_SIGMASK implementation is
heavily based on the i386 version, where it's had lots of testing
already.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/arch/x86_64/ia32/ia32entry.S b/arch/x86_64/ia32/ia32entry.S
index 5a92fed..07399fe 100644
--- a/arch/x86_64/ia32/ia32entry.S
+++ b/arch/x86_64/ia32/ia32entry.S
@@ -687,8 +687,8 @@ #endif
 	.quad sys_readlinkat		/* 305 */
 	.quad sys_fchmodat
 	.quad sys_faccessat
-	.quad quiet_ni_syscall		/* pselect6 for now */
-	.quad quiet_ni_syscall		/* ppoll for now */
+	.quad compat_sys_pselect6
+	.quad compat_sys_ppoll
 	.quad sys_unshare		/* 310 */
 	.quad compat_sys_set_robust_list
 	.quad compat_sys_get_robust_list
diff --git a/include/asm-x86_64/unistd.h b/include/asm-x86_64/unistd.h
index feb77cb..0a08bbf 100644
--- a/include/asm-x86_64/unistd.h
+++ b/include/asm-x86_64/unistd.h
@@ -600,9 +600,9 @@ __SYSCALL(__NR_fchmodat, sys_fchmodat)
 #define __NR_faccessat		269
 __SYSCALL(__NR_faccessat, sys_faccessat)
 #define __NR_pselect6		270
-__SYSCALL(__NR_pselect6, sys_ni_syscall)	/* for now */
+__SYSCALL(__NR_pselect6, sys_pselect6)
 #define __NR_ppoll		271
-__SYSCALL(__NR_ppoll,	sys_ni_syscall)		/* for now */
+__SYSCALL(__NR_ppoll,	sys_ppoll)
 #define __NR_unshare		272
 __SYSCALL(__NR_unshare,	sys_unshare)
 #define __NR_set_robust_list	273


-- 
dwmw2

