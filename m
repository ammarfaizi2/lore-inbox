Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQLFVhh>; Wed, 6 Dec 2000 16:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129415AbQLFVh2>; Wed, 6 Dec 2000 16:37:28 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:33798 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129267AbQLFVhX>;
	Wed, 6 Dec 2000 16:37:23 -0500
Message-ID: <3A2EAA62.1DB6FCCC@mandrakesoft.com>
Date: Wed, 06 Dec 2000 16:06:42 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jerdfelt@valinux.com, usb@in.tum.de
Subject: Re: test12-pre6
In-Reply-To: <20001206200803.C847@arthur.ubicom.tudelft.nl> <Pine.LNX.4.10.10012061131320.1873-100000@penguin.transmeta.com> <20001206210928.G847@arthur.ubicom.tudelft.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw wrote:
> 
> On Wed, Dec 06, 2000 at 11:38:30AM -0800, Linus Torvalds wrote:
> > But I see something obviously wrong there: you have busmaster disabled.
> >
> > Looking into the UHCI controller code, I notice that neither UHCI driver
> > actually does the (required)
> >
> >       pci_set_master(dev);
> >
> > Please add that to just after a successful "pci_enable_device(dev)", and I
> > just bet your USB will start working.
> 
> Yes, that did the trick! Problem solved, thanks a lot!
> 
> > Johannes, Georg, the above is a fairly embarrassing bug, and is likely to
> > explain a _lot_ of USB failures (the OHCI driver does do this, btw).
> 
> Here is the patch, I don't know if it is enabled in the right place,
> but it definatively fixes the problem.
> 
> --- drivers/usb/uhci.c.old      Wed Dec  6 20:55:05 2000
> +++ drivers/usb/uhci.c  Wed Dec  6 20:55:37 2000
> @@ -2383,6 +2383,8 @@
>         if (pci_enable_device(dev) < 0)
>                 return -ENODEV;
> 
> +       pci_set_master(dev);
> +
>         if (!dev->irq) {
>                 err("found UHCI device with no IRQ assigned. check BIOS
> settings!");
>                 return -ENODEV;
> --- drivers/usb/usb-uhci.c.old  Wed Dec  6 20:53:58 2000
> +++ drivers/usb/usb-uhci.c      Wed Dec  6 20:54:48 2000
> @@ -2941,6 +2941,8 @@
> 
>         if (pci_enable_device(dev) < 0)
>                 return -ENODEV;
> +
> +       pci_set_master(dev);
> 
>         /* Search for the IO base address.. */
>         for (i = 0; i < 6; i++) {
> 

I didn't test your patch, but it looks good.  Immediately following
pci_enable_device is generally a really good place for the call to
pci_set_master.

	Jeff


-- 
Jeff Garzik         |
Building 1024       | These are not the J's you're lookin' for.
MandrakeSoft        | It's an old Jedi mind trick.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
