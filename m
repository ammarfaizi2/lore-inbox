Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVCAIbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVCAIbz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 03:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVCAIbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 03:31:55 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:18153 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261448AbVCAIbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 03:31:38 -0500
Message-ID: <422428EC.3090905@jp.fujitsu.com>
Date: Tue, 01 Mar 2005 17:33:48 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linas Vepstas <linas@austin.ibm.com>,
       "Luck, Tony" <tony.luck@intel.com>
Subject: [PATCH/RFC] I/O-check interface for driver's error handling
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, long time no see :-)

Currently, I/O error is not a leading cause of system failure.
However, since Linux nowadays is making great progress on its
scalability, and ever larger number of PCI devices are being
connected to a single high-performance server, the risk of the
I/O error is increasing day by day.

For example, PCI parity error is one of the most common errors
in the hardware world. However, the major cause of parity error
is not hardware's error but software's - low voltage, humidity,
natural radiation... etc. Even though, some platforms are nervous
to parity error enough to shutdown the system immediately on such
error. So if device drivers can retry its transaction once results
as an error, we can reduce the risk of I/O errors.

So I'd like to suggest new interfaces that enable drivers to
check - detect error and retry their I/O transaction easily.

Previously I had post two prototypes to LKML:
1) readX_check() interface
    Added new kin of basic readX(), which returns its result of
    I/O. But, it would not make sense that device driver have to
    check and react after each of I/Os.
2) clear/read_pci_errors() interface
    Added new pair-interface to sandwich I/Os. It makes sense that
    device driver can adjust the number of checking I/Os and can
    react all of them at once. However, this was not generalized,
    so I thought that more expandable design would be required.

Today's patch is 3rd one - iochk_clear/read() interface.
- This also adds pair-interface, but not to sandwich only readX().
   Depends on platform, starting with ioreadX(), inX(), writeX()
   if possible... and so on could be target of error checking.
- Additionally adds special token - abstract "iocookie" structure
   to control/identifies/manage I/Os, by passing it to OS.
   Actual type of "iocookie" could be arch-specific. Device drivers
   could use the iocookie structure without knowing its detail.

Expected usage(sample) is:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#include <linux/pci.h>
#include <asm/io.h>

int sample_read_with_iochk(struct pci_dev *dev, u32 *buf, int words)
{
	unsigned long ofs = pci_resource_start(dev, 0) + DATA_OFFSET;
	int i;

	/* Create magical cookie on the stack */
	iocookie cookie;

	/* Critical section start */
	iochk_clear(&dev, &cookie);
	{
		/* Get the whole packet of data */
		for (i = 0; i < words; i++)
			*buf++ = ioread32(dev, ofs);
	}
	/* Critical section end. Did we have any trouble? */
	if ( iochk_read(&cookie) ) return -1;

	/* OK, all system go. */
	return 0;
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If arch doesn't(or cannot) have its io-checking strategy, these
interfaces could be used as a replacement of local_irq_save/restore
pair. Therefore, driver maintainer can write their driver code with
these interfaces for all arch, even where checking is not implemented.

Followings are "generic" part. Definition of default for all arch
are included. I have another part - "ia64 specific" part, which
against poisoned data read on PCI parity error. I'll post it later.

First, comments about this "generic" part are welcome.

Thanks,
H.Seto

-----

diff -Nur linux-2.6.10-iomap-0/drivers/pci/pci.c linux-2.6.10-iomap-1/drivers/pci/pci.c
--- linux-2.6.10-iomap-0/drivers/pci/pci.c      2005-02-15 15:27:28.000000000 +0900
+++ linux-2.6.10-iomap-1/drivers/pci/pci.c      2005-02-24 16:55:11.000000000 +0900
@@ -747,6 +747,8 @@
         while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
                 pci_fixup_device(pci_fixup_final, dev);
         }
+
+       iochk_init();
         return 0;
  }

diff -Nur linux-2.6.10-iomap-0/include/asm-generic/iomap.h linux-2.6.10-iomap-1/include/asm-generic/iomap.h
--- linux-2.6.10-iomap-0/include/asm-generic/iomap.h    2005-02-15 15:27:27.000000000 +0900
+++ linux-2.6.10-iomap-1/include/asm-generic/iomap.h    2005-02-21 14:40:45.000000000 +0900
@@ -60,4 +60,20 @@
  extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
  extern void pci_iounmap(struct pci_dev *dev, void __iomem *);

+/*
+ * IOMAP_CHECK provides additional interfaces for drivers to detect
+ * some IO errors, supports drivers having ability to recover errors.
+ *
+ * All works around iomap-check depends on the design of "iocookie"
+ * structure. Every architecture owning its iomap-check is free to
+ * define the actual design of iocookie to fit its special style.
+ */
+#ifndef HAVE_ARCH_IOMAP_CHECK
+typedef unsigned long iocookie;
+#endif
+
+extern void    iochk_init(void);
+extern void    iochk_clear(iocookie *cookie, struct pci_dev *dev);
+extern int     iochk_read(iocookie *cookie);
+
  #endif
diff -Nur linux-2.6.10-iomap-0/lib/iomap.c linux-2.6.10-iomap-1/lib/iomap.c
--- linux-2.6.10-iomap-0/lib/iomap.c    2005-02-15 15:27:27.000000000 +0900
+++ linux-2.6.10-iomap-1/lib/iomap.c    2005-02-21 14:38:17.000000000 +0900
@@ -210,3 +210,28 @@
  }
  EXPORT_SYMBOL(pci_iomap);
  EXPORT_SYMBOL(pci_iounmap);
+
+/*
+ * Note that default iochk_clear-read pair interfaces could be used
+ * just as a replacement of traditional local_irq_save-restore pair.
+ * Originally they don't have any effective error check, but some
+ * high-reliable platforms would provide useful information to you.
+ */
+#ifndef HAVE_ARCH_IOMAP_CHECK
+#include <asm/system.h>
+void iochk_init(void) { ; }
+
+void iochk_clear(iocookie *cookie, struct pci_dev *dev)
+{
+       local_irq_save(*cookie);
+}
+
+int iochk_read(iocookie *cookie)
+{
+       local_irq_restore(*cookie);
+       return 0;
+}
+EXPORT_SYMBOL(iochk_init);
+EXPORT_SYMBOL(iochk_clear);
+EXPORT_SYMBOL(iochk_read);
+#endif /* HAVE_ARCH_IOMAP_CHECK */

