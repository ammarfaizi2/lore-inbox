Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263485AbRFNSBr>; Thu, 14 Jun 2001 14:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263553AbRFNSBi>; Thu, 14 Jun 2001 14:01:38 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:61959 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S263485AbRFNSBX>;
	Thu, 14 Jun 2001 14:01:23 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106141801.f5EI13s413231@saturn.cs.uml.edu>
Subject: Re: Going beyond 256 PCI buses
To: davem@redhat.com (David S. Miller)
Date: Thu, 14 Jun 2001 14:01:03 -0400 (EDT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), tom_gall@vnet.ibm.com (Tom Gall),
        linux-kernel@vger.kernel.org
In-Reply-To: <15144.51504.8399.395200@pizda.ninka.net> from "David S. Miller" at Jun 14, 2001 07:24:48 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:
> Jeff Garzik writes:

>> According to the PCI spec it is -impossible- to have more than 256
>> buses on a single "hose", so you simply have to implement multiple
>> hoses, just like Alpha (and Sparc64?) already do.  That's how the
>> hardware is forced to implement it...
>
> Right, what userspace had to become aware of are "PCI domains" which
> is just another fancy term for a "hose" or "controller".
>
> All you have to do is (right now, the kernel supports this fully)
> open up a /proc/bus/pci/${BUS}/${DEVICE} node and then go:
> 
> 	domain = ioctl(fd, PCIIOC_CONTROLLER, 0);
>
> Viola.
>
> There are only two real issues:

No, three.

0) The API needs to be taken out and shot.

   You've added an ioctl. This isn't just any ioctl. It's a
   wicked nasty ioctl. It's an OH MY GOD YOU CAN'T BE SERIOUS
   ioctl by any standard.

   Consider the logical tree:
   hose -> bus -> slot -> function -> bar

   Well, the hose and bar are missing. You specify the middle
   three parts in the filename (with slot and function merged),
   then use an ioctl to specify the hose and bar.

   Doing the whole thing by filename would be better. Else
   why not just say "screw it", open /proc/pci, and do the
   whole thing by ioctl? Using ioctl for both the most and
   least significant parts of the path while using a path
   for the middle part is Wrong, Bad, Evil, and Broken.

   Fix:

   /proc/bus/PCI/0/0/3/0/config   config space
   /proc/bus/PCI/0/0/3/0/0        the first bar
   /proc/bus/PCI/0/0/3/0/1        the second bar
   /proc/bus/PCI/0/0/3/0/driver   info about the driver, if any
   /proc/bus/PCI/0/0/3/0/event    hot-plug, messages from driver...

   Then we have arch-specific MMU cruft. For example the PowerPC
   defines bits that affect caching, ordering, and merging policy.
   The chips from IBM also define an endianness bit. I don't think
   this ought to be an ioctl either. Maybe mmap() flags would be
   reasonable. This isn't just for PCI; one might do an anon mmap
   with pages locked and cache-incoherent for better performance.

> 1) Extending the type bus numbers use inside the kernel.
...
> 2) Figure out what to do wrt. sys_pciconfig_{read,write}()
...
