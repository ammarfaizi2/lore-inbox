Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268073AbTBWJAL>; Sun, 23 Feb 2003 04:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268076AbTBWJAL>; Sun, 23 Feb 2003 04:00:11 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:36295 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S268073AbTBWJAI>; Sun, 23 Feb 2003 04:00:08 -0500
Date: Sun, 23 Feb 2003 10:06:08 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pcmcia: add socket_offset for multiple pci_sockets, correct suspend&resume
Message-ID: <20030223090608.GA11747@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- suspend & remove for pci_socket was broken -- thanks to Paul Mackerras for
		noting this
- to correctly initialize multiple pci_socket devices, a sock_offset is
		needed.
- s_info doesn't need to be an array.

Please apply,
	Dominik

diff -ruN linux-original/drivers/pcmcia/cs.c linux/drivers/pcmcia/cs.c
--- linux-original/drivers/pcmcia/cs.c	2003-02-23 10:04:03.000000000 +0100
+++ linux/drivers/pcmcia/cs.c	2003-02-23 10:04:25.000000000 +0100
@@ -337,13 +337,14 @@
 		return -ENOMEM;
 	memset(s_info, 0, cls_d->nsock * sizeof(socket_info_t));
 
+	cls_d->s_info = s_info;
+
 	/* socket initialization */
 	for (i = 0; i < cls_d->nsock; i++) {
 		socket_info_t *s = &s_info[i];
 
-		cls_d->s_info[i] = s;
 		s->ss_entry = cls_d->ops;
-		s->sock = i;
+		s->sock = i + cls_d->sock_offset;
 
 		/* base address = 0, map = 0 */
 		s->cis_mem.flags = 0;
diff -ruN linux-original/drivers/pcmcia/pci_socket.c linux/drivers/pcmcia/pci_socket.c
--- linux-original/drivers/pcmcia/pci_socket.c	2003-02-23 10:04:03.000000000 +0100
+++ linux/drivers/pcmcia/pci_socket.c	2003-02-23 10:04:25.000000000 +0100
@@ -171,6 +171,16 @@
 	int err;
 	
 	memset(socket, 0, sizeof(*socket));
+
+	/* prepare class_data */
+	socket->cls_d.sock_offset = nr;
+	socket->cls_d.nsock = 1; /* yenta is 1, no other low-level driver uses
+			     this yet */
+	socket->cls_d.ops = &pci_socket_operations;
+	socket->cls_d.use_bus_pm = 1;
+	dev->dev.class_data = &socket->cls_d;
+
+	/* prepare pci_socket_t */
 	socket->dev = dev;
 	socket->op = ops;
 	pci_set_drvdata(dev, socket);
@@ -186,18 +196,6 @@
 
 int cardbus_register(struct pci_dev *p_dev)
 {
-	pci_socket_t *socket = pci_get_drvdata(p_dev);
-	struct pcmcia_socket_class_data *cls_d;
-
-	if (!socket)
-		return -EINVAL;
-
-	cls_d = &socket->cls_d;
-	cls_d->nsock = 1; /* yenta is 1, no other low-level driver uses
-			     this yet */
-	cls_d->ops = &pci_socket_operations;
-	cls_d->use_bus_pm = 1;
-	p_dev->dev.class_data = cls_d;
 	return 0;
 }
 
@@ -227,14 +225,16 @@
 static int cardbus_suspend (struct pci_dev *dev, u32 state)
 {
 	pci_socket_t *socket = pci_get_drvdata(dev);
-	pcmcia_suspend_socket (socket->pcmcia_socket);
+	if (socket && socket->cls_d.s_info)
+		pcmcia_suspend_socket (socket->cls_d.s_info);
 	return 0;
 }
 
 static int cardbus_resume (struct pci_dev *dev)
 {
 	pci_socket_t *socket = pci_get_drvdata(dev);
-	pcmcia_resume_socket (socket->pcmcia_socket);
+	if (socket && socket->cls_d.s_info)
+		pcmcia_resume_socket (socket->cls_d.s_info);
 	return 0;
 }
 
diff -ruN linux-original/drivers/pcmcia/pci_socket.h linux/drivers/pcmcia/pci_socket.h
--- linux-original/drivers/pcmcia/pci_socket.h	2003-02-23 10:04:03.000000000 +0100
+++ linux/drivers/pcmcia/pci_socket.h	2003-02-23 10:04:25.000000000 +0100
@@ -20,7 +20,6 @@
 	socket_cap_t cap;
 	spinlock_t event_lock;
 	unsigned int events;
-	struct socket_info_t *pcmcia_socket;
 	struct work_struct tq_task;
 	struct timer_list poll_timer;
 
diff -ruN linux-original/include/pcmcia/ss.h linux/include/pcmcia/ss.h
--- linux-original/include/pcmcia/ss.h	2003-02-23 10:04:12.000000000 +0100
+++ linux/include/pcmcia/ss.h	2003-02-23 10:04:25.000000000 +0100
@@ -145,12 +145,12 @@
  *  Calls to set up low-level "Socket Services" drivers
  */
 
-#define MAX_SOCKETS_PER_DEV 8
-
 struct pcmcia_socket_class_data {
 	unsigned int nsock;			/* number of sockets */
+	unsigned int sock_offset;		/* socket # (which is
+	 * returned to driver) = sock_offset + (0, 1, .. , (nsock-1) */
 	struct pccard_operations *ops;		/* see above */
-	void *s_info[MAX_SOCKETS_PER_DEV];	/* socket_info_t */
+	void *s_info;				/* socket_info_t */
 	unsigned int use_bus_pm;
 };
 
