Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264908AbUGHXHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264908AbUGHXHq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 19:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264957AbUGHXHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 19:07:46 -0400
Received: from palrel11.hp.com ([156.153.255.246]:2466 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S264908AbUGHXHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 19:07:43 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16621.54200.67552.21524@napali.hpl.hp.com>
Date: Thu, 8 Jul 2004 16:07:36 -0700
To: Jack Steiner <steiner@sgi.com>
Cc: davidm@hpl.hp.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - Eliminate machvec calls to null functions
In-Reply-To: <20040707201716.GA14015@sgi.com>
References: <20040707201716.GA14015@sgi.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 7 Jul 2004 15:17:16 -0500, Jack Steiner <steiner@sgi.com> said:

  Jack> Here is a patch to eliminate calls to null platform vectors for
  Jack> non-GENERIC kernels.

  Jack> If this looks ok, then I'll update the tlb_migrate patch & resubmit
  Jack> it. (Apply this machvec patch first...)

I was about to check this in when it occurred to me that it should be
possible to simply define the no-ops as "static inline".  If you take
the address of these functions, the compiler will instantiate the
function automatically, so this ought to work both for GENERIC and
non-GENERIC kernels.  The only downside is that for GENERIC, each
machvec definition will get its own definition of the
no-op-function(s), but that seems like an acceptable cost to me.

I tried the patch below both for zx1 and GENERIC and it does seem to
work as expected.  If nobody has a problem with the patch, I'll go
ahead and check it in.

	--david

===== arch/ia64/kernel/machvec.c 1.8 vs edited =====
--- 1.8/arch/ia64/kernel/machvec.c	Fri May 21 14:01:23 2004
+++ edited/arch/ia64/kernel/machvec.c	Thu Jul  8 15:34:20 2004
@@ -44,12 +44,6 @@
 #endif /* CONFIG_IA64_GENERIC */
 
 void
-machvec_noop (void)
-{
-}
-EXPORT_SYMBOL(machvec_noop);
-
-void
 machvec_setup (char **arg)
 {
 }
===== include/asm-ia64/machvec.h 1.23 vs edited =====
--- 1.23/include/asm-ia64/machvec.h	Thu Mar 25 11:54:44 2004
+++ edited/include/asm-ia64/machvec.h	Thu Jul  8 15:34:06 2004
@@ -69,7 +69,11 @@
 typedef unsigned int ia64_mv_readl_relaxed_t (void *);
 typedef unsigned long ia64_mv_readq_relaxed_t (void *);
 
-extern void machvec_noop (void);
+static inline void
+machvec_noop (void)
+{
+}
+
 extern void machvec_setup (char **);
 extern void machvec_timer_interrupt (int, void *, struct pt_regs *);
 extern void machvec_dma_sync_single (struct device *, dma_addr_t, size_t, int);
