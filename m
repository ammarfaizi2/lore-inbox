Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262169AbVGFGjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbVGFGjP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 02:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbVGFGgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 02:36:43 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:63416 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262116AbVGFFJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 01:09:04 -0400
Message-ID: <42CB680E.2010103@jp.fujitsu.com>
Date: Wed, 06 Jul 2005 14:11:42 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>
CC: Linas Vepstas <linas@austin.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH 2.6.13-rc1 05/10] IOCHK interface for I/O error handling/detecting
References: <42CB63B2.6000505@jp.fujitsu.com>
In-Reply-To: <42CB63B2.6000505@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[This is 5 of 10 patches, "iochk-05-check_bridge.patch"]

- Consider three devices, A, B, and C are placed under a same
   host bridge H. After A and B checked-in (=passed iochk_clear,
   doing some I/Os, not come to call iochk_read yet), now C is
   going to check-in, just entered iochk_clear, but C finds out
   that H indicates error.

   It means that A or B hits a bus error, but there is no data
   which one actually hits the error. So, C should notify the
   error to both of A and B, and clear the H's status to start
   its own I/Os.

   If there are only two devices, it become more simple. It is
   clear if one find a bridge error while another is check-in,
   the error is nothing except for another's.

Well, works concerning registers (devices and bridges) are
almost shaped up. So, from next, I'll move to deep phase
to implement more arch-specific codes... see next (6 of 10).

Changes from previous one for 2.6.11.11:
   - (non)

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

---

  arch/ia64/lib/iomap_check.c |   45 ++++++++++++++++++++++++++++++++++++++++++++
  1 files changed, 45 insertions(+)

Index: linux-2.6.13-rc1/arch/ia64/lib/iomap_check.c
===================================================================
--- linux-2.6.13-rc1.orig/arch/ia64/lib/iomap_check.c
+++ linux-2.6.13-rc1/arch/ia64/lib/iomap_check.c
@@ -17,6 +17,9 @@ DEFINE_SPINLOCK(iochk_lock);	/* all work
  static struct pci_dev *search_host_bridge(struct pci_dev *dev);
  static int have_error(struct pci_dev *dev);

+void notify_bridge_error(struct pci_dev *bridge);
+void clear_bridge_error(struct pci_dev *bridge);
+
  void iochk_init(void)
  {
  	/* setup */
@@ -33,6 +36,11 @@ void iochk_clear(iocookie *cookie, struc
  	cookie->host = search_host_bridge(dev);

  	spin_lock_irqsave(&iochk_lock, flag);
+	if (cookie->host && have_error(cookie->host)) {
+		/* someone under my bridge causes error... */
+		notify_bridge_error(cookie->host);
+		clear_bridge_error(cookie->host);
+	}
  	list_add(&cookie->list, &iochk_devices);
  	spin_unlock_irqrestore(&iochk_lock, flag);

@@ -95,5 +103,42 @@ static int have_error(struct pci_dev *de
  	return 0;
  }

+void notify_bridge_error(struct pci_dev *bridge)
+{
+	iocookie *cookie;
+
+	if (list_empty(&iochk_devices))
+		return;
+
+	/* notify error to all transactions using this host bridge */
+	if (bridge) {
+		/* local notify, ex. Parity, Abort etc. */
+		list_for_each_entry(cookie, &iochk_devices, list) {
+			if (cookie->host == bridge)
+				cookie->error = 1;
+		}
+	}
+}
+
+void clear_bridge_error(struct pci_dev *bridge)
+{
+	u16 status = ( PCI_STATUS_REC_TARGET_ABORT
+                     | PCI_STATUS_REC_MASTER_ABORT
+                     | PCI_STATUS_DETECTED_PARITY );
+
+	/* clear bridge status */
+	switch (bridge->hdr_type) {
+		case PCI_HEADER_TYPE_NORMAL: /* 0 */
+			pci_write_config_word(bridge, PCI_STATUS, status);
+			break;
+		case PCI_HEADER_TYPE_BRIDGE: /* 1 */
+			pci_write_config_word(bridge, PCI_SEC_STATUS, status);
+			break;
+		case PCI_HEADER_TYPE_CARDBUS: /* 2 */
+			default:
+			BUG();
+	}
+}
+
  EXPORT_SYMBOL(iochk_read);
  EXPORT_SYMBOL(iochk_clear);

