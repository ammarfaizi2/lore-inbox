Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264444AbUHJL6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbUHJL6X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 07:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUHJL6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 07:58:23 -0400
Received: from CWareNS1.Controlware.DE ([193.22.120.157]:60876 "EHLO
	cwarens1.controlware.de") by vger.kernel.org with ESMTP
	id S264444AbUHJL6R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 07:58:17 -0400
Message-Id: <s118d477.053@post2.controlware.de>
X-Mailer: Novell GroupWise Internet Agent 6.0.2
Date: Tue, 10 Aug 2004 13:57:45 +0200
From: "=?ISO-8859-1?Q?Harald=20K=FCthe?=" <Harald.Kuethe@controlware.de>
To: <jolt@tuxbox.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH][PPC32] 2.4.27: fixes for 8xx fec.c
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian

well you are right thank you.
Now the patch looks like:

diff -urN linux-2.4.27.orig/arch/ppc/8xx_io/fec.c linux-2.4.27/arch/ppc/8xx_io/fec.c
--- linux-2.4.27.orig/arch/ppc/8xx_io/fec.c	2003-11-28 19:26:18.000000000 +0100
+++ linux-2.4.27/arch/ppc/8xx_io/fec.c	2004-08-10 13:54:06.000000000 +0200
@@ -1466,6 +1466,8 @@
 	return -ENODEV;		/* No PHY we understand */
 #else
 	fep->link = 1;
+	/* after ifconfig down and up fec will not start -> restart it */
+	fec_restart (dev, 0);
 	netif_start_queue(dev);
 	return 0;	/* Success */
 #endif	/* CONFIG_USE_MDIO */
@@ -2049,6 +2051,9 @@
 	fecp->fec_imask = ( FEC_ENET_TXF | FEC_ENET_TXB |
 			    FEC_ENET_RXF | FEC_ENET_RXB | FEC_ENET_MII );
 
+	/* set old promiscuous/multicast settings which are lost above */
+	set_multicast_list(dev);
+
 	/* And last, enable the transmit and receive processing.
 	*/
 	fecp->fec_ecntrl = FEC_ECNTRL_PINMUX | FEC_ECNTRL_ETHER_EN;


Reagrds
Harald

>>> Florian Schirmer <jolt@tuxbox.org> 10.08.04 10:42:12 >>>
Hi,

>+
>+#ifndef	CONFIG_USE_MDIO
>+	fec_restart (dev, 0);
>+#endif
>+
> 	netif_start_queue(dev);
> 	return 0;	/* Success */
> #endif	/* CONFIG_USE_MDIO */
>  
>

Just a minor hint: you don't need the #ifndef CONFIG_USE_MDIO guard 
since you're already in the non MDIO branch (see #endif comment).

Greetings,
  Florian

