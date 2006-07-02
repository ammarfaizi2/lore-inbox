Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWGBX04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWGBX04 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 19:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWGBX04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 19:26:56 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:51159 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750716AbWGBX0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 19:26:55 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 3 Jul 2006 01:26:38 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 17/19] ieee1394: nodemgr: convert nodemgr_serialize semaphore
 to mutex
To: Ben Collins <bcollins@ubuntu.com>
cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
Message-ID: <tkrat.270fe1c963068126@s5r6.in-berlin.de>
References: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.906) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another trivial sem2mutex conversion.

Side note:  nodemgr_serialize's purpose, when introduced in linux1394's
revision 529 in July 2002, was to protect several data structures which
are now largely handled by or together with Linux' driver core and are
now protected by the LDM's own mechanisms.  It may very well be possible
to remove this mutex now.  But fully parallelized node scanning is on
our long-term TODO list anyway; the mutex will certainly go away then.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/nodemgr.c
===================================================================
--- linux.orig/drivers/ieee1394/nodemgr.c	2006-07-02 12:23:05.000000000 +0200
+++ linux/drivers/ieee1394/nodemgr.c	2006-07-02 12:23:42.000000000 +0200
@@ -158,7 +158,7 @@ static struct csr1212_bus_ops nodemgr_cs
  * but now we are much simpler because of the LDM.
  */
 
-static DECLARE_MUTEX(nodemgr_serialize);
+static DEFINE_MUTEX(nodemgr_serialize);
 
 struct host_info {
 	struct hpsb_host *host;
@@ -1621,7 +1621,7 @@ static int nodemgr_host_thread(void *__h
 		if (kthread_should_stop())
 			goto exit;
 
-		if (down_interruptible(&nodemgr_serialize)) {
+		if (mutex_lock_interruptible(&nodemgr_serialize)) {
 			if (try_to_freeze())
 				continue;
 			goto exit;
@@ -1650,7 +1650,7 @@ static int nodemgr_host_thread(void *__h
 		if (!nodemgr_check_irm_capability(host, reset_cycles) ||
 		    !nodemgr_do_irm_duties(host, reset_cycles)) {
 			reset_cycles++;
-			up(&nodemgr_serialize);
+			mutex_unlock(&nodemgr_serialize);
 			continue;
 		}
 		reset_cycles = 0;
@@ -1668,10 +1668,10 @@ static int nodemgr_host_thread(void *__h
 		/* Update some of our sysfs symlinks */
 		nodemgr_update_host_dev_links(host);
 
-		up(&nodemgr_serialize);
+		mutex_unlock(&nodemgr_serialize);
 	}
 unlock_exit:
-	up(&nodemgr_serialize);
+	mutex_unlock(&nodemgr_serialize);
 exit:
 	HPSB_VERBOSE("NodeMgr: Exiting thread");
 	return 0;


