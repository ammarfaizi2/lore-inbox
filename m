Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264599AbTLQW6r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 17:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264600AbTLQW6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 17:58:47 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:55821 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264599AbTLQW6p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 17:58:45 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Handling of bounce buffers by rh_call_control
Date: 17 Dec 2003 22:47:14 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <brqmdi$83t$1@gatekeeper.tmr.com>
References: <20031217114125.GA20057@malvern.uk.w2k.superh.com> <3FE08470.5040801@pacbell.net>
X-Trace: gatekeeper.tmr.com 1071701234 8317 192.168.12.62 (17 Dec 2003 22:47:14 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3FE08470.5040801@pacbell.net>,
David Brownell  <david-b@pacbell.net> wrote:
| Hi,
| 
| Richard Curnow wrote:
| > The following patch
| > 
| > ===== drivers/usb/hcd.c 1.10 vs edited =====
| > --- 1.10/drivers/usb/hcd.c      Mon Mar 31 14:22:42 2003
| > +++ edited/drivers/usb/hcd.c    Wed Dec 17 11:26:53 2003
| > @@ -323,7 +323,7 @@
| >         struct usb_ctrlrequest *cmd = (struct usb_ctrlrequest *) urb->setup_packet;
| >         u16             typeReq, wValue, wIndex, wLength;
| >         const u8        *bufp = 0;
| > -       u8              *ubuf = urb->transfer_buffer;
| > +       u8              *ubuf = (u8 *) urb->transfer_dma;
| >         int             len = 0;
| >  
| >         typeReq  = (cmd->bRequestType << 8) | cmd->bRequest;
| > 
| > seems to be needed to make the following code later in the function work
| > 
| > 	if (bufp) {
| > 		if (urb->transfer_buffer_length < len)
| > 			len = urb->transfer_buffer_length;
| > 		urb->actual_length = len;
| > 		// always USB_DIR_IN, toward host
| > 		memcpy (ubuf, bufp, len);
| 
| Which is why that particular patch is wrong:  "ubuf" is a dma address,
| not expected to work for memcpy().

But the existing code most certainly does use it with memcpy. I'm
looking at test11-mm1 source, but the last memcpy line he noted is most
definitely in the existing source.

Or did I misunderstand what you meant by "not expected to work for
memcpy()?" It may be that the code around the memcpy is wrong and should
be using ubuf, and that no diddling with fix it, but someone clearly DID
expect it to work ;-)
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
