Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263386AbVCJXZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263386AbVCJXZi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 18:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbVCJXUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 18:20:44 -0500
Received: from gate.crashing.org ([63.228.1.57]:46291 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263363AbVCJXIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 18:08:11 -0500
Subject: Re: [AGPGART] Map the graphic card to the bridge its connected to.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: davej@redhat.com, Linus Torvalds <torvalds@osdl.org>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <200503070222.j272MJai027858@hera.kernel.org>
References: <200503070222.j272MJai027858@hera.kernel.org>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 10:02:50 +1100
Message-Id: <1110495771.32525.287.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-23 at 02:25 +0000, Linux Kernel Mailing List wrote:
> ChangeSet 1.1982.82.19, 2005/02/22 21:25:33-05:00, davej@delerium.kernelslacker.org
> 
> 	[AGPGART] Map the graphic card to the bridge its connected to.
> 	
> 	Signed-off-by: Dave Jones <davej@redhat.com>
> 
> 
> 
>  generic.c |    5 +++++
>  1 files changed, 5 insertions(+)
> 
> 
> diff -Nru a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
> --- a/drivers/char/agp/generic.c	2005-03-06 18:22:31 -08:00
> +++ b/drivers/char/agp/generic.c	2005-03-06 18:22:31 -08:00
> @@ -636,6 +636,11 @@
>  			pci_dev_put(device);
>  			continue;
>  		}
> +		if ((device->bus->self->vendor != bridge->dev->vendor) &&
> +			(device->bus->self->device != bridge->dev->device)) {
> +			pci_dev_put(device);
> +			continue;
> +		}
>  	}
>  

That sounds totally bogus and blows up on pmac, please revert.

device->bus may be a host bridge, which has no bus->self -> Ooops.

Unfortunately, there is no sane way to match a host bridge with it's
eventual "self" device if it has any. The only way would be to scan for
devices of class host bridge, but that isn't even 100% reliable.

The result is that the self device (AGP bridge device) is generally a
sibling of the actual AGP card, which is source of interesting problems,
especially with power management.

Ideally, the AGP property should be implemented at the "bus instance"
level, but we don't really have a real pci bus driver layer at this
point, and we can't use normal PCI discovery to find host bridges, so
that would require arch support.

In the meantime, please revert the above, it will just blow up on a
number of setups.

Ben.


