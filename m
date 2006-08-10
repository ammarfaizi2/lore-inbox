Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161235AbWHJMyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161235AbWHJMyx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 08:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161238AbWHJMyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 08:54:53 -0400
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:4755 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1161235AbWHJMyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 08:54:52 -0400
Date: Thu, 10 Aug 2006 08:48:50 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: annotate the rest of entry.s::nmi
To: "Jan Beulich" <jbeulich@novell.com>
Cc: linux-kernel@vger.kernel.org, "Andi Kleen" <ak@suse.de>, stsp@aknet.ru
Message-ID: <200608100851_MC3-1-C7A8-8B6A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <44DB0927.76E4.0078.0@novell.com>

On Thu, 10 Aug 2006 10:23:35 +0200, Jan Beulich wrote:

> >Part of the NMI handler is missing annotations.  Just moving
> >the RING0_INT_FRAME macro fixes it.  And additional comments
> >should warn anyone changing this to recheck the annotations.
> 
> I have to admit that I can't see the value of this movement; the
> code sequence in question was left un-annotated intentionally.
> The point is that the push-es in FIX_STACK() aren't annotated, so
> things won't be correct at those points anyway.

I have a patch here that adds that, but it won't compile
because that part of the NMI handler is un-annotated:


i386: annotate the FIX_STACK macro.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
---

 arch/i386/kernel/entry.S  |    8 +++++++-
 include/asm-i386/dwarf2.h |    2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

--- 2.6.18-rc4-nb.orig/arch/i386/kernel/entry.S
+++ 2.6.18-rc4-nb/arch/i386/kernel/entry.S
@@ -698,9 +698,15 @@ device_not_available_emulate:
 	jne ok;					\
 label:						\
 	movl TSS_sysenter_esp0+offset(%esp),%esp;	\
+	CFI_DEF_CFA esp, 0;			\
+	CFI_UNDEFINED eip;			\
 	pushfl;					\
+	CFI_ADJUST_CFA_OFFSET 4;		\
 	pushl $__KERNEL_CS;			\
-	pushl $sysenter_past_esp
+	CFI_ADJUST_CFA_OFFSET 4;		\
+	pushl $sysenter_past_esp;		\
+	CFI_ADJUST_CFA_OFFSET 4;		\
+	CFI_REL_OFFSET eip, 0
 
 KPROBE_ENTRY(debug)
 	RING0_INT_FRAME
--- 2.6.18-rc4-nb.orig/include/asm-i386/dwarf2.h
+++ 2.6.18-rc4-nb/include/asm-i386/dwarf2.h
@@ -28,6 +28,7 @@
 #define CFI_RESTORE .cfi_restore
 #define CFI_REMEMBER_STATE .cfi_remember_state
 #define CFI_RESTORE_STATE .cfi_restore_state
+#define CFI_UNDEFINED .cfi_undefined
 
 #else
 
@@ -48,6 +49,7 @@
 #define CFI_RESTORE	ignore
 #define CFI_REMEMBER_STATE ignore
 #define CFI_RESTORE_STATE ignore
+#define CFI_UNDEFINED ignore
 
 #endif
 
-- 
Chuck
