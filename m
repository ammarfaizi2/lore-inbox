Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262407AbULCWBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbULCWBr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 17:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbULCWBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 17:01:47 -0500
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:3221 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262403AbULCWBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 17:01:22 -0500
Message-ID: <41B0E277.2090801@us.ibm.com>
Date: Fri, 03 Dec 2004 16:02:31 -0600
From: Santiago Leon <santil@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix buffer starvation race in ibmveth
Content-Type: multipart/mixed;
 boundary="------------020604070903080602030505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020604070903080602030505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew,

There's a chance that the receive buffers are being consumed at the same 
rate as they are being replenished in ibmveth_replenish_task()... 
Meanwhile, the calls to schedule_replenishing() from ibmveth_poll() 
won't schedule another replenishing cycle (because the not_replenishing 
flag is zero), starving the buffers and making the adapter unable to 
receive packets unless the module is reloaded... Here's a small patch 
that will fix it by scheduling another replenishing task after toggling 
the not_replenishing flag.

Please apply.

Signed-Off-By: Santiago Leon <santil@us.ibm.com>
-- 
Santiago A. Leon
Power Linux Development
IBM Linux Technology Center

--------------020604070903080602030505
Content-Type: text/plain;
 name="ibmveth_buff_starve.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ibmveth_buff_starve.patch"

===== drivers/net/ibmveth.c 1.19 vs edited =====
--- 1.19/drivers/net/ibmveth.c	2004-11-22 00:42:54 -06:00
+++ edited/drivers/net/ibmveth.c	2004-12-03 15:27:40 -06:00
@@ -96,6 +96,7 @@
 static void ibmveth_proc_register_adapter(struct ibmveth_adapter *adapter);
 static void ibmveth_proc_unregister_adapter(struct ibmveth_adapter *adapter);
 static irqreturn_t ibmveth_interrupt(int irq, void *dev_instance, struct pt_regs *regs);
+static inline void ibmveth_schedule_replenishing(struct ibmveth_adapter*);
 
 #ifdef CONFIG_PROC_FS
 #define IBMVETH_PROC_DIR "ibmveth"
@@ -104,7 +105,7 @@
 
 static const char ibmveth_driver_name[] = "ibmveth";
 static const char ibmveth_driver_string[] = "IBM i/pSeries Virtual Ethernet Driver";
-#define ibmveth_driver_version "1.02"
+#define ibmveth_driver_version "1.03"
 
 MODULE_AUTHOR("Santiago Leon <santil@us.ibm.com>");
 MODULE_DESCRIPTION("IBM i/pSeries Virtual Ethernet Driver");
@@ -271,6 +272,8 @@
 	adapter->rx_no_buffer = *(u64*)(((char*)adapter->buffer_list_addr) + 4096 - 8);
 
 	atomic_inc(&adapter->not_replenishing);
+
+	ibmveth_schedule_replenishing(adapter);
 }
 
 /* kick the replenish tasklet if we need replenishing and it isn't already running */

--------------020604070903080602030505--
