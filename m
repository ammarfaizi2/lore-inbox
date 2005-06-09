Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262392AbVFINDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbVFINDD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 09:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbVFINCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 09:02:15 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:44012 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262384AbVFIMy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 08:54:59 -0400
Message-ID: <42A83CF2.90304@jp.fujitsu.com>
Date: Thu, 09 Jun 2005 21:58:26 +0900
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
Subject: [PATCH 07/10] IOCHK interface for I/O error handling/detecting
References: <42A8386F.2060100@jp.fujitsu.com>
In-Reply-To: <42A8386F.2060100@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[This is 7 of 10 patches, "iochk-07-poison.patch"]

- When bus-error occur on write, write data is broken on
   the bus, so target device gets broken data.

   There are 2 way for such device to take:
    - send PERR(Parity Error) to host, expecting immediate panic.
    - mark status register as error, expecting its driver to read
      it and decide to retry.

   So it is not difficult for drivers to recover from error on
   write if it can take latter way, and if it don't worry about
   taking time to wait completion of write.

- When bus-error occur on read, read data is broken on
   the bus, so host bridge gets broken data.

   There are 2 way for such bridge to take:
    - send BERR(Bus Error) to host, expecting immediate panic.
    - mark data as "poisoned" and throw it to destination,
      expecting panic if system touched it but cannot stop data
      pollution.

   Former is traditional way, latter is modern way, called
   "data poisoning". The important difference is whether OS
   can get a chance to recover from the error.
   Usually, sending BERR doesn't tell us "where it comes",
   "who it orders", so we cannot do anything except panic.
   In the other hand, poisoned data will reach its destination
   and will cause a error on there again. Yes, destination is
   "where who lives".

   Well, the idea is quite simple:
    "driver checks read data, and recover if it was poisoned."

   Checking all read at once (ex. take a memo of all read
   addresses touched after iochk_clear and check them all in
   iochk_read) does not make sense. Practical way is check
   each read, keep its result, and read it at end.

Touching poisoned data become a MCA, so now it directly means
a system down. But since the MCA tells us "where it happens",
we can recover it...? All right, let's see next (8 of 10).

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

---

  include/asm-ia64/io.h |  110 ++++++++++++++++++++++++++++++++++++++++++++++++++
  1 files changed, 110 insertions(+)

Index: linux-2.6.11.11/include/asm-ia64/io.h
===================================================================
--- linux-2.6.11.11.orig/include/asm-ia64/io.h
+++ linux-2.6.11.11/include/asm-ia64/io.h
@@ -86,6 +86,20 @@ typedef struct __iocookie iocookie;
  /* enable ia64 iochk - See arch/ia64/lib/iomap_check.c */
  #define HAVE_ARCH_IOMAP_CHECK

+/*
+ * Some I/O bridges may poison the data read, instead of
+ * signaling a BERR.  The consummation of poisoned data
+ * triggers a local, imprecise MCA.
+ * Note that the read operation by itself does not consume
+ * the bad data, you have to do something with it, e.g.:
+ *
+ *	ld.8	r9=[r10];;	// r10 == I/O address
+ *	add.8	r8=r9,r9;;	// fake operation
+ */
+#define ia64_poison_check(val)					\
+{	register unsigned long gr8 asm("r8");			\
+	asm volatile ("add %0=%1,r0" : "=r"(gr8) : "r"(val)); }
+
  #endif /* CONFIG_IOMAP_CHECK  */

  #include <asm-generic/iomap.h>
@@ -190,6 +204,8 @@ __ia64_mk_io_addr (unsigned long port)
   * during optimization, which is why we use "volatile" pointers.
   */

+#ifdef CONFIG_IOMAP_CHECK
+
  static inline unsigned int
  ___ia64_inb (unsigned long port)
  {
@@ -198,6 +214,8 @@ ___ia64_inb (unsigned long port)

  	ret = *addr;
  	__ia64_mf_a();
+	ia64_poison_check(ret);
+
  	return ret;
  }

@@ -209,6 +227,8 @@ ___ia64_inw (unsigned long port)

  	ret = *addr;
  	__ia64_mf_a();
+	ia64_poison_check(ret);
+
  	return ret;
  }

@@ -220,9 +240,48 @@ ___ia64_inl (unsigned long port)

  	ret = *addr;
  	__ia64_mf_a();
+	ia64_poison_check(ret);
+
+	return ret;
+}
+
+#else /* CONFIG_IOMAP_CHECK */
+
+static inline unsigned int
+___ia64_inb (unsigned long port)
+{
+	volatile unsigned char *addr = __ia64_mk_io_addr(port);
+	unsigned char ret;
+
+	ret = *addr;
+	__ia64_mf_a();
  	return ret;
  }

+static inline unsigned int
+___ia64_inw (unsigned long port)
+{
+	volatile unsigned short *addr = __ia64_mk_io_addr(port);
+	unsigned short ret;
+
+	ret = *addr;
+	__ia64_mf_a();
+	return ret;
+}
+
+static inline unsigned int
+___ia64_inl (unsigned long port)
+{
+	volatile unsigned int *addr = __ia64_mk_io_addr(port);
+	unsigned int ret;
+
+	ret = *addr;
+	__ia64_mf_a();
+	return ret;
+}
+
+#endif /* CONFIG_IOMAP_CHECK */
+
  static inline void
  ___ia64_outb (unsigned char val, unsigned long port)
  {
@@ -339,6 +398,55 @@ __outsl (unsigned long port, const void
   * a good idea).  Writes are ok though for all existing ia64 platforms (and
   * hopefully it'll stay that way).
   */
+
+#ifdef CONFIG_IOMAP_CHECK
+
+static inline unsigned char
+___ia64_readb (const volatile void __iomem *addr)
+{
+	unsigned char val;
+
+	val = *(volatile unsigned char __force *)addr;
+	ia64_poison_check(val);
+
+	return val;
+}
+
+static inline unsigned short
+___ia64_readw (const volatile void __iomem *addr)
+{
+	unsigned short val;
+
+	val = *(volatile unsigned short __force *)addr;
+	ia64_poison_check(val);
+
+	return val;
+}
+
+static inline unsigned int
+___ia64_readl (const volatile void __iomem *addr)
+{
+	unsigned int val;
+
+	val = *(volatile unsigned int __force *) addr;
+	ia64_poison_check(val);
+
+	return val;
+}
+
+static inline unsigned long
+___ia64_readq (const volatile void __iomem *addr)
+{
+	unsigned long val;
+
+	val = *(volatile unsigned long __force *) addr;
+	ia64_poison_check(val);
+
+	return val;
+}
+
+#else /* CONFIG_IOMAP_CHECK */
+
  static inline unsigned char
  ___ia64_readb (const volatile void __iomem *addr)
  {
@@ -363,6 +471,8 @@ ___ia64_readq (const volatile void __iom
  	return *(volatile unsigned long __force *) addr;
  }

+#endif /* CONFIG_IOMAP_CHECK */
+
  static inline void
  __writeb (unsigned char val, volatile void __iomem *addr)
  {

