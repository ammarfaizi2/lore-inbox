Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261287AbSJIIEp>; Wed, 9 Oct 2002 04:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbSJIIEp>; Wed, 9 Oct 2002 04:04:45 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:18348 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S261287AbSJIIEo>;
	Wed, 9 Oct 2002 04:04:44 -0400
Date: Wed, 9 Oct 2002 18:10:03 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@karaya.com>
Subject: [PATCH] make do_signal static on i386
Message-Id: <20021009181003.022da660.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.3 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch makes do_signal static in arch/i386/kernel/signal.c which
means its declaration can be removed from asm-i386/signal.h which may
help Jeff out with UML.

I am not sure whether we need the FASTCALL() or whether the change
in the comment in asm-um/signal.h makes sense.  (Does UML work on
x86_64, yet?)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.41-1.715/arch/i386/kernel/signal.c 2.5.41-1.715-si.1/arch/i386/kernel/signal.c
--- 2.5.41-1.715/arch/i386/kernel/signal.c	2002-10-02 11:23:54.000000000 +1000
+++ 2.5.41-1.715-si.1/arch/i386/kernel/signal.c	2002-10-09 17:52:15.000000000 +1000
@@ -27,6 +27,8 @@
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
+static int FASTCALL(do_signal(struct pt_regs *regs, sigset_t *oldset));
+
 /*
  * Atomically swap in the new signal mask, and wait for a signal.
  */
@@ -545,7 +547,7 @@
  * want to handle. Thus you cannot kill init even with a SIGKILL even by
  * mistake.
  */
-int do_signal(struct pt_regs *regs, sigset_t *oldset)
+static int do_signal(struct pt_regs *regs, sigset_t *oldset)
 {
 	siginfo_t info;
 	int signr;
diff -ruN 2.5.41-1.715/include/asm-i386/signal.h 2.5.41-1.715-si.1/include/asm-i386/signal.h
--- 2.5.41-1.715/include/asm-i386/signal.h	2002-01-31 07:12:46.000000000 +1100
+++ 2.5.41-1.715-si.1/include/asm-i386/signal.h	2002-10-09 17:54:28.000000000 +1000
@@ -2,7 +2,6 @@
 #define _ASMi386_SIGNAL_H
 
 #include <linux/types.h>
-#include <linux/linkage.h>
 
 /* Avoid too many header ordering problems.  */
 struct siginfo;
@@ -217,9 +216,6 @@
 	return word;
 }
 
-struct pt_regs;
-extern int FASTCALL(do_signal(struct pt_regs *regs, sigset_t *oldset));
-
 #endif /* __KERNEL__ */
 
 #endif
diff -ruN 2.5.41-1.715/include/asm-um/signal.h 2.5.41-1.715-si.1/include/asm-um/signal.h
--- 2.5.41-1.715/include/asm-um/signal.h	2002-09-16 13:40:57.000000000 +1000
+++ 2.5.41-1.715-si.1/include/asm-um/signal.h	2002-10-09 17:56:20.000000000 +1000
@@ -6,7 +6,7 @@
 #ifndef __UM_SIGNAL_H
 #define __UM_SIGNAL_H
 
-/* Need to kill the do_signal() declaration in the i386 signal.h */
+/* Need to kill the do_signal() declaration in the x86_64 signal.h */
 
 #define do_signal do_signal_renamed
 #include "asm/arch/signal.h"
