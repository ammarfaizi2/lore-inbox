Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbVGFHEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbVGFHEO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 03:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbVGFHEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 03:04:13 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:59067 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262050AbVGFFSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 01:18:05 -0400
Message-ID: <42CB6A4B.9000906@jp.fujitsu.com>
Date: Wed, 06 Jul 2005 14:21:15 +0900
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
Subject: [PATCH 2.6.13-rc1 10/10] IOCHK interface for I/O error handling/detecting
References: <42CB63B2.6000505@jp.fujitsu.com>
In-Reply-To: <42CB63B2.6000505@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[This is 10 of 10 patches, "iochk-10-rwlock.patch"]

- If a read access (i.g. readX/inX) cause a error while SAL
   gathers system data on other processor ,it could be happen
   a bridge error status is marked and vanished in a blink.

   In case of MCA, thanks to rz_always flag, all MCA are
   handled as global, so all processor except one is paused
   during its handling.
   But in case of CPE, as same as other interruption, it
   have to be handled beside of all other active processors.

   Therefore, to avoid such status crash, exclusive control
   between read access and SAL_GET_STATE_INFO is required.

   To realize this, I changed control lock from spin to rw.
   There would be better way, if so, this part should be
   replaced.

Changes from previous one for 2.6.11.11:
   - (non)

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

---

  arch/ia64/kernel/mca.c      |    6 +++---
  arch/ia64/lib/iomap_check.c |   11 ++++++-----
  include/asm-ia64/io.h       |   24 ++++++++++++++++++++++++
  3 files changed, 33 insertions(+), 8 deletions(-)

Index: linux-2.6.13-rc1/arch/ia64/lib/iomap_check.c
===================================================================
--- linux-2.6.13-rc1.orig/arch/ia64/lib/iomap_check.c
+++ linux-2.6.13-rc1/arch/ia64/lib/iomap_check.c
@@ -12,7 +12,7 @@ void iochk_clear(iocookie *cookie, struc
  int  iochk_read(iocookie *cookie);

  struct list_head iochk_devices;
-DEFINE_SPINLOCK(iochk_lock);	/* all works are excluded on this lock */
+DEFINE_RWLOCK(iochk_lock);	/* all works are excluded on this lock */

  static struct pci_dev *search_host_bridge(struct pci_dev *dev);
  static int have_error(struct pci_dev *dev);
@@ -36,14 +36,14 @@ void iochk_clear(iocookie *cookie, struc
  	cookie->dev = dev;
  	cookie->host = search_host_bridge(dev);

-	spin_lock_irqsave(&iochk_lock, flag);
+	write_lock_irqsave(&iochk_lock, flag);
  	if (cookie->host && have_error(cookie->host)) {
  		/* someone under my bridge causes error... */
  		notify_bridge_error(cookie->host);
  		clear_bridge_error(cookie->host);
  	}
  	list_add(&cookie->list, &iochk_devices);
-	spin_unlock_irqrestore(&iochk_lock, flag);
+	write_unlock_irqrestore(&iochk_lock, flag);

  	cookie->error = 0;
  }
@@ -53,12 +53,12 @@ int iochk_read(iocookie *cookie)
  	unsigned long flag;
  	int ret = 0;

-	spin_lock_irqsave(&iochk_lock, flag);
+	write_lock_irqsave(&iochk_lock, flag);
  	if ( cookie->error || have_error(cookie->dev)
  		|| (cookie->host && have_error(cookie->host)) )
  		ret = 1;
  	list_del(&cookie->list);
-	spin_unlock_irqrestore(&iochk_lock, flag);
+	write_unlock_irqrestore(&iochk_lock, flag);

  	return ret;
  }
@@ -162,6 +162,7 @@ void save_bridge_error(void)
  	}
  }

+EXPORT_SYMBOL(iochk_lock);
  EXPORT_SYMBOL(iochk_read);
  EXPORT_SYMBOL(iochk_clear);
  EXPORT_SYMBOL(iochk_devices);	/* for MCA driver */
Index: linux-2.6.13-rc1/include/asm-ia64/io.h
===================================================================
--- linux-2.6.13-rc1.orig/include/asm-ia64/io.h
+++ linux-2.6.13-rc1/include/asm-ia64/io.h
@@ -73,6 +73,7 @@ extern unsigned int num_io_spaces;

  #ifdef CONFIG_IOMAP_CHECK
  #include <linux/list.h>
