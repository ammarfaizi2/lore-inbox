Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWHFFGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWHFFGa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 01:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWHFFGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 01:06:30 -0400
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:36520 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932342AbWHFFGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 01:06:30 -0400
Date: Sun, 6 Aug 2006 01:00:43 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: fix one case of stuck dwarf2 unwinder
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       Dave Jones <davej@redhat.com>, Jan Beulich <jbeulich@novell.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200608060105_MC3-1-C73A-EF22@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200608060430.06935.ak@suse.de>

On Sun, 6 Aug 2006 04:30:06 +0200, Andi Kleen wrote:
> 
> > +extern void stext(void); /* real start of kernel text */
> 
> Can't you use _stext[] from asm/sections.h?

OK.


[patch] i386: fix one case of stuck dwarf2 unwinder

When the dwarf2 unwinder does its thing, sometimes it ends up in
kernel startup code in head.S.  Changing arch_unw_user_mode() to
treat that case as if it were user mode is the easy fix.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.18-rc3-32.orig/include/asm-i386/unwind.h
+++ 2.6.18-rc3-32/include/asm-i386/unwind.h
@@ -13,6 +13,7 @@
 #include <asm/fixmap.h>
 #include <asm/ptrace.h>
 #include <asm/uaccess.h>
+#include <asm/sections.h>
 
 struct unwind_frame_info
 {
@@ -71,13 +72,14 @@ extern asmlinkage int arch_unwind_init_r
                                                                           void *arg),
                                                void *arg);
 
+/* check if unwind has reached either user mode or kernel startup code */
 static inline int arch_unw_user_mode(const struct unwind_frame_info *info)
 {
 #if 0 /* This can only work when selector register and EFLAGS saves/restores
          are properly annotated (and tracked in UNW_REGISTER_INFO). */
 	return user_mode_vm(&info->regs);
 #else
-	return info->regs.eip < PAGE_OFFSET
+	return info->regs.eip < (unsigned long)_stext
 	       || (info->regs.eip >= __fix_to_virt(FIX_VDSO)
 	            && info->regs.eip < __fix_to_virt(FIX_VDSO) + PAGE_SIZE)
 	       || info->regs.esp < PAGE_OFFSET;
-- 
Chuck
