Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbUAFQEU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 11:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbUAFQEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 11:04:20 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:19600 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261889AbUAFQES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 11:04:18 -0500
Subject: [PATCH] fix get_jiffies_64 to work on voyager
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>, johnstultz@us.ibm.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 06 Jan 2004 10:04:07 -0600
Message-Id: <1073405053.2047.28.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch


ChangeSet@1.1534.5.2, 2003-12-30 15:40:23-08:00, akpm@osdl.org
  [PATCH] ia32 jiffy wrapping fixes

Causes the voyager boot to hang.  The problem is this change:

--- a/arch/i386/kernel/timers/timer_tsc.c       Tue Jan  6 09:57:34 2004
+++ b/arch/i386/kernel/timers/timer_tsc.c       Tue Jan  6 09:57:34 2004
@@ -141,7 +140,7 @@
 #ifndef CONFIG_NUMA
        if (!use_tsc)
 #endif
-               return (unsigned long long)jiffies * (1000000000 / HZ);
+               return (unsigned long long)get_jiffies_64() *
(1000000000 / HZ);

Apart from the fact (that I've whined about before) that this
sched_clock() function should be one of the timer function pointers, so
there isn't this CONFIG_NUMA dependence (unless I can also add a
CONFIG_X86_VOYAGER dependence to it as well), the problem seems to be
some type of bad resonance between the jiffies_64 update and the
xtime_lock in get_jiffies_64().  I think this may indicate that HZ needs
to be reduced to 100 on voyager;  however, there is also no need to get
the xtime sequence lock every time we do a jiffies_64 read, since the
only unstable time is when we may be updating both halves of it
non-atomically.  Thus, we only need the sequence lock when the bottom
half is zero.  This should improve the fast path of get_jiffies_64() for
all x86 arch's.

James

===== kernel/time.c 1.18 vs edited =====
--- 1.18/kernel/time.c	Wed Oct 22 00:09:54 2003
+++ edited/kernel/time.c	Tue Jan  6 09:20:38 2004
@@ -422,13 +422,20 @@
 #if (BITS_PER_LONG < 64)
 u64 get_jiffies_64(void)
 {
-	unsigned long seq;
-	u64 ret;
+	u64 ret = jiffies_64;
 
-	do {
-		seq = read_seqbegin(&xtime_lock);
+	/* We only have read problems when the lower 32 bits are zero
+	 * indicating that we may be in the process of updating the upper
+	 * 32 bits */
+	while (unlikely((jiffies_64 & 0xffffffffULL) == 0)) {
+		unsigned long seq = read_seqbegin(&xtime_lock);
+		
+		rmb();
 		ret = jiffies_64;
-	} while (read_seqretry(&xtime_lock, seq));
+		rmb();
+		if(!read_seqretry(&xtime_lock, seq))
+			break;
+	}
 	return ret;
 }
 
 

