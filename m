Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbUCGPxx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 10:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbUCGPxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 10:53:53 -0500
Received: from 217-162-59-239.dclient.hispeed.ch ([217.162.59.239]:43012 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S262169AbUCGPxj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 10:53:39 -0500
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH 2.4] fix yenta card detection on some setups
Date: Sun, 7 Mar 2004 16:50:59 +0100
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403071650.59701.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello

this patch fixes card detection on some chips:
the current code that redoes voltage interrogation has it's check wrong.
both CB_CDETECT1 and CB_CDETECT2 needs to be _zero_ for a card to be deteced
correctly. also, more importantly, always redo when none of the voltage bits are set.
same applies to yenta_get_status().

the patch also adds the TI1510 and 1520 chips to yenta's override table as they
need the additional init code (ie. the part that enables PCI CSC interrupts).

it fixes at least silla rizzoli's IBM R40 2681-BDG, my toshba works just fine
w/ or w/o it.

against 2.4.26-pre2. please apply.

rgds
-daniel


--- 1.15/drivers/pcmcia/yenta.c	Tue Jan  6 05:55:05 2004
+++ edited/drivers/pcmcia/yenta.c	Sat Mar  6 10:38:26 2004
@@ -135,8 +135,8 @@
 
 	val  = (state & CB_3VCARD) ? SS_3VCARD : 0;
 	val |= (state & CB_XVCARD) ? SS_XVCARD : 0;
-	val |= (state & (CB_CDETECT1 | CB_CDETECT2 | CB_5VCARD | CB_3VCARD
-			 | CB_XVCARD | CB_YVCARD)) ? 0 : SS_PENDING;
+	val |= (state & (CB_5VCARD | CB_3VCARD | CB_XVCARD | CB_YVCARD)) ? 0 : SS_PENDING;
+	val |= (state & (CB_CDETECT1 | CB_CDETECT2)) ? SS_PENDING : 0;
 
 	if (state & CB_CBCARD) {
 		val |= SS_CARDBUS;	
@@ -677,10 +677,9 @@
 
 	/* Redo card voltage interrogation */
 	state = cb_readl(socket, CB_SOCKET_STATE);
-	if (!(state & (CB_CDETECT1 | CB_CDETECT2 | CB_5VCARD |
-			CB_3VCARD | CB_XVCARD | CB_YVCARD)))
-		
-	cb_writel(socket, CB_SOCKET_FORCE, CB_CVSTEST);
+	if (!(state & (CB_5VCARD | CB_3VCARD | CB_XVCARD | CB_YVCARD)) ||
+	    (state & (CB_CDETECT1 | CB_CDETECT2)))
+		cb_writel(socket, CB_SOCKET_FORCE, CB_CVSTEST);
 }
 
 /* Called at resume and initialization events */
@@ -870,6 +869,8 @@
 	{ PD(TI,1420),	&ti_ops },
 	{ PD(TI,4410),	&ti_ops },
 	{ PD(TI,4451),	&ti_ops },
+	{ PD(TI,1510),	&ti_ops },
+	{ PD(TI,1520),	&ti_ops },
 
 	{ PD(RICOH,RL5C465), &ricoh_ops },
 	{ PD(RICOH,RL5C466), &ricoh_ops },
--- 1.84/include/linux/pci_ids.h	Thu Feb 26 07:54:04 2004
+++ edited/include/linux/pci_ids.h	Fri Mar  5 12:28:10 2004
@@ -659,6 +659,8 @@
 #define PCI_DEVICE_ID_TI_4410		0xac41
 #define PCI_DEVICE_ID_TI_4451		0xac42
 #define PCI_DEVICE_ID_TI_1420		0xac51
+#define PCI_DEVICE_ID_TI_1520		0xac55
+#define PCI_DEVICE_ID_TI_1510		0xac56
 
 #define PCI_VENDOR_ID_SONY		0x104d
 #define PCI_DEVICE_ID_SONY_CXD3222	0x8039

