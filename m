Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265936AbTBCDrt>; Sun, 2 Feb 2003 22:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265939AbTBCDrt>; Sun, 2 Feb 2003 22:47:49 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:18825 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S265936AbTBCDrs>;
	Sun, 2 Feb 2003 22:47:48 -0500
Date: Sun, 2 Feb 2003 22:59:10 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][RFC] Possible PnP BIOS GPF Solution for Sony VAIO and other laptops
Message-ID: <20030202225910.GB22089@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, CaT <cat@zip.com.au>,
	linux-kernel@vger.kernel.org, greg@kroah.com,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20030202203702.GA23248@neo.rr.com> <20030203020957.GE847@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030203020957.GE847@zip.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2003 at 01:09:57PM +1100, CaT wrote:
> On Sun, Feb 02, 2003 at 08:37:02PM +0000, Adam Belay wrote:
> > The PnP BIOS may be wandering into segement 0x40.  If that is the case,
> > this patch should fix the problem.  I do not have a buggy system so I
> > cannot test this patch but I'd be intersted to hear the results.  If you
> > have a system that has caused pnpbios problems in the past, I recommend
> > you try this patch.  If it works, the system will not panic on startup.
> > This patch is against 2.5.59 and separate from my other recent patches.
> 
> This boots fine here. Then again 2.5.59 booted fine aswell. :) I also
> don't get any oopses from reading /proc/bus/pnp stuff as I did before
> when I first reported issues. As with the bootup, I also don't get these
> issues with 2.5.59. (ie 2.5.59 works fine with or without this patch).

This can be explained.  When the pnpbios makes a get current resource call
on a buggy system it causes a GPF.  In 2.5.59 I designed the pnpbios driver
to avoid making this call when scanning for devices.  It uses a get boot
resource call instead.

In other words...

Without this patch, if you made the following change it would panic.

 		 * from devices that are can only be static such as
 		 * those controlled by the "system" driver.
 		 */
-		if (pnp_bios_get_dev_node(&nodenum, (char )1, node))
+		if (pnp_bios_get_dev_node(&nodenum, (char )0, node))
 			break;
 		nodes_got++;
 		dev =  pnpbios_kmalloc(sizeof (struct pnp_dev), GFP_KERNEL);

1 = boot config
0 = current config

Therefore it can be concluded that this patch does indeed solve the problem
for your system :-).

>
> Sorry for not getting back to you earlier btw... I lost almost a
> fortnights worth of email and yours was amongst them. :/
> 

Thank you for testing my patch.

Regards,
Adam
