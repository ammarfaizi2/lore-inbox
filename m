Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWE1Qop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWE1Qop (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 12:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWE1Qoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 12:44:44 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:35043 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750768AbWE1Qoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 12:44:44 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 28 May 2006 18:43:52 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.17-rc5] ieee1394_core: switch to kthread API
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, Jody McIntyre <scjody@modernduck.com>,
       linux-kernel@vger.kernel.org
Message-ID: <tkrat.cfb023075101da5c@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.884) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jody McIntyre <scjody@modernduck.com>
Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Submitted by Christoph on 2006-04-14. The Patch has been in -mm since
April but vanished temporarily due to some git-ieee1394 mishap.

This gets also rid of the MODPOST warning "drivers/ieee1394/ieee1394.o -
Section mismatch: reference to .exit.text: from .smp_locks after '' (at
offset 0x18)".

 drivers/ieee1394/ieee1394_core.c |   44 +++++++++----------------------
 1 files changed, 13 insertions(+), 31 deletions(-)

Index: linux-2.6.17-rc5/drivers/ieee1394/ieee1394_core.c
===================================================================
--- linux-2.6.17-rc5.orig/drivers/ieee1394/ieee1394_core.c	2006-05-28 17:53:59.000000000 +0200
+++ linux-2.6.17-rc5/drivers/ieee1394/ieee1394_core.c	2006-05-28 17:54:53.000000000 +0200
@@ -33,6 +33,7 @@
 #include <linux/kdev_t.h>
 #include <linux/skbuff.h>
 #include <linux/suspend.h>
+#include <linux/kthread.h>
 
 #include <asm/byteorder.h>
 #include <asm/semaphore.h>
@@ -997,10 +998,8 @@ void abort_timedouts(unsigned long __opa
  * packets that have a "complete" function are sent here. This way, the
  * completion is run out of kernel context, and doesn't block the rest of
  * the stack. */
-static int khpsbpkt_pid = -1, khpsbpkt_kill;
-static DECLARE_COMPLETION(khpsbpkt_complete);
+static struct task_struct *khpsbpkt_thread;
 static struct sk_buff_head hpsbpkt_queue;
-static DECLARE_MUTEX_LOCKED(khpsbpkt_sig);
 
 
 static void queue_packet_complete(struct hpsb_packet *packet)
@@ -1011,9 +1010,7 @@ static void queue_packet_complete(struct
 	}
 	if (packet->complete_routine != NULL) {
 		skb_queue_tail(&hpsbpkt_queue, packet->skb);
-
-		/* Signal the kernel thread to handle this */
-		up(&khpsbpkt_sig);
+		wake_up_process(khpsbpkt_thread);
 	}
 	return;
 }
@@ -1025,19 +1022,9 @@ static int hpsbpkt_thread(void *__hi)
 	void (*complete_routine)(void*);
 	void *complete_data;
 
-	daemonize("khpsbpkt");
-
 	current->flags |= PF_NOFREEZE;
 
-	while (1) {
-		if (down_interruptible(&khpsbpkt_sig)) {
-			printk("khpsbpkt: received unexpected signal?!\n" );
-			break;
-		}
-
-		if (khpsbpkt_kill)
-			break;
-
+	while (!kthread_should_stop()) {
 		while ((skb = skb_dequeue(&hpsbpkt_queue)) != NULL) {
 			packet = (struct hpsb_packet *)skb->data;
 
@@ -1048,9 +1035,12 @@ static int hpsbpkt_thread(void *__hi)
 
 			complete_routine(complete_data);
 		}
+
+		set_current_state(TASK_INTERRUPTIBLE );
+		schedule();
 	}
 
-	complete_and_exit(&khpsbpkt_complete, 0);
+	return 0;
 }
 
 static int __init ieee1394_init(void)
@@ -1065,10 +1055,10 @@ static int __init ieee1394_init(void)
 		HPSB_ERR("Some features may not be available\n");
 	}
 
-	khpsbpkt_pid = kernel_thread(hpsbpkt_thread, NULL, CLONE_KERNEL);
-	if (khpsbpkt_pid < 0) {
+	khpsbpkt_thread = kthread_run(hpsbpkt_thread, NULL, "khpsbpkt");
+	if (IS_ERR(khpsbpkt_thread)) {
 		HPSB_ERR("Failed to start hpsbpkt thread!\n");
-		ret = -ENOMEM;
+		ret = PTR_ERR(khpsbpkt_thread);
 		goto exit_cleanup_config_roms;
 	}
 
@@ -1148,10 +1138,7 @@ release_all_bus:
 release_chrdev:
 	unregister_chrdev_region(IEEE1394_CORE_DEV, 256);
 exit_release_kernel_thread:
-	if (khpsbpkt_pid >= 0) {
-		kill_proc(khpsbpkt_pid, SIGTERM, 1);
-		wait_for_completion(&khpsbpkt_complete);
-	}
+	kthread_stop(khpsbpkt_thread);
 exit_cleanup_config_roms:
 	hpsb_cleanup_config_roms();
 	return ret;
@@ -1172,12 +1159,7 @@ static void __exit ieee1394_cleanup(void
 		bus_remove_file(&ieee1394_bus_type, fw_bus_attrs[i]);
 	bus_unregister(&ieee1394_bus_type);
 
-	if (khpsbpkt_pid >= 0) {
-		khpsbpkt_kill = 1;
-		mb();
-		up(&khpsbpkt_sig);
-		wait_for_completion(&khpsbpkt_complete);
-	}
+	kthread_stop(khpsbpkt_thread);
 
 	hpsb_cleanup_config_roms();
 


