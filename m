Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422813AbWJXXTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422813AbWJXXTl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 19:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422815AbWJXXTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 19:19:41 -0400
Received: from flvpn.ccur.com ([66.10.65.2]:53208 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S1422813AbWJXXTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 19:19:41 -0400
Date: Tue, 24 Oct 2006 19:19:21 -0400
From: Joe Korty <joe.korty@ccur.com>
To: mpm@selenic.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] strange work_notifysig code since 2.6.16
Message-ID: <20061024231921.GA25130@tsunami.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tree 9b5daef5280800a0006343a17f63072658d91a1d is surely wrong.

	[PATCH] Make vm86 support optional
	Jan 8, 2006, tree first appears in 2.6.16

If the branch to work_notifysig_86 is taken and CONFIG_VM86=n,
then entry.S drops into unrelated assembly code.

The branch to work_notifysig_v86, a few lines above the patch, says:
    "returning to kernel-space or vm86-space"
which implies if vm86-space isn't being supported we still need the
branch & jumped-to code in order to handle the kernel case.

However, I don't understand this area all that well, so take this patch
as more of an indication of a possible problem area than as a true fix.

Signed-off-by: Joe Korty <joe.korty@ccur.com>

Index: 2.6.18.1/arch/i386/kernel/entry.S
===================================================================
--- 2.6.18.1.orig/arch/i386/kernel/entry.S	2006-09-19 23:42:06.000000000 -0400
+++ 2.6.18.1/arch/i386/kernel/entry.S	2006-10-24 19:08:36.000000000 -0400
@@ -457,7 +457,6 @@
 
 	ALIGN
 work_notifysig_v86:
-#ifdef CONFIG_VM86
 	pushl %ecx			# save ti_flags for do_notify_resume
 	CFI_ADJUST_CFA_OFFSET 4
 	call save_v86_state		# %eax contains pt_regs pointer
@@ -467,7 +466,6 @@
 	xorl %edx, %edx
 	call do_notify_resume
 	jmp resume_userspace_sig
-#endif
 
 	# perform syscall exit tracing
 	ALIGN
