Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266098AbUFDXzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266098AbUFDXzR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 19:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266102AbUFDXzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 19:55:17 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:40325 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266098AbUFDXzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 19:55:07 -0400
Date: Sat, 5 Jun 2004 00:54:56 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Sebastian Kloska <kloska@scienion.de>
cc: Matt_Domsch@dell.com, <linux-kernel@vger.kernel.org>
Subject: Re: APM realy sucks on 2.6.x
In-Reply-To: <40C0E91D.9070900@scienion.de>
Message-ID: <Pine.LNX.4.44.0406050038120.2163-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2004, Sebastian Kloska wrote:
> 
> I'm really having a hard time with APM on 2.6.x. I have a DELL Latitude
> L400 with the newest BIOS release. The most important functionality
> of  APM  for  me  is  the  'suspend to RAM' function which worked like
> it should on all 2.4.x kernels I've tested. Under 2.6.x it simply does 
> not resume the second time.

Here's a patch I've been using to resume on Dell Latitude C610 for the
last eight months or so.  I've never sent it in because I guess it's
just papering over some deeper issue (with the BIOS?  originally some
earlier revision, I updated to latest A16 back then, but no change).

The funny thing is, that the code which resumes is relying on an APM
event to tell it that it's resuming, and that event sometimes doesn't
arrive.  This patch lets the resuming code jump to the wild conclusion
that it's resuming, without relying on that event.  I hope this helps
you, but fear your issue may be something else.

Hugh

--- 2.6.6/arch/i386/kernel/apm.c	2004-05-10 03:33:36.000000000 +0100
+++ linux/arch/i386/kernel/apm.c	2004-05-10 07:29:55.021595384 +0100
@@ -389,7 +389,9 @@ static int			suspends_pending;
 static int			standbys_pending;
 static int			ignore_sys_suspend;
 static int			ignore_normal_resume;
+static int			ignore_bounce;
 static int			bounce_interval = DEFAULT_BOUNCE_INTERVAL;
+static unsigned long		last_resume;
 
 #ifdef CONFIG_APM_RTC_IS_GMT
 #	define	clock_cmos_diff	0
@@ -1225,11 +1227,14 @@ static int suspend(int vetoable)
 	spin_lock(&i8253_lock);
 	reinit_timer();
 	set_time();
-	ignore_normal_resume = 1;
-
 	spin_unlock(&i8253_lock);
 	write_sequnlock_irq(&xtime_lock);
 
+	ignore_normal_resume = 1;
+	ignore_sys_suspend = -1;
+	last_resume = jiffies;
+	ignore_bounce = 1;
+
 	if (err == APM_NO_ERROR)
 		err = APM_SUCCESS;
 	if (err != APM_SUCCESS)
@@ -1239,6 +1244,7 @@ static int suspend(int vetoable)
 	device_resume();
 	pm_send_all(PM_RESUME, (void *)0);
 	queue_event(APM_NORMAL_RESUME, NULL);
+	ignore_normal_resume = 0;
  out:
 	spin_lock(&user_list_lock);
 	for (as = user_list; as != NULL; as = as->next) {
@@ -1289,8 +1295,6 @@ static apm_event_t get_event(void)
 static void check_events(void)
 {
 	apm_event_t		event;
-	static unsigned long	last_resume;
-	static int		ignore_bounce;
 
 	while ((event = get_event()) != 0) {
 		if (debug) {
@@ -1333,8 +1337,10 @@ static void check_events(void)
 			 * sending a SUSPEND event until something else
 			 * happens!
 			 */
-			if (ignore_sys_suspend)
+			if (ignore_sys_suspend > 0)
 				return;
+			if (ignore_sys_suspend < 0)
+				printk("suspend: missed resume event\n");
 			ignore_sys_suspend = 1;
 			queue_event(event, NULL);
 			if (suspends_pending <= 0)

