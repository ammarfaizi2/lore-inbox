Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbUDHO1q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 10:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbUDHO1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 10:27:46 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:42412 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261817AbUDHO1l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 10:27:41 -0400
Date: Thu, 8 Apr 2004 16:27:30 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (1/12): core s390.
Message-ID: <20040408142730.GB1793@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s390 core changes:
 - Fix _raw_spin_trylock for 64 bit.
 - Add clarification to s390 debug debug documentation.

diffstat:
 Documentation/s390/s390dbf.txt |    6 +++---
 include/asm-s390/pgalloc.h     |    5 ++++-
 include/asm-s390/spinlock.h    |   10 ++++------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff -urN linux-2.6/Documentation/s390/s390dbf.txt linux-2.6-s390/Documentation/s390/s390dbf.txt
--- linux-2.6/Documentation/s390/s390dbf.txt	Sun Apr  4 05:37:37 2004
+++ linux-2.6-s390/Documentation/s390/s390dbf.txt	Thu Apr  8 15:21:23 2004
@@ -66,9 +66,9 @@
 All debug logs have an an actual debug level (range from 0 to 6).
 The default level is 3. Event and Exception functions have a 'level'
 parameter. Only debug entries with a level that is lower or equal
-than the actual level are written to the log. This means that high 
-priority log entries should have a low level value whereas low priority
-entries should have a high one. 
+than the actual level are written to the log. This means, when
+writing events, high priority log entries should have a low level 
+value whereas low priority entries should have a high one. 
 The actual debug level can be changed with the help of the proc-filesystem 
 through writing a number string "x" to the 'level' proc file which is
 provided for every debug log. Debugging can be switched off completely
diff -urN linux-2.6/include/asm-s390/spinlock.h linux-2.6-s390/include/asm-s390/spinlock.h
--- linux-2.6/include/asm-s390/spinlock.h	Sun Apr  4 05:38:27 2004
+++ linux-2.6-s390/include/asm-s390/spinlock.h	Thu Apr  8 15:21:23 2004
@@ -70,11 +70,9 @@
 
 extern inline int _raw_spin_trylock(spinlock_t *lp)
 {
-#ifndef __s390x__
-	unsigned long result, reg;
-#else /* __s390x__ */
-	unsigned int result, reg;
-#endif /* __s390x__ */
+	unsigned long reg;
+	unsigned int result;
+
 	__asm__ __volatile("    basr  %1,0\n"
 			   "0:  cs    %0,%1,0(%3)"
 			   : "=d" (result), "=&d" (reg), "=m" (lp->lock)
@@ -226,7 +224,7 @@
 			     "0: csg %0,%1,0(%3)\n"
 #endif /* __s390x__ */
 			     : "=d" (result), "=&d" (reg), "=m" (rw->lock)
-			     : "a" (&rw->lock), "m" (rw->lock), "0" (0)
+			     : "a" (&rw->lock), "m" (rw->lock), "0" (0UL)
 			     : "cc", "memory" );
 	return result == 0;
 }
