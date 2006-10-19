Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946095AbWJSOpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946095AbWJSOpy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 10:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946096AbWJSOpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 10:45:54 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:64394 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1946095AbWJSOpx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 10:45:53 -0400
Date: Thu, 19 Oct 2006 16:44:31 +0200
Message-id: <1966866new061818079@muni.cz>
Subject: [PATCH 1/1 try #2] Char: correct pci_get_device changes
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <R.E.Wolff@BitWizard.nl>
Cc: Amit Gud <gud@eth.net>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Muni-Spam-TestIP: 147.251.51.189
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

correct pci_get_device changes

Commits 881a8c120acf7ec09c90289e2996b7c70f51e996 and
efe1ec27837d6639eae82e1f5876910ba6433c3f corrects pci device matching in
only one way; it no longer oopses/crashes, despite hotplug is not solved in
these changes.

Whenever pci_find_device -> pci_get_device change is performed, also
pci_dev_get and pci_dev_put should be in most cases called to properly
handle hotplug. This patch does exactly this thing -- increase refcount to
let kernel know, that we are using this piece of HW just now.

It affects moxa and rio char drivers.

Cc: <R.E.Wolff@BitWizard.nl>
Cc: Amit Gud <gud@eth.net>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 93751c264e1f78e5363f4736e07e2d26ea041809
tree f11b9fa9eeaa3e639d5142c67d5d804724238adb
parent 9e02a6d0d574e8ad39c1fe3a64b8493ec0524b08
author Jiri Slaby <xslaby@anemoi.localdomain> Thu, 19 Oct 2006 16:40:40 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Thu, 19 Oct 2006 16:40:40 +0200

 drivers/char/moxa.c          |    9 +++++++++
 drivers/char/rio/host.h      |    1 +
 drivers/char/rio/rio_linux.c |    9 +++++++++
 3 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/char/moxa.c b/drivers/char/moxa.c
index b401383..ce7376b 100644
--- a/drivers/char/moxa.c
+++ b/drivers/char/moxa.c
@@ -130,6 +130,7 @@ static moxa_isa_board_conf moxa_isa_boar
 typedef struct _moxa_pci_devinfo {
 	ushort busNum;
 	ushort devNum;
+	struct pci_dev *pdev;
 } moxa_pci_devinfo;
 
 typedef struct _moxa_board_conf {
@@ -324,6 +325,9 @@ static int moxa_get_PCI_conf(struct pci_
 	board->busType = MOXA_BUS_TYPE_PCI;
 	board->pciInfo.busNum = p->bus->number;
 	board->pciInfo.devNum = p->devfn >> 3;
+	board->pciInfo.pdev = p;
+	/* don't loss the reference in the next pci_get_device iteration */
+	pci_dev_get(p);
 
 	return (0);
 }
@@ -493,6 +497,11 @@ static void __exit moxa_exit(void)
 	if (tty_unregister_driver(moxaDriver))
 		printk("Couldn't unregister MOXA Intellio family serial driver\n");
 	put_tty_driver(moxaDriver);
+
+	for (i = 0; i < MAX_BOARDS; i++)
+		if (moxa_boards[i].busType == MOXA_BUS_TYPE_PCI)
+			pci_dev_put(moxa_boards[i].pciInfo.pdev);
+
 	if (verbose)
 		printk("Done\n");
 }
diff --git a/drivers/char/rio/host.h b/drivers/char/rio/host.h
index ee2ddea..23d0681 100644
--- a/drivers/char/rio/host.h
+++ b/drivers/char/rio/host.h
@@ -44,6 +44,7 @@ #define	MAX_EXTRA_UNITS	64
 **    the host.
 */
 struct Host {
+	struct pci_dev *pdev;
 	unsigned char Type;		/* RIO_EISA, RIO_MCA, ... */
 	unsigned char Ivec;		/* POLLED or ivec number */
 	unsigned char Mode;		/* Control stuff */
diff --git a/drivers/char/rio/rio_linux.c b/drivers/char/rio/rio_linux.c
index c382df0..7ac68cb 100644
--- a/drivers/char/rio/rio_linux.c
+++ b/drivers/char/rio/rio_linux.c
@@ -1017,6 +1017,10 @@ #ifdef CONFIG_PCI
 			rio_dprintk(RIO_DEBUG_PROBE, "Hmm Tested ok, uniqid = %x.\n", p->RIOHosts[p->RIONumHosts].UniqueNum);
 
 			fix_rio_pci(pdev);
+
+			p->RIOHosts[p->RIONumHosts].pdev = pdev;
+			pci_dev_get(pdev);
+
 			p->RIOLastPCISearch = 0;
 			p->RIONumHosts++;
 			found++;
@@ -1066,6 +1070,9 @@ #ifdef CONFIG_RIO_OLDPCI
 			    ((readb(&p->RIOHosts[p->RIONumHosts].Unique[1]) & 0xFF) << 8) | ((readb(&p->RIOHosts[p->RIONumHosts].Unique[2]) & 0xFF) << 16) | ((readb(&p->RIOHosts[p->RIONumHosts].Unique[3]) & 0xFF) << 24);
 			rio_dprintk(RIO_DEBUG_PROBE, "Hmm Tested ok, uniqid = %x.\n", p->RIOHosts[p->RIONumHosts].UniqueNum);
 
+			p->RIOHosts[p->RIONumHosts].pdev = pdev;
+			pci_dev_get(pdev);
+
 			p->RIOLastPCISearch = 0;
 			p->RIONumHosts++;
 			found++;
@@ -1181,6 +1188,8 @@ static void __exit rio_exit(void)
 		}
 		/* It is safe/allowed to del_timer a non-active timer */
 		del_timer(&hp->timer);
+		if (hp->Type == RIO_PCI)
+			pci_dev_put(hp->pdev);
 	}
 
 	if (misc_deregister(&rio_fw_device) < 0) {
