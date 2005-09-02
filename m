Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbVIBKdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbVIBKdN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 06:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbVIBKdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 06:33:13 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:57290 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030243AbVIBKdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 06:33:10 -0400
Message-ID: <43182A55.1000702@jp.fujitsu.com>
Date: Fri, 02 Sep 2005 19:32:53 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-ia64@vger.kernel.org
CC: Brent Casavant <bcasavan@sgi.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 2/2] IOCHK interface for I/O error handling/detecting
 (for ia64)
References: <431694DB.90400@jp.fujitsu.com> <20050901172917.I10072@chenjesu.americas.sgi.com>
In-Reply-To: <20050901172917.I10072@chenjesu.americas.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements ia64-specific IOCHK interfaces that enable
PCI drivers to detect error and make their error handling easier.

Please refer archives if you need, e.g. http://lwn.net/Articles/139240/

This is the latter part of original patch, CPE and SAL call related
codes which prevents host bridge status from unexpected clear.
Because SAL_GET_STATE_INFO for CPE might clear bridge states in
process of gathering error information from the system, we should
check the states before clearing it.
While OS and SAL are handling bridge status, we have to protect
the states from changing by any other I/Os running simultaneously.
In the opposite sight, we have to protect the status from cleaning
by such SAL call before it be checked.

As pointed by Brent, the implementation of this latter half wouldn't
be enough to use in huge boxes.  Even though this code still have
some benefit depends on the situation.

Comments, to this paranoia part, are welcomed.

Thanks,
H.Seto

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

---

  arch/ia64/kernel/mca.c      |   21 +++++++++++++++++++++
  arch/ia64/lib/iomap_check.c |   28 +++++++++++++++++++++++-----
  include/asm-ia64/io.h       |   24 ++++++++++++++++++++++++
  3 files changed, 68 insertions(+), 5 deletions(-)

Index: linux-2.6.13/arch/ia64/lib/iomap_check.c
===================================================================
--- linux-2.6.13.orig/arch/ia64/lib/iomap_check.c
+++ linux-2.6.13/arch/ia64/lib/iomap_check.c
@@ -12,13 +12,14 @@ void iochk_clear(iocookie *cookie, struc
  int  iochk_read(iocookie *cookie);

  struct list_head iochk_devices;
-DEFINE_SPINLOCK(iochk_lock);	/* all works are excluded on this lock */
+DEFINE_RWLOCK(iochk_lock);	/* all works are excluded on this lock */

  static struct pci_dev *search_host_bridge(struct pci_dev *dev);
  static int have_error(struct pci_dev *dev);

  void notify_bridge_error(struct pci_dev *bridge);
  void clear_bridge_error(struct pci_dev *bridge);
+void save_bridge_error(void);

  void iochk_init(void)
  {
@@ -35,14 +36,14 @@ void iochk_clear(iocookie *cookie, struc
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
@@ -52,12 +53,12 @@ int iochk_read(iocookie *cookie)
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
@@ -145,6 +146,23 @@ void clear_bridge_error(struct pci_dev *
  	}
  }

+void save_bridge_error(void)
+{
+	iocookie *cookie;
+
+	if (list_empty(&iochk_devices))
+		return;
+
+	/* mark devices if its root bus bridge have errors */
+	list_for_each_entry(cookie, &iochk_devices, list) {
+		if (cookie->error)
+			continue;
+		if (have_error(cookie->host))
+			notify_bridge_error(cookie->host);
+	}
+}
+
+EXPORT_SYMBOL(iochk_lock);
  EXPORT_SYMBOL(iochk_read);
  EXPORT_SYMBOL(iochk_clear);
  EXPORT_SYMBOL(iochk_devices);	/* for MCA driver */
Index: linux-2.6.13/arch/ia64/kernel/mca.c
===================================================================
--- linux-2.6.13.orig/arch/ia64/kernel/mca.c
+++ linux-2.6.13/arch/ia64/kernel/mca.c
@@ -80,6 +80,8 @@
  #ifdef CONFIG_IOMAP_CHECK
  #include <linux/pci.h>
  extern void notify_bridge_error(struct pci_dev *bridge);
+extern void save_bridge_error(void);
+extern rwlock_t iochk_lock;
  #endif

  #if defined(IA64_MCA_DEBUG_INFO)
@@ -288,11 +290,30 @@ ia64_mca_cpe_int_handler (int cpe_irq, v
  	IA64_MCA_DEBUG("%s: received interrupt vector = %#x on CPU %d\n",
  		       __FUNCTION__, cpe_irq, smp_processor_id());

+#ifndef CONFIG_IOMAP_CHECK
+
  	/* SAL spec states this should run w/ interrupts enabled */
  	local_irq_enable();

  	/* Get the CPE error record and log it */
  	ia64_mca_log_sal_error_record(SAL_INFO_TYPE_CPE);
+#else
+	/*
+	 * Because SAL_GET_STATE_INFO for CPE might clear bridge states
+	 * in process of gathering error information from the system,
+	 * we should check the states before clearing it.
+	 * While OS and SAL are handling bridge status, we have to protect
+	 * the states from changing by any other I/Os running simultaneously,
+	 * so this should be handled w/ lock and interrupts disabled.
+	 */
+	write_lock(&iochk_lock);
+	save_bridge_error();
+	ia64_mca_log_sal_error_record(SAL_INFO_TYPE_CPE);
+	write_unlock(&iochk_lock);
+
+	/* Rests can go w/ interrupt enabled as usual */
+	local_irq_enable();
+#endif

  	spin_lock(&cpe_history_lock);
  	if (!cpe_poll_enabled && cpe_vector >= 0) {
Index: linux-2.6.13/include/asm-ia64/io.h
===================================================================
--- linux-2.6.13.orig/include/asm-ia64/io.h
+++ linux-2.6.13/include/asm-ia64/io.h
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

@@ -190,10 +193,13 @@ ___ia64_inb (unsigned long port)
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
@@ -203,10 +209,13 @@ ___ia64_inw (unsigned long port)
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
@@ -216,10 +225,13 @@ ___ia64_inl (unsigned long port)
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
@@ -384,9 +396,12 @@ static inline unsigned char
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
@@ -395,9 +410,12 @@ static inline unsigned short
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
@@ -406,9 +424,12 @@ static inline unsigned int
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
@@ -417,9 +438,12 @@ static inline unsigned long
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


