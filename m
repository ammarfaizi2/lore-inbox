Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263497AbRFNSAR>; Thu, 14 Jun 2001 14:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263553AbRFNSAJ>; Thu, 14 Jun 2001 14:00:09 -0400
Received: from geos.coastside.net ([207.213.212.4]:33758 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S263497AbRFNR75>; Thu, 14 Jun 2001 13:59:57 -0400
Mime-Version: 1.0
Message-Id: <p0510030eb74ea25caa73@[207.213.214.37]>
In-Reply-To: <15144.51504.8399.395200@pizda.ninka.net>
In-Reply-To: <3B273A20.8EE88F8F@vnet.ibm.com>
 <3B28C6C1.3477493F@mandrakesoft.com>
 <15144.51504.8399.395200@pizda.ninka.net>
Date: Thu, 14 Jun 2001 10:59:06 -0700
To: "David S. Miller" <davem@redhat.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Going beyond 256 PCI buses
Cc: Tom Gall <tom_gall@vnet.ibm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 7:24 AM -0700 2001-06-14, David S. Miller wrote:
>2) Figure out what to do wrt. sys_pciconfig_{read,write}()
>
>    They ought to really be deprecated and the /proc/bus/pci
>    way is the expected way to go about doing these things.
>    The procfs interface is more intelligent, less clumsy, and
>    even allows you to mmap() PCI cards portably (instead of
>    doing crap like mmap()s on /dev/mem, yuck).
>
>    Actually, there only real issue here is what happens when
>    userspace does PCI config space reads to things which talk
>    about "bus numbers" since those will be 8-bit as this is a
>    hardware imposed type.  These syscalls take long args already
>    so they could use >256 bus numbers just fine.
>
>Basically, this 256 bus limit in Linux is a complete fallacy.

There's also the question of pci_ops() (PCI config space access 
routines). Alpha (titan in this example) uses:

	struct pci_controler *hose = dev->sysdata;

but the general idea is that you need the hose info to do 
config-space access on PCI.

The 256-bus fallacy is caused in part by an ambiguity in what we mean 
by "bus". In PCI spec talk, a bus is a very specify thing with an 
8-bit bus number, and this is reflected in various registers and 
address formats. On the other hand we have the general concept of 
buses, which includes the possibility of multiple PCI controllers, 
and thus multiple domains of 256 buses each.

As I recall, even a midline chipset such as the ServerWorks LE 
supports the use of two north bridges, which implies two PCI bus 
domains.

I'd favor adopting something like the Alpha approach, but with a 
dedicated struct pci_device item (and with "controller" spelled 
correctly). And I suppose "domain" sounds a little more sober than 
"hose". But since the domain information is necessary to access 
configuration registers, it really needs to be included in struct 
pci_device.
-- 
/Jonathan Lundell.
