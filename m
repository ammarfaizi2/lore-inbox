Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422675AbWJXVr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422675AbWJXVr1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 17:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422672AbWJXVr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 17:47:27 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:45453 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1422671AbWJXVrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 17:47:25 -0400
Date: Tue, 24 Oct 2006 15:47:24 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Jeff Garzik <jeff@garzik.org>
Cc: Roland Dreier <rdreier@cisco.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, John Partridge <johnip@sgi.com>
Subject: Re: Ordering between PCI config space writes and MMIO reads?
Message-ID: <20061024214724.GS25210@parisc-linux.org>
References: <adafyddcysw.fsf@cisco.com> <20061024192210.GE2043@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061024192210.GE2043@havoc.gtf.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2006 at 03:22:10PM -0400, Jeff Garzik wrote:
> The PCI config APIs have traditionally enforced very strong ordering.
> Heck, the PCI config APIs often take a spinlock on each read or write;
> so they are definitely not intended to be as fast as MMIO.

s/often/always/.  It's implemented in drivers/pci/access.c.

I think the right way to fix this is to ensure mmio write ordering in
the pci_write_config_*() implementations.  Like this.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index ea16805..c80f1ba 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -1,6 +1,6 @@
 #include <linux/pci.h>
 #include <linux/module.h>
-#include <linux/ioport.h>
+#include <linux/io.h>
 
 #include "pci.h"
 
@@ -45,6 +45,7 @@ int pci_bus_write_config_##size \
 	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
 	spin_lock_irqsave(&pci_lock, flags);				\
 	res = bus->ops->write(bus, devfn, pos, len, value);		\
+	mmiowb();							\
 	spin_unlock_irqrestore(&pci_lock, flags);			\
 	return res;							\
 }
@@ -102,6 +103,7 @@ int pci_user_write_config_##size					\
 	if (likely(!dev->block_ucfg_access))				\
 		ret = dev->bus->ops->write(dev->bus, dev->devfn,	\
 					pos, sizeof(type), val);	\
+	mmiowb();							\
 	spin_unlock_irqrestore(&pci_lock, flags);			\
 	return ret;							\
 }
