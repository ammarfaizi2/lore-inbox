Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161014AbWI1F7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161014AbWI1F7x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 01:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161015AbWI1F7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 01:59:53 -0400
Received: from gw.goop.org ([64.81.55.164]:27846 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1161014AbWI1F7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 01:59:52 -0400
Message-ID: <451B64E3.9020900@goop.org>
Date: Wed, 27 Sep 2006 23:00:03 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Put the BUG __FILE__ and __LINE__ info out of line
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_DEBUG_BUGVERBOSE is enabled, the embedded file and line
information makes a disassembler very unhappy, because it tries to
parse them as instructions (it probably makes the CPU's instruction
decoder a little unhappy too).

This patch moves them out of line, and calls the ud2 from the code -
the call makes sure the original %eip is available on the top of the
stack.  The result is a happy disassembler, with no loss of debugging
information.

Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>

--
 arch/i386/kernel/vmlinux.lds.S |    2 ++
 include/asm-i386/bug.h         |   13 ++++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff -r 1d29394927f3 arch/i386/kernel/vmlinux.lds.S
--- a/arch/i386/kernel/vmlinux.lds.S	Tue Sep 26 01:20:38 2006 -0700
+++ b/arch/i386/kernel/vmlinux.lds.S	Wed Sep 27 22:18:23 2006 -0700
@@ -27,6 +27,8 @@ SECTIONS
   _text = .;			/* Text and read-only data */
   .text : AT(ADDR(.text) - LOAD_OFFSET) {
 	*(.text)
+	__bugs = .;
+	*(.text.bugs)
 	SCHED_TEXT
 	LOCK_TEXT
 	KPROBES_TEXT
diff -r 1d29394927f3 include/asm-i386/bug.h
--- a/include/asm-i386/bug.h	Tue Sep 26 01:20:38 2006 -0700
+++ b/include/asm-i386/bug.h	Wed Sep 27 18:59:41 2006 -0700
@@ -11,11 +11,14 @@
 #ifdef CONFIG_BUG
 #define HAVE_ARCH_BUG
 #ifdef CONFIG_DEBUG_BUGVERBOSE
-#define BUG()				\
- __asm__ __volatile__(	"ud2\n"		\
-			"\t.word %c0\n"	\
-			"\t.long %c1\n"	\
-			 : : "i" (__LINE__), "i" (__FILE__))
+#define BUG()								\
+	__asm__ __volatile__("call 1f\n"				\
+			     ".section .text.bugs\n"			\
+			     "1:\tud2\n"					\
+			     "\t.word %c0\n"				\
+			     "\t.long %c1\n"				\
+			     ".previous\n"				\
+			     : : "i" (__LINE__), "i" (__FILE__))
 #else
 #define BUG() __asm__ __volatile__("ud2\n")
 #endif


