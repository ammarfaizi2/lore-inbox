Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032304AbWLGPcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032304AbWLGPcZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 10:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032300AbWLGPcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 10:32:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48216 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032290AbWLGPcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 10:32:24 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 1/3] WorkStruct: Fix up some PA-RISC work items
Date: Thu, 07 Dec 2006 15:31:38 +0000
To: torvalds@osdl.org, akpm@osdl.org, davem@davemloft.com, wli@holomorphy.com,
       matthew@wil.cx
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20061207153138.28408.94099.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up some PA-RISC work items broken by the workstruct reduction.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 drivers/parisc/led.c   |   12 ++++++------
 drivers/parisc/power.c |    4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/parisc/led.c b/drivers/parisc/led.c
index 8dac2ba..6818c10 100644
--- a/drivers/parisc/led.c
+++ b/drivers/parisc/led.c
@@ -66,8 +66,8 @@ static char lcd_text_default[32]  __read
 
 
 static struct workqueue_struct *led_wq;
-static void led_work_func(void *);
-static DECLARE_WORK(led_task, led_work_func, NULL);
+static void led_work_func(struct work_struct *);
+static DECLARE_DELAYED_WORK(led_task, led_work_func);
 
 #if 0
 #define DPRINTK(x)	printk x
@@ -136,7 +136,7 @@ static int start_task(void) 
 
 	/* Create the work queue and queue the LED task */
 	led_wq = create_singlethread_workqueue("led_wq");	
-	queue_work(led_wq, &led_task);
+	queue_delayed_work(led_wq, &led_task, 0);
 
 	return 0;
 }
@@ -443,7 +443,7 @@ #define HEARTBEAT_2ND_RANGE_END   (HEART
 
 #define LED_UPDATE_INTERVAL (1 + (HZ*19/1000))
 
-static void led_work_func (void *unused)
+static void led_work_func (struct work_struct *unused)
 {
 	static unsigned long last_jiffies;
 	static unsigned long count_HZ; /* counter in range 0..HZ */
@@ -590,7 +590,7 @@ int __init register_led_driver(int model
 
 	/* Ensure the work is queued */
 	if (led_wq) {
-		queue_work(led_wq, &led_task);
+		queue_delayed_work(led_wq, &led_task, 0);
 	}
 
 	return 0;
@@ -660,7 +660,7 @@ int lcd_print( char *str )
 	
 	/* re-queue the work */
 	if (led_wq) {
-		queue_work(led_wq, &led_task);
+		queue_delayed_work(led_wq, &led_task, 0);
 	}
 
 	return lcd_info.lcd_width;
diff --git a/drivers/parisc/power.c b/drivers/parisc/power.c
index 97e9dc0..9228e21 100644
--- a/drivers/parisc/power.c
+++ b/drivers/parisc/power.c
@@ -82,7 +82,7 @@ #define __getDIAG(dr) ( { 			\
 } )
 
 
-static void deferred_poweroff(void *dummy)
+static void deferred_poweroff(struct work_struct *unused)
 {
 	if (kill_cad_pid(SIGINT, 1)) {
 		/* just in case killing init process failed */
@@ -96,7 +96,7 @@ static void deferred_poweroff(void *dumm
  * use schedule_work().
  */
 
-static DECLARE_WORK(poweroff_work, deferred_poweroff, NULL);
+static DECLARE_WORK(poweroff_work, deferred_poweroff);
 
 static void poweroff(void)
 {
