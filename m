Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263236AbVCDXng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263236AbVCDXng (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263386AbVCDXb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:31:57 -0500
Received: from mail.kroah.org ([69.55.234.183]:32930 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263177AbVCDUyu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:50 -0500
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] w1: replace obsoleted *sleep_on*
In-Reply-To: <1109968782996@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:39:43 -0800
Message-Id: <11099687823191@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2084, 2005/03/02 16:59:25-08:00, johnpol@2ka.mipt.ru

[PATCH] w1: replace obsoleted *sleep_on*

Remove obsoleded *sleep_on*.

Since they are used only to wait for a given flags and awakening
only happens on signals, we can just replace them with
msleep_interruptible.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/w1/w1.c     |   18 +++++-------------
 drivers/w1/w1.h     |    1 -
 drivers/w1/w1_int.c |    1 -
 3 files changed, 5 insertions(+), 15 deletions(-)


diff -Nru a/drivers/w1/w1.c b/drivers/w1/w1.c
--- a/drivers/w1/w1.c	2005-03-04 12:37:58 -08:00
+++ b/drivers/w1/w1.c	2005-03-04 12:37:58 -08:00
@@ -58,7 +58,6 @@
 static pid_t control_thread;
 static int control_needs_exit;
 static DECLARE_COMPLETION(w1_control_complete);
-static DECLARE_WAIT_QUEUE_HEAD(w1_control_wait);
 
 static int w1_master_match(struct device *dev, struct device_driver *drv)
 {
@@ -649,7 +648,7 @@
 	struct w1_slave *sl;
 	struct w1_master *dev;
 	struct list_head *ent, *ment, *n, *mn;
-	int err, have_to_wait = 0, timeout;
+	int err, have_to_wait = 0;
 
 	daemonize("w1_control");
 	allow_signal(SIGTERM);
@@ -657,11 +656,8 @@
 	while (!control_needs_exit || have_to_wait) {
 		have_to_wait = 0;
 
-		timeout = w1_timeout*HZ;
-		do {
-			timeout = interruptible_sleep_on_timeout(&w1_control_wait, timeout);
-			try_to_freeze(PF_FREEZE);
-		} while (!signal_pending(current) && (timeout > 0));
+		try_to_freeze(PF_FREEZE);
+		msleep_interruptible(w1_timeout * 1000);
 
 		if (signal_pending(current))
 			flush_signals(current);
@@ -721,7 +717,6 @@
 int w1_process(void *data)
 {
 	struct w1_master *dev = (struct w1_master *) data;
-	unsigned long timeout;
 	struct list_head *ent, *n;
 	struct w1_slave *sl;
 
@@ -729,11 +724,8 @@
 	allow_signal(SIGTERM);
 
 	while (!dev->need_exit) {
-		timeout = w1_timeout*HZ;
-		do {
-			timeout = interruptible_sleep_on_timeout(&dev->kwait, timeout);
-			try_to_freeze(PF_FREEZE);
-		} while (!signal_pending(current) && (timeout > 0));
+		try_to_freeze(PF_FREEZE);
+		msleep_interruptible(w1_timeout * 1000);
 
 		if (signal_pending(current))
 			flush_signals(current);
diff -Nru a/drivers/w1/w1.h b/drivers/w1/w1.h
--- a/drivers/w1/w1.h	2005-03-04 12:37:58 -08:00
+++ b/drivers/w1/w1.h	2005-03-04 12:37:58 -08:00
@@ -115,7 +115,6 @@
 
 	int			need_exit;
 	pid_t			kpid;
-	wait_queue_head_t 	kwait;
 	struct semaphore 	mutex;
 
 	struct device_driver	*driver;
diff -Nru a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
--- a/drivers/w1/w1_int.c	2005-03-04 12:37:58 -08:00
+++ b/drivers/w1/w1_int.c	2005-03-04 12:37:58 -08:00
@@ -74,7 +74,6 @@
 	INIT_LIST_HEAD(&dev->slist);
 	init_MUTEX(&dev->mutex);
 
-	init_waitqueue_head(&dev->kwait);
 	init_completion(&dev->dev_released);
 	init_completion(&dev->dev_exited);
 

