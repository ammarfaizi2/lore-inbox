Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUHJH6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUHJH6r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 03:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUHJH6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 03:58:47 -0400
Received: from CWareNS1.Controlware.DE ([193.22.120.157]:20156 "EHLO
	cwarens1.controlware.de") by vger.kernel.org with ESMTP
	id S261169AbUHJH6p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 03:58:45 -0400
Message-Id: <s1189c52.091@post2.controlware.de>
X-Mailer: Novell GroupWise Internet Agent 6.0.2
Date: Tue, 10 Aug 2004 09:58:16 +0200
From: "=?ISO-8859-1?Q?Harald=20K=FCthe?=" <Harald.Kuethe@controlware.de>
To: <linuxppc-embedded@lists.linuxppc.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH][PPC32] 2.4.27: fixes for 8xx fec.c
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I found two problems concerning the fast ethernet driver 
for ppc 8xx processors (fec.c) in linux kernel version 2.4.26/27 
and I think in the 2.6 series as well (not confirmed).

First problem is only when CONFIG_USE_MDIO is __not__ set.
How to reproduce:
start the system with fec ethernet, everything works, 
issue a ifconfig ethX down and ifconfig ethX up and ethernet is not working anymore.
Fix (or at least a workaround). In fec_enet_open() add a fec_restart() at the end 
if CONFIG_USE_MDIO is not set.

2nd problem is with CONFIG_USE_MDIO set: 
The promiscuous mode/multicast settings are getting lost if link status changes occurs 
How to reproduce:
build a bridge with the fec device. Then simply unplug and replug the ethernet cable. 
fec_restart() is called which idles all promiscuous mode/multicast settings.
The bridge will then only forward broadcast frames because the promiscuous setting is lost.
Fix: call set_multicast_list(dev) at the end of fec_restart() before ethernet is reenabled.

If there are more questions please write back.

Please CC me as I'm not subscribed to the lists

Regards
Harald


Here are the fixes:

diff -urN linux-2.4.27.orig/arch/ppc/8xx_io/fec.c linux-2.4.27/arch/ppc/8xx_io/fec.c
--- linux-2.4.27.orig/arch/ppc/8xx_io/fec.c	2003-11-28 19:26:18.000000000 +0100
+++ linux-2.4.27/arch/ppc/8xx_io/fec.c	2004-08-10 09:16:00.000000000 +0200
@@ -1466,6 +1466,11 @@
 	return -ENODEV;		/* No PHY we understand */
 #else
 	fep->link = 1;
+
+#ifndef	CONFIG_USE_MDIO
+	fec_restart (dev, 0);
+#endif
+
 	netif_start_queue(dev);
 	return 0;	/* Success */
 #endif	/* CONFIG_USE_MDIO */
@@ -2049,6 +2054,9 @@
 	fecp->fec_imask = ( FEC_ENET_TXF | FEC_ENET_TXB |
 			    FEC_ENET_RXF | FEC_ENET_RXB | FEC_ENET_MII );
 
+	/* set old promiscuous/multicast settings which are lost above */
+	set_multicast_list(dev);
+
 	/* And last, enable the transmit and receive processing.
 	*/
 	fecp->fec_ecntrl = FEC_ECNTRL_PINMUX | FEC_ECNTRL_ETHER_EN; 

