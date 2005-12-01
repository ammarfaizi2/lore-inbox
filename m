Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbVK3X6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbVK3X6G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 18:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVK3X5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:57:34 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:33698
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751283AbVK3X5K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:57:10 -0500
Subject: [patch 04/43] Clean up mktime and add const modifiers
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:02:51 +0100
Message-Id: <1133395371.32542.447.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment
(mktime-set-normalized-timespec-const.patch)
- add 'const' to mktime arguments, and clean it up a bit

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

 include/linux/time.h |   10 +++++-----
 kernel/time.c        |   15 +++++++++------
 2 files changed, 14 insertions(+), 11 deletions(-)

Index: linux-2.6.15-rc2-rework/include/linux/time.h
===================================================================
--- linux-2.6.15-rc2-rework.orig/include/linux/time.h
+++ linux-2.6.15-rc2-rework/include/linux/time.h
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
Index: linux-2.6.15-rc2-rework/kernel/time.c
===================================================================
--- linux-2.6.15-rc2-rework.orig/kernel/time.c
+++ linux-2.6.15-rc2-rework/kernel/time.c
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

