Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbTEaRzF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 13:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264387AbTEaRzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 13:55:05 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:18861 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264389AbTEaRzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 13:55:04 -0400
Date: Sat, 31 May 2003 20:08:19 +0200 (CEST)
From: manfred@colorfullife.com
X-X-Sender: manfred@dbl.q-ag.de
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix sysenter crash with enabled nmi oopser
Message-ID: <Pine.LNX.4.44.0305311959120.27965-100000@dbl.q-ag.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

below is again my patch to the nmi entry point: without it, I can't boot
RH9 with both nmi oopser and page unmapping enabled.

Background:

The nmi handler must detect the combination of nmi+syscall+debug fault. It
does that by reading from (%esp)16. This can crash, if it's a "normal" nmi
and (%esp)16 doesn't exist - either above end-of-memory, or the page that
follows behind the stack is unmapped for AGP GART. RH9 crashes on every
boot with page unmap debugging enabled, the interrupted %eip is
sysenter_past_esp.

Could you apply the patch to your tree? I would prefer a symbolic constant
instead of 0x1fff (THREAD_SIZE-1) and 0x1fec
(THREAD_SIZE-3*sizeof(unsigned long)), but the current definitions are not
compatible with the assembler.

--
	Manfred
<<<
--- 2.5/arch/i386/kernel/entry.S	2003-05-24 07:56:36.000000000 +0200
+++ build-2.5/arch/i386/kernel/entry.S	2003-05-25 22:56:18.000000000 +0200
@@ -534,6 +534,15 @@
 ENTRY(nmi)
 	cmpl $sysenter_entry,(%esp)
 	je nmi_stack_fixup
+	pushl %eax
+	movl %esp,%eax
+	/* Do not access memory above the end of our stack page,
+	 * it might not exist.
+	 */
+	andl $0x1fff,%eax
+	cmpl $0x1fec,%eax
+	popl %eax
+	jae nmi_stack_correct
 	cmpl $sysenter_entry,12(%esp)
 	je nmi_debug_stack_check
 nmi_stack_correct:
<<<

