Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262709AbUKMAz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbUKMAz2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 19:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbUKLXqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:46:35 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:10627 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262713AbUKLXW4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:56 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017152249@kroah.com>
Date: Fri, 12 Nov 2004 15:21:55 -0800
Message-Id: <11003017153917@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2026.35.5, 2004/10/28 16:25:06-05:00, akpm@osdl.org

[PATCH] PCI: add hook for PCI resource deallocation

From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

This patch adds a hook 'pcibios_disable_device()' into pci_disable_device()
to call architecture specific PCI resource deallocation code.  It's a
opposite part of pcibios_enable_device().  We need this hook to deallocate
architecture specific PCI resource such as IRQ resource, etc..  This patch
is just for adding the hook, so 'pcibios_disable_device()' is defined as a
null function on all architecture so far.

I tested this patch on i386, x86_64 and ia64.  But it has not been tested
on other architectures because I don't have these machines.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/pci.c |   12 ++++++++++++
 1 files changed, 12 insertions(+)


diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	2004-11-12 15:14:21 -08:00
+++ b/drivers/pci/pci.c	2004-11-12 15:14:21 -08:00
@@ -375,6 +375,16 @@
 }
 
 /**
+ * pcibios_disable_device - disable arch specific PCI resources for device dev
+ * @dev: the PCI device to disable
+ *
+ * Disables architecture specific PCI resources for the device. This
+ * is the default implementation. Architecture implementations can
+ * override this.
+ */
+void __attribute__ ((weak)) pcibios_disable_device (struct pci_dev *dev) {}
+
+/**
  * pci_disable_device - Disable PCI device after use
  * @dev: PCI device to be disabled
  *
@@ -394,6 +404,8 @@
 		pci_command &= ~PCI_COMMAND_MASTER;
 		pci_write_config_word(dev, PCI_COMMAND, pci_command);
 	}
+
+	pcibios_disable_device(dev);
 }
 
 /**

