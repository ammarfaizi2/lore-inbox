Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbWDCX7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWDCX7r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 19:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWDCX7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 19:59:47 -0400
Received: from wp060.webpack.hosteurope.de ([80.237.132.67]:34999 "EHLO
	wp060.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S964899AbWDCX7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 19:59:42 -0400
Date: Tue, 4 Apr 2006 02:00:25 +0200
From: Hansjoerg Lipp <hjlipp@web.de>
To: Karsten Keil <kkeil@suse.de>
Cc: i4ldeveloper@listserv.isdn4linux.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       Tilman Schmidt <tilman@imap.cc>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/13] isdn4linux: Siemens Gigaset drivers - timer usage
Message-ID: <gigaset307x.2006.04.04.001.3@hjlipp.my-fqdn.de>
References: <gigaset307x.2006.04.04.001.0@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.1@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.2@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gigaset307x.2006.04.04.001.2@hjlipp.my-fqdn.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tilman Schmidt <tilman@imap.cc>, Hansjoerg Lipp <hjlipp@web.de>

This patch corrects timer usage in the Gigaset drivers to take
advantage of the existing setup_timer() function, and use milliseconds
as unit. Please merge.

Signed-off-by: Hansjoerg Lipp <hjlipp@web.de>
Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---

 drivers/isdn/gigaset/common.c  |    7 +++----
 drivers/isdn/gigaset/gigaset.h |    2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

--- linux-2.6.16-gig-kconfig/drivers/isdn/gigaset/gigaset.h	2006-04-02 18:37:04.000000000 +0200
+++ linux-2.6.16-gig-timer/drivers/isdn/gigaset/gigaset.h	2006-04-02 18:38:09.000000000 +0200
@@ -58,7 +58,7 @@
 #define MAX_TIMER_INDEX 1000
 #define MAX_SEQ_INDEX   1000
 
-#define GIG_TICK (HZ / 10)
+#define GIG_TICK 100		/* in milliseconds */
 
 /* timeout values (unit: 1 sec) */
 #define INIT_TIMEOUT 1
--- linux-2.6.16-gig-kconfig/drivers/isdn/gigaset/common.c	2006-04-02 18:37:04.000000000 +0200
+++ linux-2.6.16-gig-timer/drivers/isdn/gigaset/common.c	2006-04-02 18:38:09.000000000 +0200
@@ -219,7 +219,7 @@ static void timer_tick(unsigned long dat
 			timeout = 1;
 
 	if (atomic_read(&cs->running)) {
-		mod_timer(&cs->timer, jiffies + GIG_TICK);
+		mod_timer(&cs->timer, jiffies + msecs_to_jiffies(GIG_TICK));
 		if (timeout) {
 			dbg(DEBUG_CMD, "scheduling timeout");
 			tasklet_schedule(&cs->event_tasklet);
@@ -685,9 +685,8 @@ struct cardstate *gigaset_initcs(struct 
 	gigaset_if_init(cs);
 
 	atomic_set(&cs->running, 1);
-	cs->timer.data = (unsigned long) cs;
-	cs->timer.function = timer_tick;
-	cs->timer.expires = jiffies + GIG_TICK;
+	setup_timer(&cs->timer, timer_tick, (unsigned long) cs);
+	cs->timer.expires = jiffies + msecs_to_jiffies(GIG_TICK);
 	/* FIXME: can jiffies increase too much until the timer is added?
 	 * Same problem(?) with mod_timer() in timer_tick(). */
 	add_timer(&cs->timer);
