Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVCTDLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVCTDLZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 22:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVCTDLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 22:11:25 -0500
Received: from mail.dif.dk ([193.138.115.101]:8581 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261458AbVCTDK6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 22:10:58 -0500
Date: Sun, 20 Mar 2005 04:12:34 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: "W. Metzenthen" <billm@suburbia.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] rename FPU_*verify_area to FPU_*access_ok
Message-ID: <Pine.LNX.4.62.0503200404571.5507@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since verify_area is going the way of the Dodo soon it seems resonable to 
no longer refer to it in wrapper functions/macros.
FPU_verify_area and FPU_code_verify_area have already been converted to 
call access_ok so now seems a good time to rename them.
This patch makes no functional changes at all.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -uprN linux-2.6.11-mm4-orig/arch/i386/math-emu/fpu_entry.c linux-2.6.11-mm4/arch/i386/math-emu/fpu_entry.c
--- linux-2.6.11-mm4-orig/arch/i386/math-emu/fpu_entry.c	2005-03-02 08:38:25.000000000 +0100
+++ linux-2.6.11-mm4/arch/i386/math-emu/fpu_entry.c	2005-03-20 03:57:21.000000000 +0100
@@ -257,7 +257,7 @@ do_another_FPU_instruction:
     }
 
   RE_ENTRANT_CHECK_OFF;
-  FPU_code_verify_area(1);
+  FPU_code_access_ok(1);
   FPU_get_user(FPU_modrm, (u_char __user *) FPU_EIP);
   RE_ENTRANT_CHECK_ON;
   FPU_EIP++;