+#include <linux/spinlock.h>

  /* ia64 iocookie */
  typedef struct {
@@ -82,6 +83,8 @@ typedef struct {
  	unsigned long		error;	/* error flag */
  } iocookie;

+extern rwlock_t iochk_lock;  /* see arch/ia64/lib/iomap_check.c */
+
  /* Enable ia64 iochk - See arch/ia64/lib/iomap_check.c */
  #define HAVE_ARCH_IOMAP_CHECK

@@ -196,10 +199,13 @@ ___ia64_inb (unsigned long port)
  {
  	volatile unsigned char *addr = __ia64_mk_io_addr(port);
  	unsigned char ret;
+	unsigned long flags;

+	read_lock_irqsave(&iochk_lock,flags);
  	ret = *addr;
  	__ia64_mf_a();
  	ia64_mca_barrier(ret);
+	read_unlock_irqrestore(&iochk_lock,flags);

  	return ret;
  }
@@ -209,10 +215,13 @@ ___ia64_inw (unsigned long port)
  {
  	volatile unsigned short *addr = __ia64_mk_io_addr(port);
  	unsigned short ret;
+	unsigned long flags;

+	read_lock_irqsave(&iochk_lock,flags);
  	ret = *addr;
  	__ia64_mf_a();
  	ia64_mca_barrier(ret);
+	read_unlock_irqrestore(&iochk_lock,flags);

  	return ret;
  }
@@ -222,10 +231,13 @@ ___ia64_inl (unsigned long port)
  {
  	volatile unsigned int *addr = __ia64_mk_io_addr(port);
  	unsigned int ret;
+	unsigned long flags;

+	read_lock_irqsave(&iochk_lock,flags);
  	ret = *addr;
  	__ia64_mf_a();
  	ia64_mca_barrier(ret);
+	read_unlock_irqrestore(&iochk_lock,flags);

  	return ret;
  }
@@ -390,9 +402,12 @@ static inline unsigned char
  ___ia64_readb (const volatile void __iomem *addr)
  {
  	unsigned char val;
+	unsigned long flags;

+	read_lock_irqsave(&iochk_lock,flags);
  	val = *(volatile unsigned char __force *)addr;
  	ia64_mca_barrier(val);
+	read_unlock_irqrestore(&iochk_lock,flags);

  	return val;
  }
@@ -401,9 +416,12 @@ static inline unsigned short
  ___ia64_readw (const volatile void __iomem *addr)
  {
  	unsigned short val;
+	unsigned long flags;

+	read_lock_irqsave(&iochk_lock,flags);
  	val = *(volatile unsigned short __force *)addr;
  	ia64_mca_barrier(val);
+	read_unlock_irqrestore(&iochk_lock,flags);

  	return val;
  }
@@ -412,9 +430,12 @@ static inline unsigned int
  ___ia64_readl (const volatile void __iomem *addr)
  {
  	unsigned int val;
+	unsigned long flags;

+	read_lock_irqsave(&iochk_lock,flags);
  	val = *(volatile unsigned int __force *) addr;
  	ia64_mca_barrier(val);
+	read_unlock_irqrestore(&iochk_lock,flags);

  	return val;
  }
@@ -423,9 +444,12 @@ static inline unsigned long
  ___ia64_readq (const volatile void __iomem *addr)
  {
  	unsigned long val;
+	unsigned long flags;

+	read_lock_irqsave(&iochk_lock,flags);
  	val = *(volatile unsigned long __force *) addr;
  	ia64_mca_barrier(val);
+	read_unlock_irqrestore(&iochk_lock,flags);

  	return val;
  }
Index: linux-2.6.13-rc1/arch/ia64/kernel/mca.c
===================================================================
--- linux-2.6.13-rc1.orig/arch/ia64/kernel/mca.c
+++ linux-2.6.13-rc1/arch/ia64/kernel/mca.c
@@ -81,7 +81,7 @@
  #include <linux/pci.h>
  extern void notify_bridge_error(struct pci_dev *bridge);
  extern void save_bridge_error(void);
-extern spinlock_t iochk_lock;
+extern rwlock_t iochk_lock;
  #endif

  #if defined(IA64_MCA_DEBUG_INFO)
@@ -306,10 +306,10 @@ ia64_mca_cpe_int_handler (int cpe_irq, v
  	 * the states from changing by any other I/Os running simultaneously,
  	 * so this should be handled w/ lock and interrupts disabled.
  	 */
-	spin_lock(&iochk_lock);
+	write_lock(&iochk_lock);
  	save_bridge_error();
  	ia64_mca_log_sal_error_record(SAL_INFO_TYPE_CPE);
-	spin_unlock(&iochk_lock);
+	write_unlock(&iochk_lock);

  	/* Rests can go w/ interrupt enabled as usual */
  	local_irq_enable();

