Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130113AbRBSTUt>; Mon, 19 Feb 2001 14:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130910AbRBSTUo>; Mon, 19 Feb 2001 14:20:44 -0500
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:23984 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S130113AbRBSTU1> convert rfc822-to-8bit; Mon, 19 Feb 2001 14:20:27 -0500
From: schwidefsky@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: linux-kernel@vger.kernel.org
Message-ID: <C12569F8.006A2C9E.00@d12mta07.de.ibm.com>
Date: Mon, 19 Feb 2001 20:18:02 +0100
Subject: bug in generic math-emu
Mime-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,
I found a bug in the generic floating point emulation code. The glibc
math testcases showed errors for the nearbyint(0.5) test. The problem
is in the _FP_FRAC_SRS_2 macro. The expression to find out if some 1
bits have been shifted out is wrong. Try the _FP_FRAC_SRS_2 macro
with the following parameters: X_f1 = 0x00800000, X_f0 = 0x00000000,
N = 53, sz = 56. It comes back with 0x0000000000000005 instead of
0x0000000000000004. Now you can do the math ;-)
With the following patch test-float and test-double (both from glibc)
now run without errors on a S/390 without IEEE fpu.

diff -u -r1.1.1.1 op-2.h
--- include/math-emu/op-2.h   2000/02/04 13:53:47  1.1.1.1
+++ include/math-emu/op-2.h   2001/02/19 18:53:41
@@ -79,7 +79,7 @@
     else                                     \
       {                                           \
     X##_f0 = (X##_f1 >> ((N) - _FP_W_TYPE_SIZE) |                \
-           (((X##_f1 << (sz - (N))) | X##_f0) != 0));       \
+           (((X##_f1 << (2*_FP_W_TYPE_SIZE - (N))) | X##_f0) != 0)); \
     X##_f1 = 0;                                   \
       }                                           \
   } while (0)


blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


