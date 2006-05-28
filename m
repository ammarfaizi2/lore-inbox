Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWE1Mwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWE1Mwo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 08:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWE1Mwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 08:52:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:50521 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750753AbWE1Mwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 08:52:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=CZr9MGfc1IE+IHl2udRSAinpoJv3IDn1b+g1SjIOqlHyKqHLjl1wgMccQ0od564hxNomMhNISNzdzHeULg/uB/NU1JF0FzhsRC1NdrTW2WunNVz+dZY8Q7QUgkK1cuTzRd2nGJCwrT+Q/ODVu6nGJ4pRd4+t3jaDRCFUD1S0OjE=
Message-ID: <44799D24.7050301@gmail.com>
Date: Sun, 28 May 2006 14:52:29 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Christer Weinigel <christer@weinigel.se>
CC: Nathan Laredo <laredo@gnu.org>, linux-kernel@vger.kernel.org,
       video4linux-list@redhat.com
Subject: Re: Stradis driver conflicts with all other SAA7146 drivers
References: <m3wtc6ib0v.fsf@zoo.weinigel.se>
In-Reply-To: <m3wtc6ib0v.fsf@zoo.weinigel.se>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christer Weinigel napsal(a):
> Hi,
> 
> [Nathan Laredo is the maintainer of the stradis driver but Jiri Slaby
> submitted the PCI probing change that went into 2.6.16 so I'm Cc-ing
> him too.  I'm not a member of the video4linux mailing list so please
> Cc me on any responses.]
> 
> The stradis driver in the 2.6.16 kernel only looks at the SAA7146
> vendor and product ID and binds to any SAA7146 based device even if it
> is not a stradis card.  This stops all other SAA7146 drivers from
> working, for example my WinTV Nova-T card using the budget-ci driver
> doesn't work any longer.  A lot of other people have also been bitten
> by this.
> 
> So could you please modify your driver so that it only binds to real
> stradis cards?  If stradis cards have a subvendor and subdevice ID you
> could just modify the pci_device_id table to look something like this:
> 
> static struct pci_device_id stradis_pci_tbl[] = {
>         { 
>                 .vendor = PCI_VENDOR_ID_PHILIPS, 
>                 .device = PCI_DEVICE_ID_PHILIPS_SAA7146,
>                 .subvendor = 0xdead,
>                 .subdevice = 0xbeef,
>         },
>         { 0 }
> };
> 
>>From the code it looks as if some boards don't have a good subsystem
> vendor and device ID:
> 
>         if (!pdev->subsystem_vendor)
>                 dev_info(&pdev->dev, "%d: rev1 decoder\n", saa_num);
>         else
>                 dev_info(&pdev->dev, "%d: SDM2xx found\n", saa_num);
> 
> Are those rev1 boards out in the real world or are they just
> prototypes?  If they are prototypes, can you add the subvendor ID
> anway and add a module parameter so that your driver only binds to
> unspecified vendor IDs if you use that module parameter?  Something
> like this:
> 
> static int bind_to_anything = 0;
> module_param(bind_to_anything, int, 0);
> 
> int __init stradis_init(void)
> {
>         ...
> 	if (bind_to_anything) {   
> 		stradis_pci_tbl[0].subvendor = PCI_ANY_ID;
> 		stradis_pci_tbl[0].subdevice = PCI_ANY_ID;
>         }
>         ...
>         pci_register_driver(&stradis_driver);
>         ...
> }
> 
> For anyone submitting a new SAA7146 driver to the kernel in the
> future, please be aware that your card isn't the only one that uses
> that chip, so always add a subvendor/subdevice to your drivers.
The only difference is in order of searching for devices. Stradis now gets
control before your "real" driver. Kick stradis from your config or blacklist
it. Or, why you ever load module, you don't want to use?
There is no change in searching devices, it didn't check for subvendors before
not even now. If Nathan knows, there are some subvendor/subdevices ids, which we
should compare to, then yes, we can change the behaviour, otherwise, I am
afraid, we can't. It's vendors' problem, that they don't use this pci registers
(and it's evil) -- i think, that stradis cards have that two zeroed.

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEeZ0kMsxVwznUen4RAoh5AJ4lmYmYd6PYUZsnKOEw6nBnd+BIyACgim5k
PWpWmQPZc5PDpJdntNQ3eic=
=O7It
-----END PGP SIGNATURE-----
