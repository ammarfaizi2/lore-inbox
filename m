Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbUKUWQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbUKUWQT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 17:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbUKUWQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 17:16:18 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:15197 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261821AbUKUWQQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 17:16:16 -0500
Date: Sun, 21 Nov 2004 23:17:03 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andreas Schwab <schwab@suse.de>
Cc: Adrian Bunk <bunk@stusta.de>, Adam Belay <ambx1@neo.rr.com>,
       Thomas Hood <jdthood@mail.com>, linux-kernel@vger.kernel.org
Subject: Re: What exactly is __ALIGN_STR in pnpbios/bioscalls.c for?
Message-ID: <20041121221703.GA7856@mars.ravnborg.org>
Mail-Followup-To: Andreas Schwab <schwab@suse.de>,
	Adrian Bunk <bunk@stusta.de>, Adam Belay <ambx1@neo.rr.com>,
	Thomas Hood <jdthood@mail.com>, linux-kernel@vger.kernel.org
References: <20041121175659.GD2924@stusta.de> <jefz337xoz.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jefz337xoz.fsf@sykes.suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2004 at 09:29:32PM +0100, Andreas Schwab wrote:
> Adrian Bunk <bunk@stusta.de> writes:
 
> It's for aligning function entries to a 16 byte boundary instead of only 4
> bytes, used together with -malign-functions.  See also the ENTRY macro.
> Note that the default value of __ALIGN is actually useless for anything
> but x86 and x86-64.

Recently someone complained that __sched_text_start changed address during
pass one and two of kallsyms. The actual culprint was that an
address changed due to different section layout.
The fix I posted was to align .sched.text to an 8 byte boundary.

Can we say anything about alignment of functions across architectures?

Patch in question below.
Grepping tells me to use FUNCTION_ALIGN if I push this for inclusion.

	Sam
	
===== include/asm-generic/vmlinux.lds.h 1.16 vs edited =====
--- 1.16/include/asm-generic/vmlinux.lds.h	2004-10-06 18:45:06 +02:00
+++ edited/include/asm-generic/vmlinux.lds.h	2004-11-06 21:56:11 +01:00
@@ -6,6 +6,11 @@
 #define VMLINUX_SYMBOL(_sym_) _sym_
 #endif
 
+/* Aling functions to a 8 byte boundary.
+ * This prevents lables defined to mark start/end of section to differ
+ * during pass 1 and pass 2 when generating System.map */
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
