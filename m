Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVBNN1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVBNN1I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 08:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVBNN1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 08:27:07 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:54565 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261433AbVBNNXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 08:23:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=N3Q+Bn9OOltgiHNchg0iuIgd9JPEg0xNy8d1PFMXRwEcwxEmIN2N3QAp2iYipFo+4dZxo6Lga/fKG4KHmSKzjK11GmdxWq6SEds9yT62NtMYoouCwxUX2JirexIc3qrbyq4ONVAXfedOwllpvInGcalvOlOTvSw00TlxBYcKEEU=
Message-ID: <4301cff605021405234a44b8d4@mail.gmail.com>
Date: Mon, 14 Feb 2005 15:23:06 +0200
From: Mika Kukkonen <mikukkon@gmail.com>
Reply-To: Mika Kukkonen <mikukkon@gmail.com>
To: len.brown@intel.com
Subject: [PATCH] Build failure with !CONFIG_PCI and with CONFIG_ISAPNP=y && CONFIG_PNPBIOS=y
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to build latest kernel with !CONFIG_PCI and with
CONFIG_ISAPNP=y && CONFIG_PNPBIOS=y
I got the following build error:

  LD	vmlinux
drivers/built-in.o(.text+0x5486): In function
'pnpbios_parse_allocated_irqresource':
: undefined reference to 'pcibios_penalize_isa_irq'

Clearly pcibios_penalize_isa_irq() is meant to be called only with
CONFIG_PCI, so
following patch suggests itself:

--- linux-2.5/drivers/pnp/pnpbios/rsparser.c	2005-02-14 12:08:49.000000000 +0200
+++ linux-tiny/drivers/pnp/pnpbios/rsparser.c	2005-02-14
12:12:32.000000000 +0200
@@ -7,7 +7,12 @@
 #include <linux/ctype.h>
 #include <linux/pnp.h>
 #include <linux/pnpbios.h>
+
+#ifdef CONFIG_PCI
 #include <linux/pci.h>
+#else
+inline void pcibios_penalize_isa_irq(int irq) {}
+#endif /* CONFIG_PCI */

 #include "pnpbios.h"

By the way, while using cscope I noticed that there is very bogus looking
definition of pcibios_penalize_isa_irq() in line 24 of arch/i386/pci/visws.c,
but as that is not called anywhere in that file it could be simply removed.
No patch for that though because I could not get the file to compile.

--MiKu
