Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268247AbUHKV5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268247AbUHKV5l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 17:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268257AbUHKV5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 17:57:41 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:44556 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S268247AbUHKV4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 17:56:33 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: James Morris <jmorris@redhat.com>
Subject: [PATCH] aes-i586-asm.S optimization
Date: Thu, 12 Aug 2004 00:56:03 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zXpGBVAPg2B+RUQ"
Message-Id: <200408120056.03939.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_zXpGBVAPg2B+RUQ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi James,

These patches add a minor optimization to aes-i586-asm.S.
Diffed against linux-2.6.8-rc4.

formatting.patch:
renames macro parameters to more understandable ones
fixes wrong comment (code does not use MMX)

opt.patch:
convert fwd_rnd into pair of fwd_rnd1,fwd_rnd2 which use
r0,r2 in mirror-image fashion, thus eliminating the need
to do "mov r0,r2". After testing, same can be done
to inv_rnd.

Both patches are only compile tested. First one produces bit-identical
object file. Second one, understandably, not.

PS: why aes-i586-asm.S? it is valid _386_ code (no Pentium ops used AFAICS).

PPS: your code is very easy to understand. It was a joy hacking on it :)
--
vda

--Boundary-00=_zXpGBVAPg2B+RUQ
Content-Type: text/x-diff;
  charset="us-ascii";
  name="formatting.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="formatting.patch"

--- linux-2.6.8-rc4.src/arch/i386/crypto/aes-i586-asm.S.orig	Wed Aug 11 22:44:53 2004
+++ linux-2.6.8-rc4.src/arch/i386/crypto/aes-i586-asm.S	Thu Aug 12 00:29:14 2004
@@ -84,60 +84,61 @@
 // output registers r0, r1, r4 or r5.  
 
 // Parameters:
+// table table base address
 //   %1  out_state[0]
 //   %2  out_state[1]
 //   %3  out_state[2]
 //   %4  out_state[3]
-//   %5  table base address
-//   %6  input register for the round (destroyed)
-//   %7  scratch register for the round
-
-#define do_col(a1, a2, a3, a4, a5, a6, a7)	\
-	movzx   %l(a6),%a7;			\
-	xor     a5(,%a7,4),%a1;			\
-	movzx   %h(a6),%a7;			\
-	shr     $16,%a6;			\
-	xor     a5+tlen(,%a7,4),%a2;		\
-	movzx   %l(a6),%a7;			\
-	movzx   %h(a6),%a6;			\
-	xor     a5+2*tlen(,%a7,4),%a3;		\
-	xor     a5+3*tlen(,%a6,4),%a4;
+//   idx input register for the round (destroyed)
+//   tmp scratch register for the round
+// sched key schedule
+
+#define do_col(table, a1,a2,a3,a4, idx, tmp)	\
+	movzx   %l(idx),%tmp;			\
+	xor     table(,%tmp,4),%a1;		\
+	movzx   %h(idx),%tmp;			\
+	shr     $16,%idx;			\
+	xor     table+tlen(,%tmp,4),%a2;	\
+	movzx   %l(idx),%tmp;			\
+	movzx   %h(idx),%idx;			\
+	xor     table+2*tlen(,%tmp,4),%a3;	\
+	xor     table+3*tlen(,%idx,4),%a4;
 
 // initialise output registers from the key schedule
-
-#define do_fcol(a1, a2, a3, a4, a5, a6, a7, a8)	\
-	mov     0 a8,%a1;			\
-	movzx   %l(a6),%a7;			\
-	mov     12 a8,%a2;			\
-	xor     a5(,%a7,4),%a1;			\
-	mov     4 a8,%a4;			\
-	movzx   %h(a6),%a7;			\
-	shr     $16,%a6;			\
-	xor     a5+tlen(,%a7,4),%a2;		\
-	movzx   %l(a6),%a7;			\
-	movzx   %h(a6),%a6;			\
-	xor     a5+3*tlen(,%a6,4),%a4;		\
-	mov     %a3,%a6;			\
-	mov     8 a8,%a3;			\
-	xor     a5+2*tlen(,%a7,4),%a3;
+// NB: original a3 is in idx on exit
+#define do_fcol(table, a1,a2,a3,a4, idx, tmp, sched) \
+	mov     0 sched,%a1;			\
+	movzx   %l(idx),%tmp;			\
+	mov     12 sched,%a2;			\
+	xor     table(,%tmp,4),%a1;		\
+	mov     4 sched,%a4;			\
+	movzx   %h(idx),%tmp;			\
+	shr     $16,%idx;			\
+	xor     table+tlen(,%tmp,4),%a2;	\
+	movzx   %l(idx),%tmp;			\
+	movzx   %h(idx),%idx;			\
+	xor     table+3*tlen(,%idx,4),%a4;	\
+	mov     %a3,%idx;			\
+	mov     8 sched,%a3;			\
+	xor     table+2*tlen(,%tmp,4),%a3;
 
 // initialise output registers from the key schedule
