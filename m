Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264921AbTL1B1i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 20:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264922AbTL1B1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 20:27:37 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:41651 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S264921AbTL1B1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 20:27:36 -0500
Date: Sat, 27 Dec 2003 17:27:39 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] lockmeter does not require CONFIG_X86_TSC
Message-ID: <1030000.1072574859@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the extreme twistedness of the world, CONFIG_X86_TSC doesn't
mean "I have a TSC", it means "I compiled out PIT support completely".
Don't ask me why. 

However, this means that the check for it in the lockmeter code is 
invalid - it's perfectly valid to use a i386 compiled kernel on a 686, 
where  CONFIG_X86_TSC is off, but we have both TSC and PIT support.

Patch simply removes the #error check.

M.

diff -urpN -X /home/fletch/.diff.exclude 620-force_wholefrag/include/asm-i386/lockmeter.h 630-lockmeter_notsc/include/asm-i386/lockmeter.h
--- 620-force_wholefrag/include/asm-i386/lockmeter.h	Sat Dec 27 14:43:41 2003
+++ 630-lockmeter_notsc/include/asm-i386/lockmeter.h	Sat Dec 27 17:16:58 2003
@@ -108,9 +108,6 @@ extern inline int rwlock_readers(rwlock_
 /* this is a lot of typing just to get gcc to emit "rdtsc" */
 static inline long long get_cycles64 (void)
 {
-#ifndef CONFIG_X86_TSC
-	#error this code requires CONFIG_X86_TSC
-#else
 	union longlong_u {
 		long long intlong;
 		struct intint_s {
@@ -121,7 +118,6 @@ static inline long long get_cycles64 (vo
 
 	rdtsc(longlong.intint.eax,longlong.intint.edx);
 	return longlong.intlong;
-#endif
 }
 
 #endif /* _I386_LOCKMETER_H */

