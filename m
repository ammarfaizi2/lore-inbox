Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130365AbQKQRHV>; Fri, 17 Nov 2000 12:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129412AbQKQRHQ>; Fri, 17 Nov 2000 12:07:16 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:33289 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130368AbQKQRHC>;
	Fri, 17 Nov 2000 12:07:02 -0500
Message-ID: <3A155E8C.7D345649@mandrakesoft.com>
Date: Fri, 17 Nov 2000 11:36:28 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org, mj@suse.cz
Subject: Re: VGA PCI IO port reservations
In-Reply-To: <200011171620.eAHGKgg00324@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> I've been looking at a number of VGA cards recently, and I've started
> wondering out the Linux resource management as far as allocation of
> IO ports.  I've come to the conclusion that it does not contain all
> information necessary to allow allocations to be made safely.
> 
> Thus far, VGA cards that I've looked at scatter extra registers through
> out the PCI IO memory region without appearing in the PCI BARs.  In fact,
> for some cards there wouldn't be enough BARs to list them all.

> For example, S3 cards typically use:
> 
>  0x0102,  0x42e8,  0x46e8,  0x4ae8,  0x8180 - 0x8200,  0x82e8,  0x86e8,
>  0x8ae8,  0x8ee8,  0x92e8,  0x96e8,  0x9ae8,  0x9ee8,  0xa2e8,  0xa6e8,
>  0xaae8,  0xaee8,  0xb2e8,  0xb6e8,  0xbae8,  0xbee8,  0xe2e8,
>  0xff00 - 0xff44
[...]
> Surely we should be reserving these regions before we start to allocate
> resources to PCI cards?

I tried to push this through when I was hacking heavily on fbdev
drivers, especially S3, and it didn't fly.  On x86's, those addresses
are already reserved:

[jgarzik@rum linux_2_4]$ cat /proc/iomem
00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
[...]

If they are not reserved on your arch, I think the driver should
definitely reserve the region.  (though if its an ISA-compatible arch,
Linus might desire the above reservations as done by the core, not by
the fbdev driver)

Another alternative I thought of is freeing the resource if it is
allocated by the system, and having the driver allocate its own
resource.  When the driver unloads, it frees its resources and allocates
the whole region back to the system.  I look at this as the fbdev
driver's "clarifying the picture" of the hardware resource usage. 
[again, this hullabaloo might only be necessary on x86]

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
