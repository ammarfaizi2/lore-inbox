Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264543AbTGBCmL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 22:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264559AbTGBCmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 22:42:11 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:60544 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S264543AbTGBCmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 22:42:06 -0400
Date: Tue, 1 Jul 2003 22:30:50 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: CarlosRomero <caberome@bellsouth.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Shawn Starr <spstarr@sh0n.net>
Subject: Re: simple pnp bios io resources bug makes  system unusable
Message-ID: <20030701223050.GA19402@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	CarlosRomero <caberome@bellsouth.net>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@digeo.com>, Shawn Starr <spstarr@sh0n.net>
References: <3F010229.4020201@bellsouth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F010229.4020201@bellsouth.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The pnpbios is reserving the complete range of every possible
io port.  This causes device activation to fail for every device
that needs an io port because that resource will always appear
busy.

On Mon, Jun 30, 2003 at 11:38:17PM -0400, CarlosRomero wrote:
> cat /sys/devices/pnp0/00\:0c/name
> Reserved Motherboard Resources
> 
> cat /sys/devices/pnp0/00\:0c/resources
> state = active
> io 0x4d0-0x4d1
> io 0xcf8-0xcff
> io 0x3f7-0x3f7
> io 0x401-0x407
> io 0x298-0x298
> io 0x00000000-0xffffffff
> mem 0xfffe0000-0xffffffff
> mem 0x100000-0x7ffffff
> 
> fixup: check for null io base, other devices are now able to initialize.

Unfortunatly it's not quite that simple.

> static void current_ioresource(struct pnp_resource_table * res, int io, 
> int len)
> {
>        int i = 0;
> 
> +      if (!io) return;
>        while ((res->port_resource[i].flags & IORESOURCE_IO) && i < 
> PNP_MAX_PORT) i++;
>        if (i < PNP_MAX_PORT) {
>                res->port_resource[i].start = (unsigned long) io;
>                res->port_resource[i].end = (unsigned long)(io + len - 1);
>                res->port_resource[i].flags = IORESOURCE_IO;  // Also
> clears _UNSET flag
>        }
> }

Below are two examples that both use a base of 0 in a valid way.

(one for mem)
# cat id
PNP0c01 /* this is a system device */
# cat resources
state = active
mem 0x0-0x9ffff
mem 0xe4000-0xfffff
mem 0x100000-0x3ffffff
mem 0xfff80000-0xfffbffff

(and one for io ports)
# cat id
PNP0200	/* this is an AT DMA Controller */
# cat resources
state = active
io 0x0-0xf
io 0x81-0x8f
io 0xc0-0xdf
dma 4

Therefore just eliminating base 0 addresses is not a proper solution.

Also if we just skip the culprit resource then the resource index number
(a value that many drivers require to be consistent) will be offset by
the number of skipped resources of the same type.

Currently I'm leaning toward this logic...
if we have any of the following situations
- 0x00000000 for base and 0xffffffff for end
- 0x00000000 for base and 0x00000000 for end
- 0xffffffff for base and 0xffffffff for end
then the resource range can be considered disabled.

Also a device can have a disabled resource but not be fully disabled,
such as a parport with some features disabled (ECP etc).  So the
index number must be maintained, this will require some more complex
changes.

I'll have a full fix out soon.

Thanks,
Adam

