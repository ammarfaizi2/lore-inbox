Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132199AbQKXHeo>; Fri, 24 Nov 2000 02:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132082AbQKXHee>; Fri, 24 Nov 2000 02:34:34 -0500
Received: from toesinperil.com ([216.207.184.47]:8198 "HELO toesinperil.com")
        by vger.kernel.org with SMTP id <S129434AbQKXHea>;
        Fri, 24 Nov 2000 02:34:30 -0500
Date: Thu, 23 Nov 2000 23:06:14 -0800
From: Michael Elkins <me@toesinperil.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: Rui Sousa <rsousa@grad.physics.sunysb.edu>, usb@in.tum.de,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Re: PROBLEM: kernel 2.4.0-test11-ac1 hang with usb-uhci and emu10k1
Message-ID: <20001123230614.A32540@toesinperil.com>
In-Reply-To: <3A1DA2F7.94114CD2@mandrakesoft.com> <Pine.LNX.4.10.10011231551210.1702-100000@penguin.transmeta.com> <20001123020203.A30491@toesinperil.com> <Pine.LNX.4.21.0011231028030.17678-100000@grad.physics.sunysb.edu> <20001123174952.B7591@in.tum.de> <20001123144517.A31910@toesinperil.com> <3A1DA2F7.94114CD2@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.10i
In-Reply-To: <3A1DA2F7.94114CD2@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Nov 23, 2000 at 06:06:31PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2000 at 06:06:31PM -0500, Jeff Garzik wrote:
> Michael Elkins wrote:
> > 
> > On Thu, Nov 23, 2000 at 05:49:52PM +0100, Georg Acher wrote:
> > It hangs in start_uhci():
> > 
> >                 /* disable legacy emulation */
> >                 pci_write_config_word (dev, USBLEGSUP, USBLEGSUP_DEFAULT);
> > 
> > The loop that the call is in gets iterated 5 times.  For i < 4, the
> >                 if (!(dev->resource[i].flags & 1))
> > is TRUE, but on i==4, it drops into the bottom of the loop to execute
> > check_region() and then pci_write_config_word(), where it hangs.
> 
> It may not make a difference, but that check is flat out wrong.

The loop still exhibits the same behavior.

/usr/include/linux/ioport.h:#define IORESOURCE_IO               0x00000100 /* Resource type */

Definitely a different value, however.

> Apply this patch...  (untested, you may need to include ioport.h)

fyi, ioport.h isn't required.

On Thu, Nov 23, 2000 at 03:53:27PM -0800, Linus Torvalds wrote:
> Try changing the thing around a bit: make the above place say
> 
> 	/* disable legacy emulation */
> 	pci_write_config_word (dev, USBLEGSUP, 0);
> 
> and then AFTER we have successfully done a request_irq() call, we 
> can enable PCI interrupts with
> 
> 	/* Enable PIRQ */
> 	pci_write_config_word (dev, USBLEGSUP, USBLEGSUP_DEFAULT);
> 
> Does that make it happier?

Yep! That seems to have fixed it.  Added the pci_write_config_word() after
the request_irq() in alloc_uhci().

me
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