-
-#define do_icol(a1, a2, a3, a4, a5, a6, a7, a8)	\
-	mov     0 a8,%a1;			\
-	movzx   %l(a6),%a7;			\
-	mov     4 a8,%a2;			\
-	xor     a5(,%a7,4),%a1;			\
-	mov     12 a8,%a4;			\
-	movzx   %h(a6),%a7;			\
-	shr     $16,%a6;			\
-	xor     a5+tlen(,%a7,4),%a2;		\
-	movzx   %l(a6),%a7;			\
-	movzx   %h(a6),%a6;			\
-	xor     a5+3*tlen(,%a6,4),%a4;		\
-	mov     %a3,%a6;			\
-	mov     8 a8,%a3;			\
-	xor     a5+2*tlen(,%a7,4),%a3;
+// NB: original a3 is in idx on exit
+#define do_icol(table, a1,a2,a3,a4, idx, tmp, sched) \
+	mov     0 sched,%a1;			\
+	movzx   %l(idx),%tmp;			\
+	mov     4 sched,%a2;			\
+	xor     table(,%tmp,4),%a1;		\
+	mov     12 sched,%a4;			\
+	movzx   %h(idx),%tmp;			\
+	shr     $16,%idx;			\
+	xor     table+tlen(,%tmp,4),%a2;	\
+	movzx   %l(idx),%tmp;			\
+	movzx   %h(idx),%idx;			\
+	xor     table+3*tlen(,%idx,4),%a4;	\
+	mov     %a3,%idx;			\
+	mov     8 sched,%a3;			\
+	xor     table+2*tlen(,%tmp,4),%a3;
 
 
 // original Gladman had conditional saves to MMX regs.
@@ -149,42 +150,39 @@
 
 // This macro performs a forward encryption cycle. It is entered with
 // the first previous round column values in r0, r1, r4 and r5 and
-// exits with the final values in the same registers, using the MMX
-// registers mm0-mm1 or the stack for temporary storage
+// exits with the final values in the same registers, using stack
+// for temporary storage
 
-// mov current column values into the MMX registers
 #define fwd_rnd(arg, table)					\
-	/* mov current column values into the MMX registers */	\
 	mov     %r0,%r2;					\
 	save   (0,r1);						\
 	save   (1,r5);						\
 								\
 	/* compute new column values */				\
-	do_fcol(r0,r5,r4,r1,table, r2,r3, arg);			\
-	do_col (r4,r1,r0,r5,table, r2,r3);			\
+	do_fcol(table, r0,r5,r4,r1, r2,r3, arg);		\
+	do_col (table, r4,r1,r0,r5, r2,r3);			\
 	restore(r2,0);						\
-	do_col (r1,r0,r5,r4,table, r2,r3);			\
+	do_col (table, r1,r0,r5,r4, r2,r3);			\
 	restore(r2,1);						\
-	do_col (r5,r4,r1,r0,table, r2,r3);
+	do_col (table, r5,r4,r1,r0, r2,r3);
 
 // This macro performs an inverse encryption cycle. It is entered with
 // the first previous round column values in r0, r1, r4 and r5 and
-// exits with the final values in the same registers, using the MMX
-// registers mm0-mm1 or the stack for temporary storage
+// exits with the final values in the same registers, using stack
+// for temporary storage
 
 #define inv_rnd(arg, table)					\
-	/* mov current column values into the MMX registers */	\
 	mov     %r0,%r2;					\
 	save    (0,r1);						\
 	save    (1,r5);						\
 								\
 	/* compute new column values */				\
-	do_icol(r0,r1,r4,r5, table, r2,r3, arg);		\
-	do_col (r4,r5,r0,r1, table, r2,r3);			\
+	do_icol(table, r0,r1,r4,r5, r2,r3, arg);		\
+	do_col (table, r4,r5,r0,r1, r2,r3);			\
 	restore(r2,0);						\
-	do_col (r1,r4,r5,r0, table, r2,r3);			\
+	do_col (table, r1,r4,r5,r0, r2,r3);			\
 	restore(r2,1);						\
-	do_col (r5,r0,r1,r4, table, r2,r3);
+	do_col (table, r5,r0,r1,r4, r2,r3);
 
 // AES (Rijndael) Encryption Subroutine
 

--Boundary-00=_zXpGBVAPg2B+RUQ
Content-Type: text/x-diff;
  charset="us-ascii";
  name="opt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="opt.patch"

--- linux-2.6.8-rc4.src/arch/i386/crypto/aes-i586-asm.S.1	Thu Aug 12 00:29:14 2004
+++ linux-2.6.8-rc4.src/arch/i386/crypto/aes-i586-asm.S	Thu Aug 12 00:30:12 2004
@@ -105,7 +105,8 @@
 	xor     table+3*tlen(,%idx,4),%a4;
 
 // initialise output registers from the key schedule
-// NB: original a3 is in idx on exit
+// NB1: original value of a3 is in idx on exit
+// NB2: original values of a1,a2,a4 do not matter
 #define do_fcol(table, a1,a2,a3,a4, idx, tmp, sched) \
 	mov     0 sched,%a1;			\
 	movzx   %l(idx),%tmp;			\
