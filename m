Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129410AbQKQU6o>; Fri, 17 Nov 2000 15:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130075AbQKQU6f>; Fri, 17 Nov 2000 15:58:35 -0500
Received: from chaos.analogic.com ([204.178.40.224]:9345 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129806AbQKQU6V>; Fri, 17 Nov 2000 15:58:21 -0500
Date: Fri, 17 Nov 2000 15:27:28 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Russell King <rmk@arm.linux.org.uk>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        mj@suse.cz
Subject: Re: VGA PCI IO port reservations
In-Reply-To: <200011172002.UAA01918@raistlin.arm.linux.org.uk>
Message-ID: <Pine.LNX.3.95.1001117150349.23529A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2000, Russell King wrote:

> Richard B. Johnson writes:
> > It's Intel assembly on Intel machines. It's a hell of a lot more
> > readable than AT&T assembly. This stuff has to be set up before you
> > have any resources necessary to execute the output of a 'C' compiler,
> > so, if you are looking for 'C' syntax, you are out of luck.
> 
> Hello Dick!
> 
> Come in!
> 
> I don't care about what style of assembly it is.  Believe it or not,
> this may come as a dramatic revelation to you, but not every single
> person on this planet knows X86 assembler of any form.
> 
> I am one of the lucky people who doesn't have his brain crambed full
> of the intracies of such a language.  Instead I have my brain full of
> ARM assembler instead, which is a hell of a lot more readable than
> X86 assembler.
> 
> Therefore, you quoting bits of X86 assembler to me is meaningless.
> 
> -EAGAIN (try again)

Okay. I'll bite (byte). The last port available is 0xffff. It's an
odd number, so start at 0xfffe because all the PCI port bases start
at even numbers (actually long words).

Then, you read the port as a WORD (16 bits). If nothing responds,
you get the value of 0xffff. If somebody is responding, you will
read something if it's enabled for writes by devices (reads by the CPU).

You keep decrementing the port number by 2 until either somebody responds
or you get to 0x1000. The lowest port number, without anybody reponding
is the first port you can allocate. However, the allocation has to
be a correct PCI allocation, i.e., if somebody wants 16 bytes, you
must allocate on a 16-byte boundary, potentially wasting 15 bytes
of address space.

The first aliased addresses will usually start to appear below 0x8000.
This typically gives you almost 32k of I/O space to allocate.

Since PCI devices can come alive in just about any state, before
you actually do the snoop, your code should disable I/O for all
PCI devices found except the first bridge. You do this by reading
the second longword for each device, anding off the lowest 3 bits,
then writing it back. (Command/Status register). The low word is
the command register. The high word is the status register. Since
any bits set in the status register, will be written back (this
is how the bits get reset), you automatically reset any errors the
device may have accumulated upon startup.

If you have a PCI to ISA bridge (like PIIX4) , you have to enable
it even though ISA bridge decodes are full 32-bit decodes. This is
because the board itself will not do a 32-bit decode and can result in
aliases.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
