Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbTITVWS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 17:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbTITVWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 17:22:18 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64772 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261969AbTITVWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 17:22:12 -0400
Date: Sat, 20 Sep 2003 22:22:07 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Sean Estabrooks <seanlkml@rogers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PCMCIA]  Xircom nic hang on boot since cs.c race condition patch
Message-ID: <20030920222207.B4517@flint.arm.linux.org.uk>
Mail-Followup-To: Sean Estabrooks <seanlkml@rogers.com>,
	linux-kernel@vger.kernel.org
References: <20030917144406.753953dd.seanlkml@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030917144406.753953dd.seanlkml@rogers.com>; from seanlkml@rogers.com on Wed, Sep 17, 2003 at 02:44:06PM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 17, 2003 at 02:44:06PM -0400, Sean Estabrooks wrote:
> [PCMCIA] Fix race condition causing cards to be incorrectly recognised
> 
> This patch that went into test5 causes my Toshiba laptop with Xircom 
> pcmcia nic to freeze on boot at "Socket status: 30000020".  
> 
> test4 didn't have this issue, and test5-mm2 is the same as test5 vanilla.
> If the Xircom nic is inserted after boot then everything works without a 
> problem.
> 
> Backing out this patch restores normal boot.   Any tips on how i can 
> narrow the problem down further would be appreciated.   lspci and
> .config attached.

Ok, can you try the attached patch please?  It basically juggles the
initialisation so that we avoid the locking issues by moving the init
between our the socket driver and our private thread.

The patch is against Linus' tree as of last Wednesday.

Note that I haven't compile-tested this exact patch, (but one similar)
so I need feedback from both cardbus and pcmcia-using people before I
submit it.

===== drivers/pcmcia/cs.c 1.62 vs edited =====
--- 1.62/drivers/pcmcia/cs.c	Mon Sep  8 23:15:21 2003
+++ edited/drivers/pcmcia/cs.c	Sat Sep 20 22:13:27 2003
@@ -281,72 +281,29 @@
 EXPORT_SYMBOL(pcmcia_socket_dev_resume);
 
 
-static int pccardd(void *__skt);
-#define to_class_data(dev) dev->class_data
-
-static int pcmcia_add_socket(struct class_device *class_dev)
-{
-	struct pcmcia_socket *socket = class_get_devdata(class_dev);
-	int ret = 0;
-
-	/* base address = 0, map = 0 */
-	socket->cis_mem.flags = 0;
-	socket->cis_mem.speed = cis_speed;
-	socket->erase_busy.next = socket->erase_busy.prev = &socket->erase_busy;
-	INIT_LIST_HEAD(&socket->cis_cache);
-	spin_lock_init(&socket->lock);
-
-	init_completion(&socket->thread_done);
-	init_waitqueue_head(&socket->thread_wait);
-	init_MUTEX(&socket->skt_sem);
-	spin_lock_init(&socket->thread_lock);
-
-	socket->socket = dead_socket;
-	socket->ops->init(socket);
-
-	ret = kernel_thread(pccardd, socket, CLONE_KERNEL);
-	if (ret < 0)
-		return ret;
-
-	wait_for_completion(&socket->thread_done);
-	BUG_ON(!socket->thread);
-	pcmcia_parse_events(socket, SS_DETECT);
-
-	return 0;
-}
-
-static void pcmcia_remove_socket(struct class_device *class_dev)
+static void pcmcia_release_socket(struct class_device *class_dev)
 {
 	struct pcmcia_socket *socket = class_get_devdata(class_dev);
 	client_t *client;
 
-	if (socket->thread) {
-		init_completion(&socket->thread_done);
-		socket->thread = NULL;
-		wake_up(&socket->thread_wait);
-		wait_for_completion(&socket->thread_done);
-	}
-	release_cis_mem(socket);
 	while (socket->clients) {
 		client = socket->clients;
 		socket->clients = socket->clients->next;
 		kfree(client);
 	}
-	socket->ops = NULL;
-}
 
-static void pcmcia_release_socket(struct class_device *class_dev)
-{
-	struct pcmcia_socket *socket = class_get_devdata(class_dev);
 	complete(&socket->socket_released);
 }
 
