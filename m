Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751536AbVLFAhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbVLFAhG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbVLFAfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:35:24 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:22222
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751536AbVLFAeg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:34:36 -0500
Message-Id: <20051206000153.250805000@tglx.tec.linutronix.de>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
Date: Tue, 06 Dec 2005 01:01:30 +0100
From: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, rostedt@goodmis.org, johnstul@us.ibm.com,
       zippel@linux-m86k.org, mingo@elte.hu
Subject: [patch 04/21] Clean up mktime and make arguments const
Content-Disposition: inline;
	filename=mktime-set-normalized-timespec-const.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- add 'const' to mktime arguments, and clean it up a bit

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

 include/linux/time.h |   10 +++++-----
 kernel/time.c        |   15 +++++++++------
 2 files changed, 14 insertions(+), 11 deletions(-)

Index: linux-2.6.15-rc5/include/linux/time.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/time.h
+++ linux-2.6.15-rc5/include/linux/time.h
@@ -38,9 +38,11 @@ static __inline__ int timespec_equal(str
 	return (a->tv_sec == b->tv_sec) && (a->tv_nsec == b->tv_nsec);
 } 
 
-extern unsigned long mktime (unsigned int year, unsigned int mon,
-			     unsigned int day, unsigned int hour,
-			     unsigned int min, unsigned int sec);
+extern unsigned long mktime(const unsigned int year, const unsigned int mon,
+			    const unsigned int day, const unsigned int hour,
+			    const unsigned int min, const unsigned int sec);
+
+extern void set_normalized_timespec(struct timespec *ts, time_t sec, long nsec);
 
 extern struct timespec xtime;
 extern struct timespec wall_to_monotonic;
@@ -51,8 +53,6 @@ static inline unsigned long get_seconds(
 	return xtime.tv_sec;
 }
 
-extern void set_normalized_timespec (struct timespec *ts, time_t sec, long nsec);
-
 struct timespec current_kernel_time(void);
 
 #define CURRENT_TIME (current_kernel_time())
Index: linux-2.6.15-rc5/kernel/time.c
===================================================================
--- linux-2.6.15-rc5.orig/kernel/time.c
+++ linux-2.6.15-rc5/kernel/time.c
@@ -577,12 +577,15 @@ EXPORT_SYMBOL_GPL(getnstimeofday);
  * will already get problems at other places on 2038-01-19 03:14:08)
  */
 unsigned long
-mktime (unsigned int year, unsigned int mon,
-	unsigned int day, unsigned int hour,
-	unsigned int min, unsigned int sec)
+mktime(const unsigned int year0, const unsigned int mon0,
+       const unsigned int day, const unsigned int hour,
+       const unsigned int min, const unsigned int sec)
 {
-	if (0 >= (int) (mon -= 2)) {	/* 1..12 -> 11,12,1..10 */
-		mon += 12;		/* Puts Feb last since it has leap day */
+	unsigned int mon = mon0, year = year0;
+
+	/* 1..12 -> 11,12,1..10 */
+	if (0 >= (int) (mon -= 2)) {
+		mon += 12;	/* Puts Feb last since it has leap day */
 		year -= 1;
 	}
 
@@ -608,7 +611,7 @@ mktime (unsigned int year, unsigned int 
  * 	0 <= tv_nsec < NSEC_PER_SEC
  * For negative values only the tv_sec field is negative !
  */
-void set_normalized_timespec (struct timespec *ts, time_t sec, long nsec)
+void set_normalized_timespec(struct timespec *ts, time_t sec, long nsec)
 {
 	while (nsec >= NSEC_PER_SEC) {
 		nsec -= NSEC_PER_SEC;

--

