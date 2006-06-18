Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWFRRGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWFRRGK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 13:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWFRRGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 13:06:10 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:8383 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932259AbWFRRGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 13:06:08 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 18 Jun 2006 19:05:50 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.17-rc6-mm2 6/6] ieee1394: convert nodemgr_serialize
 semaphore to mutex
To: linux1394-devel@lists.sourceforge.net
cc: Ben Collins <bcollins@ubuntu.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.d002fde02fba70c0@s5r6.in-berlin.de>
Message-ID: <tkrat.13f1e5efe9b17b13@s5r6.in-berlin.de>
References: <20060610143100.GA15536@sergelap.austin.ibm.com>
 <20060610144205.GA13850@infradead.org> <448AE12E.5060002@s5r6.in-berlin.de>
 <20060610154213.GA19077@infradead.org> <1149957286.4448.542.camel@grayson>
 <20060610163859.GA24081@infradead.org> <1149962931.4448.557.camel@grayson>
 <20060610183703.GA1497@infradead.org> <44944D8A.6090808@s5r6.in-berlin.de>
 <tkrat.7edcc575e6bfd4ed@s5r6.in-berlin.de>
 <tkrat.285947e88a3d529f@s5r6.in-berlin.de>
 <tkrat.7fb54747c3c78ac1@s5r6.in-berlin.de>
 <tkrat.68482958a026ceaa@s5r6.in-berlin.de>
 <tkrat.2acbea371dfb6404@s5r6.in-berlin.de>
 <tkrat.d002fde02fba70c0@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.88) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another trivial sem2mutex conversion.

Side note:  nodemgr_serialize's purpose, when introduced in linux1394's
revision 529 in July 2002, was to protect several data structures which
are now largely handled by or together with Linux' driver core and are
now protected by the LDM's own mechanisms.  It may very well be possible
to get rid of this mutex entirely now.  But fully parallelized node
scanning is on our long-term TODO list anyway.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/nodemgr.c
===================================================================
--- linux.orig/drivers/ieee1394/nodemgr.c	2006-06-18 16:34:45.000000000 +0200
+++ linux/drivers/ieee1394/nodemgr.c	2006-06-18 17:28:48.000000000 +0200
@@ -157,7 +157,7 @@ static struct csr1212_bus_ops nodemgr_cs
  * but now we are much simpler because of the LDM.
  */
 
-static DECLARE_MUTEX(nodemgr_serialize);
+static DEFINE_MUTEX(nodemgr_serialize);
 
 struct host_info {
 	struct hpsb_host *host;
@@ -1615,7 +1615,7 @@ static int nodemgr_host_thread(void *__h
 		if (kthread_should_stop())
 			goto exit;
 
-		if (down_interruptible(&nodemgr_serialize)) {
+		if (mutex_lock_interruptible(&nodemgr_serialize)) {
 			if (try_to_freeze())
 				continue;
 			goto exit;
@@ -1644,7 +1644,7 @@ static int nodemgr_host_thread(void *__h
 		if (!nodemgr_check_irm_capability(host, reset_cycles) ||
 		    !nodemgr_do_irm_duties(host, reset_cycles)) {
 			reset_cycles++;
-			up(&nodemgr_serialize);
+			mutex_unlock(&nodemgr_serialize);
 			continue;
 		}
 		reset_cycles = 0;
@@ -1662,10 +1662,10 @@ static int nodemgr_host_thread(void *__h
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


