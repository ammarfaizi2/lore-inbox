Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129036AbRBHWQf>; Thu, 8 Feb 2001 17:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129108AbRBHWQZ>; Thu, 8 Feb 2001 17:16:25 -0500
Received: from cs.columbia.edu ([128.59.16.20]:63676 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S129036AbRBHWQV>;
	Thu, 8 Feb 2001 17:16:21 -0500
Date: Thu, 8 Feb 2001 14:16:17 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Donald Becker <becker@scyld.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Alan Cox <alan@redhat.com>,
        <linux-kernel@vger.kernel.org>, <jes@linuxcare.com>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <Pine.LNX.4.10.10102081555500.7141-100000@vaio.greennet>
Message-ID: <Pine.LNX.4.30.0102081406020.31024-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001, Donald Becker wrote:

> > > The align-copy should *never* be required because the alignment differs
> > > between DIX and E-II encapsulated packets.  The machine shouldn't crash
> > > because someone sends you a different encapsulation type!
> 
> This is true for a number of drivers -- triggering the copy-align code
> might eliminate the misaligned traps on your local network, but it's not
> a solution.

Ok, so what *is* a good solution then? I'm not arguing that unaligned 
memory access traps should be avoided because they are deadly (they 
shouldn't be), but because they are costly.

Or we can just tell people, "hey, don't use this 64-bit PCI card on a real 
64-bit system, it's broken by design"? I don't think that's a good 
solution either.

The lack of a 64-bit frame descriptor isn't going to help either, if and 
when zerocopy makes into the official tree. Using buffer descriptors with 
fragmented sk_buffs is *not* fun (and yet that's what I do in 32-bit for 
my BSDI driver, but for unrelated reasons).

> I saw the Adaptec people last week at LinuxWorld.  The 2.4.0 starfire
> has a number of actual bugs that should be fixed RSN:
>    The consistency check in the Rx code was broken.  Did anyone ever try
>    the driver after the changes?  The test triggers with every received
>    packet.  The easiest patch is to just get rid the consistency checks
>    inside "#ifndef final_version".

Done.

>    The region resource was not released, requiring a reboot between each
>    driver test.  Trivial fix.

Done.

>    The MII read code is no longer reliable.  I spent twenty minutes at
>    the show, but couldn't figure out the problem.  I haven't been able
>    reproduce the problem locally with my 2.2 code and someone older
>    hardware.

Yes, I've noticed this too, the PHY doesn't seem to get detected in all 
cases, and it's pretty random at that. Other times the same PHY gets 
detected multiple times at different addresses.

The good news is that the same code behaves the same on 2.4 and 2.2, so 
I think it's not a core kernel issue. I'll try to track it down; 
fortunately it doesn't affect card functionality as long as the user 
sticks with autonegotiation.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
