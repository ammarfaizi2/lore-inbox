Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272527AbTGaPzG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272505AbTGaPxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:53:46 -0400
Received: from chaos.analogic.com ([204.178.40.224]:5760 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S274824AbTGaPuX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:50:23 -0400
Date: Thu, 31 Jul 2003 11:50:27 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jamie Lokier <jamie@shareable.org>
cc: Willy Tarreau <willy@w.ods.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: TSCs are a no-no on i386
In-Reply-To: <20030731150758.GE6410@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.53.0307311126530.770@chaos>
References: <20030730135623.GA1873@lug-owl.de> <20030730181006.GB21734@fs.tum.de>
 <20030730183033.GA970@matchmail.com> <20030730184529.GE21734@fs.tum.de>
 <1059595260.10447.6.camel@dhcp22.swansea.linux.org.uk> <20030730203318.GH1873@lug-owl.de>
 <20030731002230.GE22991@fs.tum.de> <20030731062252.GM1873@lug-owl.de>
 <20030731071719.GA26249@alpha.home.local> <20030731150758.GE6410@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jul 2003, Jamie Lokier wrote:

> Willy Tarreau wrote:
> > The other problem lies with the lock :
> > When a 486 executes "LOCK ; CMPXCHG", it locks the bus during the whole cmpxchg
> > instruction. If a 386 executes the same code, it will get an exception which
> > will be caught by the emulator. I don't see how we can do such an atomic
> > operation while holding a lock. At best, we would think about a global memory
> > based shared lock during the operation (eg: int bus_lock;), but it's not
> > implemented at the moment, and will only be compatible with processors sharing
> > the same code. Add-on processors, such as co-processors, transputer cards, or
> > DSPs, will know nothing about such a lock emulation. And it would result in
> > even poorer performance of course !
>
> Of course this is not a problem when "lock;cmpxchg" is used only for thread
> synchronisation on uniprocessor 386s...  The lock prefix is irrelevant then.
>
> Perhaps the emulation should refuse to pretend to work on an SMP 386 :)
>
> -- Jamie
> -

You can use the lock instruction ahead of any 386 instruction
without creating an exception. When relevent, it locks the whole
bus. When not, it's just a no-op. The trap on the lock instruction
came with the '486. With the '486, if the instruction doesn't
modify memory, then the lock prefix is invalid and will generate
an invalid-opcode exception.

It is not correct to use a lock instruction in front of every
op-code of course, and it might not have been tested for all
corner cases, but generally it's harmless on a '386.

The bad op-code for the i386 is cmpxchg. This is what triggers
the trap. This can be emulated, although the emulation is
not SMP compatible. You worry about this when somebody makes
a dual '386 machine ;^).  Also, the best performing emulation
for any op-codes should be done within the kernel. That way,
the invalid-opcode trap works just like the math emulator. You
don't need the overhead of calling a user-mode handler. If
this is emulation is implimented, then one should also emulate
BSWAP and XADD. This makes '486 code compatible with '386
machines.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

