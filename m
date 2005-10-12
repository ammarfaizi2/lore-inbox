Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751483AbVJLSAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbVJLSAy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 14:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbVJLSAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 14:00:54 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:2246 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751483AbVJLSAx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 14:00:53 -0400
Date: Wed, 12 Oct 2005 12:00:50 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: acpi-devel@lists.sourceforge.net, Adam Litke <agl@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [ACPI] 2.6.14-rc4 ACPI/PCI compile problem
Message-ID: <20051012180050.GC5103@parisc-linux.org>
References: <1129069727.27663.8.camel@localhost.localdomain> <200510111717.01887.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510111717.01887.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2005 at 05:17:01PM -0600, Bjorn Helgaas wrote:
> Please try the following patch and confirm whether it works.
> 
> [i386 kbuild] Don't clobber pci-y when X86_VISWS or X86_NUMAQ
> 
> Previously, enabling CONFIG_X86_VISWS or CONFIG_X86_NUMAQ
> clobbered any previous contents of pci-y, because they used
> ":=" instead of "+=".

This isn't correct.  We want to get rid of some of the current contents
of pci-y when NUMAQ or VISWS are enabled.  I'm not quite sure what the
right fix is here.  Maybe something like ...

--- arch/i386/pci/Makefile      14 Sep 2005 12:54:20 -0000      1.3
+++ arch/i386/pci/Makefile      12 Oct 2005 17:51:19 -0000
@@ -4,11 +4,11 @@ obj-$(CONFIG_PCI_BIOS)                += pcbios.o
 obj-$(CONFIG_PCI_MMCONFIG)     += mmconfig.o
 obj-$(CONFIG_PCI_DIRECT)       += direct.o
 
-pci-y                          := fixup.o
-pci-$(CONFIG_ACPI)             += acpi.o
-pci-y                          += legacy.o irq.o
+acpi-$(CONFIG_ACPI)            := acpi.o
+
+pci-y                          := fixup.o $(acpi-y) legacy.o irq.o
 
 pci-$(CONFIG_X86_VISWS)                := visws.o fixup.o
-pci-$(CONFIG_X86_NUMAQ)                := numa.o irq.o
+pci-$(CONFIG_X86_NUMAQ)                := numa.o $(acpi-y) irq.o
 
 obj-y                          += $(pci-y) common.o

This mess really needs some more eyes on it.  For example, should fixups.o
really be enabled on visws but disabled on numaq?  I suspect both want
legacy.o disabled.  Does it make sense to enable ACPI on a NUMAQ system?
I don't know enough about them.

And it /really/ needs some commentary.  Here's my first cut at it, based
on my memories of editing it several years ago:

# A little more complex than most Makefiles.
# Neither the VISWS nor the NUMAQ configs want to see legacy.o compiled in.
# VISWS doesn't have ACPI to worry about, but NUMAQ might
# Order is important -- don't rearrange the order of files here.

Help most gratefully received from people who really understand these boxes!
