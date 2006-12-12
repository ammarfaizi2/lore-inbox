Return-Path: <linux-kernel-owner+w=401wt.eu-S932348AbWLLSza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWLLSza (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 13:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWLLSz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 13:55:27 -0500
Received: from mx0.karneval.cz ([81.27.192.123]:28444 "EHLO av1.karneval.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932348AbWLLSzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 13:55:16 -0500
Message-id: <1289228942882311384@karneval.cz>
In-reply-to: <5182276292485062@karneval.cz>
Subject: [PATCH 3/3] Char: sx, fix non-PCI build
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>
Date: Tue, 12 Dec 2006 19:15:40 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sx, fix non-PCI build

When CONFIG_PCI is not defined (i.e. PCI bus is disabled), the sx
driver fails to link, since some pci functions are not available. Fix this
behaviour to be able to compile this driver on machines with no PCI bus (but
with ISA bus support).

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit af8e1f039e2f0b822c5b96551b3363da7371b0b5
tree e954ee931dd5bab70494d4ae3a4e0f45a043646c
parent 1bdc489336b6f2e6909c553f88f8275fafe741c6
author Jiri Slaby <jirislaby@gmail.com> Tue, 12 Dec 2006 18:57:54 +0100
committer Jiri Slaby <jirislaby@gmail.com> Tue, 12 Dec 2006 18:57:54 +0100

 drivers/char/Kconfig |    2 +-
 drivers/char/sx.c    |    8 ++++++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index f64f131..c599273 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -312,7 +312,7 @@ config SPECIALIX_RTSCTS
 
 config SX
 	tristate "Specialix SX (and SI) card support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && (PCI || EISA || ISA)
 	help
 	  This is a driver for the SX and SI multiport serial cards.
 	  Please read the file <file:Documentation/sx.txt> for details.
diff --git a/drivers/char/sx.c b/drivers/char/sx.c
index a3008ce..1da92a6 100644
--- a/drivers/char/sx.c
+++ b/drivers/char/sx.c
@@ -2498,8 +2498,10 @@ static void __devexit sx_remove_card(struct sx_board *board,
 		/* It is safe/allowed to del_timer a non-active timer */
 		del_timer(&board->timer);
 		if (pdev) {
+#ifdef CONFIG_PCI
 			pci_iounmap(pdev, board->base);
 			pci_release_region(pdev, IS_CF_BOARD(board) ? 3 : 2);
+#endif
 		} else {
 			iounmap(board->base);
 			release_region(board->hw_base, board->hw_len);
@@ -2601,6 +2603,7 @@ static struct eisa_driver sx_eisadriver = {
 
 #endif
 
+#ifdef CONFIG_PCI
  /******************************************************** 
  * Setting bit 17 in the CNTRL register of the PLX 9050  * 
  * chip forces a retry on writes while a read is pending.*
@@ -2632,10 +2635,12 @@ static void __devinit fix_sx_pci(struct pci_dev *pdev, struct sx_board *board)
 	}
 	iounmap(rebase);
 }
+#endif
 
 static int __devinit sx_pci_probe(struct pci_dev *pdev,
 				  const struct pci_device_id *ent)
 {
+#ifdef CONFIG_PCI
 	struct sx_board *board;
 	unsigned int i, reg;
 	int retval = -EIO;
@@ -2700,6 +2705,9 @@ err_flag:
 	board->flags &= ~SX_BOARD_PRESENT;
 err:
 	return retval;
+#else
+	return -ENODEV;
+#endif
 }
 
 static void __devexit sx_pci_remove(struct pci_dev *pdev)
