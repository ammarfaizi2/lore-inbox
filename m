Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262253AbVDFQtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbVDFQtx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 12:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVDFQtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 12:49:53 -0400
Received: from palrel13.hp.com ([156.153.255.238]:36332 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262253AbVDFQto (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 12:49:44 -0400
Date: Wed, 6 Apr 2005 09:49:43 -0700
To: Michal Rokos <michal@rokos.info>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [IrDA] Oops with NULL deref in irda_device_set_media_busy
Message-ID: <20050406164943.GA12518@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <200504051102.27533.michal@rokos.info> <20050405170102.GD10447@bougret.hpl.hp.com> <200504060922.49267.michal@rokos.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504060922.49267.michal@rokos.info>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.6+20040907i
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2005 at 09:22:48AM +0200, Michal Rokos wrote:
> Hello again,
> 
> I'm gonna provide more info this time...
> 
> > > When I turn debug on, I get just
> > > Assertion failed! net/irda/irda_device.c:irda_device_set_media_busy:128
> > > self != NULL
> > >
> > > The obvious reason is that I don't have irlap module in that inits
> > > dev->atalk_ptr, so I'm getting assertion exception in irda_device.c:489.
> 
> The assertion is seen when ifup -a is called so it's when 'ifconfig irda0 up' 
> is used.

	That was the crucial bit that was missing. Now I get it. A
good night of sleep also did help.
	Patch attached.

	Jean

-----------------------------------------------------

diff -u -p linux/net/irda/irda_device.d2.c linux/net/irda/irda_device.c
--- linux/net/irda/irda_device.d2.c	Wed Apr  6 09:40:09 2005
+++ linux/net/irda/irda_device.c	Wed Apr  6 09:45:22 2005
@@ -125,8 +125,15 @@ void irda_device_set_media_busy(struct n
 
 	self = (struct irlap_cb *) dev->atalk_ptr;
 
-	IRDA_ASSERT(self != NULL, return;);
-	IRDA_ASSERT(self->magic == LAP_MAGIC, return;);
+	/* Some drivers may enable the receive interrupt before calling
+	 * irlap_open(), or they may disable the receive interrupt
+	 * after calling irlap_close().
+	 * The IrDA stack is protected from this in irlap_driver_rcv().
+	 * However, the driver calls directly the wrapper, that calls
+	 * us directly. Make sure we protect ourselves.
+	 * Jean II */
+	if (!self || self->magic != LAP_MAGIC)
+		return;
 
 	if (status) {
 		self->media_busy = TRUE;
