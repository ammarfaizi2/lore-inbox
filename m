Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263583AbUCUAz2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 19:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbUCUAz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 19:55:28 -0500
Received: from 80-218-57-148.dclient.hispeed.ch ([80.218.57.148]:4357 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S263583AbUCUAzX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 19:55:23 -0500
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Russell King <rmk+lkml@arm.linux.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: REMINDER: 2.4.25 and 2.6.x yenta detection issue
Date: Sun, 21 Mar 2004 01:51:55 +0100
User-Agent: KMail/1.5.2
Cc: David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0403191509280.2227-100000@dmt.cyclades> <20040319210720.J14431@flint.arm.linux.org.uk>
In-Reply-To: <20040319210720.J14431@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403210151.56041.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 March 2004 22:07, Russell King wrote:
> On Fri, Mar 19, 2004 at 03:14:54PM -0300, Marcelo Tosatti wrote:
> > It seems the problem reported by Silla Rizzoli is still present in 2.6.x
> > and 2.4.25 (both include the voltage interrogation patch by rmk).
> > 
> > Daniel Ritz made some efforts to fix it, but did not seem to get it right. 
> 
> And that effort is still going on.  Daniel and Pavel have been trying
> to find a good algorithm for detecting and fixing misconfigured TI
> interrupt routing, and this effort is still on-going.
> 
> What would be useful is if Silla could test some of Daniel's patches
> and provide feedback.

silla has another problem. mfunc and devctl are correct. the problems:
- in 2.4 TI1520 is not in the override list, so PCI CSC interrupts are not active
- redoing voltage interrogation: before 2.4.25 when there was no check pcmcia
  was working better for silla (as long as another device was generating
  interrupts) but with the check added cards are not recognized correctly.
- it looks like (i'm not sure) that the socket state is bouncing a bit after card insert
  (the CDETECT bits) so yenta_get_status() returns w/o SS_PENDING too early....
the attached patch fixes it (at least for silla)  and does nothing bad for me...

marcelo, please apply at least the second part of the patch which adds the TI1510/1520.

rgds
-daniel

---patch---

- add the TI1510 and TI1520 to the TI override list
- redo voltage interrogation if none of the voltage bits is set. this also does
  the interrogation when there's no card or a partitial inserted card. some
  bridges may have a wrong state on power up. the check was added to 2.4.25 'cos
  unconditionally doing it breaks on some setups when a card is already
  recognized correctly. this check is still intact with my small modification.
- in yenta_get_status() return SS_PENDING when none of the voltage bits is set
  or a card is only partitiall inserted, but not if there's no card at all.


--- 1.15/drivers/pcmcia/yenta.c	Tue Jan  6 11:55:05 2004
+++ edited/drivers/pcmcia/yenta.c	Sat Mar 20 18:50:07 2004
@@ -135,8 +135,12 @@
 
 	val  = (state & CB_3VCARD) ? SS_3VCARD : 0;
 	val |= (state & CB_XVCARD) ? SS_XVCARD : 0;
-	val |= (state & (CB_CDETECT1 | CB_CDETECT2 | CB_5VCARD | CB_3VCARD
-			 | CB_XVCARD | CB_YVCARD)) ? 0 : SS_PENDING;
+
+	/* when there's may be a card -> SS_PENDING if no voltage bit is set */
+	if ((state & (CB_CDETECT1 | CB_CDETECT2)) != (CB_CDETECT1 | CB_CDETECT2))
+		if (!(state & (CB_5VCARD | CB_3VCARD | CB_XVCARD | CB_YVCARD)) ||
+		    (state & (CB_CDETECT1 | CB_CDETECT2)))
+			val |= SS_PENDING;
 
 	if (state & CB_CBCARD) {
 		val |= SS_CARDBUS;	
@@ -677,10 +681,8 @@
 
 	/* Redo card voltage interrogation */
 	state = cb_readl(socket, CB_SOCKET_STATE);
-	if (!(state & (CB_CDETECT1 | CB_CDETECT2 | CB_5VCARD |
-			CB_3VCARD | CB_XVCARD | CB_YVCARD)))
-		
-	cb_writel(socket, CB_SOCKET_FORCE, CB_CVSTEST);
+	if (!(state & (CB_5VCARD | CB_3VCARD | CB_XVCARD | CB_YVCARD)))
+		cb_writel(socket, CB_SOCKET_FORCE, CB_CVSTEST);
 }
 
 /* Called at resume and initialization events */
@@ -870,6 +872,8 @@
 	{ PD(TI,1420),	&ti_ops },
 	{ PD(TI,4410),	&ti_ops },
 	{ PD(TI,4451),	&ti_ops },
+	{ PD(TI,1510),	&ti_ops },
+	{ PD(TI,1520),	&ti_ops },
 
 	{ PD(RICOH,RL5C465), &ricoh_ops },
 	{ PD(RICOH,RL5C466), &ricoh_ops },
--- 1.85/include/linux/pci_ids.h	Tue Mar 16 20:08:27 2004
+++ edited/include/linux/pci_ids.h	Sat Mar 20 00:19:22 2004
@@ -660,6 +660,8 @@
 #define PCI_DEVICE_ID_TI_4410		0xac41
 #define PCI_DEVICE_ID_TI_4451		0xac42
 #define PCI_DEVICE_ID_TI_1420		0xac51
+#define PCI_DEVICE_ID_TI_1520		0xac55
+#define PCI_DEVICE_ID_TI_1510		0xac56
 
 #define PCI_VENDOR_ID_SONY		0x104d
 #define PCI_DEVICE_ID_SONY_CXD3222	0x8039





