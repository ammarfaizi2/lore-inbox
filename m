Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275301AbRJFQ5W>; Sat, 6 Oct 2001 12:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275320AbRJFQ5N>; Sat, 6 Oct 2001 12:57:13 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:48395 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S275301AbRJFQ47> convert rfc822-to-8bit; Sat, 6 Oct 2001 12:56:59 -0400
Date: Sat, 6 Oct 2001 18:51:58 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: <paulus@samba.org>, "David S. Miller" <davem@redhat.com>, <jes@sunsite.dk>,
        <linuxopinion@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: how to get virtual address from dma address 
In-Reply-To: <200110061445.f96Ej5S01591@localhost.localdomain>
Message-ID: <20011006180825.T8432-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[...]

> Worse still, every driver that needs this feature is doing it on its own, so
> the code for doing this in usb-ohci is different from the code in the
> sym53c8xx driver etc.  We're now duplicating this fairly subtle and complex
> code all over the driver base.

What's complex??

The sym53c8xx driver uses a simple hash table to retrieve the IO control
block from the DSA value. This DSA value is in fact the bus physical
address. Indeed, this is kind of reverse mapping DMA address -> Virtual
address, but the code is about 20 lines _only_, and it is absolutely not
complex, neither it impacts performances nor makes significant difference
about memory used. The driver could, for example, use a simple index
instead and retrieve the IO control block from an array of virtual
addresses, as does the aic7xxx driver, for example. This simple reverse
mapping seemed to me more appropriate for the sym53c8xx stuff.

In my opinion, any bus_to_virt() thing hurts a lot. It only makes sense if
it refers to the virt_to_bus() mapping that was used to generate the bus
address and assumes the reverse function to be a mapping. A general
bus_to_virt() thing looks so ugly thing to me that I donnot want to ever
use such. Even if we implicitely assume that it refers to some 'virtual to
DMA mapping' that ensures that each virtual address only maps a single DMA
address, it may be trivial to implement on some arch with no significant
overhead but it can be complex to implement on some other or may suffer of
significant overhead.

Frankly, I definitely would not like any general bus_to_virt() to be
resurrected.

By the way, what is a bit complex in the sym53c8xx driver is probably the
memory allocator that provides virtual to bus address mapping for internal
driver data structures + naturally aligned allocations. I wrote it once
and now it is also useful for SYM-2 that runs on 3 O/Ses. I haven't had
any problem with that code since day one, so I will keep with it even if
some O/S does provide an equivalent service. :-)

[...]

Regards,
  Gérard.

