Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751776AbWHUNXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbWHUNXF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 09:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbWHUNXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 09:23:05 -0400
Received: from p02c11o145.mxlogic.net ([208.65.145.68]:27852 "EHLO
	p02c11o145.mxlogic.net") by vger.kernel.org with ESMTP
	id S1751776AbWHUNXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 09:23:03 -0400
Date: Mon, 21 Aug 2006 16:22:22 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
       Roland Dreier <rolandd@cisco.com>, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: restore missing PCI registers after reset
Message-ID: <20060821132222.GM13693@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060726164246.GE9871@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060726164246.GE9871@suse.de>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 21 Aug 2006 13:28:49.0375 (UTC) FILETIME=[BC8236F0:01C6C525]
X-Spam: [F=0.0100000000; S=0.010(2006081701)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Greg KH <gregkh@suse.de>:
> Subject: Re: restore missing PCI registers after reset
> 
> On Wed, Jul 26, 2006 at 07:32:26PM +0300, Michael S. Tsirkin wrote:
> > Quoting r. Greg KH <gregkh@suse.de>:
> > > I think pci_restore_state() already restores the msi and msix state,
> > > take a look at the latest kernel version :)
> > 
> > Yes, I know :)
> > but I am not talking abotu MSI/MSI-X, I am talking about the following:
> > > > >   PCI-X device: PCI-X command register
> > > > >   PCI-X bridge: upstream and downstream split transaction registers
> > > > >   PCI Express : PCI Express device control and link control registers
> > 
> > these register values include maxumum MTU for PCI express and other vital
> > data.
> 
> Make up a patch that shows how you would save these in a generic way and
> we can discuss it.  I know people have talked about saving the extended
> PCI config space for devices that need it, so that might be all you
> need to do here.

Like this?

--

Restore PCI Express capability registers after PM event.
This includes maxumum MTU for PCI express and other vital data.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9f79dd6..198b200 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -443,6 +443,52 @@ pci_power_t pci_choose_state(struct pci_
 
 EXPORT_SYMBOL(pci_choose_state);
 
+static int __pci_save_pcie_state(struct pci_dev *dev)
+{
+	int pos, i = 0;
+	struct pci_cap_saved_state *save_state;
+	u16 *cap;
+
+	pos = pci_find_capability(dev, PCI_CAP_ID_EXP);
+	if (pos <= 0)
+		return 0;
+
+	save_state = kzalloc(sizeof(struct pci_cap_saved_state) + sizeof(u16) * 4,
+		GFP_KERNEL);
+	if (!save_state) {
+		printk(KERN_ERR "Out of memory in pci_save_pcie_state\n");
+		return -ENOMEM;
+	}
+	cap =  (u16 *)&save_state->data[0];
+
+	pci_read_config_word(dev, pos + PCI_EXP_DEVCTL, &cap[i++]);
+	pci_read_config_word(dev, pos + PCI_EXP_LNKCTL, &cap[i++]);
+	pci_read_config_word(dev, pos + PCI_EXP_SLTCTL, &cap[i++]);
+	pci_read_config_word(dev, pos + PCI_EXP_RTCTL, &cap[i++]);
+	pci_add_saved_cap(dev, save_state);
+	return 0;
+}
+
+static void __pci_restore_pcie_state(struct pci_dev *dev)
+{
+	int i = 0, pos;
+	struct pci_cap_saved_state *save_state;
+	u16 *cap;
+
+	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
+	pos = pci_find_capability(dev, PCI_CAP_ID_EXP);
+	if (!save_state || pos <= 0)
+		return;
+	cap = (u16 *)&save_state->data[0];
+
+	pci_write_config_word(dev, pos + PCI_EXP_DEVCTL, cap[i++]);
+	pci_write_config_word(dev, pos + PCI_EXP_LNKCTL, cap[i++]);
+	pci_write_config_word(dev, pos + PCI_EXP_SLTCTL, cap[i++]);
+	pci_write_config_word(dev, pos + PCI_EXP_RTCTL, cap[i++]);
+	pci_remove_saved_cap(save_state);
+	kfree(save_state);
+}
+
 /**
  * pci_save_state - save the PCI configuration space of a device before suspending
  * @dev: - PCI device that we're dealing with
@@ -458,6 +504,8 @@ pci_save_state(struct pci_dev *dev)
 		return i;
 	if ((i = pci_save_msix_state(dev)) != 0)
 		return i;
+	if ((i = __pci_save_pcie_state(dev)) != 0)
+		return i;
 	return 0;
 }
 
@@ -471,6 +519,9 @@ pci_restore_state(struct pci_dev *dev)
 	int i;
 	int val;
 
+	/* PCI Express register must be restored first */
+	__pci_restore_pcie_state(dev);
+
 	/*
 	 * The Base Address register should be programmed before the command
 	 * register(s)

-- 
MST
