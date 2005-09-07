Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbVIGTb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbVIGTb0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 15:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbVIGTb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 15:31:26 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:10412 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1751289AbVIGTbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 15:31:25 -0400
Message-ID: <431F4006.6060901@vc.cvut.cz>
Date: Wed, 07 Sep 2005 21:31:18 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
CC: LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Request only really used I/O ports in w83627hf driver
References: <20050907181415.GA468@vana.vc.cvut.cz> <20050907210753.3dbad61b.khali@linux-fr.org>
In-Reply-To: <20050907210753.3dbad61b.khali@linux-fr.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare wrote:
> Hi Petr,
> 
> 
>>my motherboard (Tyan S2885) reports range 295-296 in its PNP hardware
>>descriptors, and due to this w83627hf driver fails to load, as it
>>requests 290-297 range, which is not subrange of this PNP resource. 
>>As hardware monitor chip responds to 295/296 addresses only, there is
>>no reason to request full 8 byte I/O.
> 
> 
> Another point of view would be: as the physical address of the chip is
> 0x290-0x297, there is no reason to even think of requesting a different
> range. And there is a very valid reason to request the full 8 byte I/O
> range: to let the user know that this range is not available for other
> devices. Mapping another device to the unused I/O ports of the W83627HF
> would not work, right? Also consider that future chips of this family
> could use additional ports.

No, it would perfectly work.  W83627HF (and all other hardware monitoring
chips from Winbond) respond only to xxx5 and xxx6 address, not to the
other addresses in the range xxx0-xxx7.  So requesting full 8 byte range
is not only unnecessary, but also incorrect.

For example I can place 4-byte printer port at 0xC00-0xC03, while sensors
live at 0xC05-0xC06.  If I place sensors and serial port at same address,
I get bytes (from C00-C07) "04 00 01 00 13 40 01 00".  When I move senors
away, I get "04 00 01 00 13 06 00 00", so you can see that only address + 5
and + 6 are affected.  And when I move serial port away, leaving sensors
in place, I see "FF FF FF FF FF 40 01 FF" - again chip respons to +5 & +6
addresses only, not to the full range.

And even if it would answer to the other addresses, you should not request
them, as driver apparently does not need them, while some other driver might.
Take a look at i2c-amd756 driver for example.  It uses bytes 0xE0-0xEF
from large 256 byte I/O window on amd7x6/amd8111 chips.  And it correctly
requests only region 0xE0-0xEF, so other drivers can drive other parts
of the chip.

> The cause of your trouble is, IMVHO, a buggy BIOS. Ask Tyan to fix their
> BIOS to allocate the real I/O range to the W83627HF chip, and you're
> done.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=4014

I do not agree with your analysis here.  Chip just wants 8 byte aligned
address, nowhere in the documentation is stated that full 8 bytes are
used, actually doc is quite explicit that accesses are decoded only if
low nibble is 5 or 6 (for example w83627hf/f/hg/g datasheet revision A1,
page 28).

> Your fix might come in handy for your own situation, but it looks wrong
> in the long run. We are not going to shrink the requested I/O range of
> every random driver each time a motherboard manufacturer releases a
> buggy BIOS.

It is not buggy BIOS.  It is incorrect assumption of driver writter about
hardware, and about request_region API.  If you want to put potential
resources to the tree, you should not tag them BUSY, as they are not
busy, they are free for use by the driver.

> If getting the manufacturers to provide fixed BIOSes doesn't seem to be
> feasable, then the PNPACPI code certainly needs to be extended to handle
> this case transparently. This could be achived using quirks similar to
> what we have for PCI, or PNPACPI could simply accept requests of I/O
> ranges which include a single PNP range as defined by the BIOS. Note
> that everything was working just fine for everyone before PNPACPI was
> added to the kernel.

No.  Unfortunately BIOS knows how hardware works while w83627hf driver
apparently does not, so I do not think manufacturers are going to break
BIOS just to match Linux driver expectations.
						Petr Vandrovec

