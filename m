Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965291AbWJZCTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965291AbWJZCTb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 22:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965295AbWJZCTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 22:19:14 -0400
Received: from isilmar.linta.de ([213.239.214.66]:34271 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S965291AbWJZCTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 22:19:06 -0400
Date: Wed, 25 Oct 2006 22:17:42 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-pcmcia@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, jeff@garzik.org
Subject: [RFC PATCH 10/11] PCMCIA: handle sysfs, PCI errors
Message-ID: <20061026021742.GK20473@dominikbrodowski.de>
Mail-Followup-To: linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org, jeff@garzik.org
References: <20061026021027.GA20473@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061026021027.GA20473@dominikbrodowski.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Garzik <jeff@garzik.org>
Date: Fri, 20 Oct 2006 14:44:23 -0700
Subject: [PATCH] PCMCIA: handle sysfs, PCI errors

Handle sysfs and PCI errors correctly.

Signed-off-by: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/pcmcia/pcmcia_ioctl.c |   11 ++++++++---
 drivers/pcmcia/yenta_socket.c |   16 +++++++++++++---
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/pcmcia/pcmcia_ioctl.c b/drivers/pcmcia/pcmcia_ioctl.c
index 9ad18e6..310ede5 100644
--- a/drivers/pcmcia/pcmcia_ioctl.c
+++ b/drivers/pcmcia/pcmcia_ioctl.c
@@ -128,9 +128,12 @@ static int proc_read_drivers(char *buf, 
 			     int count, int *eof, void *data)
 {
 	char *p = buf;
+	int rc;
 
-	bus_for_each_drv(&pcmcia_bus_type, NULL,
-			 (void *) &p, proc_read_drivers_callback);
+	rc = bus_for_each_drv(&pcmcia_bus_type, NULL,
+			      (void *) &p, proc_read_drivers_callback);
+	if (rc < 0)
+		return rc;
 
 	return (p - buf);
 }
@@ -269,8 +272,10 @@ rescan:
 	 * Prevent this racing with a card insertion.
 	 */
 	mutex_lock(&s->skt_mutex);
-	bus_rescan_devices(&pcmcia_bus_type);
+	ret = bus_rescan_devices(&pcmcia_bus_type);
 	mutex_unlock(&s->skt_mutex);
+	if (ret)
+		goto err_put_module;
 
 	/* check whether the driver indeed matched. I don't care if this
 	 * is racy or not, because it can only happen on cardmgr access
diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
index 9ced52a..da471bd 100644
--- a/drivers/pcmcia/yenta_socket.c
+++ b/drivers/pcmcia/yenta_socket.c
@@ -1197,8 +1197,12 @@ static int __devinit yenta_probe (struct
 	ret = pcmcia_register_socket(&socket->socket);
 	if (ret == 0) {
 		/* Add the yenta register attributes */
-		device_create_file(&dev->dev, &dev_attr_yenta_registers);
-		goto out;
+		ret = device_create_file(&dev->dev, &dev_attr_yenta_registers);
+		if (ret == 0)
+			goto out;
+
+		/* error path... */
+		pcmcia_unregister_socket(&socket->socket);
 	}
 
  unmap:
@@ -1248,12 +1252,18 @@ static int yenta_dev_resume (struct pci_
 	struct yenta_socket *socket = pci_get_drvdata(dev);
 
 	if (socket) {
+		int rc;
+
 		pci_set_power_state(dev, 0);
 		/* FIXME: pci_restore_state needs to have a better interface */
 		pci_restore_state(dev);
 		pci_write_config_dword(dev, 16*4, socket->saved_state[0]);
 		pci_write_config_dword(dev, 17*4, socket->saved_state[1]);
-		pci_enable_device(dev);
+
+		rc = pci_enable_device(dev);
+		if (rc)
+			return rc;
+
 		pci_set_master(dev);
 
 		if (socket->type && socket->type->restore_state)
-- 
1.4.3

