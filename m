Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262360AbUKKU7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbUKKU7H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 15:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbUKKU7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 15:59:07 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:3558 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S262360AbUKKU7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 15:59:00 -0500
Date: Thu, 11 Nov 2004 12:58:52 -0800
From: Tim Hockin <thockin@google.com>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: small PCI probe patch for odd 64 bit BARs
Message-ID: <20041111205852.GP19615@google.com>
References: <20041111044809.GE19615@google.com> <20041110215142.3a81b426.akpm@osdl.org> <20041111173901.GH19615@google.com> <20041111175418.GA18811@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041111175418.GA18811@kroah.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 09:54:19AM -0800, Greg KH wrote:
> I'll wait till you test this on 2.6 before applying it.

OK.  Tested now on real hardware in 32 bit and 64 bit kernels.  32 bit
found another dumbness, that we can fix up.

Some PCI bridges default their UPPER prefetch windows to an unused state
of base > limit.  We should not use those values if we find that.  It
might be nice to reprogram them to 0, in fact.

Yes, BIOS should fix that up, but apparently, some do not.

Tim

Signed-Off-By: Tim Hockin <thockin@google.com>



--- linux-2.6.9/drivers/pci/probe.c.orig	2004-11-11 12:50:06.000000000 -0800
+++ linux-2.6.9/drivers/pci/probe.c	2004-11-11 12:53:33.000000000 -0800
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
