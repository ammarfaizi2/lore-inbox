Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269900AbTHFQPt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 12:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269958AbTHFQPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 12:15:49 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:43649 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S269900AbTHFQPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 12:15:46 -0400
Date: Wed, 6 Aug 2003 11:42:25 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Misha Nasledov <misha@nasledov.com>, Andrew Morton <akpm@osdl.org>,
       Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.5/2.6 PCMCIA Issues
Message-ID: <20030806114225.GI13275@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Misha Nasledov <misha@nasledov.com>, Andrew Morton <akpm@osdl.org>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20030804232204.GA21763@nasledov.com> <20030805144453.A8914@flint.arm.linux.org.uk> <20030806045627.GA1625@nasledov.com> <200308060559.h765xhI05860@mail.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308060559.h765xhI05860@mail.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 10:59:43PM -0700, OSDL wrote:
> Misha Nasledov wrote:
> > 
> > I am attaching the dmesg output after booting 2.6.0-test2; this does
> > not include the insertion of the Orinoco card as the console freezes
> > immediately after the event. I inspected my logs after a reboot and
> > there were no messages whatsoever regarding the event of the insertion
> > of the Orinoco card.
> 
> Can you try with PnP and the i82365 support _disabled_. I find this sequence
> very suspicious:
> 
>         Intel PCIC probe: PNP <6>pnp: Device 00:17 activated.
>         invalid resources ?
>         pnp: Device 00:17 disabled.
>         not found.

Here's a quick fix that will at least correct the i82365 probing.  It will
be interesting to see what effect it has on these other problems.  Note
that this driver needs some work with check_region etc.

[PCMCIA] Fix PnP Probing in i82365.c
pnp_x_valid returns 1 if valid.  Therefore we should be using !pnp_port_valid.
Also cleans up some formatting issues.

--- a/drivers/pcmcia/i82365.c	2003-07-27 17:08:32.000000000 +0000
+++ b/drivers/pcmcia/i82365.c	2003-08-06 11:18:21.000000000 +0000
@@ -795,16 +795,14 @@

 	    if (pnp_device_attach(dev) < 0)
 	    	continue;
-
-	    printk("PNP ");
-
+
 	    if (pnp_activate_dev(dev) < 0) {
 		printk("activate failed\n");
 		pnp_device_detach(dev);
 		break;
 	    }

-	    if (pnp_port_valid(dev, 0)) {
+	    if (!pnp_port_valid(dev, 0)) {
 		printk("invalid resources ?\n");
 		pnp_device_detach(dev);
 		break;


> 
> and I bet it messes up some of the register state that the yenta probe had
> just set up.
> 
> You should try with just CONFIG_YENTA - the 82365 stuff is for the old
> 16-bit only controllers.
> 
>                 Linus

Thanks,
Adam
