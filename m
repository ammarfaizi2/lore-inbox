Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbUKFUEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbUKFUEV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 15:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbUKFUEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 15:04:21 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:48013 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261455AbUKFUEQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 15:04:16 -0500
Date: Sat, 6 Nov 2004 22:05:48 +0100
From: Sam Ravnborg <sam@mars.opasia.dk>
To: Alexander Stohr <Alexander.Stohr@gmx.de>, linux-kernel@vger.kernel.org,
       kai@germaschewski.name, sam@ravnborg.org
Subject: Re: [PATCH] fix for pseudo symbol swapping with scripts/kallsyms - linux-2.6.10-rc1-bk12 & gcc 3.4.2
Message-ID: <20041106210548.GA18305@mars.opasia.dk>
Mail-Followup-To: Alexander Stohr <Alexander.Stohr@gmx.de>,
	linux-kernel@vger.kernel.org, kai@germaschewski.name,
	sam@ravnborg.org
References: <31629.1099492414@www8.gmx.net> <20041105232558.GA9844@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105232558.GA9844@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 12:25:58AM +0100, Sam Ravnborg wrote:
> The linker will adhere to any alingment demands in the section,
> but not the labels. So the real fix is to make sure the labels are
> defined inside the section.
> Please try attached (untested) patch.
> 
> Check that error is present without patch, and it is fixed with the patch.

This patch is better - we cannot define sections within sections.

	Sam
	
===== include/asm-generic/vmlinux.lds.h 1.16 vs edited =====
--- 1.16/include/asm-generic/vmlinux.lds.h	2004-10-06 18:45:06 +02:00
+++ edited/include/asm-generic/vmlinux.lds.h	2004-11-06 21:56:11 +01:00
@@ -6,6 +6,11 @@
 #define VMLINUX_SYMBOL(_sym_) _sym_
 #endif
 
+/* Aling functions to a 32 byte boundary.
+ * This prevents lables defined to mark start/end of section to differ
+ * during pass 1 and pass 2 when generating Systme.map */
+#define ALIGN_FUNCTION()  . = ALIGN(8)
+
 #define RODATA								\
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
 		*(.rodata) *(.rodata.*)					\
@@ -77,11 +82,13 @@
 	}
 
 #define SCHED_TEXT							\
+		ALIGN_FUNCTION();					\
 		VMLINUX_SYMBOL(__sched_text_start) = .;			\
 		*(.sched.text)						\
 		VMLINUX_SYMBOL(__sched_text_end) = .;
 
 #define LOCK_TEXT							\
+		ALIGN_FUNCTION();					\
 		VMLINUX_SYMBOL(__lock_text_start) = .;			\
 		*(.spinlock.text)					\
 		VMLINUX_SYMBOL(__lock_text_end) = .;
