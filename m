Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263653AbUJ2X2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbUJ2X2Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 19:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263509AbUJ2XU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 19:20:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:61362 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263597AbUJ2XPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 19:15:04 -0400
Date: Fri, 29 Oct 2004 16:14:56 -0700
From: Chris Wright <chrisw@osdl.org>
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove duplicate FAKE_STACK_FRAME macro
Message-ID: <20041029161456.S2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

FAKE_STACK_FRAME macro is defined twice.  The one that gets used is in
arch/x86_64/kernel/entry.S, and is slightly different codewise, although
should have the same end result (uses pushq rather than addq %rsp + movq
and has the extra dwarf annotations).  Looks like we can remove the dups?

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== include/asm-x86_64/calling.h 1.10 vs edited =====
--- 1.10/include/asm-x86_64/calling.h	2004-03-21 12:35:48 -08:00
+++ edited/include/asm-x86_64/calling.h	2004-10-28 17:00:53 -07:00
@@ -143,22 +143,6 @@
 	RESTORE_ARGS 0,\addskip
 	.endm
 
-	/* push in order ss, rsp, eflags, cs, rip */
-	.macro FAKE_STACK_FRAME child_rip
-	xorl %eax,%eax
-	subq $6*8,%rsp
-	movq %rax,5*8(%rsp)  /* ss */
-	movq %rax,4*8(%rsp)  /* rsp */
-	movq $(1<<9),3*8(%rsp)  /* eflags */
-	movq $__KERNEL_CS,2*8(%rsp) /* cs */
-	movq \child_rip,1*8(%rsp)  /* rip */ 
-	movq %rax,(%rsp)   /* orig_rax */ 
-	.endm
-
-	.macro UNFAKE_STACK_FRAME
-	addq $8*6, %rsp
-	.endm
-
 	.macro icebp
 	.byte 0xf1
 	.endm
