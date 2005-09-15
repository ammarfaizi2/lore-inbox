Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030350AbVIOCiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbVIOCiZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 22:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbVIOCiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 22:38:25 -0400
Received: from fmr19.intel.com ([134.134.136.18]:21965 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030350AbVIOCiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 22:38:25 -0400
Subject: [PATCH]FPU context corrupted after resume
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain
Date: Thu, 15 Sep 2005 10:44:18 +0800
Message-Id: <1126752258.11133.4.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
mxcsr_feature_mask_init isn't needed in suspend/resume time (we can use boot
time mask). And actually it's harmful, as it clear task's saved fxsave in resume.
This bug is widely seen by users using zsh.


Signed-off-by: Shaohua Li<shaohua.li@intel.com>
---

 linux-2.6.13-root/arch/i386/power/cpu.c        |    1 -
 linux-2.6.13-root/arch/x86_64/kernel/suspend.c |    1 -
 2 files changed, 2 deletions(-)

diff -puN arch/i386/power/cpu.c~fpu_reinit_after_resume arch/i386/power/cpu.c
--- linux-2.6.13/arch/i386/power/cpu.c~fpu_reinit_after_resume	2005-09-14 09:35:13.000000000 +0800
+++ linux-2.6.13-root/arch/i386/power/cpu.c	2005-09-14 11:00:55.000000000 +0800
@@ -74,7 +74,6 @@ do_fpu_end(void)
         /* restore FPU regs if necessary */
 	/* Do it out of line so that gcc does not move cr0 load to some stupid place */
         kernel_fpu_end();
-	mxcsr_feature_mask_init();
 }
 
 
diff -puN arch/x86_64/kernel/suspend.c~fpu_reinit_after_resume arch/x86_64/kernel/suspend.c
--- linux-2.6.13/arch/x86_64/kernel/suspend.c~fpu_reinit_after_resume	2005-09-14 11:02:21.000000000 +0800
+++ linux-2.6.13-root/arch/x86_64/kernel/suspend.c	2005-09-14 11:02:41.000000000 +0800
@@ -82,7 +82,6 @@ do_fpu_end(void)
         /* restore FPU regs if necessary */
 	/* Do it out of line so that gcc does not move cr0 load to some stupid place */
         kernel_fpu_end();
-	mxcsr_feature_mask_init();
 }
 
 void __restore_processor_state(struct saved_context *ctxt)
_


