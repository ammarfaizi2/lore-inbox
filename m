Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281128AbRLVQNl>; Sat, 22 Dec 2001 11:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286808AbRLVQNc>; Sat, 22 Dec 2001 11:13:32 -0500
Received: from bs1.dnx.de ([213.252.143.130]:12710 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S281128AbRLVQNY>;
	Sat, 22 Dec 2001 11:13:24 -0500
Date: Sat, 22 Dec 2001 17:13:18 +0100 (CET)
From: Robert Schwebel <robert@schwebel.de>
X-X-Sender: <robert@callisto.local>
Reply-To: <robert@schwebel.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: <linux-embedded@waste.org>, <rkaiser@sysgo.de>
Subject: Re: AMD SC410 boot problems with recent kernels
In-Reply-To: <3C23B308.9080800@zytor.com>
Message-ID: <Pine.LNX.4.33.0112221520300.10528-100000@callisto.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2001, H. Peter Anvin wrote:
> > there are boot problems with new kernels on AMD SC410 processors.
>
> "On one particular SC410 board."

Ok, but it's one of the most widespread embedded x86 boards in Europe.

> The loop counter you're outputting is the 2nd byte of the loop counter,
> which really isn't interesting;

This was just from the last test: the result was %ch=0 and %cl=1.

> what probably makes more sense to output is the value of %dx in your
> code.

%dx? Do you mean %cx or do I not understand the code? ;)

> I would like to suggest making the following changes and try them out:
>
> a) Change A20_TEST_LOOPS to something like 32768 in the new kernel code.

Still reboots.

> b) Add a "call delay" between the movw and the cmpw in your old_loop
>    and see if it suddenly breaks;

No, it still works.

> c) Check what your %dx value is (if it's nonzero, there might be an
>    issue.)

I assume you mean in my old_wait code, at the lines where I give out the
stuff to the LED ports? Neither %dl nor %dh has something different from
0 here. How could something come into %dx here?

> d) Once again, please complain to your motherboard/BIOS vendor and tell
>    them to implement int 15h, ax=2401h.

I'll do that, but this won't help for the hundrets of boards which are
still out there and worked fine with the previous code...

> e) Add a strictly serializing instruction sequence, such as:
>
> 	pushw %dx
> 	smsw %dx
> 	lmsw %dx
> 	popw %dx
>
>    ... where the "call delay" call is in a20_test.

Hope I understand you correctly - I'm not an assembler wizzard yet ;) Is
this correct:

----------8<----------
a20_test:
        pushw   %cx
        pushw   %ax
        xorw    %cx, %cx
        movw    %cx, %fs                  # Low memory (segment 0x0000)
        decw    %cx
        movw    %cx, %gs                  # High memory area (segment 0xffff)
        movw    $A20_TEST_LOOPS, %cx
        movw    %fs:(A20_TEST_ADDR), %ax  # put content of test address...
        pushw   %ax                       # ... on stack
a20_test_wait:
        incw    %ax
        movw    %ax, %fs:(A20_TEST_ADDR)

        pushw   %dx
        smsw    %dx

        call    delay                     # Serialize and make delay constant

        lmsw    %dx
        popw    %dx

        cmpw    %gs:(A20_TEST_ADDR+0x10), %ax
        loope   a20_test_wait

        popw    %fs:(A20_TEST_ADDR)
        popw    %ax
        popw    %cx
        ret
---------->8----------

Still reboots with this code.

Robert
--
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+



