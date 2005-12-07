Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbVLGLCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbVLGLCq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 06:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbVLGLCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 06:02:46 -0500
Received: from isilmar.linta.de ([213.239.214.66]:57254 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1750837AbVLGLCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 06:02:46 -0500
Date: Wed, 7 Dec 2005 12:02:44 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Jan De Luyck <lkml@kcore.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.14.2] port smartcard driver to new pcmcia infrastructure?
Message-ID: <20051207110244.GA12569@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Jan De Luyck <lkml@kcore.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm currently looking into getting my smartcard driver to work. O2Micro was 
> nice enough to opensource the driver [1]. The driver compiles without 
> problems, and can be insmod' without triggering any problem. The main problem 
> lies that it doesn't seem to be calling the ozscrx_attach function, which 
> sets up the irq's and everything, thus causing the subsequent open of the 
> device to fail with -ENODEV.
>
> Does anyone have any idea how i can continue debugging this?

The problem is that one, possibly two of the required changes haven't yet
propagated to their driver.

* event handler initialization in struct pcmcia_driver (as of 2.6.13)
   The event handler is notified of all events, and must be initialized
   as the event() callback in the driver's struct pcmcia_driver.
Example patch:
http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=1e212f3645a6b355de8c43a23376bc0e2ac49a63

and

* in-kernel device<->driver matching (as of 2.6.13)
   PCMCIA devices and their correct drivers can now be matched in
   kernelspace. See 'devicetable.txt' for details.
Example patch:
http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff;h=cdcc46e1f11d6dfbf4e741d7c77ec83a4b7c09ac;hp=f3ea4a9f2bf196a0b884cde3d44a2cec27f9db13;hb=ce8a0037e110c1f4ec2fac7a3d791043e4e38cfc;f=drivers/net/pcmcia/pcnet_cs.c
the correct ID is, AFAICS:
	PCMCIA_DEVICE_PROD_ID123("O2Micro", "SmartCardBus Reader", "V1.0", 0x97299583, 0xb8501ba9, 0xe611e659);


For -mm (and for 2.6.16, not .15) there are quite more changes necessary,
which are also described in Documentation/pcmcia/driver-changes.txt.


	Dominik
