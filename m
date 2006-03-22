Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWCVIhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWCVIhu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 03:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWCVIhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 03:37:50 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:47318 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751098AbWCVIht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 03:37:49 -0500
Message-ID: <44210D1B.7010806@jp.fujitsu.com>
Date: Wed, 22 Mar 2006 17:38:51 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
CC: Greg KH <greg@kroah.com>
Subject: [PATCH] PCIERR : interfaces for synchronous I/O error detection on
 driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch proposes new interfaces, that known by few as iochk_*,
for synchronous I/O error detection on PCI drivers.

At 2.6.16-rc1, Linux kernel accepts and provides "PCI-bus error event
callbacks" that enable RAS-aware drivers to notice errors asynchronously,
and to join following kernel-initiated PCI-bus error recovery.
This callbacks work well on PPC64 where it was designed to fit.

However, some difficulty still remains to cover all possible error
situations even if we use callbacks. It will not help keeping data
integrity, passing no broken data to drivers and user lands, preventing
applications from going crazy or sudden death.

I suppose that proposed interfaces will solve most of remaining issues.
It would be FAQ that what is the difference between this interfaces and
the callback. Following list would help you:

** Feature 1: Asynchronous error event callbacks:
  - written by Linas Vepstas
  - patch was already accepted (2.6.16-rc1)
  - designed for "Error Recovery":
    Interface for asynchronous error recovery (such as bus reset)
    on other context after an serious error occurrences.
    This will be effective if system needs complex taking-time recovery,
    ex. re-enabling erroneous PCI-bus.
  - It will be useful if the arch supports bus-isolating and can continue
    running after such isolation, limiting a part of its services.
  - i.e. this feature improves Serviceability.
  - drivers can use this feature by constructing struct pci_error_handlers
    with its callbacks and register it in struct pci_driver of itself.

** Feature 2: Synchronous error detect interfaces:
  - written by Hidetoshi Seto
  - patch is not accepted yet.
  - designed for "Error Detection":
    Interface for synchronous error detection on same context
    and prevent system from data pollution on any error occurrences.
    This will be effective if system doesn't require complex recovery,
    ex. retrying I/O after trivial soft error, or re-issuing I/O if it
    gets poisoned data (forwarded error from PCI-Express).
  - It will be useful if arch chooses panic on bus errors not to pass
    any broken data to un-reliable drivers.
  - i.e. this feature improves Availability by keeping data integrity.
  - drivers can use this feature by clipping its I/O by *_clear/read call
    and checking the return value after all.

Following patch adds definition of interfaces described as Feature 2.
(They were renamed from iochk_* to pcierr_*, and located in pci.h.)
There are no more patch for generic part. The core implementation is
architecture dependent. You will get proper error status only on arch
where supports and implements this feature. Or you will get always 0,
means "no errors".

Thanks,
H.Seto

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

-----

  include/linux/pci.h |   15 +++++++++++++++
  1 files changed, 15 insertions(+)

Index: linux-2.6.16_WORK/include/linux/pci.h
===================================================================
--- linux-2.6.16_WORK.orig/include/linux/pci.h	2006-03-22 14:27:04.000000000 +0900
+++ linux-2.6.16_WORK/include/linux/pci.h	2006-03-22 14:41:01.000000000 +0900
@@ -696,6 +696,21 @@
  #endif /* HAVE_ARCH_PCI_RESOURCE_TO_USER */


+/* PCIERR_CHECK provides additional interfaces for drivers to detect
+ * some IO errors, to support drivers can handle errors properly.
+ * Some archs requiring high-reliability would implement these.
+ */
+#ifdef HAVE_ARCH_PCIERR_CHECK
+/* type of iocookie is arch dependent */
+extern void pcierr_clear(iocookie *cookie, struct pci_dev *dev);
+extern int pcierr_read(iocookie *cookie);
+#else
+typedef int iocookie;
+static inline void pcierr_clear(iocookie *cookie, struct pci_dev *dev) {}
+static inline int pcierr_read(iocookie *cookie) { return 0; }
+#endif
+
+
  /*
   *  The world is not perfect and supplies us with broken PCI devices.
   *  For at least a part of these bugs we need a work-around, so both

