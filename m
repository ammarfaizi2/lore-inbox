Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWJQOyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWJQOyH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 10:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWJQOyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 10:54:07 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:33977 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1751111AbWJQOyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 10:54:05 -0400
Date: Tue, 17 Oct 2006 08:54:04 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       Adam Belay <abelay@MIT.EDU>
Subject: Re: [PATCH] Block on access to temporarily unavailable pci device
Message-ID: <20061017145403.GK22289@parisc-linux.org>
References: <20061017145146.GJ22289@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061017145146.GJ22289@parisc-linux.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 08:51:46AM -0600, Matthew Wilcox wrote:
> I'll post the patch I used to test blocking device accesses separately.

Here it is.  Not for applying.

Nacked-by: Matthew Wilcox <matthew@wil.cx>

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index a1d2e97..267bf76 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -175,6 +175,20 @@ msi_bus_store(struct device *dev, struct
 	return count;
 }
 
+static ssize_t
+block_store(struct device *dev, struct device_attribute *attr,
+	      const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (*buf == '0')
+		pci_unblock_user_cfg_access(pdev);
+	else if (*buf == '1')
+		pci_block_user_cfg_access(pdev);
+
+	return count;
+}
+
 struct device_attribute pci_dev_attrs[] = {
 	__ATTR_RO(resource),
 	__ATTR_RO(vendor),
@@ -189,6 +203,7 @@ struct device_attribute pci_dev_attrs[] 
 	__ATTR(broken_parity_status,(S_IRUGO|S_IWUSR),
 		broken_parity_status_show,broken_parity_status_store),
 	__ATTR(msi_bus, 0644, msi_bus_show, msi_bus_store),
+	__ATTR(block, 0200, NULL, block_store),
 	__ATTR_NULL,
 };
 
