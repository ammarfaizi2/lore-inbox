Return-Path: <linux-kernel-owner+w=401wt.eu-S1752832AbWLOQWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832AbWLOQWG (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 11:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752828AbWLOQWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 11:22:04 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:32532 "EHLO
	mtagate4.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbWLOQVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 11:21:53 -0500
Date: Fri, 15 Dec 2006 17:21:45 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, rwuerthn@de.ibm.com
Subject: [S390] zcrypt: module unload fixes.
Message-ID: <20061215162145.GD4920@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralph Wuerthner <rwuerthn@de.ibm.com>

[S390] zcrypt: module unload fixes.

Add code to reset all queues for a domain and add missing tasklet_kill
call to ap bus module exit code.

Signed-off-by: Ralph Wuerthner <rwuerthn@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/ap_bus.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/drivers/s390/crypto/ap_bus.c linux-2.6-patched/drivers/s390/crypto/ap_bus.c
--- linux-2.6/drivers/s390/crypto/ap_bus.c	2006-12-15 16:54:55.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/ap_bus.c	2006-12-15 16:55:08.000000000 +0100
@@ -1129,7 +1129,15 @@ static void ap_poll_thread_stop(void)
 	mutex_unlock(&ap_poll_thread_mutex);
 }
 
-static void ap_reset(void)
+static void ap_reset_domain(void)
+{
+	int i;
+
+	for (i = 0; i < AP_DEVICES; i++)
+		ap_reset_queue(AP_MKQID(i, ap_domain_index));
+}
+
+static void ap_reset_all(void)
 {
 	int i, j;
 
@@ -1139,7 +1147,7 @@ static void ap_reset(void)
 }
 
 static struct reset_call ap_reset_call = {
-	.fn = ap_reset,
+	.fn = ap_reset_all,
 };
 
 /**
@@ -1229,10 +1237,12 @@ void ap_module_exit(void)
 	int i;
 	struct device *dev;
 
+	ap_reset_domain();
 	ap_poll_thread_stop();
 	del_timer_sync(&ap_config_timer);
 	del_timer_sync(&ap_poll_timer);
 	destroy_workqueue(ap_work_queue);
+	tasklet_kill(&ap_tasklet);
 	s390_root_dev_unregister(ap_root_device);
 	while ((dev = bus_find_device(&ap_bus_type, NULL, NULL,
 		    __ap_match_all)))
