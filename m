Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbTFOQyw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 12:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbTFOQyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 12:54:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47883 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262385AbTFOQyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 12:54:39 -0400
Date: Sun, 15 Jun 2003 18:08:27 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Dominik Brodowski <linux@brodo.de>, linux-pcmcia@lists.infradead.org
Subject: [PATCH] Prevent sysfs-related oops in pcmcia class code
Message-ID: <20030615180827.E5417@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Dominik Brodowski <linux@brodo.de>,
	linux-pcmcia@lists.infradead.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Although no such oops has been reported, removing a socket driver
while a file under /sysfs/class/pcmcia_socket/pcmcia_socket* is
held open by user space could potentially cause an oops.

Plug this by preventing pcmcia_unregister_socket from returning
until all references by sysfs to the pcmcia socket have been
dropped.

This patch is against my current bk tree, so will apply with offsets
to 2.5.71.

diff -Nru a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
--- a/drivers/pcmcia/cs.c	Sun Jun 15 18:05:06 2003
+++ b/drivers/pcmcia/cs.c	Sun Jun 15 18:05:06 2003
@@ -387,6 +387,12 @@
 	socket->ss_entry = NULL;
 }
 
+static void pcmcia_release_socket(struct class_device *class_dev)
+{
+	struct pcmcia_socket *socket = class_get_devdata(class_dev);
+	complete(&socket->socket_released);
+}
+
 
 /**
  * pcmcia_register_socket - add a new pcmcia socket device
@@ -450,6 +456,8 @@
 
 	DEBUG(0, "cs: pcmcia_unregister_socket(0x%p)\n", socket->ss_entry);
 
+	init_completion(&socket->socket_released);
+
 	/* remove from the device core */
 	class_device_unregister(&socket->dev);
 
@@ -457,6 +465,9 @@
 	down_write(&pcmcia_socket_list_rwsem);
 	list_del(&socket->socket_list);
 	up_write(&pcmcia_socket_list_rwsem);
+
+	/* wait for sysfs to drop all references */
+	wait_for_completion(&socket->socket_released);
 } /* pcmcia_unregister_socket */
 EXPORT_SYMBOL(pcmcia_unregister_socket);
 
@@ -2496,6 +2507,7 @@
 
 struct class pcmcia_socket_class = {
 	.name = "pcmcia_socket",
+	.release = pcmcia_release_socket,
 };
 EXPORT_SYMBOL(pcmcia_socket_class);
 
diff -Nru a/include/pcmcia/ss.h b/include/pcmcia/ss.h
--- a/include/pcmcia/ss.h	Sun Jun 15 18:05:06 2003
+++ b/include/pcmcia/ss.h	Sun Jun 15 18:05:06 2003
@@ -193,6 +193,7 @@
 	char				*fake_cis;
 
 	struct list_head		socket_list;
+	struct completion		socket_released;
 
  	/* deprecated */
 	unsigned int			sock;		/* socket number */

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

