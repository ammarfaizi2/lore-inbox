Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266448AbRH0T2h>; Mon, 27 Aug 2001 15:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266263AbRH0T22>; Mon, 27 Aug 2001 15:28:28 -0400
Received: from archive.osdlab.org ([65.201.151.11]:62944 "EHLO fire.osdlab.org")
	by vger.kernel.org with ESMTP id <S265249AbRH0T2U>;
	Mon, 27 Aug 2001 15:28:20 -0400
Message-ID: <3B8A9DF5.B7FC5E8D@osdlab.org>
Date: Mon, 27 Aug 2001 12:22:29 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bart Vandewoestyne <Bart.Vandewoestyne@pandora.be>
CC: linux-kernel@vger.kernel.org
Subject: Re: time question
In-Reply-To: <3B89F5D6.5813BF4D@pandora.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart Vandewoestyne wrote:
> 
> I'm trying to port the DOS driver for a data aquisition card to linux
> (http::/mc303.ulyssis.org).  It is my first linux driver writing
> attempt. Somewhere in the code i have the following lines of DOS-code
> that do some busy waiting:
> 
> _bios_timeofday(_TIME_GETCLOCK,&tb); l = tb;
>   while(l-tb < 2) _bios_timeofday(_TIME_GETCLOCK,&l);
> 
> What is the best linux equivalent for this?

I don't have a DOS system + development tools handy.
Can you tell me what _bios_timeofday(_TIME_GETCLOCK, ptr) compiles/
assembles to?  I.e., what software interrupt, and what the AH
register is set to on entry?

I'm guessing that this code is just doing a 2-tick delay
(18.2 ticks per second), using int. 0x1a, AH=00
(http://www.ctyme.com/intr/rb-2271.htm).
This means that each tick is approximately 55 ms,
so the code is delaying for about 110 ms.


Take a look at the new Linux Device Drivers book (second edition),
in the "Flow of Time" chapeter:
http://www.xml.com/ldd/chapter/book/ch06.html
You may get some answers there.

To begin with, you could try using
  mdelay(110);

Is this busy-waiting loop used seldom or often?
If seldom, then using mdelay() might be OK.
If often, then a sleep queue seems to be preferred.
Read the LDD Time chapter.

You might also try kernelnewbies.org for introductory kernel
questions.  See the FAQ and the /documents/ directory.

>From your list of questions:

1. What kind of device do I need? Right now I am trying a
character device, but is this indeed what we need???

A: Yes.  If it's not a block device and not a network device,
it's usually a character device.

2. If I need a character device, what linux-existing driver is good
to look at and learn from it? 

A: I'm not aware of other data acq drivers in the kernel, but that's
just not my area.  Are there any (anyone)?

3. How should I translate the assembler code of the DOS driver?
Can I use linux native system calls?
To what linux sytem calls can I map the inplI and outplI functions?

A:  Sure, you can use native Linux system calls, if you know which
ones to use.  However, some calls may actually be (g)lib calls instead
of system calls.

inplI():  same as inpl() on your web page (since bswap is
commented).  Maps to:
  value = inl(port);

outplI():  Only difference here is the 16-bit word-order of the
32-bit value to write to the I/O port.  I'd suggest just getting
the data order correct in the calling function and using
  outl(value, port);
in Linux drivers.


~Randy
