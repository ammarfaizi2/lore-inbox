Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbUKOU3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbUKOU3G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 15:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbUKOU3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 15:29:02 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:44554 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261774AbUKOU2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 15:28:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=dCQ8p4BrBj3rEkB/tpvXpLHZSKHxt4akP/B5DOM7nJcxmnt1rJzEHptYqFK8+4hn7yO4ER9OO/BXUrwsFcXgxgqVje5T4JkJ6idPwb8mvc63zwV4UKmXhCB8cPsTEtmw7HKcuX2lLEieanAq+zzyo9Xi5O02h0g5HKhrcch8CuE=
Message-ID: <d120d500041115122846b9f0fa@mail.gmail.com>
Date: Mon, 15 Nov 2004 15:28:08 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: matthieu castet <castet.matthieu@free.fr>
Subject: Re: [PATCH] PNP support for i8042 driver
Cc: linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>,
       bjorn.helgaas@hp.com, vojtech@suse.cz
In-Reply-To: <419908B8.10202@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41960AE9.8090409@free.fr>
	 <200411140148.02811.dtor_core@ameritech.net>
	 <41974DFD.5070603@free.fr> <d120d50004111506416237ff1b@mail.gmail.com>
	 <419908B8.10202@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2004 20:51:20 +0100, matthieu castet
<castet.matthieu@free.fr> wrote:
> Dmitry Torokhov wrote:
> > Is it possible to leave the device in enabled state or enable device
> > after unloading the driver with PNP? 
> Yes you could do a very ugly hack : set pnp_can_disable(dev) to 0 before
>  unregister. With that the device won't be disabled (no resource
> desalocation), but the device will be mark as not active in pnp layer.
> 

I'd like to release resoures al well (interrupts only really, as ports are
always reserved by the system even before PNP is initialized).

> > All we need from PNP layer
> > for i8042 is to verify presence of the KBC, we don't need resource
> > management.The ports range is already marked as reserved, IRQ
> > will be requested if needed...
> > 
> I don't agree at all :
> - the pci layer allow you to find the device like pnp layer, then you
> register resource with request_region or equivalent. Do we need to do
> the same for all pci drivers?

While PCI devices can be very flexible i8042 is extremely rigid. Its
resources are pretty much fixed and will not move. Its IO port region
is reserved by the kernel right off the bat and is not available to anyone
including PNP subsystem to ensure that nothing will touch it or bad
things might happen. 

> - actually the resources are registered in the kernel, but not in the
> bios, why some strange bios can allow to use irq 12 to an other device
> if it isn't used ?

I think you need to make an effort to make a PCI device use IRQ12
but the idea is that if you don't have a mouse attached (but you do
have i8042) and you are short on free interrupts and your HW can
use IRQ12 for some other stuff let it have it. That is the reqson why
i8042 requests IRQ only when corresponding port is open. No mouse -
IRQ is free.

> - Do you save lot's of memory with __init/__initdata ? The pnp code is
> quite small.
> 

Well it is not needed one i8042 has been initialized at all so why
keep it? Even if it saves 1K it is good enough.

-- 
Dmitry