+static int pccardd(void *__skt);
 
 /**
  * pcmcia_register_socket - add a new pcmcia socket device
  */
 int pcmcia_register_socket(struct pcmcia_socket *socket)
 {
+	int ret;
+
 	if (!socket || !socket->ops || !socket->dev.dev)
 		return -EINVAL;
 
@@ -381,15 +338,34 @@
 	socket->dev.class = &pcmcia_socket_class;
 	snprintf(socket->dev.class_id, BUS_ID_SIZE, "pcmcia_socket%u", socket->sock);
 
-	/* register with the device core */
-	if (class_device_register(&socket->dev)) {
-		down_write(&pcmcia_socket_list_rwsem);
-		list_del(&socket->socket_list);
-		up_write(&pcmcia_socket_list_rwsem);
-		return -EINVAL;
-	}
+	/* base address = 0, map = 0 */
+	socket->cis_mem.flags = 0;
+	socket->cis_mem.speed = cis_speed;
+	socket->erase_busy.next = socket->erase_busy.prev = &socket->erase_busy;
+	INIT_LIST_HEAD(&socket->cis_cache);
+	spin_lock_init(&socket->lock);
+
+	init_completion(&socket->socket_released);
+	init_completion(&socket->thread_done);
+	init_waitqueue_head(&socket->thread_wait);
+	init_MUTEX(&socket->skt_sem);
+	spin_lock_init(&socket->thread_lock);
+
+	ret = kernel_thread(pccardd, socket, CLONE_KERNEL);
+	if (ret < 0)
+		goto err;
+
+	wait_for_completion(&socket->thread_done);
+	BUG_ON(!socket->thread);
+	pcmcia_parse_events(socket, SS_DETECT);
 
 	return 0;
+
+ err:
+	down_write(&pcmcia_socket_list_rwsem);
+	list_del(&socket->socket_list);
+	up_write(&pcmcia_socket_list_rwsem);
+	return ret;
 } /* pcmcia_register_socket */
 EXPORT_SYMBOL(pcmcia_register_socket);
 
@@ -404,10 +380,13 @@
 
 	DEBUG(0, "cs: pcmcia_unregister_socket(0x%p)\n", socket->ops);
 
-	init_completion(&socket->socket_released);
-
-	/* remove from the device core */
-	class_device_unregister(&socket->dev);
+	if (socket->thread) {
+		init_completion(&socket->thread_done);
+		socket->thread = NULL;
+		wake_up(&socket->thread_wait);
+		wait_for_completion(&socket->thread_done);
+	}
+	release_cis_mem(socket);
 
 	/* remove from our own list */
 	down_write(&pcmcia_socket_list_rwsem);
@@ -783,11 +762,22 @@
 {
 	struct pcmcia_socket *skt = __skt;
 	DECLARE_WAITQUEUE(wait, current);
+	int ret;
 
 	daemonize("pccardd");
 	skt->thread = current;
 	complete(&skt->thread_done);
 
+	skt->socket = dead_socket;
+	skt->ops->init(skt);
+
+	/* register with the device core */
+	ret = class_device_register(&skt->dev);
+	if (ret) {
+		printk(KERN_WARNING "PCMCIA: unable to register socket 0x%p\n",
+			skt);
+	}
+
 	add_wait_queue(&skt->thread_wait, &wait);
 	for (;;) {
 		unsigned long flags;
@@ -823,6 +813,9 @@
 	}
 	remove_wait_queue(&skt->thread_wait, &wait);
 
+	/* remove from the device core */
+	class_device_unregister(&skt->dev);
+
 	complete_and_exit(&skt->thread_done, 0);
 }
 
@@ -2501,12 +2494,6 @@
 };
 EXPORT_SYMBOL(pcmcia_socket_class);
 
-static struct class_interface pcmcia_socket = {
-	.class = &pcmcia_socket_class,
-	.add = &pcmcia_add_socket,
-	.remove = &pcmcia_remove_socket,
-};
-
 
 static int __init init_pcmcia_cs(void)
 {
@@ -2514,7 +2501,6 @@
     printk(KERN_INFO "  %s\n", options);
     DEBUG(0, "%s\n", version);
     class_register(&pcmcia_socket_class);
-    class_interface_register(&pcmcia_socket);
 
     return 0;
 }
@@ -2523,7 +2509,6 @@
 {
     printk(KERN_INFO "unloading Kernel Card Services\n");
     release_resource_db();
-    class_interface_unregister(&pcmcia_socket);
     class_unregister(&pcmcia_socket_class);
 }
 


-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
