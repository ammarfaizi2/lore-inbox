Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262663AbVAQBhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbVAQBhM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 20:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262664AbVAQBhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 20:37:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49106 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262663AbVAQBhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 20:37:02 -0500
Date: Sun, 16 Jan 2005 17:36:55 -0800
Message-Id: <200501170136.j0H1at6x026128@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>
Subject: [PATCH] i386/x86_64 fpu: fix x87 tag word simulation using fxsave
X-Fcc: ~/Mail/linus
X-Shopping-List: (1) Incumbent Scratch 'n' Snot citation skis
   (2) Embryonic eggplant tape
   (3) Educated brief Johnny Carson lookalikes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note, this code is identical in 2.4 so this fix applies there as well.


A user reported that the x87 "tag word" value reported by PTRACE_GETFPREGS
did not match what the "fnsave" instruction stores for the same FPU state.
It turns out to be a bug in the conversion from fxsave format to fnsave
format.  (This can also bite interrupted FPU state restored by a signal
handler.)  The tag bits (in both formats) are stored in physical register
order, though the register contents are stored in x87 register stack order.
This is barely mentioned in the processor manuals, and easy to overlook.
It's even more confusing when you read the AMD64 manuals, which erroneously
claim that fxsave stores the register contents in physical order as well.
Fortunately, only the manuals differ and all the chips actually agree.


Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/arch/i386/kernel/i387.c
+++ linux-2.6/arch/i386/kernel/i387.c
@@ -111,6 +111,7 @@ static inline unsigned short twd_i387_to
 static inline unsigned long twd_fxsr_to_i387( struct i387_fxsave_struct *fxsave )
 {
 	struct _fpxreg *st = NULL;
+	const unsigned int tos = (fxsave->swd >> 11) & 7;
 	unsigned long twd = (unsigned long) fxsave->twd;
 	unsigned long tag;
 	unsigned long ret = 0xffff0000u;
@@ -120,7 +121,10 @@ static inline unsigned long twd_fxsr_to_
 
 	for ( i = 0 ; i < 8 ; i++ ) {
 		if ( twd & 0x1 ) {
-			st = (struct _fpxreg *) FPREG_ADDR( fxsave, i );
+			/* The tag bits are saved in physical order,
+			   but the registers are saved in stack order.  */
+			st = (struct _fpxreg *) FPREG_ADDR(fxsave,
+							   (i + 8 - tos) & 7);
 
 			switch ( st->exponent & 0x7fff ) {
 			case 0x7fff:
--- linux-2.6/arch/x86_64/ia32/fpu32.c
+++ linux-2.6/arch/x86_64/ia32/fpu32.c
@@ -28,6 +28,7 @@ static inline unsigned short twd_i387_to
 static inline unsigned long twd_fxsr_to_i387(struct i387_fxsave_struct *fxsave)
 {
 	struct _fpxreg *st = NULL;
+	const unsigned int tos = (fxsave->swd >> 11) & 7;
 	unsigned long twd = (unsigned long) fxsave->twd;
 	unsigned long tag;
 	unsigned long ret = 0xffff0000;
@@ -37,7 +38,10 @@ static inline unsigned long twd_fxsr_to_
 
 	for (i = 0 ; i < 8 ; i++) {
 		if (twd & 0x1) {
-			st = (struct _fpxreg *) FPREG_ADDR( fxsave, i );
+			/* The tag bits are saved in physical order,
+			   but the registers are saved in stack order.  */
+			st = (struct _fpxreg *) FPREG_ADDR(fxsave,
+							   (i + 8 - tos) & 7);
 
 			switch (st->exponent & 0x7fff) {
 			case 0x7fff:
