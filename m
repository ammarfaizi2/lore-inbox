Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWDMQ4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWDMQ4F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 12:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWDMQ4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 12:56:04 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44299 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751070AbWDMQ4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 12:56:03 -0400
Date: Thu, 13 Apr 2006 17:54:52 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Richard Purdie <rpurdie@rpsys.net>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-pcmcia@lists.infradead.org, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, metan@seznam.cz
Subject: Re: 2.6.17-rc1: collie -- oopsen in pccardd?
Message-ID: <20060413165452.GA7805@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Richard Purdie <rpurdie@rpsys.net>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-pcmcia@lists.infradead.org, lenz@cs.wisc.edu,
	kernel list <linux-kernel@vger.kernel.org>, metan@seznam.cz
References: <20060404122212.GG19139@elf.ucw.cz> <20060404124350.GA16857@flint.arm.linux.org.uk> <20060404000129.GA2590@ucw.cz> <1144923105.7236.18.camel@localhost.localdomain> <20060413164706.GB18635@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413164706.GB18635@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 06:47:06PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > > > I'm getting some oopses when inserting/removing pccard (on collie,
> > > > > oopses in pccardd). It does not break boot, so it is not immediate
> > > > > problem, but I wonder if it also happens on non-collie machines?
> > > > 
> > > > No idea what so ever.  Not even any clues as to what might be going wrong
> > > > due to the lack of oops dump.  (Not that I even look after PCMCIA anymore.)
> > > 
> > > Sorry for lack of oops. I was not expecting you to debug it, I
> > > expected some voices telling me it is broken for them, too :-).
> > 
> > With a recent git kernel (907d91d708d9999bec0185d630062576ac4181a7) I
> > see the oops below when booting spitz (SL-C3000 - ARM pxa270 based). Was
> > this the same oops you saw Pavel?
> 
> I think so.

diff --git a/drivers/pcmcia/pcmcia_resource.c b/drivers/pcmcia/pcmcia_resource.c
--- a/drivers/pcmcia/pcmcia_resource.c
+++ b/drivers/pcmcia/pcmcia_resource.c
@@ -89,7 +88,7 @@ static int alloc_io_space(struct pcmcia_
        }
        if ((s->features & SS_CAP_STATIC_MAP) && s->io_offset) {
                *base = s->io_offset | (*base & 0x0fff);
-               s->io[0].Attributes = attr;
+               s->io[0].res->flags = (s->io[0].res->flags & ~IORESOURCE_BITS) | (attr & IORESOURCE_BITS);
                return 0;
        }
        /* Check for an already-allocated window that must conflict with

will probably be the culpret - which is from commit
c7d006935dfda9174187aa557e94a137ced10c30.

Static maps do not have IO resources, so s->io[].Attributes was not a
"duplicated" field in this case.  This part of this change needs
reverting.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
