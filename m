Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264857AbSLQJkG>; Tue, 17 Dec 2002 04:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264863AbSLQJkG>; Tue, 17 Dec 2002 04:40:06 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:56335
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S264857AbSLQJkF>; Tue, 17 Dec 2002 04:40:05 -0500
Date: Tue, 17 Dec 2002 01:45:52 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, hpa@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.4.44.0212162140500.1644-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.10.10212170144030.31876-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Are you serious about moving of the banging we currently do on 0x80?
If so, I have a P4 development board with leds to monitor all the lower io
ports and can decode for you.

On Mon, 16 Dec 2002, Linus Torvalds wrote:

> 
> On Mon, 16 Dec 2002, Linus Torvalds wrote:
> >
> > (Modulo the missing syscall page I already mentioned and potential bugs
> > in the code itself, of course ;)
> 
> Ok, I did the vsyscall page too, and tried to make it do the right thing
> (but I didn't bother to test it on a non-SEP machine).
> 
> I'm pushing the changes out right now, but basically it boils down to the
> fact that with these changes, user space can instead of doing an
> 
> 	int $0x80
> 
> instruction for a system call just do a
> 
> 	call 0xfffff000
> 
> instead. The vsyscall page will be set up to use sysenter if the CPU
> supports it, and if it doesn't, it will just do the old "int $0x80"
> instead (and it could use the AMD syscall instruction if it wants to).
> User mode shouldn't know or care, the calling convention is the same as it
> ever was.
> 
> On my P4 machine, a "getppid()" is 641 cycles with sysenter/sysexit, and
> something like 1761 cycles with the old "int 0x80/iret" approach. That's a
> noticeable improvement, but I have to say that I'm a bit disappointed in
> the P4 still, it shouldn't be even that much.
> 
> As a comparison, an Athlon will do a full int/iret faster than a P4 does a
> sysenter/sysexit. Pathetic. But it's better than it used to be.
> 
> Whatever. The code is extremely simple, and while I'm sure there are
> things I've missed I'd love to hear if this works for anybody else. I'm
> appending the (extremely stupid) test-program I used to test it.
> 
> The way I did this, things like system call restarting etc _should_ all
> work fine even with "sysenter", simply by virtue of both sysenter and "int
> 0x80" being two-byte opcodes. But it might be interesting to verify that a
> recompiled glibc (or even just a preload) really works with this on a
> "whole system" testbed rather than just testing one system call (and not
> even caring about the return value) a million times.
> 
> The good news is that the kernel part really looks pretty clean.
> 
> 		Linus
> 
> ---
> #include <time.h>
> #include <sys/time.h>
> #include <asm/unistd.h>
> #include <sys/stat.h>
> #include <stdio.h>
> 
> #define rdtsc() ({ unsigned long a,d; asm volatile("rdtsc":"=a" (a), "=d" (d)); a; })
> 
> int main()
> {
> 	int i, ret;
> 	unsigned long start, end;
> 
> 	start = rdtsc();
> 	for (i = 0; i < 1000000; i++) {
> 		asm volatile("call 0xfffff000"
> 			:"=a" (ret)
> 			:"0" (__NR_getppid));
> 	}
> 	end = rdtsc();
> 	printf("%f cycles\n", (end - start) / 1000000.0);
> 
> 	start = rdtsc();
> 	for (i = 0; i < 1000000; i++) {
> 		asm volatile("int $0x80"
> 			:"=a" (ret)
> 			:"0" (__NR_getppid));
> 	}
> 	end = rdtsc();
> 	printf("%f cycles\n", (end - start) / 1000000.0);
> }
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