@@ -589,7 +589,7 @@ static int valid_prefix(u_char *Byte, u_
   *override = (overrides) { 0, 0, PREFIX_DEFAULT };       /* defaults */
 
   RE_ENTRANT_CHECK_OFF;
-  FPU_code_verify_area(1);
+  FPU_code_access_ok(1);
   FPU_get_user(byte, ip);
   RE_ENTRANT_CHECK_ON;
 
@@ -635,7 +635,7 @@ static int valid_prefix(u_char *Byte, u_
 	do_next_byte:
 	  ip++;
 	  RE_ENTRANT_CHECK_OFF;
-	  FPU_code_verify_area(1);
+	  FPU_code_access_ok(1);
 	  FPU_get_user(byte, ip);
 	  RE_ENTRANT_CHECK_ON;
 	  break;
@@ -686,7 +686,7 @@ int restore_i387_soft(void *s387, struct
   int offset, other, i, tags, regnr, tag, newtop;
 
   RE_ENTRANT_CHECK_OFF;
-  FPU_verify_area(VERIFY_READ, d, 7*4 + 8*10);
+  FPU_access_ok(VERIFY_READ, d, 7*4 + 8*10);
   if (__copy_from_user(&S387->cwd, d, 7*4))
     return -1;
   RE_ENTRANT_CHECK_ON;
@@ -732,7 +732,7 @@ int save_i387_soft(void *s387, struct _f
   int offset = (S387->ftop & 7) * 10, other = 80 - offset;
 
   RE_ENTRANT_CHECK_OFF;
-  FPU_verify_area(VERIFY_WRITE, d, 7*4 + 8*10);
+  FPU_access_ok(VERIFY_WRITE, d, 7*4 + 8*10);
 #ifdef PECULIAR_486
   S387->cwd &= ~0xe080;
   /* An 80486 sets nearly all of the reserved bits to 1. */
diff -uprN linux-2.6.11-mm4-orig/arch/i386/math-emu/fpu_system.h linux-2.6.11-mm4/arch/i386/math-emu/fpu_system.h
--- linux-2.6.11-mm4-orig/arch/i386/math-emu/fpu_system.h	2005-03-16 15:45:03.000000000 +0100
+++ linux-2.6.11-mm4/arch/i386/math-emu/fpu_system.h	2005-03-20 03:56:09.000000000 +0100
@@ -66,7 +66,7 @@
 #define instruction_address	(*(struct address *)&I387.soft.fip)
 #define operand_address		(*(struct address *)&I387.soft.foo)
 
-#define FPU_verify_area(x,y,z)	if ( !access_ok(x,y,z) ) \
+#define FPU_access_ok(x,y,z)	if ( !access_ok(x,y,z) ) \
 				math_abort(FPU_info,SIGSEGV)
 
 #undef FPU_IGNORE_CODE_SEGV
@@ -75,12 +75,12 @@
    about 20% slower if applied to the code. Anyway, errors due to bad
    code addresses should be much rarer than errors due to bad data
    addresses. */
-#define	FPU_code_verify_area(z)
+#define	FPU_code_access_ok(z)
 #else
 /* A simpler test than access_ok() can probably be done for
-   FPU_code_verify_area() because the only possible error is to step
+   FPU_code_access_ok() because the only possible error is to step
    past the upper boundary of a legal code area. */
-#define	FPU_code_verify_area(z) FPU_verify_area(VERIFY_READ,(void __user *)FPU_EIP,z)
+#define	FPU_code_access_ok(z) FPU_access_ok(VERIFY_READ,(void __user *)FPU_EIP,z)
 #endif
 
 #define FPU_get_user(x,y)       get_user((x),(y))
diff -uprN linux-2.6.11-mm4-orig/arch/i386/math-emu/get_address.c linux-2.6.11-mm4/arch/i386/math-emu/get_address.c
--- linux-2.6.11-mm4-orig/arch/i386/math-emu/get_address.c	2005-03-02 08:38:32.000000000 +0100
+++ linux-2.6.11-mm4/arch/i386/math-emu/get_address.c	2005-03-20 03:58:29.000000000 +0100
@@ -81,7 +81,7 @@ static int sib(int mod, unsigned long *f
   long offset;
 
   RE_ENTRANT_CHECK_OFF;
-  FPU_code_verify_area(1);
+  FPU_code_access_ok(1);
   FPU_get_user(base, (u_char __user *) (*fpu_eip));   /* The SIB byte */
   RE_ENTRANT_CHECK_ON;
   (*fpu_eip)++;
@@ -111,7 +111,7 @@ static int sib(int mod, unsigned long *f
       /* 8 bit signed displacement */
       long displacement;
       RE_ENTRANT_CHECK_OFF;
-      FPU_code_verify_area(1);
+      FPU_code_access_ok(1);
       FPU_get_user(displacement, (signed char __user *) (*fpu_eip));
       offset += displacement;
       RE_ENTRANT_CHECK_ON;
@@ -122,7 +122,7 @@ static int sib(int mod, unsigned long *f
       /* 32 bit displacement */
       long displacement;
       RE_ENTRANT_CHECK_OFF;
-      FPU_code_verify_area(4);
+      FPU_code_access_ok(4);
       FPU_get_user(displacement, (long __user *) (*fpu_eip));
       offset += displacement;
       RE_ENTRANT_CHECK_ON;
@@ -276,7 +276,7 @@ void __user *FPU_get_address(u_char FPU_
 	    {
 	      /* Special case: disp32 */
 	      RE_ENTRANT_CHECK_OFF;
-	      FPU_code_verify_area(4);
+	      FPU_code_access_ok(4);
 	      FPU_get_user(address, (unsigned long __user *) (*fpu_eip));
 	      (*fpu_eip) += 4;
 	      RE_ENTRANT_CHECK_ON;
@@ -293,7 +293,7 @@ void __user *FPU_get_address(u_char FPU_
 	case 1:
 	  /* 8 bit signed displacement */
 	  RE_ENTRANT_CHECK_OFF;
-	  FPU_code_verify_area(1);
+	  FPU_code_access_ok(1);
 	  FPU_get_user(address, (signed char __user *) (*fpu_eip));
 	  RE_ENTRANT_CHECK_ON;
 	  (*fpu_eip)++;
@@ -301,7 +301,7 @@ void __user *FPU_get_address(u_char FPU_
 	case 2:
 	  /* 32 bit displacement */
 	  RE_ENTRANT_CHECK_OFF;
-	  FPU_code_verify_area(4);
+	  FPU_code_access_ok(4);
 	  FPU_get_user(address, (long __user *) (*fpu_eip));
 	  (*fpu_eip) += 4;
 	  RE_ENTRANT_CHECK_ON;
@@ -362,7 +362,7 @@ void __user *FPU_get_address_16(u_char F
 	{
 	  /* Special case: disp16 */
 	  RE_ENTRANT_CHECK_OFF;
-	  FPU_code_verify_area(2);
+	  FPU_code_access_ok(2);
 	  FPU_get_user(address, (unsigned short __user *) (*fpu_eip));
 	  (*fpu_eip) += 2;
 	  RE_ENTRANT_CHECK_ON;
@@ -372,7 +372,7 @@ void __user *FPU_get_address_16(u_char F
     case 1:
       /* 8 bit signed displacement */
       RE_ENTRANT_CHECK_OFF;
-      FPU_code_verify_area(1);
+      FPU_code_access_ok(1);
       FPU_get_user(address, (signed char __user *) (*fpu_eip));
       RE_ENTRANT_CHECK_ON;
       (*fpu_eip)++;
@@ -380,7 +380,7 @@ void __user *FPU_get_address_16(u_char F
     case 2:
       /* 16 bit displacement */
       RE_ENTRANT_CHECK_OFF;
-      FPU_code_verify_area(2);
+      FPU_code_access_ok(2);
       FPU_get_user(address, (unsigned short __user *) (*fpu_eip));
       (*fpu_eip) += 2;
       RE_ENTRANT_CHECK_ON;
diff -uprN linux-2.6.11-mm4-orig/arch/i386/math-emu/load_store.c linux-2.6.11-mm4/arch/i386/math-emu/load_store.c
--- linux-2.6.11-mm4-orig/arch/i386/math-emu/load_store.c	2005-03-16 15:45:03.000000000 +0100
+++ linux-2.6.11-mm4/arch/i386/math-emu/load_store.c	2005-03-20 03:59:03.000000000 +0100
@@ -208,7 +208,7 @@ int FPU_load_store(u_char type, fpu_addr
       break;
     case 024:     /* fldcw */
       RE_ENTRANT_CHECK_OFF;
-      FPU_verify_area(VERIFY_READ, data_address, 2);
+      FPU_access_ok(VERIFY_READ, data_address, 2);
       FPU_get_user(control_word, (unsigned short __user *) data_address);
       RE_ENTRANT_CHECK_ON;
       if ( partial_status & ~control_word & CW_Exceptions )
@@ -243,7 +243,7 @@ int FPU_load_store(u_char type, fpu_addr
       break;
     case 034:      /* fstcw m16int */
       RE_ENTRANT_CHECK_OFF;
-      FPU_verify_area(VERIFY_WRITE,data_address,2);
+      FPU_access_ok(VERIFY_WRITE,data_address,2);
       FPU_put_user(control_word, (unsigned short __user *) data_address);
       RE_ENTRANT_CHECK_ON;
       return 1;
@@ -255,7 +255,7 @@ int FPU_load_store(u_char type, fpu_addr
       break;
     case 036:      /* fstsw m2byte */
       RE_ENTRANT_CHECK_OFF;
-      FPU_verify_area(VERIFY_WRITE,data_address,2);
+      FPU_access_ok(VERIFY_WRITE,data_address,2);
       FPU_put_user(status_word(),(unsigned short __user *) data_address);
       RE_ENTRANT_CHECK_ON;
       return 1;
diff -uprN linux-2.6.11-mm4-orig/arch/i386/math-emu/reg_ld_str.c linux-2.6.11-mm4/arch/i386/math-emu/reg_ld_str.c
--- linux-2.6.11-mm4-orig/arch/i386/math-emu/reg_ld_str.c	2005-03-02 08:38:13.000000000 +0100
+++ linux-2.6.11-mm4/arch/i386/math-emu/reg_ld_str.c	2005-03-20 04:01:28.000000000 +0100
@@ -91,7 +91,7 @@ int FPU_load_extended(long double __user
   FPU_REG *sti_ptr = &st(stnr);
 
   RE_ENTRANT_CHECK_OFF;
-  FPU_verify_area(VERIFY_READ, s, 10);
+  FPU_access_ok(VERIFY_READ, s, 10);
   __copy_from_user(sti_ptr, s, 10);
   RE_ENTRANT_CHECK_ON;
 
@@ -106,7 +106,7 @@ int FPU_load_double(double __user *dfloa
   unsigned m64, l64;
 
   RE_ENTRANT_CHECK_OFF;
-  FPU_verify_area(VERIFY_READ, dfloat, 8);
+  FPU_access_ok(VERIFY_READ, dfloat, 8);
   FPU_get_user(m64, 1 + (unsigned long __user *) dfloat);
   FPU_get_user(l64, (unsigned long __user *) dfloat);
   RE_ENTRANT_CHECK_ON;
@@ -178,7 +178,7 @@ int FPU_load_single(float __user *single
   int exp, tag, negative;
 
   RE_ENTRANT_CHECK_OFF;
-  FPU_verify_area(VERIFY_READ, single, 4);
+  FPU_access_ok(VERIFY_READ, single, 4);
   FPU_get_user(m32, (unsigned long __user *) single);
   RE_ENTRANT_CHECK_ON;
 
@@ -243,7 +243,7 @@ int FPU_load_int64(long long __user *_s)
   FPU_REG *st0_ptr = &st(0);
 
   RE_ENTRANT_CHECK_OFF;
-  FPU_verify_area(VERIFY_READ, _s, 8);
+  FPU_access_ok(VERIFY_READ, _s, 8);
   copy_from_user(&s,_s,8);
   RE_ENTRANT_CHECK_ON;
 
@@ -274,7 +274,7 @@ int FPU_load_int32(long __user *_s, FPU_
   int negative;
 
   RE_ENTRANT_CHECK_OFF;
-  FPU_verify_area(VERIFY_READ, _s, 4);
+  FPU_access_ok(VERIFY_READ, _s, 4);
   FPU_get_user(s, _s);
   RE_ENTRANT_CHECK_ON;
 
@@ -302,7 +302,7 @@ int FPU_load_int16(short __user *_s, FPU
   int s, negative;
 
   RE_ENTRANT_CHECK_OFF;
-  FPU_verify_area(VERIFY_READ, _s, 2);
+  FPU_access_ok(VERIFY_READ, _s, 2);
   /* Cast as short to get the sign extended. */
   FPU_get_user(s, _s);
   RE_ENTRANT_CHECK_ON;
@@ -335,7 +335,7 @@ int FPU_load_bcd(u_char __user *s)
   int sign;
 
   RE_ENTRANT_CHECK_OFF;
-  FPU_verify_area(VERIFY_READ, s, 10);
+  FPU_access_ok(VERIFY_READ, s, 10);
   RE_ENTRANT_CHECK_ON;
   for ( pos = 8; pos >= 0; pos--)
     {
@@ -380,7 +380,7 @@ int FPU_store_extended(FPU_REG *st0_ptr,
   if ( st0_tag != TAG_Empty )
     {
       RE_ENTRANT_CHECK_OFF;
-      FPU_verify_area(VERIFY_WRITE, d, 10);
+      FPU_access_ok(VERIFY_WRITE, d, 10);
 
       FPU_put_user(st0_ptr->sigl, (unsigned long __user *) d);
       FPU_put_user(st0_ptr->sigh, (unsigned long __user *) ((u_char __user *)d + 4));
@@ -397,7 +397,7 @@ int FPU_store_extended(FPU_REG *st0_ptr,
       /* The masked response */
       /* Put out the QNaN indefinite */
       RE_ENTRANT_CHECK_OFF;
-      FPU_verify_area(VERIFY_WRITE,d,10);
+      FPU_access_ok(VERIFY_WRITE,d,10);
       FPU_put_user(0, (unsigned long __user *) d);
       FPU_put_user(0xc0000000, 1 + (unsigned long __user *) d);
       FPU_put_user(0xffff, 4 + (short __user *) d);
@@ -607,7 +607,7 @@ int FPU_store_double(FPU_REG *st0_ptr, u
 	  /* The masked response */
 	  /* Put out the QNaN indefinite */
 	  RE_ENTRANT_CHECK_OFF;
-	  FPU_verify_area(VERIFY_WRITE,dfloat,8);
+	  FPU_access_ok(VERIFY_WRITE,dfloat,8);
 	  FPU_put_user(0, (unsigned long __user *) dfloat);
 	  FPU_put_user(0xfff80000, 1 + (unsigned long __user *) dfloat);
 	  RE_ENTRANT_CHECK_ON;
@@ -620,7 +620,7 @@ int FPU_store_double(FPU_REG *st0_ptr, u
     l[1] |= 0x80000000;
 
   RE_ENTRANT_CHECK_OFF;
-  FPU_verify_area(VERIFY_WRITE,dfloat,8);
+  FPU_access_ok(VERIFY_WRITE,dfloat,8);
   FPU_put_user(l[0], (unsigned long __user *)dfloat);
   FPU_put_user(l[1], 1 + (unsigned long __user *)dfloat);
   RE_ENTRANT_CHECK_ON;
@@ -826,7 +826,7 @@ int FPU_store_single(FPU_REG *st0_ptr, u
 	  /* The masked response */
 	  /* Put out the QNaN indefinite */
 	  RE_ENTRANT_CHECK_OFF;
-	  FPU_verify_area(VERIFY_WRITE,single,4);
+	  FPU_access_ok(VERIFY_WRITE,single,4);
 	  FPU_put_user(0xffc00000, (unsigned long __user *) single);
 	  RE_ENTRANT_CHECK_ON;
 	  return 1;
@@ -845,7 +845,7 @@ int FPU_store_single(FPU_REG *st0_ptr, u
     templ |= 0x80000000;
 
   RE_ENTRANT_CHECK_OFF;
-  FPU_verify_area(VERIFY_WRITE,single,4);
+  FPU_access_ok(VERIFY_WRITE,single,4);
   FPU_put_user(templ,(unsigned long __user *) single);
   RE_ENTRANT_CHECK_ON;
 
@@ -906,7 +906,7 @@ int FPU_store_int64(FPU_REG *st0_ptr, u_
     }
 
   RE_ENTRANT_CHECK_OFF;
-  FPU_verify_area(VERIFY_WRITE,d,8);
+  FPU_access_ok(VERIFY_WRITE,d,8);
   copy_to_user(d, &tll, 8);
   RE_ENTRANT_CHECK_ON;
 
@@ -963,7 +963,7 @@ int FPU_store_int32(FPU_REG *st0_ptr, u_
     }
 
   RE_ENTRANT_CHECK_OFF;
-  FPU_verify_area(VERIFY_WRITE,d,4);
+  FPU_access_ok(VERIFY_WRITE,d,4);
   FPU_put_user(t.sigl, (unsigned long __user *) d);
   RE_ENTRANT_CHECK_ON;
 
@@ -1020,7 +1020,7 @@ int FPU_store_int16(FPU_REG *st0_ptr, u_
     }
 
   RE_ENTRANT_CHECK_OFF;
-  FPU_verify_area(VERIFY_WRITE,d,2);
+  FPU_access_ok(VERIFY_WRITE,d,2);
   FPU_put_user((short)t.sigl, d);
   RE_ENTRANT_CHECK_ON;
 
@@ -1069,7 +1069,7 @@ int FPU_store_bcd(FPU_REG *st0_ptr, u_ch
 	{
 	  /* Produce the QNaN "indefinite" */
 	  RE_ENTRANT_CHECK_OFF;
-	  FPU_verify_area(VERIFY_WRITE,d,10);
+	  FPU_access_ok(VERIFY_WRITE,d,10);
 	  for ( i = 0; i < 7; i++)
 	    FPU_put_user(0, d+i); /* These bytes "undefined" */
 	  FPU_put_user(0xc0, d+7); /* This byte "undefined" */
@@ -1088,7 +1088,7 @@ int FPU_store_bcd(FPU_REG *st0_ptr, u_ch
     }
 
   RE_ENTRANT_CHECK_OFF;
-  FPU_verify_area(VERIFY_WRITE,d,10);
+  FPU_access_ok(VERIFY_WRITE,d,10);
   RE_ENTRANT_CHECK_ON;
   for ( i = 0; i < 9; i++)
     {
@@ -1186,7 +1186,7 @@ u_char __user *fldenv(fpu_addr_modes add
       ^ (addr_modes.override.operand_size == OP_SIZE_PREFIX)) )
     {
       RE_ENTRANT_CHECK_OFF;
-      FPU_verify_area(VERIFY_READ, s, 0x0e);
+      FPU_access_ok(VERIFY_READ, s, 0x0e);
       FPU_get_user(control_word, (unsigned short __user *) s);
       FPU_get_user(partial_status, (unsigned short __user *) (s+2));
       FPU_get_user(tag_word, (unsigned short __user *) (s+4));
@@ -1206,7 +1206,7 @@ u_char __user *fldenv(fpu_addr_modes add
   else
     {
       RE_ENTRANT_CHECK_OFF;
-      FPU_verify_area(VERIFY_READ, s, 0x1c);
+      FPU_access_ok(VERIFY_READ, s, 0x1c);
       FPU_get_user(control_word, (unsigned short __user *) s);
       FPU_get_user(partial_status, (unsigned short __user *) (s+4));
       FPU_get_user(tag_word, (unsigned short __user *) (s+8));
@@ -1274,7 +1274,7 @@ void frstor(fpu_addr_modes addr_modes, u
 
   /* Copy all registers in stack order. */
   RE_ENTRANT_CHECK_OFF;
-  FPU_verify_area(VERIFY_READ,s,80);
+  FPU_access_ok(VERIFY_READ,s,80);
   __copy_from_user(register_base+offset, s, other);
   if ( offset )
     __copy_from_user(register_base, s+other, offset);
@@ -1298,7 +1298,7 @@ u_char __user *fstenv(fpu_addr_modes add
       ^ (addr_modes.override.operand_size == OP_SIZE_PREFIX)) )
     {
       RE_ENTRANT_CHECK_OFF;
-      FPU_verify_area(VERIFY_WRITE,d,14);
+      FPU_access_ok(VERIFY_WRITE,d,14);
 #ifdef PECULIAR_486
       FPU_put_user(control_word & ~0xe080, (unsigned long __user *) d);
 #else
@@ -1326,7 +1326,7 @@ u_char __user *fstenv(fpu_addr_modes add
   else
     {
       RE_ENTRANT_CHECK_OFF;
-      FPU_verify_area(VERIFY_WRITE, d, 7*4);
+      FPU_access_ok(VERIFY_WRITE, d, 7*4);
 #ifdef PECULIAR_486
       control_word &= ~0xe080;
       /* An 80486 sets nearly all of the reserved bits to 1. */
@@ -1356,7 +1356,7 @@ void fsave(fpu_addr_modes addr_modes, u_
   d = fstenv(addr_modes, data_address);
 
   RE_ENTRANT_CHECK_OFF;
-  FPU_verify_area(VERIFY_WRITE,d,80);
+  FPU_access_ok(VERIFY_WRITE,d,80);
 
   /* Copy all registers in stack order. */
   __copy_to_user(d, register_base+offset, other);


