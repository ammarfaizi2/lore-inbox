Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268539AbUH3Qse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268539AbUH3Qse (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 12:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268553AbUH3Qse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 12:48:34 -0400
Received: from mdm-digital417.uol.brasilvision.com.br ([200.222.15.249]:10903
	"EHLO tirion") by vger.kernel.org with ESMTP id S268539AbUH3Qs2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 12:48:28 -0400
Date: Mon, 30 Aug 2004 12:47:33 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@conectiva.com.br>
To: marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] - drivers/pci/pci.c NULL pointer fix.
Message-Id: <20040830124733.7d44dbe1.lcapitulino@conectiva.com.br>
Organization: Conectiva S/A.
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Marcelo,

 This is another bug fix: the function pci/pci.c::pci_add_new_bus() does not
check the return of pci_alloc_bus(). If this function returns NULL, `child'
can be utilised.

 In the patch bellow I added the check, if the call that pci_scan_bridge()
is doing to pci_alloc_bus() return NULL, pci_scan_bridge() returns `max'
(Greg accepted this fix for 2.6, a while ago).

(against 2.4.28-pre2)


Signed-off-by: Luiz Capitulino <lcapitulino@conectiva.com.br>

 drivers/pci/pci.c |    9 +++++++++
 1 files changed, 9 insertions(+)


diff -X /home/capitulino/kernels/2.6/dontdiff -Nparu a/drivers/pci/pci.c a~/drivers/pci/pci.c
--- a/drivers/pci/pci.c	2004-08-07 20:26:05.000000000 -0300
+++ a~/drivers/pci/pci.c	2004-08-21 19:04:58.000000000 -0300
@@ -1238,6 +1238,8 @@ struct pci_bus * __devinit pci_add_new_b
 	 * Allocate a new bus, and inherit stuff from the parent..
 	 */
 	child = pci_alloc_bus();
+	if (!child)
+		return NULL;
 
 	list_add_tail(&child->node, &parent->children);
 	child->self = dev;
@@ -1291,7 +1293,11 @@ static int __devinit pci_scan_bridge(str
 		 */
 		if (pass)
 			return max;
+
 		child = pci_add_new_bus(bus, dev, 0);
+		if (!child)
+			return max;
+
 		child->primary = buses & 0xFF;
 		child->secondary = (buses >> 8) & 0xFF;
 		child->subordinate = (buses >> 16) & 0xFF;
@@ -1316,6 +1322,9 @@ static int __devinit pci_scan_bridge(str
 		pci_write_config_word(dev, PCI_STATUS, 0xffff);
 
 		child = pci_add_new_bus(bus, dev, ++max);
+		if (!child)
+			return max;
+
 		buses = (buses & 0xff000000)
 		      | ((unsigned int)(child->primary)     <<  0)
 		      | ((unsigned int)(child->secondary)   <<  8)

-- 
Luiz Fernando Capitulino
