Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263261AbTIVS6W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 14:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263266AbTIVS6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 14:58:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10003 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263261AbTIVS6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 14:58:11 -0400
Date: Mon, 22 Sep 2003 19:58:05 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-pcmcia@lists.infradead.org
Subject: [CFT] Socket quiescing changes
Message-ID: <20030922195805.E31823@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	linux-pcmcia@lists.infradead.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the way in which we turn off power to PCMCIA sockets.
We have traditionally relied on the socket drivers "init" method to
shut down the power to the socket by calling its own "set_socket" function.

Rather than relying on all socket drivers replicating this behaviour, we
move this into the core by calling the "set_socket" method explicitly
after we clear out the socket state structure.

One final note - there is the remote possibility that this may upset some
pcmcia/cardbus controllers which may cause the power to be left switched
on to the socket - should this happen, you should see the "*** DANGER ***"
sign appear in your kernel messages.  Should this happen, I strongly
advise not plugging in your 3.3V card...

(No warranty, if you blow your hardware up you get to keep both pieces,
etc etc etc)

===== cs.c 1.63 vs edited =====
--- 1.63/drivers/pcmcia/cs.c	Sun Sep 21 21:03:37 2003
+++ edited/cs.c	Mon Sep 22 19:44:19 2003
@@ -450,6 +450,7 @@
     s->state &= SOCKET_PRESENT|SOCKET_INUSE;
     s->socket = dead_socket;
     s->ops->init(s);
+    s->ops->set_socket(s, &s->socket);
     s->irq.AssignedIRQ = s->irq.Config = 0;
     s->lock_count = 0;
     destroy_cis_cache(s);
@@ -457,15 +458,6 @@
 	kfree(s->fake_cis);
 	s->fake_cis = NULL;
     }
-    /* Should not the socket be forced quiet as well?  e.g. turn off Vcc */
-    /* Without these changes, the socket is left hot, even though card-services */
-    /* realizes that no card is in place. */
-    s->socket.flags &= ~SS_OUTPUT_ENA;
-    s->socket.Vpp = 0;
-    s->socket.Vcc = 0;
-    s->socket.io_irq = 0;
-    s->ops->set_socket(s, &s->socket);
-    /* */
 #ifdef CONFIG_CARDBUS
     cb_free(s);
 #endif
@@ -485,6 +477,14 @@
     }
     free_regions(&s->a_region);
     free_regions(&s->c_region);
+
+    {
+	int status;
+	skt->ops->get_status(skt, &status);
+	if (status & SS_POWERON) {
+		printk(KERN_ERR "PCMCIA: socket %p: *** DANGER *** unable to remove socket power\n", skt);
+	}
+    }
 } /* shutdown_socket */
 
 /*======================================================================
@@ -639,6 +639,12 @@
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(cs_to_timeout(vcc_settle));
 
+	skt->ops->get_status(skt, &status);
+	if (!(status & SS_POWERON)) {
+		pcmcia_error(skt, "unable to apply power.\n");
+		return CS_BAD_TYPE;
+	}
+
 	return socket_reset(skt);
 }
 
@@ -698,6 +704,7 @@
 
 	skt->socket = dead_socket;
 	skt->ops->init(skt);
+	skt->ops->set_socket(skt, &skt->socket);
 
 	ret = socket_setup(skt, resume_delay);
 	if (ret == CS_SUCCESS) {
@@ -770,6 +777,7 @@
 
 	skt->socket = dead_socket;
 	skt->ops->init(skt);
+	skt->ops->set_socket(skt, &skt->socket);
 
 	/* register with the device core */
 	ret = class_device_register(&skt->dev);
===== hd64465_ss.c 1.16 vs edited =====
--- 1.16/drivers/pcmcia/hd64465_ss.c	Sat Sep  6 22:32:53 2003
+++ edited/hd64465_ss.c	Mon Sep 22 17:52:29 2003
@@ -347,11 +347,7 @@
     	hs_socket_t *sp = container_of(s, struct hs_socket_t, socket);
 	
     	DPRINTK("hs_init(%d)\n", sp->number);
-	
-	sp->state.Vcc = 0;
-	sp->state.Vpp = 0;
-	hs_set_voltages(sp, 0, 0);
-	
+
 	return 0;
 }
 
===== i82092.c 1.29 vs edited =====
--- 1.29/drivers/pcmcia/i82092.c	Thu Sep 11 23:46:11 2003
+++ edited/i82092.c	Mon Sep 22 17:53:00 2003
@@ -426,7 +426,6 @@
         enter("i82092aa_init");
                         
         mem.sys_stop = 0x0fff;
-        i82092aa_set_socket(sock, &dead_socket);
         for (i = 0; i < 2; i++) {
         	io.map = i;
                 i82092aa_set_io_map(sock, &io);
===== i82365.c 1.45 vs edited =====
--- 1.45/drivers/pcmcia/i82365.c	Sat Sep  6 22:32:53 2003
+++ edited/i82365.c	Mon Sep 22 17:53:36 2003
@@ -1322,7 +1322,6 @@
 	pccard_mem_map mem = { 0, 0, 0, 0, 0, 0 };
 
 	mem.sys_stop = 0x1000;
-	pcic_set_socket(s, &dead_socket);
 	for (i = 0; i < 2; i++) {
 		io.map = i;
 		pcic_set_io_map(s, &io);
===== sa11xx_core.c 1.13 vs edited =====
--- 1.13/drivers/pcmcia/sa11xx_core.c	Sat Sep  6 21:34:13 2003
+++ edited/sa11xx_core.c	Mon Sep 22 17:54:15 2003
@@ -232,8 +232,6 @@
 	DEBUG(2, "%s(): initializing socket %u\n", __FUNCTION__, skt->nr);
 
 	skt->ops->socket_init(skt);
-	sa1100_pcmcia_config_skt(skt, &dead_socket);
-
 	return 0;
 }
 
===== tcic.c 1.34 vs edited =====
--- 1.34/drivers/pcmcia/tcic.c	Sat Sep  6 22:32:54 2003
+++ edited/tcic.c	Mon Sep 22 17:54:36 2003
@@ -865,7 +865,6 @@
 	pccard_mem_map mem = { 0, 0, 0, 0, 0, 0 };
 
 	mem.sys_stop = 0x1000;
-	tcic_set_socket(s, &dead_socket);
 	for (i = 0; i < 2; i++) {
 		io.map = i;
 		tcic_set_io_map(s, &io);

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
