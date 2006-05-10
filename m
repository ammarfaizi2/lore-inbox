Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbWEJC5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWEJC5z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 22:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWEJC5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:57:34 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:4926 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S932424AbWEJC4s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:56:48 -0400
Date: Tue, 9 May 2006 19:55:58 -0700
Message-Id: <200605100255.k4A2twf5031682@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] math-emu gcc 4.1 warning fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whoa ..

Fixes the following warnings,

arch/i386/math-emu/fpu_entry.c: In function 'save_i387_soft':
arch/i386/math-emu/fpu_entry.c:745: warning: ignoring return value of '__copy_to_user', declared with attribute warn_unused_result
arch/i386/math-emu/fpu_entry.c: In function 'math_emulate':
arch/i386/math-emu/fpu_entry.c:554: warning: 'entry_sel_off.empty' is used uninitialized in this function

arch/i386/math-emu/reg_ld_str.c: In function 'FPU_load_int64':
arch/i386/math-emu/reg_ld_str.c:247: warning: ignoring return value of 'copy_from_user', declared with attribute warn_unused_result
arch/i386/math-emu/reg_ld_str.c: In function 'FPU_store_int64':
arch/i386/math-emu/reg_ld_str.c:910: warning: ignoring return value of 'copy_to_user', declared with attribute warn_unused_result
arch/i386/math-emu/reg_ld_str.c: In function 'fstenv':
arch/i386/math-emu/reg_ld_str.c:1339: warning: ignoring return value of '__copy_to_user', declared with attribute warn_unused_result
arch/i386/math-emu/reg_ld_str.c: In function 'fsave':
arch/i386/math-emu/reg_ld_str.c:1362: warning: ignoring return value of '__copy_to_user', declared with attribute warn_unused_result
arch/i386/math-emu/reg_ld_str.c:1364: warning: ignoring return value of '__copy_to_user', declared with attribute warn_unused_result
arch/i386/math-emu/reg_ld_str.c: In function 'FPU_store_double':
arch/i386/math-emu/reg_ld_str.c:416: warning: 'l[0]' may be used uninitialized in this function
arch/i386/math-emu/reg_ld_str.c:416: warning: 'l[1]' may be used uninitialized in this function


Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/arch/i386/math-emu/fpu_emu.h
===================================================================
--- linux-2.6.16.orig/arch/i386/math-emu/fpu_emu.h
+++ linux-2.6.16/arch/i386/math-emu/fpu_emu.h
@@ -114,7 +114,7 @@ struct address {
   unsigned int offset;
   unsigned int selector:16;
   unsigned int opcode:11;
-  unsigned int empty:5;
+  unsigned int empty:5; /* XXX: Unused ? */
 };
 struct fpu__reg {
   unsigned sigl;
Index: linux-2.6.16/arch/i386/math-emu/fpu_entry.c
===================================================================
--- linux-2.6.16.orig/arch/i386/math-emu/fpu_entry.c
+++ linux-2.6.16/arch/i386/math-emu/fpu_entry.c
@@ -142,7 +142,7 @@ asmlinkage void math_emulate(long arg)
   u_char	  loaded_tag, st0_tag;
   void __user *data_address;
   struct address data_sel_off;
-  struct address entry_sel_off;
+  struct address entry_sel_off = { .empty = 0 };
   unsigned long code_base = 0;
   unsigned long code_limit = 0;  /* Initialized to stop compiler warnings */
   struct desc_struct code_descriptor;
@@ -742,7 +742,8 @@ int save_i387_soft(void *s387, struct _f
   S387->fcs &= ~0xf8000000;
   S387->fos |= 0xffff0000;
 #endif /* PECULIAR_486 */
-  __copy_to_user(d, &S387->cwd, 7*4);
+  if (__copy_to_user(d, &S387->cwd, 7*4))
+	return -1;
   RE_ENTRANT_CHECK_ON;
 
   d += 7*4;
Index: linux-2.6.16/arch/i386/math-emu/reg_ld_str.c
===================================================================
--- linux-2.6.16.orig/arch/i386/math-emu/reg_ld_str.c
+++ linux-2.6.16/arch/i386/math-emu/reg_ld_str.c
@@ -244,7 +244,8 @@ int FPU_load_int64(long long __user *_s)
 
   RE_ENTRANT_CHECK_OFF;
   FPU_access_ok(VERIFY_READ, _s, 8);
-  copy_from_user(&s,_s,8);
+  if (copy_from_user(&s,_s,8))
+	math_abort(FPU_info,SIGSEGV);
   RE_ENTRANT_CHECK_ON;
 
   if (s == 0)
@@ -413,7 +414,7 @@ int FPU_store_extended(FPU_REG *st0_ptr,
 /* Put a double into user memory */
 int FPU_store_double(FPU_REG *st0_ptr, u_char st0_tag, double __user *dfloat)
 {
-  unsigned long l[2];
+  unsigned long l[2] = {0, 0};
   unsigned long increment = 0;	/* avoid gcc warnings */
   int precision_loss;
   int exp;
@@ -907,7 +908,8 @@ int FPU_store_int64(FPU_REG *st0_ptr, u_
 
   RE_ENTRANT_CHECK_OFF;
   FPU_access_ok(VERIFY_WRITE,d,8);
-  copy_to_user(d, &tll, 8);
+  if (copy_to_user(d, &tll, 8))
+	 math_abort(FPU_info,SIGSEGV);
   RE_ENTRANT_CHECK_ON;
 
   return 1;
@@ -1336,7 +1338,8 @@ u_char __user *fstenv(fpu_addr_modes add
       I387.soft.fcs &= ~0xf8000000;
       I387.soft.fos |= 0xffff0000;
 #endif /* PECULIAR_486 */
-      __copy_to_user(d, &control_word, 7*4);
+      if (__copy_to_user(d, &control_word, 7*4))
+		 math_abort(FPU_info,SIGSEGV);
       RE_ENTRANT_CHECK_ON;
       d += 0x1c;
     }
@@ -1359,9 +1362,11 @@ void fsave(fpu_addr_modes addr_modes, u_
   FPU_access_ok(VERIFY_WRITE,d,80);
 
   /* Copy all registers in stack order. */
-  __copy_to_user(d, register_base+offset, other);
+  if (__copy_to_user(d, register_base+offset, other))
+	 math_abort(FPU_info,SIGSEGV);
   if ( offset )
-    __copy_to_user(d+other, register_base, offset);
+    if (__copy_to_user(d+other, register_base, offset))
+		 math_abort(FPU_info,SIGSEGV);
   RE_ENTRANT_CHECK_ON;
 
   finit();
