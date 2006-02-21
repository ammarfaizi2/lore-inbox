Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWBUWk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWBUWk7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 17:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWBUWk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 17:40:59 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:37381 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S1750759AbWBUWk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 17:40:58 -0500
Message-ID: <43FB9718.4050606@suse.com>
Date: Tue, 21 Feb 2006 17:41:28 -0500
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
Cc: mchan@broadcom.com, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com, netdev@vger.kernel.org
Subject: Re: [PATCH] tg3: netif_carrier_off runs too early; could still be
 queued when init fails
References: <20060220194337.GA21719@locomotive.unixthugs.org>	<1140540260.20584.6.camel@rh4> <20060221.133947.05470613.davem@davemloft.net>
In-Reply-To: <20060221.133947.05470613.davem@davemloft.net>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

David S. Miller wrote:
> From: "Michael Chan" <mchan@broadcom.com>
> Date: Tue, 21 Feb 2006 08:44:20 -0800
> 
>> On Mon, 2006-02-20 at 14:43 -0500, Jeff Mahoney wrote:
>>>  This patch moves the netif_carrier_off() call from tg3_init_one()->
>>>  tg3_init_link_config() to tg3_open() as is the convention for most
>>>  other network drivers.
>> I think moving netif_carrier_off() later is the right thing to do. We
>> can also move it to the end of tg3_init_one() just before returning 0.
> 
> Agreed.
> 
>>>  I was getting a panic after a tg3 device failed to initialize due to DMA
>>>  failure. The oops pointed to the link watch queue with spinlock debugging
>>>  enabled. Without spinlock debugging, the Oops didn't occur.
>>>
>>>  I suspect that the link event was getting queued but not executed until
>>>  after the DMA test had failed and the device was freed. The link event
>>>  was then operating on freed memory, which could contain anything. With this
>>>  patch applied, the Oops no longer occurs. 
>> DMA test failed? What NIC device do you have? How did it fail?
> 
> I get this too with an old 5700 3COM card on sparc64.  I'll get
> you some more detailed info later today, hopefully.
> 
> Jeff, please get some details for Michael about your failure
> case.  Thanks.

dmesg after modprobe tg3:
tg3.c:v3.49 (Feb 2, 2006)
ACPI: PCI Interrupt 0000:0a:02.0[A] -> GSI 24 (level, low) -> IRQ 201
Uhhuh. NMI received for unknown reason 21 on CPU 0.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
tg3_test_dma() Write the buffer failed -19
tg3: DMA engine test failed, aborting.

relevant lspci output:
0000:0a:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5701
Gigabit Ethernet (rev 15)
        Subsystem: Compaq Computer Corporation NC7770 Gigabit Server
Adapter (PCI-X, 10/100/1000-T)
        Flags: 66Mhz, medium devsel, IRQ 201
        Memory at f7df0000 (64-bit, non-prefetchable) [size=64K]
        Expansion ROM at dc080000 [disabled] [size=64K]
        Capabilities: [40] PCI-X non-bridge device.
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=0/3 Enable-

If you need more details, I can try to dig them up. This is a machine
I've only been using for a few days for some testing and I'm not yet
familiar with all the hardware details.

- -Jeff

- --
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD+5cXLPWxlyuTD7IRArVcAJ4nEwx2b1j50dJp1uLBbqKJp9UlGwCfbE9N
P9iCdmB7IvGXDsuxTyjRj5M=
=5QzB
-----END PGP SIGNATURE-----
