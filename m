Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVCZIIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVCZIIT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 03:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVCZIIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 03:08:18 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:45869 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261647AbVCZIIL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 03:08:11 -0500
Date: Sat, 26 Mar 2005 09:09:18 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1-bk1: Inconsistent kallsyms data
Message-ID: <20050326080918.GA16087@mars.ravnborg.org>
References: <200503260343.03342.adobriyan@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503260343.03342.adobriyan@mail.ru>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2005 at 03:43:03AM +0300, Alexey Dobriyan wrote:
> While building 2.6.12-rc1-bk1 with attached config I get "Inconsistent
> kallsyms data".
> 
> Setting CONFIG_KALLSYMS_EXTRA_PASS or CONFIG_KALLSYMS_ALL fixes the problem.

Please try attached patch. What you see may be the linker deciding to
re-shuffle some sections a bit more than usual.
Patch has been in -mm for a while.

	Sam

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/03/14 20:56:01+01:00 sam@mars.ravnborg.org 
#   kbuild: Avoid inconsistent kallsyms data
#   
#   Several reports on inconsistent kallsyms data has been caused by the aliased symbols
#   __sched_text_start and __down to shift places in the output of nm.
#   The root cause was that on second pass ld aligned __sched_text_start to a 4 byte boundary
#   which is the function alignment on i386.
#   sched.text and spinlock.text is now aligned to an 8 byte boundary to make sure they
#   are aligned to a function alignemnt on most (all?) archs.
#   
#   Tested by: Paulo Marques <pmarques@grupopie.com>
#   Tested by: Alexander Stohr <Alexander.Stohr@gmx.de>
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# include/asm-generic/vmlinux.lds.h
#   2005/03/14 20:55:39+01:00 sam@mars.ravnborg.org +9 -0
#   Align sched.text and spinlock.text to an 8 byte boundary
# 
diff -Nru a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
--- a/include/asm-generic/vmlinux.lds.h	2005-03-26 09:07:42 +01:00
+++ b/include/asm-generic/vmlinux.lds.h	2005-03-26 09:07:42 +01:00
@@ -6,6 +6,9 @@
 #define VMLINUX_SYMBOL(_sym_) _sym_
 #endif
 
+/* Align . to a 8 byte boundary equals to maximum function alignment. */
+#define ALIGN_FUNCTION()  . = ALIGN(8)
+
 #define RODATA								\
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
 		*(.rodata) *(.rodata.*)					\
@@ -79,12 +82,18 @@
 		VMLINUX_SYMBOL(__security_initcall_end) = .;		\
 	}
 
+/* sched.text is aling to function alignment to secure we have same
+ * address even at second ld pass when generating System.map */
 #define SCHED_TEXT							\
+		ALIGN_FUNCTION();					\
 		VMLINUX_SYMBOL(__sched_text_start) = .;			\
 		*(.sched.text)						\
 		VMLINUX_SYMBOL(__sched_text_end) = .;
 
+/* spinlock.text is aling to function alignment to secure we have same
+ * address even at second ld pass when generating System.map */
 #define LOCK_TEXT							\
+		ALIGN_FUNCTION();					\
 		VMLINUX_SYMBOL(__lock_text_start) = .;			\
 		*(.spinlock.text)					\
 		VMLINUX_SYMBOL(__lock_text_end) = .;
