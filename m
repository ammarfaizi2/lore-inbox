Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268019AbUJDTQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268019AbUJDTQJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 15:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268474AbUJDTQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 15:16:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:434 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268019AbUJDTHz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 15:07:55 -0400
Date: Mon, 4 Oct 2004 12:05:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jason Stubbs <jstubbs@work-at.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Consistent lock up on >=2.6.8
Message-Id: <20041004120535.3c68115a.akpm@osdl.org>
In-Reply-To: <200410041931.00159.jstubbs@work-at.co.jp>
References: <200410041611.17000.jstubbs@work-at.co.jp>
	<20041004013548.26e853fc.akpm@osdl.org>
	<200410041931.00159.jstubbs@work-at.co.jp>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Stubbs <jstubbs@work-at.co.jp> wrote:
>
>   [<c0157630>] nr_blockdev_pages+0x10/0x51
>   [<f8b9c7ea>] update_defense_level+0x16/0x22a [ip_vs]
>   [<f8b9ca06>] defense_timer_handler+0x8/0x2f [ip_vs]
>   [<c0123216>] run_timer_softirq+0xd4/0x17d
>   [<c011f84d>] __do_softirq+0xb9/0xcb
>   [<c01062ab>] do_softirq+0x4f/0x5e

Yeah, that'll deadlock for sure.   Please try this:



update_defense_level() is calling si_meminfo() from timer context.  But
si_meminfo takes non-irq-safe locks.

Move it all to keventd context.  

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/net/ipv4/ipvs/ip_vs_ctl.c |   19 ++++++++-----------
 1 files changed, 8 insertions(+), 11 deletions(-)

diff -puN net/ipv4/ipvs/ip_vs_ctl.c~ipvs-deadlock-fix net/ipv4/ipvs/ip_vs_ctl.c
--- 25/net/ipv4/ipvs/ip_vs_ctl.c~ipvs-deadlock-fix	2004-10-04 11:59:01.138835688 -0700
+++ 25-akpm/net/ipv4/ipvs/ip_vs_ctl.c	2004-10-04 12:03:07.790338960 -0700
@@ -26,7 +26,7 @@
 #include <linux/fs.h>
 #include <linux/sysctl.h>
 #include <linux/proc_fs.h>
-#include <linux/timer.h>
+#include <linux/workqueue.h>
 #include <linux/swap.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
@@ -89,7 +89,7 @@ int ip_vs_get_debug_level(void)
 #endif
 
 /*
- *	update_defense_level is called from timer bh and from sysctl.
+ *	update_defense_level is called from keventd and from sysctl.
  */
 static void update_defense_level(void)
 {
@@ -211,19 +211,19 @@ static void update_defense_level(void)
 /*
  *	Timer for checking the defense
  */
-static struct timer_list defense_timer;
 #define DEFENSE_TIMER_PERIOD	1*HZ
+static void defense_work_handler(void *data);
+static DECLARE_WORK(defense_work, defense_work_handler, NULL);
 
-static void defense_timer_handler(unsigned long data)
+static void defense_work_handler(void *data)
 {
 	update_defense_level();
 	if (atomic_read(&ip_vs_dropentry))
 		ip_vs_random_dropentry();
 
-	mod_timer(&defense_timer, jiffies + DEFENSE_TIMER_PERIOD);
+	schedule_delayed_work(&defense_work, DEFENSE_TIMER_PERIOD);
 }
 
-
 int
 ip_vs_use_count_inc(void)
 {
@@ -2361,10 +2361,7 @@ int ip_vs_control_init(void)
 	ip_vs_new_estimator(&ip_vs_stats);
 
 	/* Hook the defense timer */
-	init_timer(&defense_timer);
-	defense_timer.function = defense_timer_handler;
-	defense_timer.expires = jiffies + DEFENSE_TIMER_PERIOD;
-	add_timer(&defense_timer);
+	schedule_delayed_work(&defense_work, DEFENSE_TIMER_PERIOD);
 
 	LeaveFunction(2);
 	return 0;
@@ -2375,7 +2372,7 @@ void ip_vs_control_cleanup(void)
 {
 	EnterFunction(2);
 	ip_vs_trash_cleanup();
-	del_timer_sync(&defense_timer);
+	cancel_delayed_work(&defense_work);
 	ip_vs_kill_estimator(&ip_vs_stats);
 	unregister_sysctl_table(sysctl_header);
 	proc_net_remove("ip_vs_stats");
_

