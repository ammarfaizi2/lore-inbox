Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129072AbRCAUJy>; Thu, 1 Mar 2001 15:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129175AbRCAUJo>; Thu, 1 Mar 2001 15:09:44 -0500
Received: from smtp-rt-2.wanadoo.fr ([193.252.19.154]:64734 "EHLO
	apeiba.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S129072AbRCAUJc>; Thu, 1 Mar 2001 15:09:32 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: The IO problem on multiple PCI busses
Date: Thu, 1 Mar 2001 21:09:16 +0100
Message-Id: <19350124134100.15285@smtp.wanadoo.fr>
In-Reply-To: <15006.42475.79484.578530@pizda.ninka.net>
In-Reply-To: <15006.42475.79484.578530@pizda.ninka.net>
X-Mailer: CTM PowerMail 3.0.6 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>As a side note, Alpha has a special PCI syscall to get the "PCI
>controller number" a given PCI device is behind.  We could add
>another ioctl number which does the same thing on /proc/bus/pci/*/*
>nodes.  This way sparc64 and Alpha could have the same user visible
>API for this as well.

And on PPC too since I adapted the pci controller mecanism to
it in 2.4.

In fact, all that is done by our various syscalls could be done by
ioctl's on /proc/bus/pci/*/*.

To be generic, the pci controller number should rather be the pci bus
number of the host bridge (the top of the PCI tree a given device lives
on). The internal controller numbers have no real meaning I think to
userland.

Also, an ioctl to retreive the iobase would be useful too (in addition
to the mmap), especially for getting access to VGA IOs associated with a
given PCI card, but also for whatever test tool one would want to write
in userland that access legacy IOs on a given PCI bus.
Having the mmap is fine, but I like having also the ability to retreive
all the informations via an ioctl too. 

I beleive that if we can agree on the in-kernel format of the PCI
controller structure and function to retreive it from a bus number, we
can make this generic.

For us, the pci controller requires at least an iobase (physical &
virtual as we always ioremap the IO space during boot) for generating
io cycles, the config ops, the mem offset (some platforms don't have
a 1:1 mapping of memory cycles vs. CPU bus cycles for PCI memory, for
example, on PReP, you write to physical c0000000 to get a PCI memory
write to 00000000). And finally the isa memory base (it may be located
differently, some bridge have 1:1 mappings and so allow only high
memory addresses to go to the PCI, but do open a "window" at a different
physical address to generate ISA memory cycles (low address cycles)).

Finally, we have some private datas (pointer to OF node for example),
the resource structures (so that we know what a given host bridge can
decode and can allocate unallocated PCI resources properly).

I'm not familiar with the requirements of other archs however.

Ben.
