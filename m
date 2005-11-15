Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbVKOApe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbVKOApe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 19:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbVKOApd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 19:45:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16366 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932232AbVKOApc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 19:45:32 -0500
Date: Mon, 14 Nov 2005 19:45:18 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Martin Bachem <info@colognechip.com>
Subject: Re: [PATCH] i4l: update hfc_usb driver
Message-ID: <20051115004518.GA26922@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Martin Bachem <info@colognechip.com>
References: <200511071721.jA7HLC18028788@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511071721.jA7HLC18028788@hera.kernel.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 09:21:12AM -0800, Linux Kernel wrote:
 > tree 0bb0aeb735a917561cf4d91d4c3fa1ed5434bede
 > parent 6978bbc097c2f665c336927a9d56ae39ef75fa56
 > author Martin Bachem <info@colognechip.com> Mon, 07 Nov 2005 17:00:20 -0800
 > committer Linus Torvalds <torvalds@g5.osdl.org> Mon, 07 Nov 2005 23:53:47 -0800
 > 
 > [PATCH] i4l: update hfc_usb driver
 > 
 >   - cleanup source
 >   - remove nonfunctional code parts

Something isn't right with this.  We've got a number of reports from
Fedora rawhide users over the last few days since this went in that
this module is now auto-loading itself, and preventing other usb devices
from working.

Looking at it, I spotted what I think is one problem, though it isn't a fix..

 > +static struct usb_device_id hfcusb_idtab[] = {
 > +	{
 > +	 .idVendor = 0x0959,
 > +	 .idProduct = 0x2bd0,
 > +	 .driver_info = (unsigned long) &((hfcsusb_vdata)
 > +			  {LED_OFF, {4, 0, 2, 1},
 > +			   "ISDN USB TA (Cologne Chip HFC-S USB based)"}),
 > +	},
.... 
 > +	{
 > +	 .idVendor = 0x07b0,
 > +	 .idProduct = 0x0006,
 > +	 .driver_info = (unsigned long) &((hfcsusb_vdata)
 > +			  {LED_SCHEME1, {0x80, -64, -32, -16},
 > +			   "Twister ISDN TA"}),
 > +	 },
 >  };

This list isn't terminated.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.14/drivers/isdn/hisax/hfc_usb.c~	2005-11-14 17:08:04.000000000 -0500
+++ linux-2.6.14/drivers/isdn/hisax/hfc_usb.c	2005-11-14 17:08:17.000000000 -0500
@@ -140,6 +140,7 @@ static struct usb_device_id hfcusb_idtab
 			  {LED_SCHEME1, {0x80, -64, -32, -16},
 			   "Twister ISDN TA"}),
 	 },
+	{ }	/* Terminating entry */
 };
 
 

There's still something very odd though...

(19:42:39:davej@nwo:~)$ modinfo hfc_usb
filename:       /lib/modules/2.6.14-1.1663_FC5/kernel/drivers/isdn/hisax/hfc_usb.ko
license:        GPL
description:    HFC-S USB based HiSAX ISDN driver
author:         Peter Sprenger (sprenger@moving-byters.de)
srcversion:     25809AF1F50EE1387A42B75
alias:          usb:v*p*d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v*p*d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v*p*d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v*p*d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v*p*d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v*p*d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v*p*d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v*p*d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v*p*d*dc*dsc*dp*ic*isc*ip*
depends:        hisax
vermagic:       2.6.14-1.1663_FC5 SMP gcc-4.0


Note the wildcard aliases.

		Dave

