Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268119AbUHQF2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268119AbUHQF2P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 01:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268120AbUHQF2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 01:28:15 -0400
Received: from ozlabs.org ([203.10.76.45]:666 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268119AbUHQF1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 01:27:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16673.38737.538311.116328@cargo.ozlabs.ibm.com>
Date: Tue, 17 Aug 2004 15:27:45 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: anton@samba.org, olh@suse.de, dhowells@redhat.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] PPC Fix bug in altivec emulation
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bug in the kernel emulation of altivec instructions
with denormalized operands.  The emulation of the vmaddfp and vmnsubfp
instructions was giving the wrong answer because I had the wrong order
of operands to the fmadds and fnmsubs instructions.  This patch fixes
it for both ppc32 and ppc64.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc/kernel/vector.S ppc64/arch/ppc/kernel/vector.S
--- linux-2.5/arch/ppc/kernel/vector.S	2004-05-19 00:48:08.000000000 +1000
+++ ppc64/arch/ppc/kernel/vector.S	2004-08-17 15:23:20.908955312 +1000
@@ -106,7 +106,7 @@
 1:	lfsx	fr0,r4,r7
 	lfsx	fr1,r5,r7
 	lfsx	fr2,r6,r7
-	fmadds	fr0,fr0,fr1,fr2
+	fmadds	fr0,fr0,fr2,fr1
 	stfsx	fr0,r3,r7
 	addi	r7,r7,4
 	bdnz	1b
@@ -133,7 +133,7 @@
 1:	lfsx	fr0,r4,r7
 	lfsx	fr1,r5,r7
 	lfsx	fr2,r6,r7
-	fnmsubs	fr0,fr0,fr1,fr2
+	fnmsubs	fr0,fr0,fr2,fr1
 	stfsx	fr0,r3,r7
 	addi	r7,r7,4
 	bdnz	1b
diff -urN linux-2.5/arch/ppc64/kernel/vector.S ppc64/arch/ppc64/kernel/vector.S
--- linux-2.5/arch/ppc64/kernel/vector.S	2004-06-23 12:52:07.000000000 +1000
+++ ppc64/arch/ppc64/kernel/vector.S	2004-08-17 13:22:18.000000000 +1000
@@ -89,7 +89,7 @@
 1:	lfsx	fr0,r4,r7
 	lfsx	fr1,r5,r7
 	lfsx	fr2,r6,r7
-	fmadds	fr0,fr0,fr1,fr2
+	fmadds	fr0,fr0,fr2,fr1
 	stfsx	fr0,r3,r7
 	addi	r7,r7,4
 	bdnz	1b
@@ -109,7 +109,7 @@
 1:	lfsx	fr0,r4,r7
 	lfsx	fr1,r5,r7
 	lfsx	fr2,r6,r7
-	fnmsubs	fr0,fr0,fr1,fr2
+	fnmsubs	fr0,fr0,fr2,fr1
 	stfsx	fr0,r3,r7
 	addi	r7,r7,4
 	bdnz	1b
