Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316132AbSEWGde>; Thu, 23 May 2002 02:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316135AbSEWGdd>; Thu, 23 May 2002 02:33:33 -0400
Received: from thoth.sbs.de ([192.35.17.2]:45699 "EHLO thoth.sbs.de")
	by vger.kernel.org with ESMTP id <S316132AbSEWGdd>;
	Thu, 23 May 2002 02:33:33 -0400
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: linux-kernel@vger.kernel.org
Date: Thu, 23 May 2002 10:33:24 +0400 (MSD)
X-X-Sender: bor@itsrm2.mow.siemens.ru
Subject: ehci-hcd on CARDBUS hangs when stopping card service
Message-ID: <Pine.SV4.4.44.0205231018300.7427-100000@itsrm2.mow.siemens.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There were several reports about Linux hanging on shutdown. In one case
hardware was Dell Inspirion 8100 with Cardbus slot (Texas Instruments
PCI4451) and Adaptec USB2connect (aua-1420) controller.

Logs that were shown were somewhat crippled; in the above case log is:

> Although, I still get the following hang on shutdown:
>
> {HIGH TONE BEEP HERE}
> usb.c: USB disconnect on device
> usb-ohci.c: bogus NDP=255 for OHCI usb - 09:00.1
> (the above two statements are repeated ~4x's)
>
> usb-ohci.c: USB HC Takeover failed!
> usb.c: USB bus 3 deregistered
> usb.c: USB disconnect on device
> usb-ohci.c: USB HDC TakeOver failed!
> usb.c: USB bus 4 deregistered
> hcd.c: remove: 09:00.2, state 3
> usb.c: USB disconnect on device
>
> {TOTAL SYSTEM HANG HERE!}

It appears system hangs in ehci-hcd driver when removing USB tree. What I
suspect happens is:

cs driver (shutdwon_socket()) first powers down card slot and then calls
cb_free() that finally unresgisters USB. It appears that PCI reads from
USB controller in this state return just zeros (that explains bogus NDP
message). In which case it is quite probable that ehci-hcd just loops in
this place in ehci_stop:

        while (readl (&ehci->regs->status) & (STS_ASS | STS_PSS))
                udelay (100);

Unfortunately I do not have corr. hardware to test and guy who initially
reported it won't recompile kernel with more debugging on. So I thought I
just pass it on even if I cannot give a patch.

IMHO sequence in cs driver should be reverted - it is not polite to remove
hardware before giving driver a chance to cleanup :-) Irrespectively,
endless loop in ehci_stop does not look nice.

TIA

-andrej
