Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133113AbRECRJH>; Thu, 3 May 2001 13:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133116AbRECRI5>; Thu, 3 May 2001 13:08:57 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:2577 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S133113AbRECRIt>; Thu, 3 May 2001 13:08:49 -0400
Date: Thu, 3 May 2001 10:08:38 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Edward Spidre <beamz_owl@yahoo.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Possible PCI subsystem bug in 2.4
In-Reply-To: <20010503140318.7583.qmail@web10704.mail.yahoo.com>
Message-ID: <Pine.LNX.4.21.0105031004410.30346-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 3 May 2001, Edward Spidre wrote:
> 
> Note: a diff between booting with mem and without it
> yield the same results (the user-defined phys ram map
> is identical to the bios provided one)

Interesting. Your BIOS-provided memory map is buggy:

> BIOS-provided physical RAM map:
>  BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
>  BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
>  BIOS-e820: 000000000000c000 @ 00000000000c0000 (reserved)
>  BIOS-e820: 0000000013eec000 @ 0000000000100000 (usable)
>  BIOS-e820: 0000000000004000 @ 0000000013fec000 (reserved)
>  BIOS-e820: 0000000000200000 @ 00000000ffe00000 (reserved)

Note how it says that you have usable RAM from

	0000000000100000 - 0000000013fec000

(the thing is hard to read and the output was changed in later kernels: it
really says that you have 0000000013eec000 bytes of ram starting at
0000000000100000, which obviously doing the math means that it goes up to
0000000013fec000).

Now, it then says that you have reserved memory (ie probably the BIOS has
reserved 1kB at high memory) from

	0000000013fec000 - 0000000013ff0000

In particular, notice how it does NOT mention the memory region from

	0000000013ff0000 - 0000000014000000

at ALL. Which means that Linux thinks that it is free... And Linux will
place PCI devices there. Even though there certainly is memory there.

I'll have to work around the BIOS bug some way. Will you be willing to
try out patches?

		Linus

