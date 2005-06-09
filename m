Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbVFIMyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbVFIMyT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 08:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVFIMyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 08:54:10 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:53736 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261335AbVFIMtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 08:49:14 -0400
Message-ID: <42A83B6D.8010703@jp.fujitsu.com>
Date: Thu, 09 Jun 2005 21:51:57 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Cc: Linas Vepstas <linas@austin.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH 03/10] IOCHK interface for I/O error handling/detecting
References: <42A8386F.2060100@jp.fujitsu.com>
In-Reply-To: <42A8386F.2060100@jp.fujitsu.com>
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

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

---

  arch/ia64/lib/iomap_check.c |   54 ++++++++++++++++++++++++++++++++++++++++++--
  include/asm-ia64/io.h       |    8 +++++-
  2 files changed, 59 insertions(+), 3 deletions(-)

Index: linux-2.6.11.11/arch/ia64/lib/iomap_check.c
===================================================================
--- linux-2.6.11.11.orig/arch/ia64/lib/iomap_check.c
+++ linux-2.6.11.11/arch/ia64/lib/iomap_check.c
@@ -4,24 +4,74 @@
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
+	if( cookie->error || have_error(cookie->dev) )
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
Index: linux-2.6.11.11/include/asm-ia64/io.h
===================================================================
--- linux-2.6.11.11.orig/include/asm-ia64/io.h
+++ linux-2.6.11.11/include/asm-ia64/io.h
@@ -72,9 +72,15 @@ extern unsigned int num_io_spaces;
  #include <asm/system.h>

  #ifdef CONFIG_IOMAP_CHECK
+#include <linux/list.h>

  /* definition of ia64 iocookie */
-typedef unsigned long iocookie;
+struct __iocookie {
+	struct list_head	list;
+	struct pci_dev		*dev;	/* targeting device */
+	unsigned long		error;	/* error flag */
+};
+typedef struct __iocookie iocookie;

  /* enable ia64 iochk - See arch/ia64/lib/iomap_check.c */
  #define HAVE_ARCH_IOMAP_CHECK

