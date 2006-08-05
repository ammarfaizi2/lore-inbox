Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbWHEUml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbWHEUml (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 16:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbWHEUml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 16:42:41 -0400
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:37057 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932504AbWHEUmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 16:42:40 -0400
Date: Sat, 5 Aug 2006 16:36:46 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386: fix one case of stuck dwarf2 unwinder
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Jan Beulich <jbeulich@novell.com>, Andi Kleen <ak@suse.de>,
       Dave Jones <davej@redhat.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Andrew Morton <akpm@osdl.org>
Message-ID: <200608051640_MC3-1-C736-44E2@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the dwarf2 unwinder does its thing, sometimes it ends up in
kernel startup code in head.S.  Changing arch_unw_user_mode() to
treat that case as if it were user mode is the easy fix.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

---

I copied people who posted traces where this happened. Can anyone
test if this fixes the problem?

--- 2.6.18-rc3-d4.orig/include/asm-i386/unwind.h
+++ 2.6.18-rc3-d4/include/asm-i386/unwind.h
@@ -71,13 +71,14 @@ extern asmlinkage int arch_unwind_init_r
                                                                           void *arg),
                                                void *arg);
 
+extern void stext(void); /* real start of kernel text */
 static inline int arch_unw_user_mode(const struct unwind_frame_info *info)
 {
 #if 0 /* This can only work when selector register and EFLAGS saves/restores
          are properly annotated (and tracked in UNW_REGISTER_INFO). */
 	return user_mode_vm(&info->regs);
 #else
-	return info->regs.eip < PAGE_OFFSET
+	return info->regs.eip < (unsigned long)stext
 	       || (info->regs.eip >= __fix_to_virt(FIX_VDSO)
 	            && info->regs.eip < __fix_to_virt(FIX_VDSO) + PAGE_SIZE)
 	       || info->regs.esp < PAGE_OFFSET;
-- 
Chuck