@@ -148,23 +149,40 @@
 #define restore(a1, a2)		\
 	mov     4*a2(%esp),%a1
 
-// This macro performs a forward encryption cycle. It is entered with
+// These macro perform a forward encryption cycle. They are entered with
 // the first previous round column values in r0, r1, r4 and r5 and
-// exits with the final values in the same registers, using stack
-// for temporary storage
+// exit with the final values in the same registers, using stack
+// for temporary storage.
 
-#define fwd_rnd(arg, table)					\
-	mov     %r0,%r2;					\
+// round column values
+// on entry: r0,r1,r4,r5
+// on exit:  r2,r1,r4,r5
+#define fwd_rnd1(arg, table)					\
 	save   (0,r1);						\
 	save   (1,r5);						\
 								\
-	/* compute new column values */				\
-	do_fcol(table, r0,r5,r4,r1, r2,r3, arg);		\
-	do_col (table, r4,r1,r0,r5, r2,r3);			\
-	restore(r2,0);						\
-	do_col (table, r1,r0,r5,r4, r2,r3);			\
-	restore(r2,1);						\
-	do_col (table, r5,r4,r1,r0, r2,r3);
+	/* compute new column values */					\
+	do_fcol(table, r2,r5,r4,r1, r0,r3, arg);	/* idx=r0 */	\
+	do_col (table, r4,r1,r2,r5, r0,r3);		/* idx=r4 */	\
+	restore(r0,0);							\
+	do_col (table, r1,r2,r5,r4, r0,r3);		/* idx=r1 */	\
+	restore(r0,1);							\
+	do_col (table, r5,r4,r1,r2, r0,r3);		/* idx=r5 */
+
+// round column values
+// on entry: r2,r1,r4,r5
+// on exit:  r0,r1,r4,r5
+#define fwd_rnd2(arg, table)					\
+	save   (0,r1);						\
+	save   (1,r5);						\
+								\
+	/* compute new column values */					\
+	do_fcol(table, r0,r5,r4,r1, r2,r3, arg);	/* idx=r2 */	\
+	do_col (table, r4,r1,r0,r5, r2,r3);		/* idx=r4 */	\
+	restore(r2,0);							\
+	do_col (table, r1,r0,r5,r4, r2,r3);		/* idx=r1 */	\
+	restore(r2,1);							\
+	do_col (table, r5,r4,r1,r0, r2,r3);		/* idx=r5 */
 
 // This macro performs an inverse encryption cycle. It is entered with
 // the first previous round column values in r0, r1, r4 and r5 and
@@ -228,20 +246,20 @@
 	je      3f              // 12 rounds for 128-bit key
 	add     $32,%r6
 
-2:	fwd_rnd( -64(%r6) ,ft_tab)	// 14 rounds for 128-bit key
-	fwd_rnd( -48(%r6) ,ft_tab)
-3:	fwd_rnd( -32(%r6) ,ft_tab)	// 12 rounds for 128-bit key
-	fwd_rnd( -16(%r6) ,ft_tab)
-4:	fwd_rnd(    (%r6) ,ft_tab)	// 10 rounds for 128-bit key
-	fwd_rnd( +16(%r6) ,ft_tab)
-	fwd_rnd( +32(%r6) ,ft_tab)
-	fwd_rnd( +48(%r6) ,ft_tab)
-	fwd_rnd( +64(%r6) ,ft_tab)
-	fwd_rnd( +80(%r6) ,ft_tab)
-	fwd_rnd( +96(%r6) ,ft_tab)
-	fwd_rnd(+112(%r6) ,ft_tab)
-	fwd_rnd(+128(%r6) ,ft_tab)
-	fwd_rnd(+144(%r6) ,fl_tab)	// last round uses a different table
+2:	fwd_rnd1( -64(%r6) ,ft_tab)	// 14 rounds for 128-bit key
+	fwd_rnd2( -48(%r6) ,ft_tab)
+3:	fwd_rnd1( -32(%r6) ,ft_tab)	// 12 rounds for 128-bit key
+	fwd_rnd2( -16(%r6) ,ft_tab)
+4:	fwd_rnd1(    (%r6) ,ft_tab)	// 10 rounds for 128-bit key
+	fwd_rnd2( +16(%r6) ,ft_tab)
+	fwd_rnd1( +32(%r6) ,ft_tab)
+	fwd_rnd2( +48(%r6) ,ft_tab)
+	fwd_rnd1( +64(%r6) ,ft_tab)
+	fwd_rnd2( +80(%r6) ,ft_tab)
+	fwd_rnd1( +96(%r6) ,ft_tab)
+	fwd_rnd2(+112(%r6) ,ft_tab)
+	fwd_rnd1(+128(%r6) ,ft_tab)
+	fwd_rnd2(+144(%r6) ,fl_tab)	// last round uses a different table
 
 // move final values to the output array.  CAUTION: the 
 // order of these assigns rely on the register mappings

--Boundary-00=_zXpGBVAPg2B+RUQ--

