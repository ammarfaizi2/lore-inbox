Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbUCGVUf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 16:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262338AbUCGVUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 16:20:35 -0500
Received: from [139.30.44.16] ([139.30.44.16]:63924 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S262337AbUCGVUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 16:20:30 -0500
Date: Sun, 7 Mar 2004 22:20:19 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Arthur Corliss <corliss@digitalmages.com>
cc: Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Re: 2.6.x BSD Process Accounting w/High UID
In-Reply-To: <Pine.LNX.4.53.0403071820190.32060@gockel.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.53.0403072120030.4840@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.44.0403041451360.20043-100000@chimarrao.boston.redhat.com>
 <Pine.LNX.4.58.0403041103500.24930@bifrost.nevaeh-linux.org>
 <Pine.LNX.4.53.0403042242190.29818@gockel.physik3.uni-rostock.de>
 <Pine.LNX.4.58.0403041324330.20616@bifrost.nevaeh-linux.org>
 <Pine.LNX.4.53.0403071820190.32060@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Mar 2004, Tim Schmielau wrote:

> Still, I'd prefer to do something about this as well. Will send out a
> patch to deal with both things in a few minutes. (Note to Andrew/Linus:  
> please don't apply the patch below before considering the other patch :-)

Problem was: BSD accounting is not able to report real/user/sys times of 
             more than 49 days with HZ=1000.

Possible solutions:

 1) comp_t is actually able to encode 34 bit instead of 32 bit values, 
    which would be enough for 196 days.

    Upside:   - No incompatible format change needed.
              - Maybe also useful for things like reporting memory usage
                on >4 GByte Xeon machines (Actually it isn't, since memory 
                usage isn't acurately accounted for anyways.
    Downside: - Supported by GNU acct package, but other tools might break 
                due to internal overflows.
              - some (small) overhead.

    Patch (against 2.6.4-rc1) for demonstration at
      http://www.physik3.uni-rostock.de/tim/kernel/2.6/acct-02.patch


 2) Report times in units of 1/USER_HZ.

    Upside:   - Hides the 100->1000HZ transition on i386
    Downside: - Doesn't help other archs where HZ>=1000.
              - some (small) overhead.

    Patch (against 2.6.4-rc1 + my previous high uid patch) at
      http://www.physik3.uni-rostock.de/tim/kernel/2.6/acct-user_hz-02.patch


 3) Since milisecond resolution probably isn't useful anyways, report 
    times in units of 1/AHZ == 0.01 seconds. Good enough for 497 days.

    Upside:   - This is what the kernel already advertises anyways. Thus,
              - supported by current userland tools, which would 
                magically start working correctly.
    Downside: - Incompatible change during stable kernel series.

    Patch below.


 4) combine 1) and 3). Good for up to 1988 days.


 5) Do nothing. Reported times don't wrap anyways, but max out at the
    largest representable value.

    Upside:   Easy. Compatible with previous 2.6 kernels.
    Downside: Incompatible with 2.4 kernels.
              Not supported by current userspace.


If my previous patch for high uid accounting get's applied, I'd like
this to be resolved at the same time. This would allow (future)
userspace tools to work with all kernel versions by ckecking for
the signature of that patch.
Note that current 2.6 is already broken, which is a regression wrt. to 
2.4 at least on i386.

Patch (against 2.6.4-rc1 + my previous high uid patch) below.

Tim


--- linux-2.6.4-rc1-acct/include/linux/acct.h	2004-03-07 18:03:48.000000000 +0100
+++ linux-2.6.4-rc1-acct4/include/linux/acct.h	2004-03-07 21:03:47.000000000 +0100
@@ -88,6 +88,28 @@ extern void acct_process(long exitcode);
 #define acct_process(x)		do { } while (0)
 #endif
 
+/*
+ * Yet another HZ to *HZ helper function.
+ * See <linux/timer.h> for the original.
+ */
+
+#if (HZ % AHZ)==0
+# define jiffies_to_AHZ(x) ((x) / (HZ / AHZ))
+#else
+# define jiffies_to_AHZ(x) ((clock_t) jiffies_64_to_AHZ((u64) x))
+#endif
+
+static inline u64 jiffies_64_to_AHZ(u64 x)
+{
+#if (HZ % AHZ)==0
+	do_div(x, HZ / AHZ);
+#else
+	x *= AHZ;
+	do_div(x, HZ);
+#endif
+	return x;
+}
+
 #endif	/* __KERNEL */
 
 #endif	/* _LINUX_ACCT_H */

--- linux-2.6.4-rc1-acct/kernel/acct.c	2004-03-07 20:00:23.000000000 +0100
+++ linux-2.6.4-rc1-acct4/kernel/acct.c	2004-03-07 21:03:48.000000000 +0100
@@ -52,6 +52,7 @@
 #include <linux/security.h>
 #include <linux/vfs.h>
 #include <linux/jiffies.h>
+#include <linux/times.h>
 #include <asm/uaccess.h>
 #include <asm/div64.h>
 #include <linux/blkdev.h> /* sector_div */
@@ -341,13 +342,13 @@ static void do_acct_process(long exitcod
 
 	strlcpy(ac.ac_comm, current->comm, sizeof(ac.ac_comm));
 
-	elapsed = get_jiffies_64() - current->start_time;
+	elapsed = jiffies_64_to_AHZ(get_jiffies_64() - current->start_time);
 	ac.ac_etime = encode_comp_t(elapsed < (unsigned long) -1l ?
 	                       (unsigned long) elapsed : (unsigned long) -1l);
-	do_div(elapsed, HZ);
+	do_div(elapsed, AHZ);
 	ac.ac_btime = xtime.tv_sec - elapsed;
-	ac.ac_utime = encode_comp_t(current->utime);
-	ac.ac_stime = encode_comp_t(current->stime);
+	ac.ac_utime = encode_comp_t(jiffies_to_AHZ(current->utime));
+	ac.ac_stime = encode_comp_t(jiffies_to_AHZ(current->stime));
 	/*
 	 * Some day we might change the layout to 32 bit uid/gid fields.
 	 * But let's keep it compatible for now.
