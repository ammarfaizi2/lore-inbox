Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbWGJJ2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbWGJJ2B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 05:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWGJJ2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 05:28:01 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:33052 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932494AbWGJJ17
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 05:27:59 -0400
Date: Mon, 10 Jul 2006 11:28:05 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] s390: fix futex_atomic_cmpxchg_inatomic
Message-ID: <20060710092805.GB30303@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[S390] fix futex_atomic_cmpxchg_inatomic

futex_atomic_cmpxchg_inatomic has the same bug as the other
atomic futex operations: the operation needs to be done in the
user address space, not the kernel address space. Add the missing
sacf 256 & sacf 0.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/futex.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/include/asm-s390/futex.h linux-2.6-patched/include/asm-s390/futex.h
--- linux-2.6/include/asm-s390/futex.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/futex.h	2006-07-10 10:33:42.000000000 +0200
@@ -98,9 +98,10 @@ futex_atomic_cmpxchg_inatomic(int __user
 
 	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
 		return -EFAULT;
-	asm volatile("   cs   %1,%4,0(%5)\n"
+	asm volatile("   sacf 256\n"
+		     "   cs   %1,%4,0(%5)\n"
 		     "0: lr   %0,%1\n"
-		     "1:\n"
+		     "1: sacf 0\n"
 #ifndef __s390x__
 		     ".section __ex_table,\"a\"\n"
 		     "   .align 4\n"
