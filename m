Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbUBTWhq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 17:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbUBTWhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 17:37:46 -0500
Received: from 217-162-59-239.dclient.hispeed.ch ([217.162.59.239]:24581 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S261318AbUBTWhn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 17:37:43 -0500
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Silla Rizzoli <silla@netvalley.it>, David Hinds <dhinds@sonic.net>
Subject: Re: 2.4.25 yenta problem and small fix/workaround
Date: Fri, 20 Feb 2004 23:31:44 +0100
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402202331.45218.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

silla, does this one help?
dave, what do you think?

rgds
-daniel

patch:
the CB_CDETECT1 and CB_CDETECT2 bits both should be 0 for the card being
recognized correctly (and one of the voltage bits need to be set)

--- 1.15/drivers/pcmcia/yenta.c	Tue Jan  6 11:55:05 2004
+++ edited/drivers/pcmcia/yenta.c	Fri Feb 20 23:17:54 2004
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

