Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317030AbSEWWb5>; Thu, 23 May 2002 18:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317034AbSEWWb4>; Thu, 23 May 2002 18:31:56 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:58326 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S317030AbSEWWbz>; Thu, 23 May 2002 18:31:55 -0400
Date: Thu, 23 May 2002 15:32:43 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: ehci-hcd on CARDBUS hangs when stopping card service
To: Andrej.Borsenkow@mow.siemens.ru, linux-kernel@vger.kernel.org
Message-id: <3CED6E0B.8020501@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
In-Reply-To: <20020523171326.GA11562@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've recently got some similar reports, but with a few less
facts ... it was clear to me there was a problem somewhere
in the CardBus code, since I know that cleanup via rmmod is
working fine, and in fact that's the workaround one person
had ended up with!


>>usb-ohci.c: bogus NDP=255 for OHCI usb - 09:00.1
>>(the above two statements are repeated ~4x's)

And the OHCI driver hits a related problem too ...


> IMHO sequence in cs driver should be reverted - it is not polite to remove
> hardware before giving driver a chance to cleanup :-)

Yes, absolutely.  It's turning a "clean shutdown" scenario into a
"dirty shutdown" ... a normal "rmmod" works, correctly, and from the
perspective of a device driver (if not the CardBus code) those should
be exactly the same:  two ways to start the same driver shutdown.

That current sequence (powerdown before pci_dev->remove) violates the
device tree sequencing requirement ... which I recall was one of the
key features of the original 2.4 CardBus support.  Did it change rather
recently, or has this bug really been lurking for a very long time?
I'd expect to have heard about that OHCI problem (seemingly the same root
cause) before, since there are folk using Cardbus OHCI (more using EHCI!),
but nobody's reported it that I know of.

I'll hope that problem appears only in 2.4.18-6mdk, and isn't found in
other kernels.  In particular, if it's in 2.5.17 then there's a big
hole in the "new driver model" work (struct device etc)!


 > 
	 Irrespectively,
> endless loop in ehci_stop does not look nice.

I partially agree.  For a clean shutdown, it's guaranteed not to be
endless.  For a dirty shutdown -- physically ejecting the card, or
the hardware having truly nasty failure mode (one I've not seen but
which could conceivably happen) -- it's a problem to fix.

Is there a clean way to detect the "card ejected before anything calls 
pci_dev->remove()" case?  I don't really like the idea of wrapping code
around every PCI register access to detect such cases.

- Dave



