Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWCGXk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWCGXk3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 18:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWCGXk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 18:40:29 -0500
Received: from liaag2ad.mx.compuserve.com ([149.174.40.155]:32975 "EHLO
	liaag2ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964809AbWCGXk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 18:40:29 -0500
Date: Tue, 7 Mar 2006 18:34:07 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386 spinlocks: disable interrupts only if we enabled
  them
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>
Message-ID: <200603071837_MC3-1-BA13-E5FB@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

_raw_spin_lock_flags() is entered with interrupts disabled.  If it
cannot obtain a spinlock, it checks the flags that were passed and
re-enables interrupts before spinning if that's how the flags are set.
When the spinlock might be available, it disables interrupts (even if
they are already disabled) before trying to get the lock.  Change that
so interrupts are only disabled if they have been enabled.  This costs
nine bytes of duplicated spinloop code.

Fastpath before patch:
        jle <keep looping>      not-taken conditional jump
        cli                     disable interrupts
        jmp <try for lock>      unconditional jump

Fastpath after patch, if interrupts were not enabled:
        jg <try for lock>       taken conditional branch

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.16-rc5-d2.orig/include/asm-i386/spinlock.h
+++ 2.6.16-rc5-d2/include/asm-i386/spinlock.h
@@ -35,18 +35,23 @@
 #define __raw_spin_lock_string_flags \
 	"\n1:\t" \
 	"lock ; decb %0\n\t" \
-	"jns 4f\n\t" \
+	"jns 5f\n" \
 	"2:\t" \
 	"testl $0x200, %1\n\t" \
-	"jz 3f\n\t" \
-	"sti\n\t" \
+	"jz 4f\n\t" \
+	"sti\n" \
 	"3:\t" \
 	"rep;nop\n\t" \
 	"cmpb $0, %0\n\t" \
 	"jle 3b\n\t" \
 	"cli\n\t" \
 	"jmp 1b\n" \
-	"4:\n\t"
+	"4:\t" \
+	"rep;nop\n\t" \
+	"cmpb $0, %0\n\t" \
+	"jg 1b\n\t" \
+	"jmp 4b\n" \
+	"5:\n\t"
 
 static inline void __raw_spin_lock(raw_spinlock_t *lock)
 {
-- 
Chuck
"Penguins don't come from next door, they come from the Antarctic!"
