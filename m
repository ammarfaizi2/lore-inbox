Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbVJNRu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVJNRu6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 13:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbVJNRu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 13:50:58 -0400
Received: from liaag2ae.mx.compuserve.com ([149.174.40.156]:7628 "EHLO
	liaag2ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750762AbVJNRu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 13:50:57 -0400
Date: Fri, 14 Oct 2005 13:47:09 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.14-rc4] i386: spinlock optimization
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Chuck Ebbert <76306.1226@compuserve.com>
Message-ID: <200510141350_MC3-1-ACA0-C8C9@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attempt to acquire spinlock sooner after spinning and then noticing
it has become available.  Also adds a slight delay before testing the
spinlock again when it's not available, reducing bus traffic.

This change makes spinlocks fairer in the case where the owner drops
the lock and then immediately tries to take it again.

Signed-Off-By: Chuck Ebbert <76306.1226@compuserve.com>
---

 include/asm-i386/spinlock.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- 2.6.14-rc4a.orig/include/asm-i386/spinlock.h
+++ 2.6.14-rc4a/include/asm-i386/spinlock.h
@@ -28,8 +28,8 @@
 	"2:\t" \
 	"rep;nop\n\t" \
 	"cmpb $0,%0\n\t" \
-	"jle 2b\n\t" \
-	"jmp 1b\n" \
+	"jg 1b\n\t" \
+	"jmp 2b\n" \
 	"3:\n\t"
 
 #define __raw_spin_lock_string_flags \
