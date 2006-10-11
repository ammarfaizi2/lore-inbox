Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422669AbWJKVt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422669AbWJKVt7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422671AbWJKVt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:49:59 -0400
Received: from havoc.gtf.org ([69.61.125.42]:57815 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1422669AbWJKVt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:49:56 -0400
Date: Wed, 11 Oct 2006 17:49:56 -0400
From: Jeff Garzik <jeff@garzik.org>
To: linux-pcmcia@lists.infradead.org, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCMCIA: handle sysfs, PCI errors
Message-ID: <20061011214955.GA22109@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/pcmcia/ds.c           |   16 ++++++++++++++--
 drivers/pcmcia/i82092.c       |    7 +++++--
 drivers/pcmcia/pcmcia_ioctl.c |   11 ++++++++---
 drivers/pcmcia/yenta_socket.c |   16 +++++++++++++---

diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index 74b3124..06bcbfa 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -1292,14 +1292,26 @@ struct bus_type pcmcia_bus_type = {
 
 static int __init init_pcmcia_bus(void)
 {
+	int rc;
+
 	spin_lock_init(&pcmcia_dev_list_lock);
 
-	bus_register(&pcmcia_bus_type);
-	class_interface_register(&pcmcia_bus_interface);
+	rc = bus_register(&pcmcia_bus_type);
+	if (rc)
+		goto err;
+
+	rc = class_interface_register(&pcmcia_bus_interface);
+	if (rc)
+		goto err_bus;
 
 	pcmcia_setup_ioctl();
 
 	return 0;
+
+err_bus:
+	bus_unregister(&pcmcia_bus_type);
+err:
+	return rc;
 }
 fs_initcall(init_pcmcia_bus); /* one level after subsys_initcall so that 
 			       * pcmcia_socket_class is already registered */
diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index 82715f4..d4f137e 100644
--- a/drivers/pcmcia/i82092.c
+++ b/drivers/pcmcia/i82092.c
@@ -705,10 +705,13 @@ static int i82092aa_set_mem_map(struct p
 
 static int i82092aa_module_init(void)
 {
+	int rc;
+
 	enter("i82092aa_module_init");
-	pci_register_driver(&i82092aa_pci_drv);
+	rc = pci_register_driver(&i82092aa_pci_drv);
 	leave("i82092aa_module_init");
-	return 0;
+
+	return rc;
 }
 
 static void i82092aa_module_exit(void)
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
index 26229d9..0a69b5a 100644
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
