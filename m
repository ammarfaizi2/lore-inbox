Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263036AbUKTDPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263036AbUKTDPj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 22:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263086AbUKTCo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:44:28 -0500
Received: from baikonur.stro.at ([213.239.196.228]:61399 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S263050AbUKTCee
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:34:34 -0500
Subject: [patch 03/10]  atm/ambassador: replace 	schedule_timeout() with msleep()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:34:33 +0100
Message-ID: <E1CVL57-0001Ii-KK@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: msleep() is used instead of schedule_timeout() to guarantee
the task delays as expected. Two set_current_state()s were also
inserted, as schedule_timeout() will return immediately unless the state
is set.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.10-rc2-bk4-max/drivers/atm/ambassador.c |   21 ++++++---------------
 1 files changed, 6 insertions(+), 15 deletions(-)

diff -puN drivers/atm/ambassador.c~msleep-drivers_atm_ambassador drivers/atm/ambassador.c
--- linux-2.6.10-rc2-bk4/drivers/atm/ambassador.c~msleep-drivers_atm_ambassador	2004-11-19 17:15:24.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/drivers/atm/ambassador.c	2004-11-19 17:15:24.000000000 +0100
@@ -601,18 +601,13 @@ static int command_do (amb_dev * dev, co
     
     // prepare to wait for cq->pending milliseconds
     // effectively one centisecond on i386
-    timeout = (cq->pending*HZ+999)/1000;
+    timeout = cq->pending;
     
     if (cq->pending > cq->high)
       cq->high = cq->pending;
     spin_unlock (&cq->lock);
     
-    while (timeout) {
-      // go to sleep
-      // PRINTD (DBG_CMD, "wait: sleeping %lu for command", timeout);
-      set_current_state(TASK_UNINTERRUPTIBLE);
-      timeout = schedule_timeout (timeout);
-    }
+    msleep (timeout);
     
     // wait for my slot to be reached (all waiters are here or above, until...)
     while (ptrs->out != my_slot) {
@@ -1817,6 +1812,7 @@ static int __init do_loader_command (vol
     timeout = HZ/10;
     while (rd_plain (dev, offsetof(amb_mem, doorbell)))
       if (timeout) {
+	set_current_state(TASK_UNINTERRUPTIBLE);
 	timeout = schedule_timeout (timeout);
       } else {
 	PRINTD (DBG_LOAD|DBG_ERR, "start command did not clear doorbell, res=%08x",
@@ -1932,11 +1928,7 @@ static int amb_reset (amb_dev * dev, int
   if (diags) { 
     unsigned long timeout;
     // 4.2 second wait
-    timeout = HZ*42/10;
-    while (timeout) {
-      set_current_state(TASK_UNINTERRUPTIBLE);
-      timeout = schedule_timeout (timeout);
-    }
+    msleep (4200);
     // half second time-out
     timeout = HZ/2;
     while (!rd_plain (dev, offsetof(amb_mem, mb.loader.ready)))
@@ -2056,13 +2048,12 @@ static int __init amb_talk (amb_dev * de
   wr_mem (dev, offsetof(amb_mem, doorbell), virt_to_bus (&a));
   
   // 2.2 second wait (must not touch doorbell during 2 second DMA test)
-  timeout = HZ*22/10;
-  while (timeout)
-    timeout = schedule_timeout (timeout);
+  msleep (2200);
   // give the adapter another half second?
   timeout = HZ/2;
   while (rd_plain (dev, offsetof(amb_mem, doorbell)))
     if (timeout) {
+      set_current_state(TASK_UNINTERRUPTIBLE);
       timeout = schedule_timeout (timeout);
     } else {
       PRINTD (DBG_INIT|DBG_ERR, "adapter init timed out");
_
