Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263120AbVG3TMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263120AbVG3TMz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 15:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263112AbVG3TKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 15:10:48 -0400
Received: from silver.veritas.com ([143.127.12.111]:56501 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S263115AbVG3TIu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 15:08:50 -0400
Date: Sat, 30 Jul 2005 20:10:33 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>, linux-kernel@vger.kernel.org
Subject: revert yenta free_irq on suspend
Message-ID: <Pine.LNX.4.61.0507301952350.3319@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 30 Jul 2005 19:08:49.0800 (UTC) FILETIME=[1E3EC880:01C5953A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please revert the yenta free_irq on suspend patch (below)
which went into 2.6.13-rc4 after 2.6.13-rc3-git9.

Sorry Daniel, you may have a box on which resume doesn't work without
it, but on my laptop APM resume from RAM now fails to work because of
it - locks up solid.  The patch sounded rather fishy when it went in,
but I've done an unprejudiced bisection and this turns out to be the
culprit.  Perhaps it needs something more (I can try further patches),
but as it stands it's unsuitable for 2.6.13.

Do I recall a worry about shared interrupts?  I indeed have
PCI: Found IRQ 11 for device 0000:00:1f.1
PCI: Sharing IRQ 11 with 0000:02:00.0
PCI: Found IRQ 11 for device 0000:02:00.0
PCI: Sharing IRQ 11 with 0000:00:1f.1
PCI: Found IRQ 11 for device 0000:02:01.0
PCI: Sharing IRQ 11 with 0000:02:01.1
PCI: Found IRQ 11 for device 0000:02:01.1
PCI: Sharing IRQ 11 with 0000:02:01.0
on resume before that patch, and again now I've backed it out.

Thanks,
Hugh

From: Daniel Ritz <daniel.ritz@gmx.ch>

Resume doesn't seem to work without.

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/pcmcia/yenta_socket.c |    9 +++++++++
 1 files changed, 9 insertions(+)

diff -puN drivers/pcmcia/yenta_socket.c~yenta-free_irq-on-suspend drivers/pcmcia/yenta_socket.c
--- devel/drivers/pcmcia/yenta_socket.c~yenta-free_irq-on-suspend	2005-07-28 01:05:52.000000000 -0700
+++ devel-akpm/drivers/pcmcia/yenta_socket.c	2005-07-28 01:05:52.000000000 -0700
@@ -1107,6 +1107,8 @@ static int yenta_dev_suspend (struct pci
 		pci_read_config_dword(dev, 17*4, &socket->saved_state[1]);
 		pci_disable_device(dev);
 
+		free_irq(dev->irq, socket);
+
 		/*
 		 * Some laptops (IBM T22) do not like us putting the Cardbus
 		 * bridge into D3.  At a guess, some other laptop will
@@ -1132,6 +1134,13 @@ static int yenta_dev_resume (struct pci_
 		pci_enable_device(dev);
 		pci_set_master(dev);
 
+		if (socket->cb_irq)
+			if (request_irq(socket->cb_irq, yenta_interrupt,
+			                SA_SHIRQ, "yenta", socket)) {
+				printk(KERN_WARNING "Yenta: request_irq() failed on resume!\n");
+				socket->cb_irq = 0;
+			}
+
 		if (socket->type && socket->type->restore_state)
 			socket->type->restore_state(socket);
 	}
