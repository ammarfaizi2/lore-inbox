Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbUDGAvu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 20:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbUDGAvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 20:51:50 -0400
Received: from boggle.pobox.com ([208.58.1.193]:9095 "EHLO boggle.pobox.com")
	by vger.kernel.org with ESMTP id S263380AbUDGAvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 20:51:47 -0400
Date: Tue, 6 Apr 2004 17:50:12 -0700
From: Jeff Lightfoot <jeffml@pobox.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] net/sk98lin: correct buggy VPD in ASUS MB
Message-Id: <20040406175012.64fe9d7c.jeffml@pobox.com>
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-pc-linux-gnu)
X-Face: $n=Rh`fC)-'~T?N4{k<m#PDTgj\,OYTK+D(!TTIdBm&(^y:ydlx9:~xe.1@_]/h!~a]D.Ja
 T)qLF2A(b!G{>=V~zorpO2&"J`qbq{|eiZ&k.#tAz{{7.3M_}Y?qY1sB}1,-F
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__6_Apr_2004_17_50_12_-0700_U_OhkD.N/eBLNeGo"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Tue__6_Apr_2004_17_50_12_-0700_U_OhkD.N/eBLNeGo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following patch to net/sk98lin/skvpd.c was put together by Marc
Bouget, mbouget at club-internet.fr.  He currently doesn't have time to
interface with linux-kernel so I offered to work that front.

This patch works around a corrupt EEPROM (VPD?) in the ASUS K8V Deluxe
SE motherboard ethernet chipset and allows the network driver to work
correctly.  We have written to ASUS and the sk98lin maintainers but have
not heard anything back.

Does this have a chance to be included in mainline or is there a
preferable way to fix these kind of issues?

  -- Jeff Lightfoot

--Multipart=_Tue__6_Apr_2004_17_50_12_-0700_U_OhkD.N/eBLNeGo
Content-Type: text/plain;
 name="skvpd.c.diff"
Content-Disposition: attachment;
 filename="skvpd.c.diff"
Content-Transfer-Encoding: 7bit

--- drivers/net/sk98lin/skvpd.c.orig	2004-04-05 17:32:59.000000000 -0700
+++ drivers/net/sk98lin/skvpd.c	2004-04-05 17:33:26.000000000 -0700
@@ -468,6 +468,16 @@
 	
 	pAC->vpd.vpd_size = vpd_size;
 
+	/* Asus K8V Se Deluxe bugfix. Correct VPD content */
+	/* MBo April 2004 */
+	if( ((unsigned char)pAC->vpd.vpd_buf[0x3f] == 0x38) &&
+	    ((unsigned char)pAC->vpd.vpd_buf[0x40] == 0x3c) &&
+	    ((unsigned char)pAC->vpd.vpd_buf[0x41] == 0x45) ) {
+		printk("sk98lin : humm... Asus mainboard with buggy VPD ? correcting data.\n");
+		(unsigned char)pAC->vpd.vpd_buf[0x40] = 0x38;
+	}
+
+
 	/* find the end tag of the RO area */
 	if (!(r = vpd_find_para(pAC, VPD_RV, &rp))) {
 		SK_DBG_MSG(pAC, SK_DBGMOD_VPD, SK_DBGCAT_ERR | SK_DBGCAT_FATAL,



--Multipart=_Tue__6_Apr_2004_17_50_12_-0700_U_OhkD.N/eBLNeGo--
