Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318899AbSH1QNA>; Wed, 28 Aug 2002 12:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318901AbSH1QNA>; Wed, 28 Aug 2002 12:13:00 -0400
Received: from [217.167.51.129] ([217.167.51.129]:20178 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S318899AbSH1QM6>;
	Wed, 28 Aug 2002 12:12:58 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Richard Zidlicky <rz@linux-m68k.org>
Cc: <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: readsw/writesw readsl/writesl
Date: Wed, 28 Aug 2002 18:17:01 +0200
Message-Id: <20020828161701.22623@192.168.4.1>
In-Reply-To: <20020828142356.B4464@linux-m68k.org>
References: <20020828142356.B4464@linux-m68k.org>
X-Mailer: CTM PowerMail 3.1.2 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>it is a bit ugly right now, in asm-m68/ide.h we have to include io.h
>and redefine some of the defs. Even more fun with some net drivers (eg 8390)
>which on m68k can accessed over ISA bus, Zorro bus, or Zorro bus +
>ISA bridge and maybe a few other methods. Byteswaps are the smallest
>problem here, we have also to translate adresses and deal with sparsely
>mapped io regions.
>
>A decent solution should use a per device "busops" struct that would
>define in/out and other access methods for the underlying bus.

This have been proposed several times in the past, and always rejected
for what is I think mostly fantasmatic performances reasons.

Though that would fit nicely in the new driver model ;)

The fact is that an indirect function call has a non-negligible cost
on heavily pipelined CPUs like we have nowadays. But on the other
hand, do we do _that_ much perf critical MMIOs ? Most of the really
perf critical IOs are DMA... We could eventually mix that and provide
direct accessors for PCI in addition to generic per-bus "ops"...

Another possibility (that looks saner to me) would be to define that
the IO macros take all a parameter which represents the bus (or rather
the device pointer in the new driver model). Most archs would just
ignore that macro parameter and so have exactly equivalent code as
we have today, but that let archs that feel they need it to actually
use that to go pick the proper access methods for that device.

In all cases, though, I would keep the distinction between {read,write}*
and {in,out}* as there are PCI drivers that will need to mix them.

But I have few hopes for anything like that to ever be accepted
anyway...

Ben.


