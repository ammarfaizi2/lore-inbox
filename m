Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263011AbRFNOZX>; Thu, 14 Jun 2001 10:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263016AbRFNOZO>; Thu, 14 Jun 2001 10:25:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:15536 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263011AbRFNOZA>;
	Thu, 14 Jun 2001 10:25:00 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15144.51504.8399.395200@pizda.ninka.net>
Date: Thu, 14 Jun 2001 07:24:48 -0700 (PDT)
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Tom Gall <tom_gall@vnet.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Going beyond 256 PCI buses
In-Reply-To: <3B28C6C1.3477493F@mandrakesoft.com>
In-Reply-To: <3B273A20.8EE88F8F@vnet.ibm.com>
	<3B28C6C1.3477493F@mandrakesoft.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik writes:
 > According to the PCI spec it is -impossible- to have more than 256 buses
 > on a single "hose", so you simply have to implement multiple hoses, just
 > like Alpha (and Sparc64?) already do.  That's how the hardware is forced
 > to implement it...

Right, what userspace had to become aware of are "PCI domains" which
is just another fancy term for a "hose" or "controller".

All you have to do is (right now, the kernel supports this fully)
open up a /proc/bus/pci/${BUS}/${DEVICE} node and then go:

	domain = ioctl(fd, PCIIOC_CONTROLLER, 0);

Viola.

There are only two real issues:

1) Extending the type bus numbers use inside the kernel.

   Basically how most multi-controller platforms work now
   is they allocate bus numbers in the 256 bus space as
   controllers are probed.  If we change the internal type
   used by the kernel to "u32" or whatever, we expand that
   available space accordingly.

   For the lazy, basically go into include/linux/pci.h
   and change the "unsigned char"s in struct pci_bus into
   some larger type.  This is mindless work.

2) Figure out what to do wrt. sys_pciconfig_{read,write}()

   They ought to really be deprecated and the /proc/bus/pci
   way is the expected way to go about doing these things.
   The procfs interface is more intelligent, less clumsy, and
   even allows you to mmap() PCI cards portably (instead of
   doing crap like mmap()s on /dev/mem, yuck).

   Actually, there only real issue here is what happens when
   userspace does PCI config space reads to things which talk
   about "bus numbers" since those will be 8-bit as this is a
   hardware imposed type.  These syscalls take long args already
   so they could use >256 bus numbers just fine.

Basically, this 256 bus limit in Linux is a complete fallacy.

Later,
David S. Miller
davem@redhat.com
