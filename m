Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751571AbWDYVvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbWDYVvT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 17:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbWDYVvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 17:51:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:56216 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751555AbWDYVvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 17:51:18 -0400
X-IronPort-AV: i="4.04,154,1144047600"; 
   d="scan'208"; a="28511446:sNHT50913037"
Subject: Re: [patch] pciehp: dont call pci_enable_dev
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: pcihpd-discuss@lists.sourceforge.net, greg@kroah.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <1145945819.3114.0.camel@laptopd505.fenrus.org>
References: <1145919059.6478.29.camel@whizzy>
	 <1145945819.3114.0.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 25 Apr 2006 15:00:36 -0700
Message-Id: <1146002437.6478.43.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 25 Apr 2006 21:51:13.0359 (UTC) FILETIME=[5EFAA5F0:01C668B2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-25 at 08:16 +0200, Arjan van de Ven wrote:
> On Mon, 2006-04-24 at 15:50 -0700, Kristen Accardi wrote:
> > Don't call pci_enable_device from pciehp because the pcie port service driver
> > already does this.
> 
> hmmmm shouldn't pci_enable_device on a previously enabled device just
> succeed? Sounds more than logical to me to make it that way at least...

I can't think of any reason why not.  Something like this what you had
in mind perhaps?

---
 drivers/pci/pci.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

--- 2.6-git-pcie.orig/drivers/pci/pci.c
+++ 2.6-git-pcie/drivers/pci/pci.c
@@ -504,11 +504,15 @@ pci_enable_device_bars(struct pci_dev *d
 int
 pci_enable_device(struct pci_dev *dev)
 {
-	int err = pci_enable_device_bars(dev, (1 << PCI_NUM_RESOURCES) - 1);
-	if (err)
-		return err;
-	pci_fixup_device(pci_fixup_enable, dev);
-	dev->is_enabled = 1;
+	int err;
+
+	if (!dev->is_enabled) {
+		err = pci_enable_device_bars(dev, (1 << PCI_NUM_RESOURCES) - 1);
+		if (err)
+			return err;
+		pci_fixup_device(pci_fixup_enable, dev);
+		dev->is_enabled = 1;
+	}
 	return 0;
 }
 
