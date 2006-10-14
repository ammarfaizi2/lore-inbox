Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752241AbWJNXgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241AbWJNXgu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 19:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752243AbWJNXgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 19:36:50 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:58263 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1752239AbWJNXgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 19:36:49 -0400
Message-id: <1966866271061818079@wsc.cz>
Subject: [PATCH 1/1] Char: correct pci_get_device changes
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <R.E.Wolff@BitWizard.nl>
Cc: Amit Gud <gud@eth.net>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Date: Sun, 15 Oct 2006 01:36:45 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

correct pci_get_device changes

Commits 881a8c120acf7ec09c90289e2996b7c70f51e996 and
efe1ec27837d6639eae82e1f5876910ba6433c3f are totally wrong and
"Replace pci_find_device() with more safer pci_get_device()." holds only for a
very short time until next iteration of pci_get_device is called (and
refcount is decreased again there).

Whenever pci_find_device -> pci_get_device change is performed, also
pci_dev_get and pci_dev_put should be in most cases called. If not, it's
not easy to find such issues and this is example of such case. Here it
was made safer in no way but a moment during initialization, weird.

It affects moxa and rio char drivers. (All this stuff deserves to be
converted to pci_probing, though.)

Cc: <R.E.Wolff@BitWizard.nl>
Cc: Amit Gud <gud@eth.net>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit cf08d779dbf942c5da538e7c286782d05c9da56f
tree 2eaea73812a57c869db26bcc589b4c1b3b2e87f8
parent ed395025a185ff6da5a564a55d320ffd8162304c
author Jiri Slaby <jirislaby@gmail.com> Sun, 15 Oct 2006 01:29:38 +0200
committer Jiri Slaby <jirislaby@gmail.com> Sun, 15 Oct 2006 01:29:38 +0200

 drivers/char/moxa.c          |    6 ++++++
 drivers/char/rio/host.h      |    1 +
 drivers/char/rio/rio_linux.c |    9 +++++++++
 3 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/char/moxa.c b/drivers/char/moxa.c
index e19f917..3d29670 100644
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
@@ -497,6 +501,8 @@ static void __exit moxa_exit(void)
 	for (i = 0; i < MAX_BOARDS; i++) {
 		if (moxaBaseAddr[i])
 			iounmap(moxaBaseAddr[i]);
+		if (moxa_boards[i].busType == MOXA_BUS_TYPE_PCI)
+			pci_dev_put(moxa_boards[i].pciInfo.pdev);
 	}
 
 	if (verbose)
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
index 6c220a6..cb5c459 100644
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
@@ -1067,6 +1071,9 @@ #ifdef CONFIG_RIO_OLDPCI
 			    ((readb(&p->RIOHosts[p->RIONumHosts].Unique[1]) & 0xFF) << 8) | ((readb(&p->RIOHosts[p->RIONumHosts].Unique[2]) & 0xFF) << 16) | ((readb(&p->RIOHosts[p->RIONumHosts].Unique[3]) & 0xFF) << 24);
 			rio_dprintk(RIO_DEBUG_PROBE, "Hmm Tested ok, uniqid = %x.\n", p->RIOHosts[p->RIONumHosts].UniqueNum);
 
+			p->RIOHosts[p->RIONumHosts].pdev = pdev;
+			pci_dev_get(pdev);
+
 			p->RIOLastPCISearch = 0;
 			p->RIONumHosts++;
 			found++;
@@ -1188,6 +1195,8 @@ static void __exit rio_exit(void)
 
 		if (hp->Caddr)
 			iounmap(hp->Caddr);
+		if (hp->Type == RIO_PCI)
+			pci_dev_put(hp->pdev);
 	}
 
 	if (misc_deregister(&rio_fw_device) < 0) {
