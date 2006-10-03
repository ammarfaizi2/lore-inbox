Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbWJCBIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbWJCBIY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 21:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030202AbWJCBIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 21:08:24 -0400
Received: from havoc.gtf.org ([69.61.125.42]:4031 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030198AbWJCBIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 21:08:23 -0400
Date: Mon, 2 Oct 2006 21:08:22 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] hp100: fix conditional compilation mess
Message-ID: <20061003010822.GA29176@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The previous hp100 changeset attempted to kill warnings, but was only
tested on !CONFIG_ISA platforms.  The correct conditional compilation
setup involves tested CONFIG_ISA rather than just MODULE.

Fixes link on CONFIG_ISA platforms (i386) in current -git.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/net/Space.c |    2 +-
 drivers/net/hp100.c |    8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/Space.c b/drivers/net/Space.c
index 9953201..a67f5ef 100644
--- a/drivers/net/Space.c
+++ b/drivers/net/Space.c
@@ -165,7 +165,7 @@ #endif
  * look for EISA/PCI/MCA cards in addition to ISA cards).
  */
 static struct devprobe2 isa_probes[] __initdata = {
-#ifdef CONFIG_HP100 		/* ISA, EISA & PCI */
+#if defined(CONFIG_HP100) && defined(CONFIG_ISA)	/* ISA, EISA */
 	{hp100_probe, 0},
 #endif
 #ifdef CONFIG_3C515
diff --git a/drivers/net/hp100.c b/drivers/net/hp100.c
index 561db44..ae8ad4f 100644
--- a/drivers/net/hp100.c
+++ b/drivers/net/hp100.c
@@ -188,7 +188,7 @@ struct hp100_private {
 /*
  *  variables
  */
-#ifndef MODULE
+#ifdef CONFIG_ISA
 static const char *hp100_isa_tbl[] = {
 	"HWPF150", /* HP J2573 rev A */
 	"HWP1950", /* HP J2573 */
@@ -335,7 +335,7 @@ static __devinit const char *hp100_read_
 	return str;
 }
 
-#ifndef MODULE
+#ifdef CONFIG_ISA
 static __init int hp100_isa_probe1(struct net_device *dev, int ioaddr)
 {
 	const char *sig;
@@ -393,7 +393,9 @@ static int  __init hp100_isa_probe(struc
 	}
 	return err;
 }
+#endif /* CONFIG_ISA */
 
+#if !defined(MODULE) && defined(CONFIG_ISA)
 struct net_device * __init hp100_probe(int unit)
 {
 	struct net_device *dev = alloc_etherdev(sizeof(struct hp100_private));
@@ -423,7 +425,7 @@ #endif
 	free_netdev(dev);
 	return ERR_PTR(err);
 }
-#endif
+#endif /* !MODULE && CONFIG_ISA */
 
 static int __devinit hp100_probe1(struct net_device *dev, int ioaddr,
 				  u_char bus, struct pci_dev *pci_dev)
