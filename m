Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266034AbRF1Qtw>; Thu, 28 Jun 2001 12:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266032AbRF1Qtm>; Thu, 28 Jun 2001 12:49:42 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:49590 "EHLO
	e32.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266031AbRF1Qtg>; Thu, 28 Jun 2001 12:49:36 -0400
Message-ID: <3B3B5FCE.EF80E5E9@vnet.ibm.com>
Date: Thu, 28 Jun 2001 11:48:14 -0500
From: Todd Inglett <tinglett@vnet.ibm.com>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.16-3.c4eb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: tgall%rchland.vnet@RCHGATE.RCHLAND.IBM.COM, linux-kernel@vger.kernel.org
Subject: Re: RFC: Changes for PCI
In-Reply-To: <3B3A58FC.2728DAFF@vnet.ibm.com> <15162.33158.683289.641171@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Tom Gall writes:
>  >   The first part changes number, primary, and secondary to unsigned ints from
>  > chars. What we do is encode the PCI "domain" aka PCI Primary Host Bridge, aka
>  > pci controller in with the bus number. In our case we do it like this:
>  >
>  > pci_controller=dev->bus->number>>8) &0xFF0000
>  > bus_number= dev->bus->number&0x0000FF),
>  >
>  >   Is this reasonable for everyone?
> 
> This is totally unreasonable.

Well, back in the "Going beyond 256 PCI buses" thread two weeks ago when
you argued that Linux not supporting >256 busses was a fallacy...

"David S. Miller" wrote:
> There are only two real issues: 
> 
> 1) Extending the type bus numbers use inside the kernel. 
> 
>    Basically how most multi-controller platforms work now 
>    is they allocate bus numbers in the 256 bus space as 
>    controllers are probed. If we change the internal type 
>    used by the kernel to "u32" or whatever, we expand that 
>   available space accordingly. 
> 
>   For the lazy, basically go into include/linux/pci.h 
>   and change the "unsigned char"s in struct pci_bus into 
>   some larger type. This is mindless work. 

Yes it is mindless work and is in that patch.  Should we attempt to go
beyond 256 physical busses in 2.4?  Maybe not.  But it is a simple
change and it does work and it works around the existing drivers which
compare busid+devfn for uniqueness when they really should compare
pci_dev pointers.  Should it be redone the correct way (domains) in
2.5?  Absolutely.

The patch does not handle the user mode case.  This leaves the X server
broken.  We could probably weed out busses beyond 256 under
/proc/bus/pci as a workaround -- meaning the video adapter (if any --
rare in these boxes) must be in one of the first I/O drawers.

The added pci_op functions are probably not needed if the code probes
ahead in pcibios_fixup_bus().

> What you want are PCI domains.

Correct.  This is 2.5.

-- 
-todd
