Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbUBURMU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 12:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUBURMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 12:12:19 -0500
Received: from 217-162-59-239.dclient.hispeed.ch ([217.162.59.239]:8196 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S261581AbUBURMS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 12:12:18 -0500
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Silla Rizzoli <silla@netvalley.it>
Subject: Re: 2.4.25 yenta problem and small fix/workaround
Date: Sat, 21 Feb 2004 18:12:14 +0100
User-Agent: KMail/1.5.2
References: <200402202331.45218.daniel.ritz@gmx.ch> <200402211328.56826.silla@netvalley.it>
In-Reply-To: <200402211328.56826.silla@netvalley.it>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402211812.14040.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 February 2004 13:28, Silla Rizzoli wrote:
> > the CB_CDETECT1 and CB_CDETECT2 bits both should be 0 for the card being
> > recognized correctly (and one of the voltage bits need to be set)
> >
> Nope, sorry, same behaviour. :(

either voltage interrogation is still not redone or one of CB_CDETECT1,CB_CDETECT2
is still set afterwards...

could you apply the attached patch (on top of my previous patch) and send the
output of dmesg?

thanx
-daniel


--- drivers/pcmcia/yenta.c~	2004-02-21 17:29:36.000000000 +0100
+++ drivers/pcmcia/yenta.c	2004-02-21 17:37:38.000000000 +0100
@@ -132,6 +132,7 @@
 {
 	unsigned int val;
 	u32 state = cb_readl(socket, CB_SOCKET_STATE);
+	printk(KERN_INFO "yenta_get_status: socket %p state %08x\n", socket, state);
 
 	val  = (state & CB_3VCARD) ? SS_3VCARD : 0;
 	val |= (state & CB_XVCARD) ? SS_XVCARD : 0;
@@ -677,8 +678,9 @@
 
 	/* Redo card voltage interrogation */
 	state = cb_readl(socket, CB_SOCKET_STATE);
+	printk(KERN_INFO "yenta_config_init socket %p state %08x\n", socket, state);
 	if (!(state & (CB_5VCARD | CB_3VCARD | CB_XVCARD | CB_YVCARD)) ||
-	    (state & (CB_CDETECT1 | CB_CDETECT2)))
+	    (state & (CB_CDETECT1 | CB_CDETECT2)) || (state & CB_NOTACARD))
 		cb_writel(socket, CB_SOCKET_FORCE, CB_CVSTEST);
 }
 


