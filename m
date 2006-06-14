Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWFNMIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWFNMIW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 08:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWFNMIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 08:08:21 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:50380 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751267AbWFNMIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 08:08:20 -0400
Date: Wed, 14 Jun 2006 07:06:37 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: linux-pcmcia@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] kthread: convert pcmcia_cs from kernel_thread
Message-ID: <20060614120637.GD15061@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert pcmcia_cs to use kthread instead of the deprecated
kernel_thread.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 drivers/pcmcia/cs.c |   27 ++++++++++-----------------
 include/pcmcia/ss.h |    1 -
 2 files changed, 10 insertions(+), 18 deletions(-)

d711552935ab4b1734624e49d13b19675f24f29c
diff --git a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
index 3162998..aa31b44 100644
--- a/drivers/pcmcia/cs.c
+++ b/drivers/pcmcia/cs.c
@@ -28,6 +28,7 @@
 #include <linux/pm.h>
 #include <linux/pci.h>
 #include <linux/device.h>
+#include <linux/kthread.h>
 #include <asm/system.h>
 #include <asm/irq.h>
 
@@ -176,6 +177,7 @@ static int pccardd(void *__skt);
  */
 int pcmcia_register_socket(struct pcmcia_socket *socket)
 {
+	struct task_struct *tsk;
 	int ret;
 
 	if (!socket || !socket->ops || !socket->dev.dev || !socket->resource_ops)
@@ -234,20 +236,16 @@ int pcmcia_register_socket(struct pcmcia
 	INIT_LIST_HEAD(&socket->cis_cache);
 
 	init_completion(&socket->socket_released);
-	init_completion(&socket->thread_done);
 	init_waitqueue_head(&socket->thread_wait);
 	mutex_init(&socket->skt_mutex);
 	spin_lock_init(&socket->thread_lock);
 
-	ret = kernel_thread(pccardd, socket, CLONE_KERNEL);
-	if (ret < 0)
+	tsk = kthread_run(pccardd, socket, "pccardd");
+	if (IS_ERR(tsk)) {
+		ret = PTR_ERR(tsk);
 		goto err;
-
-	wait_for_completion(&socket->thread_done);
-	if(!socket->thread) {
-		printk(KERN_WARNING "PCMCIA: warning: socket thread for socket %p did not start\n", socket);
-		return -EIO;
 	}
+
 	pcmcia_parse_events(socket, SS_DETECT);
 
 	return 0;
@@ -272,10 +270,8 @@ void pcmcia_unregister_socket(struct pcm
 	cs_dbg(socket, 0, "pcmcia_unregister_socket(0x%p)\n", socket->ops);
 
 	if (socket->thread) {
-		init_completion(&socket->thread_done);
-		socket->thread = NULL;
 		wake_up(&socket->thread_wait);
-		wait_for_completion(&socket->thread_done);
+		kthread_stop(socket->thread);
 	}
 	release_cis_mem(socket);
 
@@ -630,8 +626,6 @@ static int pccardd(void *__skt)
 	DECLARE_WAITQUEUE(wait, current);
 	int ret;
 
-	daemonize("pccardd");
-
 	skt->thread = current;
 	skt->socket = dead_socket;
 	skt->ops->init(skt);
@@ -643,11 +637,10 @@ static int pccardd(void *__skt)
 		printk(KERN_WARNING "PCMCIA: unable to register socket 0x%p\n",
 			skt);
 		skt->thread = NULL;
-		complete_and_exit(&skt->thread_done, 0);
+		return 0;
 	}
 
 	add_wait_queue(&skt->thread_wait, &wait);
-	complete(&skt->thread_done);
 
 	for (;;) {
 		unsigned long flags;
@@ -674,7 +667,7 @@ static int pccardd(void *__skt)
 			continue;
 		}
 
-		if (!skt->thread)
+		if (kthread_should_stop())
 			break;
 
 		schedule();
@@ -688,7 +681,7 @@ static int pccardd(void *__skt)
 	/* remove from the device core */
 	class_device_unregister(&skt->dev);
 
-	complete_and_exit(&skt->thread_done, 0);
+	return 0;
 }
 
 /*
diff --git a/include/pcmcia/ss.h b/include/pcmcia/ss.h
index 5e0a01a..e35d0bb 100644
--- a/include/pcmcia/ss.h
+++ b/include/pcmcia/ss.h
@@ -245,7 +245,6 @@ struct pcmcia_socket {
 	struct mutex			skt_mutex;	/* protects socket h/w state */
 
 	struct task_struct		*thread;
-	struct completion		thread_done;
 	wait_queue_head_t		thread_wait;
 	spinlock_t			thread_lock;	/* protects thread_events */
 	unsigned int			thread_events;
-- 
1.1.6
