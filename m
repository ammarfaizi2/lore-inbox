Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWDMRO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWDMRO1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 13:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWDMRO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 13:14:27 -0400
Received: from isilmar.linta.de ([213.239.214.66]:25523 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932105AbWDMRO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 13:14:27 -0400
Date: Thu, 13 Apr 2006 19:14:25 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>,
       linux-pcmcia@lists.infradead.org, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, metan@seznam.cz
Subject: Re: 2.6.17-rc1: collie -- oopsen in pccardd?
Message-ID: <20060413171425.GA12404@isilmar.linta.de>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Richard Purdie <rpurdie@rpsys.net>,
	linux-pcmcia@lists.infradead.org, lenz@cs.wisc.edu,
	kernel list <linux-kernel@vger.kernel.org>, metan@seznam.cz
References: <20060404122212.GG19139@elf.ucw.cz> <20060404124350.GA16857@flint.arm.linux.org.uk> <20060404000129.GA2590@ucw.cz> <1144923105.7236.18.camel@localhost.localdomain> <20060413164706.GB18635@atrey.karlin.mff.cuni.cz> <20060413165452.GA7805@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413165452.GA7805@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 05:54:52PM +0100, Russell King wrote:
> diff --git a/drivers/pcmcia/pcmcia_resource.c b/drivers/pcmcia/pcmcia_resource.c
> --- a/drivers/pcmcia/pcmcia_resource.c
> +++ b/drivers/pcmcia/pcmcia_resource.c
> @@ -89,7 +88,7 @@ static int alloc_io_space(struct pcmcia_
>         }
>         if ((s->features & SS_CAP_STATIC_MAP) && s->io_offset) {
>                 *base = s->io_offset | (*base & 0x0fff);
> -               s->io[0].Attributes = attr;
> +               s->io[0].res->flags = (s->io[0].res->flags & ~IORESOURCE_BITS) | (attr & IORESOURCE_BITS);
>                 return 0;
>         }
>         /* Check for an already-allocated window that must conflict with
> 
> will probably be the culpret - which is from commit
> c7d006935dfda9174187aa557e94a137ced10c30.
> 
> Static maps do not have IO resources, so s->io[].Attributes was not a
> "duplicated" field in this case.  This part of this change needs
> reverting.

Oh yes, mea culpa. However, we can simply remove setting res->flags here, as
we never read it in this case anyways.

Thanks,
	Dominik


From: Dominik Brodowski <linux@dominikbrodowski.net>
Date: Thu Apr 13 19:06:49 2006 +0200
Subject: [PATCH] pcmcia: fix oops in static mapping case

As static maps do not have IO resources, this setting oopses. However, as
we do not ever read this value, we can safely remove it.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

---

 drivers/pcmcia/pcmcia_resource.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

618d4702f894d73df4f6e631e83699ea5cc87abc
diff --git a/drivers/pcmcia/pcmcia_resource.c b/drivers/pcmcia/pcmcia_resource.c
index 2539c0b..cc3402c 100644
--- a/drivers/pcmcia/pcmcia_resource.c
+++ b/drivers/pcmcia/pcmcia_resource.c
@@ -88,7 +88,6 @@ static int alloc_io_space(struct pcmcia_
 	}
 	if ((s->features & SS_CAP_STATIC_MAP) && s->io_offset) {
 		*base = s->io_offset | (*base & 0x0fff);
-		s->io[0].res->flags = (s->io[0].res->flags & ~IORESOURCE_BITS) | (attr & IORESOURCE_BITS);
 		return 0;
 	}
 	/* Check for an already-allocated window that must conflict with
-- 
1.2.4

 
