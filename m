Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262692AbUKLXZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262692AbUKLXZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262685AbUKLXZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:25:16 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:52374 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262692AbUKLXWq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:46 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017181025@kroah.com>
Date: Fri, 12 Nov 2004 15:21:58 -0800
Message-Id: <11003017181959@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2091.1.4, 2004/11/12 14:01:32-08:00, thockin@google.com

[PATCH] PCI: small PCI probe patch for odd 64 bit BARs

On Thu, Nov 11, 2004 at 09:54:19AM -0800, Greg KH wrote:
> I'll wait till you test this on 2.6 before applying it.

OK.  Tested now on real hardware in 32 bit and 64 bit kernels.  32 bit
found another dumbness, that we can fix up.

Some PCI bridges default their UPPER prefetch windows to an unused state
of base > limit.  We should not use those values if we find that.  It
might be nice to reprogram them to 0, in fact.

Yes, BIOS should fix that up, but apparently, some do not.


Signed-Off-By: Tim Hockin <thockin@google.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/probe.c |   28 +++++++++++++++++++---------
 1 files changed, 19 insertions(+), 9 deletions(-)


diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	2004-11-12 15:11:34 -08:00
+++ b/drivers/pci/probe.c	2004-11-12 15:11:34 -08:00
@@ -144,9 +144,11 @@
 			pci_write_config_dword(dev, reg+4, ~0);
 			pci_read_config_dword(dev, reg+4, &sz);
 			pci_write_config_dword(dev, reg+4, l);
-			if (~sz)
-				res->end = res->start + 0xffffffff +
-						(((unsigned long) ~sz) << 32);
+			sz = pci_size(l, sz, 0xffffffff);
+			if (sz) {
+				/* This BAR needs > 4GB?  Wow. */
+				res->end |= (unsigned long)sz<<32;
+			}
 #else
 			if (l) {
 				printk(KERN_ERR "PCI: Unable to handle 64-bit address for device %s\n", pci_name(dev));
@@ -243,15 +245,23 @@
 		u32 mem_base_hi, mem_limit_hi;
 		pci_read_config_dword(dev, PCI_PREF_BASE_UPPER32, &mem_base_hi);
 		pci_read_config_dword(dev, PCI_PREF_LIMIT_UPPER32, &mem_limit_hi);
+
+		/*
+		 * Some bridges set the base > limit by default, and some
+		 * (broken) BIOSes do not initialize them.  If we find
+		 * this, just assume they are not being used.
+		 */
+		if (mem_base_hi <= mem_limit_hi) {
 #if BITS_PER_LONG == 64
-		base |= ((long) mem_base_hi) << 32;
-		limit |= ((long) mem_limit_hi) << 32;
+			base |= ((long) mem_base_hi) << 32;
+			limit |= ((long) mem_limit_hi) << 32;
 #else
-		if (mem_base_hi || mem_limit_hi) {
-			printk(KERN_ERR "PCI: Unable to handle 64-bit address space for %s\n", child->name);
-			return;
-		}
+			if (mem_base_hi || mem_limit_hi) {
+				printk(KERN_ERR "PCI: Unable to handle 64-bit address space for bridge %s\n", pci_name(dev));
+				return;
+			}
 #endif
+		}
 	}
 	if (base <= limit) {
 		res->flags = (mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) | IORESOURCE_MEM | IORESOURCE_PREFETCH;

