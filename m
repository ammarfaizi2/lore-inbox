Return-Path: <linux-kernel-owner+w=401wt.eu-S965176AbXATHAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbXATHAl (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 02:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965222AbXATHAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 02:00:40 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:8316 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965175AbXATHAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 02:00:35 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=dNuFyxt2qTfRp4usfwrM6xsw5pvcpnhYVBEDSEgSkvGZxjNhS1lqBcpNHCuPCO9dhjgDpr4KVBRQ9W45BBQkH491uusWUpPRblfi7j5IbQ6xBf7I6gGlw+pH17Vn9Wh1JyP5mawVE5lrY49YZcjNQeQEkBG5m0E59K/NpBoi4+g=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/7] libata: implement ata_host_detach()
In-Reply-To: <11692764262700-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Sat, 20 Jan 2007 16:00:26 +0900
Message-Id: <1169276426417-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: jgarzik@pobox.com, gregkh@suse.de, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       htejun@gmail.com
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement ata_host_detach() which calls ata_port_detach() for each
port in the host and export it.  ata_port_detach() is now internal and
thus un-exported.  ata_host_detach() will be used as the 'deregister
from libata layer' function after devres conversion.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c        |    3 +--
 drivers/ata/libata-core.c |   22 +++++++++++++++++++---
 include/linux/libata.h    |    2 +-
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 5998f74..d089217 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1767,8 +1767,7 @@ static void ahci_remove_one (struct pci_dev *pdev)
 	unsigned int i;
 	int have_msi;
 
-	for (i = 0; i < host->n_ports; i++)
-		ata_port_detach(host->ports[i]);
+	ata_host_detach(host);
 
 	have_msi = hpriv->flags & AHCI_FLAG_MSI;
 	free_irq(host->irq, host);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8315ee6..20a943f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6002,6 +6002,23 @@ void ata_port_detach(struct ata_port *ap)
 }
 
 /**
+ *	ata_host_detach - Detach all ports of an ATA host
+ *	@host: Host to detach
+ *
+ *	Detach all ports of @host.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+void ata_host_detach(struct ata_host *host)
+{
+	int i;
+
+	for (i = 0; i < host->n_ports; i++)
+		ata_port_detach(host->ports[i]);
+}
+
+/**
  *	ata_host_remove - PCI layer callback for device removal
  *	@host: ATA host set that was removed
  *
@@ -6016,8 +6033,7 @@ void ata_host_remove(struct ata_host *host)
 {
 	unsigned int i;
 
-	for (i = 0; i < host->n_ports; i++)
-		ata_port_detach(host->ports[i]);
+	ata_host_detach(host);
 
 	free_irq(host->irq, host);
 	if (host->irq2)
@@ -6392,7 +6408,7 @@ EXPORT_SYMBOL_GPL(ata_std_bios_param);
 EXPORT_SYMBOL_GPL(ata_std_ports);
 EXPORT_SYMBOL_GPL(ata_host_init);
 EXPORT_SYMBOL_GPL(ata_device_add);
-EXPORT_SYMBOL_GPL(ata_port_detach);
+EXPORT_SYMBOL_GPL(ata_host_detach);
 EXPORT_SYMBOL_GPL(ata_host_remove);
 EXPORT_SYMBOL_GPL(ata_sg_init);
 EXPORT_SYMBOL_GPL(ata_sg_init_one);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 09c110a..8bad682 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -718,7 +718,7 @@ extern int ata_pci_device_resume(struct pci_dev *pdev);
 extern int ata_pci_clear_simplex(struct pci_dev *pdev);
 #endif /* CONFIG_PCI */
 extern int ata_device_add(const struct ata_probe_ent *ent);
-extern void ata_port_detach(struct ata_port *ap);
+extern void ata_host_detach(struct ata_host *host);
 extern void ata_host_init(struct ata_host *, struct device *,
 			  unsigned long, const struct ata_port_operations *);
 extern void ata_host_remove(struct ata_host *host);
-- 
1.4.4.4


