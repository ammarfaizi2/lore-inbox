Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270618AbRHQToW>; Fri, 17 Aug 2001 15:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270639AbRHQToN>; Fri, 17 Aug 2001 15:44:13 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:57341 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S270618AbRHQToG>; Fri, 17 Aug 2001 15:44:06 -0400
Message-ID: <3B7D703C.E2517636@mvista.com>
Date: Fri, 17 Aug 2001 12:27:56 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Strange macros set HZ value for timer channel zero
In-Reply-To: <Pine.LNX.3.95.1010817091911.6570A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> To whomever maintains the timer code, greetings.
> 
> When using Linux on the AMD SC520 chip, the system time will
> not be correct because the PIT clock is 1.1882 MHz instead of
> the usual 1.19318 MHz. Therefore, I put a conditional value
> in ../linux/include/asm/timex.h .
> 
> #ifndef _ASMi386_TIMEX_H
> #define _ASMi386_TIMEX_H
> 
> #include <linux/config.h>
> #include <asm/msr.h>
> #ifdef SC520
> #define CLOCK_TICK_RATE 1188200 /* Underlying HZ */
> #else
> #define CLOCK_TICK_RATE 1193180 /* Underlying HZ */
> #endif
> 
> Something is wrong! I now gain 3 hours in a 12 hour period. There
> are some calculations performed somewhere that result in the
> wrong divisor for the timer (PIT). I don't understand any of the
> SHIFT stuff, nor FINE_TUNE stuff. It all seems bogus although
> it might be the "new math" that's biting me.
> 
> The correct value for 100 Hz should be 1188200/100 = 11882 = 0x2e6a
> for the divisor. If I hard-code the value as a divisor in
> /usr/src/linux/arch/i386/kernel/i8259.c,  it works. If I use the
> #defines and macros in the headers, it doesn't.
> 
Seems hard to believe.  Try this:

cd ../arch/i386/kernel
gcc -D__KERNEL__ -I/usr/src/linux-2.4.7-hr/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe  -march=i586    -c -o i8259.o
i8259.c -E

(note the -E, the rest of the line is just cut from the make output, I
usually make from a shell in emacs so all this output is available... 
If you are cutting this line from this message, make sure you change the
-I path to match your kernel location.)

now exit i8259.c and search for your new number, i.e. 118820.  (Or if
that fails search for "init_IRQ" and look at the outb_p in there.)  For
the old 1192180 I find:

	outb_p(0x34,0x43);		 
	outb_p(((1193180  + 100 /2) / 100 )  & 0xff , 0x40);	 
	outb(((1193180  + 100 /2) / 100 )  >> 8 , 0x40);	 

Seems like the new number should do just what you need here.  The
calibration in time.c is a little wonky, but that will not give the
errors you are seeing, nor would your change of LATCH (I assume this is
what you changed in i8259.c) affect that wonky stuff.

Oh, by the way, you will want to purge i8259.o as make will assume it is
up to date and try to merge it as a *.o file, which will fail rather
badly.

George
