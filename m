Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161115AbWI1NKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161115AbWI1NKH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 09:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161117AbWI1NKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 09:10:07 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:21174 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161115AbWI1NKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 09:10:03 -0400
Date: Thu, 28 Sep 2006 15:10:02 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [S390] user readable uninitialised kernel memory.
Message-ID: <20060928131001.GG1120@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[S390] user readable uninitialised kernel memory.

A user space program can read uninitialised kernel memory
by appending to a file from a bad address and then reading
the result back. The cause is the copy_from_user function
that does not clear the remaining bytes of the kernel
buffer after it got a fault on the user space address.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/lib/uaccess_mvcos.c |   22 ++++++++++++++++------
 arch/s390/lib/uaccess_std.c   |   36 ++++++++++++++++++++++++++----------
 2 files changed, 42 insertions(+), 16 deletions(-)

diff -urpN linux-2.6/arch/s390/lib/uaccess_mvcos.c linux-2.6-patched/arch/s390/lib/uaccess_mvcos.c
--- linux-2.6/arch/s390/lib/uaccess_mvcos.c	2006-09-28 14:58:39.000000000 +0200
+++ linux-2.6-patched/arch/s390/lib/uaccess_mvcos.c	2006-09-28 14:58:57.000000000 +0200
@@ -35,7 +35,7 @@ size_t copy_from_user_mvcos(size_t size,
 	tmp1 = -4096UL;
 	asm volatile(
 		"0: .insn ss,0xc80000000000,0(%0,%2),0(%1),0\n"
-		"   jz    4f\n"
+		"   jz    7f\n"
 		"1:"ALR"  %0,%3\n"
 		"  "SLR"  %1,%3\n"
 		"  "SLR"  %2,%3\n"
@@ -44,13 +44,23 @@ size_t copy_from_user_mvcos(size_t size,
 		"   nr    %4,%3\n"	/* %4 = (ptr + 4095) & -4096 */
 		"  "SLR"  %4,%1\n"
 		"  "CLR"  %0,%4\n"	/* copy crosses next page boundary? */
-		"   jnh   5f\n"
+		"   jnh   4f\n"
 		"3: .insn ss,0xc80000000000,0(%4,%2),0(%1),0\n"
 		"  "SLR"  %0,%4\n"
-		"   j     5f\n"
-		"4:"SLR"  %0,%0\n"
-		"5: \n"
-		EX_TABLE(0b,2b) EX_TABLE(3b,5b)
+		"  "ALR"  %2,%4\n"
+		"4:"LHI"  %4,-1\n"
+		"  "ALR"  %4,%0\n"	/* copy remaining size, subtract 1 */
+		"   bras  %3,6f\n"	/* memset loop */
+		"   xc    0(1,%2),0(%2)\n"
+		"5: xc    0(256,%2),0(%2)\n"
+		"   la    %2,256(%2)\n"
+		"6:"AHI"  %4,-256\n"
+		"   jnm   5b\n"
+		"   ex    %4,0(%3)\n"
+		"   j     8f\n"
+		"7:"SLR"  %0,%0\n"
+		"8: \n"
+		EX_TABLE(0b,2b) EX_TABLE(3b,4b)
 		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
 		: "d" (reg0) : "cc", "memory");
 	return size;
diff -urpN linux-2.6/arch/s390/lib/uaccess_std.c linux-2.6-patched/arch/s390/lib/uaccess_std.c
--- linux-2.6/arch/s390/lib/uaccess_std.c	2006-09-28 14:58:39.000000000 +0200
+++ linux-2.6-patched/arch/s390/lib/uaccess_std.c	2006-09-28 14:58:57.000000000 +0200
@@ -35,25 +35,35 @@ size_t copy_from_user_std(size_t size, c
 	tmp1 = -256UL;
 	asm volatile(
 		"0: mvcp  0(%0,%2),0(%1),%3\n"
-		"   jz    5f\n"
+		"   jz    8f\n"
 		"1:"ALR"  %0,%3\n"
 		"   la    %1,256(%1)\n"
 		"   la    %2,256(%2)\n"
 		"2: mvcp  0(%0,%2),0(%1),%3\n"
 		"   jnz   1b\n"
-		"   j     5f\n"
+		"   j     8f\n"
 		"3: la    %4,255(%1)\n"	/* %4 = ptr + 255 */
 		"  "LHI"  %3,-4096\n"
 		"   nr    %4,%3\n"	/* %4 = (ptr + 255) & -4096 */
 		"  "SLR"  %4,%1\n"
 		"  "CLR"  %0,%4\n"	/* copy crosses next page boundary? */
-		"   jnh   6f\n"
+		"   jnh   5f\n"
 		"4: mvcp  0(%4,%2),0(%1),%3\n"
 		"  "SLR"  %0,%4\n"
-		"   j     6f\n"
-		"5:"SLR"  %0,%0\n"
-		"6: \n"
-		EX_TABLE(0b,3b) EX_TABLE(2b,3b) EX_TABLE(4b,6b)
+		"  "ALR"  %2,%4\n"
+		"5:"LHI"  %4,-1\n"
+		"  "ALR"  %4,%0\n"	/* copy remaining size, subtract 1 */
+		"   bras  %3,7f\n"	/* memset loop */
+		"   xc    0(1,%2),0(%2)\n"
+		"6: xc    0(256,%2),0(%2)\n"
+		"   la    %2,256(%2)\n"
+		"7:"AHI"  %4,-256\n"
+		"   jnm   6b\n"
+		"   ex    %4,0(%3)\n"
+		"   j     9f\n"
+		"8:"SLR"  %0,%0\n"
+		"9: \n"
+		EX_TABLE(0b,3b) EX_TABLE(2b,3b) EX_TABLE(4b,5b)
 		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
 		: : "cc", "memory");
 	return size;
@@ -67,16 +77,22 @@ size_t copy_from_user_std_small(size_t s
 	asm volatile(
 		"0: mvcp  0(%0,%2),0(%1),%3\n"
 		"  "SLR"  %0,%0\n"
-		"   j     3f\n"
+		"   j     5f\n"
 		"1: la    %4,255(%1)\n" /* %4 = ptr + 255 */
 		"  "LHI"  %3,-4096\n"
 		"   nr    %4,%3\n"	/* %4 = (ptr + 255) & -4096 */
 		"  "SLR"  %4,%1\n"
 		"  "CLR"  %0,%4\n"	/* copy crosses next page boundary? */
-		"   jnh   3f\n"
+		"   jnh   5f\n"
 		"2: mvcp  0(%4,%2),0(%1),%3\n"
 		"  "SLR"  %0,%4\n"
-		"3:\n"
+		"  "ALR"  %2,%4\n"
+		"3:"LHI"  %4,-1\n"
+		"  "ALR"  %4,%0\n"	/* copy remaining size, subtract 1 */
+		"   bras  %3,4f\n"
+		"   xc    0(1,%2),0(%2)\n"
+		"4: ex    %4,0(%3)\n"
+		"5:\n"
 		EX_TABLE(0b,1b) EX_TABLE(2b,3b)
 		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
 		: : "cc", "memory");
