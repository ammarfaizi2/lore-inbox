Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbUKSWsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbUKSWsK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 17:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbUKSWp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 17:45:57 -0500
Received: from atorelbas01.hp.com ([156.153.255.245]:39583 "EHLO
	palrel10.hp.com") by vger.kernel.org with ESMTP id S261666AbUKSWpB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 17:45:01 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16798.30567.856728.922425@napali.hpl.hp.com>
Date: Fri, 19 Nov 2004 14:44:55 -0800
To: akpm@osdl.org, ak@suse.org
Cc: linux-kernel@vger.kernel.org
Subject: provide means to efficiently and reliably detect signal-frame
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment, there is no clean way to detect the signal frame on
Linux platforms that use DWARF2 unwind info.  The patch below proposes
to add a new "S" augmentation to mark special properties of a frame.
The proposed augmentation consists of 2 16-bit values: an
ABI-identifier (e.g., Linux) and a tag that identifies the type of the
frame (e.g., regular signal frame vs. real-time signal frame).

Why is this useful?  Clearly, signal frames are special frames.  For
example, it's not unusual to want to create a backtrace starting only
at the point before the most recent signal frame (e.g., so that you
can see what lead to a segfault).  Furthermore, signal-frames may
contain information which cannot be described by the normal DWARF2
unwind-info.  For example, when unwinding past a signal-frame, you'll
normally want to restore the signal mask but there is currently no way
to describe the location of a signal mask with the current DWARF2
info.  Thus, at the moment, one has to resort to code-reading to
detect signal-frames, but this is fragile, architecture-specific, and
slow.  In contrast, with a DWARF2 augmentation, the unwinder will
detect signal frames in the course of normal DWARF2-processing, so
this is efficient and, assuming this extension will be adopted by
other DWARF2-based Linux platforms, it will be portable.

Andi, I cc'd you since I'd want to make the same type of change to
x86-64 if this solution gets accepted.

Comments?

	--david

===== arch/i386/kernel/vsyscall-sigreturn.S 1.3 vs edited =====
--- 1.3/arch/i386/kernel/vsyscall-sigreturn.S	2004-03-17 04:02:27 -08:00
+++ edited/arch/i386/kernel/vsyscall-sigreturn.S	2004-11-12 22:00:06 -08:00
@@ -9,6 +9,13 @@
 #include <asm/unistd.h>
 #include <asm/asm_offsets.h>
 
+/*
+ * Manifest constants for the special frame augmentation used to
+ * mark the signal frames.
+ */
+#define ABI_LINUX			3
+#define SPECIAL_FRAME_SIGFRAME		1
+#define SPECIAL_FRAME_RT_SIGFRAME	2
 
 /* XXX
    Should these be named "_sigtramp" or something?
@@ -43,7 +50,7 @@
 .LSTARTCIEDLSI1:
 	.long 0			/* CIE ID */
 	.byte 1			/* Version number */
-	.string "zR"		/* NUL-terminated augmentation string */
+	.string "zRS"		/* NUL-terminated augmentation string */
 	.uleb128 1		/* Code alignment factor */
 	.sleb128 -4		/* Data alignment factor */
 	.byte 8			/* Return address register column */
@@ -62,7 +69,8 @@
 	   to make up for it.  */
 	.long .LSTART_sigreturn-1-.	/* PC-relative start address */
 	.long .LEND_sigreturn-.LSTART_sigreturn+1
-	.uleb128 0			/* Augmentation */
+	.uleb128 4			/* pointer-encoding augmentation */
+	.short ABI_LINUX, SPECIAL_FRAME_SIGFRAME /* special-frame aug. */
 	/* What follows are the instructions for the table generation.
 	   We record the locations of each register saved.  This is
 	   complicated by the fact that the "CFA" is always assumed to
@@ -121,7 +129,8 @@
 	/* HACK: See above wrt unwind library assumptions.  */
 	.long .LSTART_rt_sigreturn-1-.	/* PC-relative start address */
 	.long .LEND_rt_sigreturn-.LSTART_rt_sigreturn+1
-	.uleb128 0			/* Augmentation */
+	.uleb128 4			/* pointer-encoding augmentation */
+	.short ABI_LINUX, SPECIAL_FRAME_RT_SIGFRAME /* special-frame aug. */
 	/* What follows are the instructions for the table generation.
 	   We record the locations of each register saved.  This is
 	   slightly less complicated than the above, since we don't
