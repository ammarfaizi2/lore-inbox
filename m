Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVBTMi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVBTMi1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 07:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbVBTMi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 07:38:27 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64265 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261826AbVBTMiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 07:38:21 -0500
Date: Sun, 20 Feb 2005 12:38:17 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Martin Drohmann <m_droh01@uni-muenster.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why does printk helps PCMCIA card to initialise?
Message-ID: <20050220123817.A12696@flint.arm.linux.org.uk>
Mail-Followup-To: Martin Drohmann <m_droh01@uni-muenster.de>,
	linux-kernel@vger.kernel.org
References: <42187819.5050808@uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42187819.5050808@uni-muenster.de>; from m_droh01@uni-muenster.de on Sun, Feb 20, 2005 at 12:44:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2005 at 12:44:25PM +0100, Martin Drohmann wrote:
>  #ifdef CONFIG_PCI
>         if (s->cb_dev) {
>                 ret = pci_bus_alloc_resource(s->cb_dev->bus, res, num, 1,
>                                              min, 0, pcmcia_align, &data);
>         } else
>  #endif
> -        printk("This line will never be printed, but it helps!!!");

If you added this, you've done much more than just adding it.  Look 
two lines above and realise that you've just changed what the "else"
clause conditionalises.

>                 ret = allocate_resource(&ioport_resource, res, num, min, 
> ~0UL,
>                                         1, pcmcia_align, &data);

So, with your printk in place, we try pci_bus_alloc_resource.  If that
succeeds or fails, we completely stomp on that with allocate_resource.
Bad.  Very bad.

The first thing that needs solving is why you're getting the "odd IO
request" crap.  That may explain why the resource can't be allocated.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
