Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267880AbUHUV2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267880AbUHUV2o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 17:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267895AbUHUV2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 17:28:43 -0400
Received: from 80-219-192-49.dclient.hispeed.ch ([80.219.192.49]:11268 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S267880AbUHUV2i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 17:28:38 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH 2.4] enable read prefetch on o2micro bridges to fix HDSP
Date: Sat, 21 Aug 2004 23:22:24 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408212322.24041.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi marcelo

this is in 2.6 since june 21 and even longer on the linux-pcmcia list (2.6 version).
not a single negative report about this until now.

against 2.4-bknow

rgds
-daniel

--------------------

enable read prefetching on O2micro bridges. It fixes the problems
seen with the RME Hammerfall DSP. it's also known to fix problems
with an external cd-writer on a dell laptop.
Thanks to Eric Still from O2micro for the input.

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>

--- 1.17/drivers/pcmcia/yenta.c	Mon May 17 22:09:06 2004
+++ edited/drivers/pcmcia/yenta.c	Fri Jun 25 21:51:44 2004
@@ -845,6 +845,7 @@
 
 #include "ti113x.h"
 #include "ricoh.h"
+#include "o2micro.h"
 
 /*
  * Different cardbus controllers have slightly different
@@ -879,6 +880,8 @@
 	{ PD(ENE,1225),  &ti_ops },
 	{ PD(ENE,1410),  &ti_ops },
 	{ PD(ENE,1420),  &ti_ops },
+
+	{ PCI_VENDOR_ID_O2, PCI_ANY_ID, &o2micro_ops },
 
 	{ PD(RICOH,RL5C465), &ricoh_ops },
 	{ PD(RICOH,RL5C466), &ricoh_ops },
--- 1.3/drivers/pcmcia/o2micro.h	Sat Oct 19 01:10:30 2002
+++ edited/drivers/pcmcia/o2micro.h	Fri Jun 25 21:36:08 2004
@@ -120,4 +120,36 @@
 #define  O2_MODE_E_LED_OUT	0x08
 #define  O2_MODE_E_SKTA_ACTV	0x10
 
+static int o2micro_open(pci_socket_t *socket)
+{
+	/*
+	 * 'reserved' register at 0x94/D4. chaning it to 0xCA (8 bit) enables
+	 * read prefetching which for example makes the RME Hammerfall DSP
+	 * working. for some bridges it is at 0x94, for others at 0xD4. it's
+	 * ok to write to both registers on all O2 bridges.
+	 * from Eric Still, 02Micro.
+	 */
+	if (PCI_FUNC(socket->dev->devfn) == 0) {
+		config_writeb(socket, 0x94, 0xCA);
+		config_writeb(socket, 0xD4, 0xCA);
+	}
+
+	return 0;
+}
+
+static struct pci_socket_ops o2micro_ops = {
+	o2micro_open,
+	yenta_close,
+	yenta_init,
+	yenta_suspend,
+	yenta_get_status,
+	yenta_get_socket,
+	yenta_set_socket,
+	yenta_get_io_map,
+	yenta_set_io_map,
+	yenta_get_mem_map,
+	yenta_set_mem_map,
+	yenta_proc_setup
+};
+
 #endif /* _LINUX_O2MICRO_H */
--- 1.11/drivers/pcmcia/i82365.c	Sat Sep 27 17:41:26 2003
+++ edited/drivers/pcmcia/i82365.c	Sat Aug 21 21:51:47 2004
@@ -63,7 +63,6 @@
 #include "cirrus.h"
 #include "vg468.h"
 #include "ricoh.h"
-#include "o2micro.h"
 
 #ifdef PCMCIA_DEBUG
 static int pc_debug = PCMCIA_DEBUG;

