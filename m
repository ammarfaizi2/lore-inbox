Return-Path: <linux-kernel-owner+w=401wt.eu-S965098AbXATHBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965098AbXATHBR (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 02:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965214AbXATHBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 02:01:04 -0500
Received: from wx-out-0506.google.com ([66.249.82.236]:8229 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965220AbXATHAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 02:00:39 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=OtF2RSn2GJurPhlVVwkCU737NizOrhYsSo9uWm5mu6ejUg5pD7Ly7HdfHgbYlrlM9RGWkM39LRpOhxRV1MtGtu9ZVT5AKBOunznx8jTVj/USI30DjMlsupKe63aV5N2lrCjElhmY++p5Sj+GVU86ov6IuDcbM//y9rMA33WRG8o=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 6/7] devres: implement pcim_iomap_regions()
In-Reply-To: <11692764262700-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Sat, 20 Jan 2007 16:00:28 +0900
Message-Id: <11692764281087-git-send-email-htejun@gmail.com>
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

Implement pcim_iomap_regions().  This function takes mask of BARs to
request and iomap.  No BAR should have length of zero.  BARs are
iomapped using pcim_iomap_table().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 include/linux/io.h |    2 +
 lib/iomap.c        |   53 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/include/linux/io.h b/include/linux/io.h
index f5edf9c..45a9c94 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -45,6 +45,8 @@ void __iomem * pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
 void __iomem * const * pcim_iomap_table(struct pci_dev *pdev);
 
+int pcim_iomap_regions(struct pci_dev *pdev, u16 mask, const char *name);
+
 /**
  *	check_signature		-	find BIOS signatures
  *	@io_addr: mmio address to check
diff --git a/lib/iomap.c b/lib/iomap.c
index 3214028..4990c73 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -498,3 +498,56 @@ void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr)
 	WARN_ON(1);
 }
 EXPORT_SYMBOL(pcim_iounmap);
+
+/**
+ * pcim_iomap_regions - Request and iomap PCI BARs
+ * @pdev: PCI device to map IO resources for
+ * @mask: Mask of BARs to request and iomap
+ * @name: Name used when requesting regions
+ *
+ * Request and iomap regions specified by @mask.
+ */
+int pcim_iomap_regions(struct pci_dev *pdev, u16 mask, const char *name)
+{
+	void __iomem * const *iomap;
+	int i, rc;
+
+	iomap = pcim_iomap_table(pdev);
+	if (!iomap)
+		return -ENOMEM;
+
+	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+		unsigned long len;
+
+		if (!(mask & (1 << i)))
+			continue;
+
+		rc = -EINVAL;
+		len = pci_resource_len(pdev, i);
+		if (!len)
+			goto err_inval;
+
+		rc = pci_request_region(pdev, i, name);
+		if (rc)
+			goto err_region;
+
+		rc = -ENOMEM;
+		if (!pcim_iomap(pdev, i, 0))
+			goto err_iomap;
+	}
+
+	return 0;
+
+ err_iomap:
+	pcim_iounmap(pdev, iomap[i]);
+ err_region:
+	pci_release_region(pdev, i);
+ err_inval:
+	while (--i >= 0) {
+		pcim_iounmap(pdev, iomap[i]);
+		pci_release_region(pdev, i);
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL(pcim_iomap_regions);
-- 
1.4.4.4


