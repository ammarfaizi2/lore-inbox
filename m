Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266704AbUG0XKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266704AbUG0XKe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 19:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266712AbUG0XKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 19:10:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37006 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266704AbUG0XKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 19:10:12 -0400
Date: Tue, 27 Jul 2004 19:09:29 -0400
From: Alan Cox <alan@redhat.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: PATCH: serial-cs and unusable port size ranges
Message-ID: <20040727230929.GA31501@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of GSM GPRS PCMCIA cards advertise 16 rather than 8 port sized windows
for their serial interface. This breaks our current pcmcia serial driver
which ignores any windows that are not 8 bytes.

To avoid any regressions on other cards given this driver contains a certain
amount of "magic" the patch below looks for 8 byte windows first so will
not break existing supported cards (I hope ;))

Patch-by: Alan Cox <alan@redhat.com>
OSDL Developer Certiticate Of Origin included herein by reference

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.7/drivers/serial/serial_cs.c 2.6.7-ac/drivers/serial/serial_cs.c
--- linux-2.6.7/drivers/serial/serial_cs.c	2004-06-16 21:10:07.000000000 +0100
+++ 2.6.7-ac/drivers/serial/serial_cs.c	2004-06-19 14:17:04.000000000 +0100
@@ -366,6 +366,7 @@
 static int simple_config(dev_link_t * link)
 {
 	static ioaddr_t base[5] = { 0x3f8, 0x2f8, 0x3e8, 0x2e8, 0x0 };
+	static int size_table[2] = { 8, 16 };
 	client_handle_t handle = link->handle;
 	struct serial_info *info = link->priv;
 	tuple_t tuple;
@@ -374,6 +375,7 @@
 	cistpl_cftable_entry_t *cf = &parse.cftable_entry;
 	config_info_t config;
 	int i, j, try;
+	int s;
 
 	/* If the card is already configured, look up the port and irq */
 	i = pcmcia_get_configuration_info(handle, &config);
@@ -399,29 +401,31 @@
 	tuple.Attributes = 0;
 	tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
 	/* Two tries: without IO aliases, then with aliases */
-	for (try = 0; try < 2; try++) {
-		i = first_tuple(handle, &tuple, &parse);
-		while (i != CS_NO_MORE_ITEMS) {
-			if (i != CS_SUCCESS)
-				goto next_entry;
-			if (cf->vpp1.present & (1 << CISTPL_POWER_VNOM))
-				link->conf.Vpp1 = link->conf.Vpp2 =
-				    cf->vpp1.param[CISTPL_POWER_VNOM] / 10000;
-			if ((cf->io.nwin > 0) && (cf->io.win[0].len == 8) &&
-			    (cf->io.win[0].base != 0)) {
-				link->conf.ConfigIndex = cf->index;
-				link->io.BasePort1 = cf->io.win[0].base;
-				link->io.IOAddrLines = (try == 0) ?
-				    16 : cf->io.flags & CISTPL_IO_LINES_MASK;
-				i = pcmcia_request_io(link->handle, &link->io);
-				if (i == CS_SUCCESS)
-					goto found_port;
+	for (s = 0; s < 2; s++)
+	{
+		for (try = 0; try < 2; try++) {
+			i = first_tuple(handle, &tuple, &parse);
+			while (i != CS_NO_MORE_ITEMS) {
+				if (i != CS_SUCCESS)
+					goto next_entry;
+				if (cf->vpp1.present & (1 << CISTPL_POWER_VNOM))
+					link->conf.Vpp1 = link->conf.Vpp2 =
+					    cf->vpp1.param[CISTPL_POWER_VNOM] / 10000;
+				if ((cf->io.nwin > 0) && (cf->io.win[0].len == size_table[s]) &&
+					    (cf->io.win[0].base != 0)) {
+					link->conf.ConfigIndex = cf->index;
+					link->io.BasePort1 = cf->io.win[0].base;
+					link->io.IOAddrLines = (try == 0) ?
+					    16 : cf->io.flags & CISTPL_IO_LINES_MASK;
+					i = pcmcia_request_io(link->handle, &link->io);
+					if (i == CS_SUCCESS)
+						goto found_port;
+				}
+			      next_entry:
+				i = next_tuple(handle, &tuple, &parse);
 			}
-		      next_entry:
-			i = next_tuple(handle, &tuple, &parse);
 		}
 	}
-
 	/* Second pass: try to find an entry that isn't picky about
 	   its base address, then try to grab any standard serial port
 	   address, and finally try to get any free port. */



