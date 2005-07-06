Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbVGFGeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbVGFGeu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 02:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbVGFGeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 02:34:50 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:31708 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262049AbVGFFAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 01:00:46 -0400
Message-ID: <42CB664E.1050003@jp.fujitsu.com>
Date: Wed, 06 Jul 2005 14:04:14 +0900
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
Subject: [PATCH 2.6.13-rc1 03/10] IOCHK interface for I/O error handling/detecting
References: <42CB63B2.6000505@jp.fujitsu.com>
In-Reply-To: <42CB63B2.6000505@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[This is 3 of 10 patches, "iochk-03-register.patch"]

- Implement ia64 version of basic codes:
     iochk_clear, iochk_read, iochk_init, and iocookie

   The direction is:

     - Have a "now in check" global list, "iochk_devices",
       for future use.

     - Take a lock, "iochk_lock", to protect the global list.

     - iochk_clear packs *dev into iocookie, and add it to
       the global list. After all prepared, clear error-flag
       in cookie to start io-critical-session.

     - iochk_read checks error-flag and device's status
       register. After removing iocookie from list, return
       the result.

This is too simple. We need more codes... See next (4 of 10).

Changes from previous one for 2.6.11.11:
   - trivial coding style fix.

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

---

  arch/ia64/lib/iomap_check.c |   55 ++++++++++++++++++++++++++++++++++++++++++--
  include/asm-ia64/io.h       |    5 +++-
  2 files changed, 57 insertions(+), 3 deletions(-)

Index: linux-2.6.13-rc1/arch/ia64/lib/iomap_check.c
===================================================================
--- linux-2.6.13-rc1.orig/arch/ia64/lib/iomap_check.c
+++ linux-2.6.13-rc1/arch/ia64/lib/iomap_check.c
@@ -4,24 +4,75 @@
   */

  #include <linux/pci.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>

  void iochk_init(void);
  void iochk_clear(iocookie *cookie, struct pci_dev *dev);
  int  iochk_read(iocookie *cookie);

+struct list_head iochk_devices;
+DEFINE_SPINLOCK(iochk_lock);	/* all works are excluded on this lock */
+
+static int have_error(struct pci_dev *dev);
+
  void iochk_init(void)
  {
  	/* setup */
+	INIT_LIST_HEAD(&iochk_devices);
  }

  void iochk_clear(iocookie *cookie, struct pci_dev *dev)
  {
-	/* register device etc. */
+	unsigned long flag;
+
+	INIT_LIST_HEAD(&(cookie->list));
+
+	cookie->dev = dev;
+
+	spin_lock_irqsave(&iochk_lock, flag);
+	list_add(&cookie->list, &iochk_devices);
+	spin_unlock_irqrestore(&iochk_lock, flag);
+
+	cookie->error = 0;
  }

  int iochk_read(iocookie *cookie)
  {
-	/* check error etc. */
+	unsigned long flag;
+	int ret = 0;
+
+	spin_lock_irqsave(&iochk_lock, flag);
+	if (cookie->error || have_error(cookie->dev))
+		ret = 1;
+	list_del(&cookie->list);
+	spin_unlock_irqrestore(&iochk_lock, flag);
+
+	return ret;
+}
+
+static int have_error(struct pci_dev *dev)
+{
+	u16 status;
+
+	/* check status */
+	switch (dev->hdr_type) {
+	case PCI_HEADER_TYPE_NORMAL: /* 0 */
+		pci_read_config_word(dev, PCI_STATUS, &status);
+		break;
+	case PCI_HEADER_TYPE_BRIDGE: /* 1 */
+		pci_read_config_word(dev, PCI_SEC_STATUS, &status);
+		break;
+	case PCI_HEADER_TYPE_CARDBUS: /* 2 */
+		return 0; /* FIX ME */
+	default:
+		BUG();
+	}
+
+	if ( (status & PCI_STATUS_REC_TARGET_ABORT)
+		|| (status & PCI_STATUS_REC_MASTER_ABORT)
+		|| (status & PCI_STATUS_DETECTED_PARITY) )
+		return 1;

  	return 0;
  }
Index: linux-2.6.13-rc1/include/asm-ia64/io.h
===================================================================
--- linux-2.6.13-rc1.orig/include/asm-ia64/io.h
+++ linux-2.6.13-rc1/include/asm-ia64/io.h
@@ -72,10 +72,13 @@ extern unsigned int num_io_spaces;
  #include <asm/system.h>

  #ifdef CONFIG_IOMAP_CHECK
+#include <linux/list.h>

  /* ia64 iocookie */
  typedef struct {
-	int dummy;
+	struct list_head	list;
+	struct pci_dev		*dev;	/* target device */
+	unsigned long		error;	/* error flag */
  } iocookie;

  /* Enable ia64 iochk - See arch/ia64/lib/iomap_check.c */

