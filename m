Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262733AbUKMB4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262733AbUKMB4W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 20:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262732AbUKLXld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:41:33 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:8697 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262708AbUKLXWx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:53 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017162945@kroah.com>
Date: Fri, 12 Nov 2004 15:21:56 -0800
Message-Id: <11003017163474@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2026.66.14, 2004/11/05 15:05:43-08:00, tglx@linutronix.de

[PATCH] Lock initializer unifying Batch 2 (PCI)

To make spinlock/rwlock initialization consistent all over the kernel,
this patch converts explicit lock-initializers into spin_lock_init() and
rwlock_init() calls.

Currently, spinlocks and rwlocks are initialized in two different ways:

  lock = SPIN_LOCK_UNLOCKED
  spin_lock_init(&lock)

  rwlock = RW_LOCK_UNLOCKED
  rwlock_init(&rwlock)

this patch converts all explicit lock initializations to
spin_lock_init() or rwlock_init(). (Besides consistency this also helps
automatic lock validators and debugging code.)

The conversion was done with a script, it was verified manually and it
was reviewed, compiled and tested as far as possible on x86, ARM, PPC.

There is no runtime overhead or actual code change resulting out of this
patch, because spin_lock_init() and rwlock_init() are macros and are
thus equivalent to the explicit initialization method.

That's the second batch of the unifying patches.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/acpiphp_glue.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
--- a/drivers/pci/hotplug/acpiphp_glue.c	2004-11-12 15:13:13 -08:00
+++ b/drivers/pci/hotplug/acpiphp_glue.c	2004-11-12 15:13:13 -08:00
@@ -389,7 +389,7 @@
 
 	bridge->pci_bus = pci_find_bus(seg, bus);
 
-	bridge->res_lock = SPIN_LOCK_UNLOCKED;
+	spin_lock_init(&bridge->res_lock);
 
 	/* to be overridden when we decode _CRS	*/
 	bridge->sub = bridge->bus;
@@ -457,7 +457,7 @@
 		return;
 	}
 
-	bridge->res_lock = SPIN_LOCK_UNLOCKED;
+	spin_lock_init(&bridge->res_lock);
 
 	bridge->bus = bridge->pci_bus->number;
 	bridge->sub = bridge->pci_bus->subordinate;

