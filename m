Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVFZOGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVFZOGF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 10:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVFZOEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 10:04:36 -0400
Received: from isilmar.linta.de ([213.239.214.66]:36332 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261232AbVFZOEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 10:04:23 -0400
Date: Sun, 26 Jun 2005 16:04:12 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Andrew Morton <akpm@osdl.org>, greg@kroah.com, rajesh.shah@intel.com
Cc: linux-kernel@vger.kernel.org
Subject: ACPI-based PCI resources: PCMCIA bugfix, but resources missing in trees
Message-ID: <20050626140411.GA8597@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Andrew Morton <akpm@osdl.org>, greg@kroah.com, rajesh.shah@intel.com,
	linux-kernel@vger.kernel.org
References: <20050626040329.3849cf68.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050626040329.3849cf68.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2005 at 04:03:29AM -0700, Andrew Morton wrote:
> - Lots of merges.  I'm holding off on the 80-odd pcmcia patches until we get
>   the recent PCI breakage sorted out.

pci-yenta-cardbus-fix.patch and the following patch should solve the
initialization time trouble. However, the ACPI-based PCI resource handling
is badly broken, IMHO:

- many resources of devices don't show up in the resource trees (
  /proc/iomem and /proc/ioports) any longer. This means that PCMCIA, but
  also possibly other subsystems (ISA, PnP, ...) do not know which resources
  it cannot use.

- verify_root_windows() should fail if there are no iomem _or_ ioport
  resources, not only if there are no iomem _and_ ioport resources.

Nonetheless, with the init-time trouble (hopefully) solved, I'd say that it
is time for the PCMCIA patches to get into mainline.

	Dominik


Don't auto-configure yenta sockets for PCMCIA devices if it is connected to
the root PCI bus on the x86 or x86_64 architectures. Previously, this was
handled by the "ioport_resource"/"iomem_resource" check a few lines below,
but with the new ACPI-based resource handling this doesn't catch all cases
any longer.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

--- 2.6.12-mm2/drivers/pcmcia/rsrc_nonstatic.c.orig	2005-06-26 15:04:57.000000000 +0200
+++ 2.6.12-mm2/drivers/pcmcia/rsrc_nonstatic.c	2005-06-26 15:09:02.000000000 +0200
@@ -779,6 +779,17 @@
 	if (!s->cb_dev || !s->cb_dev->bus)
 		return -ENODEV;
 
+#if defined(CONFIG_X86) || defined(CONFIG_X86_64)
+	/* If this is the root bus, the risk of hitting
+	 * some strange system devices which aren't protected
+	 * by either ACPI resource tables or properly requested
+	 * resources is too big. Therefore, don't do auto-adding
+	 * of resources at the moment.
+	 */
+	if (s->cb_dev->bus->number == 0)
+		return -EINVAL;
+#endif
+
 	for (i=0; i < PCI_BUS_NUM_RESOURCES; i++) {
 		res = s->cb_dev->bus->resource[i];
 		if (!res)
