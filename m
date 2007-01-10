Return-Path: <linux-kernel-owner+w=401wt.eu-S964769AbXAJFiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964769AbXAJFiv (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 00:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932611AbXAJFiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 00:38:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:26779 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932669AbXAJFgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 00:36:03 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=XRs6dB5r6VBFthbqF0YqK6Y5Gl5hIng99YmznrPbaxptyLyfkshMxTxm5XjxPCO1/7t271UqpqhB3RUSOUYYAvL1shlVWPJthYzjPMxHp6HrgKoLIbQeo0sBcMXUOfxODoPPyQHcIj2qqQWF0RrbuDWWv4pQ96szv/37gKM+dtk=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/13] devres: implement pcim_iomap_regions()
In-Reply-To: <11684073353213-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Wed, 10 Jan 2007 14:35:38 +0900
Message-Id: <1168407338988-git-send-email-htejun@gmail.com>
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
1.4.4.3


