Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275313AbTHSCym (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 22:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275315AbTHSCyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 22:54:32 -0400
Received: from tomts11.bellnexxia.net ([209.226.175.55]:43430 "EHLO
	tomts11-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S275313AbTHSCy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 22:54:28 -0400
Subject: scheduler interactivity: timeslice calculation seem wrong
From: Eric St-Laurent <ericstl34@sympatico.ca>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-7Ug6ip5t3N8n3b/DwklW"
Message-Id: <1061261666.2094.15.camel@orbiter>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 18 Aug 2003 22:54:26 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7Ug6ip5t3N8n3b/DwklW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

currently, nicer tasks (nice value toward -20) get larger timeslices,
and less nice tasks (nice value toward 19) get small timeslices.

this is contrary to all process scheduling theory i've read, and also
contrary to my intuition.

maybe it was done this way for fairness reasons, but that's another
story...

high priority (interactive) tasks should get small timeslices for best
interactive feeling, and low priority (cpu hog) tasks should get large
timeslices for best efficiency, anyway they can be preempted by higher
priority tasks if needed.

also, i think dynamic priority should be used for timeslice calculation
instead of static priority. the reason is, if a low priority task get a
priority boost (to prevent starvation, for example) it should use the
small timeslice corresponding to it's new priority level, instead of
using it's original large timeslice that can ruin the interactive feel.

something like this: (Sorry, not tested...)

PS: i've attached a small program to calculate and print the timeslices
length from code ripped from linux-2.6.0-test3



--- sched-orig.c	Sat Aug 09 00:39:34 2003
+++ sched.c	Mon Aug 18 10:52:22 2003
@@ -126,8 +126,8 @@
  * task_timeslice() is the interface that is used by the scheduler.
  */
 
-#define BASE_TIMESLICE(p) (MIN_TIMESLICE + \
-	((MAX_TIMESLICE - MIN_TIMESLICE)
*(MAX_PRIO-1-(p)->static_prio)/(MAX_USER_PRIO - 1)))
+#define BASE_TIMESLICE(p)	((p)->prio < MAX_RT_PRIO ? MIN_TIMESLICE :
(MAX_TIMESLICE - \
+	((MAX_TIMESLICE - MIN_TIMESLICE) *
(MAX_PRIO-1-(p)->prio)/(MAX_USER_PRIO - 1))))
 
 static inline unsigned int task_timeslice(task_t *p)
 {



Best regards,

Eric St-Laurent


--=-7Ug6ip5t3N8n3b/DwklW
Content-Disposition: attachment; filename=diff.txt
Content-Type: text/plain; name=diff.txt; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- sched-orig.c	Sat Aug 09 00:39:34 2003
+++ sched.c	Mon Aug 18 10:52:22 2003
@@ -126,8 +126,8 @@
  * task_timeslice() is the interface that is used by the scheduler.
  */
 
-#define BASE_TIMESLICE(p) (MIN_TIMESLICE + \
-	((MAX_TIMESLICE - MIN_TIMESLICE) * (MAX_PRIO-1-(p)->static_prio)/(MAX_USER_PRIO - 1)))
+#define BASE_TIMESLICE(p)	((p)->prio < MAX_RT_PRIO ? MIN_TIMESLICE : (MAX_TIMESLICE - \
+	((MAX_TIMESLICE - MIN_TIMESLICE) * (MAX_PRIO-1-(p)->prio)/(MAX_USER_PRIO - 1))))
 
 static inline unsigned int task_timeslice(task_t *p)
 {

--=-7Ug6ip5t3N8n3b/DwklW
Content-Disposition: attachment; filename=ts26.cpp
Content-Type: text/x-c++; name=ts26.cpp; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

#include <stdio.h>

#define HZ			1000
#define MIN_TIMESLICE		( 10 * HZ / 1000)
#define MAX_TIMESLICE		(200 * HZ / 1000)
#define MAX_USER_RT_PRIO	100
#define MAX_RT_PRIO		MAX_USER_RT_PRIO
#define MAX_PRIO		(MAX_RT_PRIO + 40)
#define NICE_TO_PRIO(nice)	(MAX_RT_PRIO + (nice) + 20)
#define USER_PRIO(p)		((p)-MAX_RT_PRIO)
#define MAX_USER_PRIO		(USER_PRIO(MAX_PRIO))

#define BASE_TIMESLICE(p)	(MIN_TIMESLICE + \
	((MAX_TIMESLICE - MIN_TIMESLICE) * (MAX_PRIO-1-p)/(MAX_USER_PRIO - 1)))

#define BASE_TIMESLICE2(p)	(MAX_TIMESLICE - \
	((MAX_TIMESLICE - MIN_TIMESLICE) * (MAX_PRIO-1-p)/(MAX_USER_PRIO - 1)))

#define BASE_TIMESLICE3(p)	(prio < MAX_RT_PRIO ? MIN_TIMESLICE : (MAX_TIMESLICE - \
	((MAX_TIMESLICE - MIN_TIMESLICE) * (MAX_PRIO-1-p)/(MAX_USER_PRIO - 1))))

int main(int argc, char *argv[])
{
	// original timeslice calculation
	for (int nice = -20; nice <= 19; nice++)
		printf("nice: %d, timeslice: %d ms\n", nice, BASE_TIMESLICE(NICE_TO_PRIO(nice)) * 1000 / HZ);

	printf("\n");

	// reversed timeslice calculation
	for (int nice = -20; nice <= 19; nice++)
		printf("nice: %d, timeslice: %d ms\n", nice, BASE_TIMESLICE2(NICE_TO_PRIO(nice)) * 1000 / HZ);

	printf("\n");

	// dynamic priority based timeslice calculation
	for (int prio = 0; prio < MAX_PRIO; prio++)
		printf("prio: %d, timeslice: %d ms\n", prio, BASE_TIMESLICE3(prio) * 1000 / HZ);

	return 0;
}

--=-7Ug6ip5t3N8n3b/DwklW--

