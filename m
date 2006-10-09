Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWJICsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWJICsB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 22:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWJICsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 22:48:00 -0400
Received: from xenotime.net ([66.160.160.81]:28334 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751640AbWJICr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 22:47:58 -0400
Date: Sun, 8 Oct 2006 19:47:24 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, ak@suse.de
Subject: [PATCH] i386/math-emu: fix must_checks
Message-Id: <20061008194724.1e9c026c.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix __must_check warnings in i386/math-emu.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 arch/i386/math-emu/fpu_emu.h    |    1 +
 arch/i386/math-emu/fpu_entry.c  |    3 ++-
 arch/i386/math-emu/fpu_system.h |    1 +
 arch/i386/math-emu/load_store.c |    2 ++
 arch/i386/math-emu/reg_ld_str.c |   15 ++++++++++-----
 5 files changed, 16 insertions(+), 6 deletions(-)

--- linux-2619-rc1g3.orig/arch/i386/math-emu/fpu_emu.h
+++ linux-2619-rc1g3/arch/i386/math-emu/fpu_emu.h
@@ -57,6 +57,7 @@
 #define TAG_Special	Const(2)	/* De-normal, + or - infinity,
 					   or Not a Number */
 #define TAG_Empty	Const(3)	/* empty */
+#define TAG_Error	Const(0x80)	/* probably need to abort */
 
 #define LOADED_DATA	Const(10101)	/* Special st() number to identify
 					   loaded data (not on stack). */
--- linux-2619-rc1g3.orig/arch/i386/math-emu/fpu_entry.c
+++ linux-2619-rc1g3/arch/i386/math-emu/fpu_entry.c
@@ -742,7 +742,8 @@ int save_i387_soft(void *s387, struct _f
   S387->fcs &= ~0xf8000000;
   S387->fos |= 0xffff0000;
 #endif /* PECULIAR_486 */
-  __copy_to_user(d, &S387->cwd, 7*4);
+  if (__copy_to_user(d, &S387->cwd, 7*4))
+    return -1;
   RE_ENTRANT_CHECK_ON;
 
   d += 7*4;
--- linux-2619-rc1g3.orig/arch/i386/math-emu/fpu_system.h
+++ linux-2619-rc1g3/arch/i386/math-emu/fpu_system.h
@@ -68,6 +68,7 @@
 
 #define FPU_access_ok(x,y,z)	if ( !access_ok(x,y,z) ) \
 				math_abort(FPU_info,SIGSEGV)
+#define FPU_abort		math_abort(FPU_info, SIGSEGV)
 
 #undef FPU_IGNORE_CODE_SEGV
 #ifdef FPU_IGNORE_CODE_SEGV
--- linux-2619-rc1g3.orig/arch/i386/math-emu/load_store.c
+++ linux-2619-rc1g3/arch/i386/math-emu/load_store.c
@@ -227,6 +227,8 @@ int FPU_load_store(u_char type, fpu_addr
     case 027:      /* fild m64int */
       clear_C1();
       loaded_tag = FPU_load_int64((long long __user *)data_address);
+      if (loaded_tag == TAG_Error)
+	return 0;
       FPU_settag0(loaded_tag);
       break;
     case 030:     /* fstenv  m14/28byte */
--- linux-2619-rc1g3.orig/arch/i386/math-emu/reg_ld_str.c
+++ linux-2619-rc1g3/arch/i386/math-emu/reg_ld_str.c
@@ -244,7 +244,8 @@ int FPU_load_int64(long long __user *_s)
 
   RE_ENTRANT_CHECK_OFF;
   FPU_access_ok(VERIFY_READ, _s, 8);
-  copy_from_user(&s,_s,8);
+  if (copy_from_user(&s,_s,8))
+    FPU_abort;
   RE_ENTRANT_CHECK_ON;
 
   if (s == 0)
@@ -907,7 +908,8 @@ int FPU_store_int64(FPU_REG *st0_ptr, u_
 
   RE_ENTRANT_CHECK_OFF;
   FPU_access_ok(VERIFY_WRITE,d,8);
-  copy_to_user(d, &tll, 8);
+  if (copy_to_user(d, &tll, 8))
+    FPU_abort;
   RE_ENTRANT_CHECK_ON;
 
   return 1;
@@ -1336,7 +1338,8 @@ u_char __user *fstenv(fpu_addr_modes add
       I387.soft.fcs &= ~0xf8000000;
       I387.soft.fos |= 0xffff0000;
 #endif /* PECULIAR_486 */
-      __copy_to_user(d, &control_word, 7*4);
+      if (__copy_to_user(d, &control_word, 7*4))
+	FPU_abort;
       RE_ENTRANT_CHECK_ON;
       d += 0x1c;
     }
@@ -1359,9 +1362,11 @@ void fsave(fpu_addr_modes addr_modes, u_
   FPU_access_ok(VERIFY_WRITE,d,80);
 
   /* Copy all registers in stack order. */
-  __copy_to_user(d, register_base+offset, other);
+  if (__copy_to_user(d, register_base+offset, other))
+    FPU_abort;
   if ( offset )
-    __copy_to_user(d+other, register_base, offset);
+    if (__copy_to_user(d+other, register_base, offset))
+      FPU_abort;
   RE_ENTRANT_CHECK_ON;
 
   finit();


---
