Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262954AbVALAIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbVALAIo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 19:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262916AbVALAFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 19:05:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:1430 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262960AbVALADq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 19:03:46 -0500
Date: Tue, 11 Jan 2005 16:03:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: DHollenbeck <dick@softplc.com>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       magnus.damm@gmail.com
Subject: Re: yenta_socket rapid fires interrupts
In-Reply-To: <41E45410.7070004@softplc.com>
Message-ID: <Pine.LNX.4.58.0501111557260.2373@ppc970.osdl.org>
References: <41E2BC77.2090509@softplc.com> <Pine.LNX.4.58.0501101857330.2373@ppc970.osdl.org>
 <41E42691.3060102@softplc.com> <Pine.LNX.4.58.0501111143370.2373@ppc970.osdl.org>
 <41E44738.2050606@softplc.com> <Pine.LNX.4.58.0501111340570.2373@ppc970.osdl.org>
 <41E45410.7070004@softplc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Jan 2005, DHollenbeck wrote:
> 
> And the dmesg output.  Please look at intctl.  Is this our unsatisfied 
> noise maker?

Hmm. It has I365_PC_RESET set, which does indeed not look right. Could you 
try just forcing it to zero in the initialization path? In fact, that's 
there in the 16-bit card case, but not in the CBCARD case. Something like 
this:

--- 1.65/drivers/pcmcia/yenta_socket.c	2004-12-01 00:14:04 -08:00
+++ edited/drivers/pcmcia/yenta_socket.c	2005-01-11 16:02:45 -08:00
@@ -260,7 +260,7 @@
 
 		/* ISA interrupt control? */
 		intr = exca_readb(socket, I365_INTCTL);
-		intr = (intr & ~0xf);
+		intr &= I365_RING_ENA | I365_INTR_ENA;
 		if (!socket->cb_irq) {
 			intr |= state->io_irq;
 			bridge |= CB_BRIDGE_INTR;

should hopefully take care of it.

		Linus
