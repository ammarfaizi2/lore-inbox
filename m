Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVAGTgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVAGTgF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 14:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVAGTgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:36:03 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:7319 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261564AbVAGTdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:33:24 -0500
Date: Fri, 7 Jan 2005 11:33:22 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: kj <kernel-janitors@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Cc: chas@cmf.nrl.navy.mil, linux-atm-general@lists.sourceforge.net
Subject: [UPDATE PATCH] atm/ambassador: use msleep() instead of schedule_timeout()
Message-ID: <20050107193322.GA2924@us.ibm.com>
References: <20041225004846.GA19373@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041225004846.GA19373@nd47.coderock.org>
X-Operating-System: Linux 2.6.10 (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2004 at 01:48:46AM +0100, Domen Puncer wrote:
> Hi.
> 
> Santa brought another present :-)
> 
> I'll start mailing new patches these days, and after external trees get
> merged, I'll be bugging you with the old ones.

<snip>

> all patches:
> ------------

<snip>

> msleep-drivers_atm_ambassador.patch

Please consider updating to the following patch.

Description: Multiple schedule_timeout() related fixes. Generally uses msleep()
to guarantee the task delays as expected. In one place, this allowed for the
deletion of a variable. In a few places, I reverted back to using
TASK_INTERRUPTIBLE, because the code makes little sense otherwise. In these
places, the units of the timeout variable has been changed from jiffies to
msecs. As far as I can see, this driver is still not fixed, as there is no
response to the signal which may have interrupted the sleep. But this patch
at least brings it closer.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.10-v/drivers/atm/ambassador.c	2004-12-24 13:33:59.000000000 -0800
+++ 2.6.10/drivers/atm/ambassador.c	2005-01-04 14:57:49.000000000 -0800
@@ -574,7 +574,6 @@ static int command_do (amb_dev * dev, co
   amb_cq * cq = &dev->cq;
   volatile amb_cq_ptrs * ptrs = &cq->ptrs;
   command * my_slot;
-  unsigned long timeout;
   
   PRINTD (DBG_FLOW|DBG_CMD, "command_do %p", dev);
   
@@ -599,20 +598,14 @@ static int command_do (amb_dev * dev, co
     // mail the command
     wr_mem (dev, offsetof(amb_mem, mb.adapter.cmd_address), virt_to_bus (ptrs->in));
     
-    // prepare to wait for cq->pending milliseconds
-    // effectively one centisecond on i386
-    timeout = (cq->pending*HZ+999)/1000;
-    
     if (cq->pending > cq->high)
       cq->high = cq->pending;
     spin_unlock (&cq->lock);
     
-    while (timeout) {
-      // go to sleep
-      // PRINTD (DBG_CMD, "wait: sleeping %lu for command", timeout);
-      set_current_state(TASK_UNINTERRUPTIBLE);
-      timeout = schedule_timeout (timeout);
-    }
+    // these comments were in a while-loop before, msleep removes the loop
+    // go to sleep
+    // PRINTD (DBG_CMD, "wait: sleeping %lu for command", timeout);
+    msleep(cq->pending);
     
     // wait for my slot to be reached (all waiters are here or above, until...)
     while (ptrs->out != my_slot) {
@@ -1799,12 +1792,11 @@ static int __init do_loader_command (vol
   // dump_loader_block (lb);
   wr_mem (dev, offsetof(amb_mem, doorbell), virt_to_bus (lb) & ~onegigmask);
   
-  timeout = command_timeouts[cmd] * HZ/100;
+  timeout = command_timeouts[cmd] * 10;
   
   while (!lb->result || lb->result == cpu_to_be32 (COMMAND_IN_PROGRESS))
     if (timeout) {
-      set_current_state(TASK_UNINTERRUPTIBLE);
-      timeout = schedule_timeout (timeout);
+      timeout = msleep_interruptible(timeout);
     } else {
       PRINTD (DBG_LOAD|DBG_ERR, "command %d timed out", cmd);
       dump_registers (dev);
@@ -1814,10 +1806,10 @@ static int __init do_loader_command (vol
   
   if (cmd == adapter_start) {
     // wait for start command to acknowledge...
-    timeout = HZ/10;
+    timeout = 100;
     while (rd_plain (dev, offsetof(amb_mem, doorbell)))
       if (timeout) {
-	timeout = schedule_timeout (timeout);
+	timeout = msleep_interruptible(timeout);
       } else {
 	PRINTD (DBG_LOAD|DBG_ERR, "start command did not clear doorbell, res=%08x",
 		be32_to_cpu (lb->result));
@@ -1932,17 +1924,12 @@ static int amb_reset (amb_dev * dev, int
   if (diags) { 
     unsigned long timeout;
     // 4.2 second wait
-    timeout = HZ*42/10;
-    while (timeout) {
-      set_current_state(TASK_UNINTERRUPTIBLE);
-      timeout = schedule_timeout (timeout);
-    }
+    msleep(4200);
     // half second time-out
-    timeout = HZ/2;
+    timeout = 500;
     while (!rd_plain (dev, offsetof(amb_mem, mb.loader.ready)))
       if (timeout) {
-        set_current_state(TASK_UNINTERRUPTIBLE);
-	timeout = schedule_timeout (timeout);
+        timeout = msleep_interruptible(timeout);
       } else {
 	PRINTD (DBG_LOAD|DBG_ERR, "reset timed out");
 	return -ETIMEDOUT;
@@ -2056,14 +2043,12 @@ static int __init amb_talk (amb_dev * de
   wr_mem (dev, offsetof(amb_mem, doorbell), virt_to_bus (&a));
   
   // 2.2 second wait (must not touch doorbell during 2 second DMA test)
-  timeout = HZ*22/10;
-  while (timeout)
-    timeout = schedule_timeout (timeout);
+  msleep(2200);
   // give the adapter another half second?
-  timeout = HZ/2;
+  timeout = 500;
   while (rd_plain (dev, offsetof(amb_mem, doorbell)))
     if (timeout) {
-      timeout = schedule_timeout (timeout);
+      timeout = msleep_interruptible(timeout);
     } else {
       PRINTD (DBG_INIT|DBG_ERR, "adapter init timed out");
       return -ETIMEDOUT;
