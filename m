Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318859AbSH1O4k>; Wed, 28 Aug 2002 10:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318861AbSH1O4j>; Wed, 28 Aug 2002 10:56:39 -0400
Received: from chaos.analogic.com ([204.178.40.224]:12163 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318859AbSH1O4f>; Wed, 28 Aug 2002 10:56:35 -0400
Date: Wed, 28 Aug 2002 11:02:57 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: yodaiken@fsmlabs.com
cc: Mark Hounschell <markh@compro.net>,
       "Wessler, Siegfried" <Siegfried.Wessler@de.hbm.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: interrupt latency
In-Reply-To: <20020828075319.A24146@hq.fsmlabs.com>
Message-ID: <Pine.LNX.3.95.1020828103801.15591A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2002 yodaiken@fsmlabs.com wrote:

> On Wed, Aug 28, 2002 at 08:18:25AM -0400, Richard B. Johnson wrote:
> > No, no, no. There is no such port read that takes 18 microseconds, even
> > on old '386 machines with real ISR slots. A port read on those took
> > almost exactly 300 nanoseconds and, in fact, was the limiting factor
> > for the programmed I/O devices on the ISA bus.
> 
> Amazing how they can do that with a bus clock that is much slower -)

The ISA bus is not a clocked bus. It is entirely asynchronous. The
fact that there is a clock on the bus is irrelevant. It is not used
for any bus-related operations and, in fact, its phase is not guaranteed.

Now, I read your previous post which claimed that what I stated was
impossible and that I didn't measure anything useful. Now, I note
with trepidation that you are in some kind of "real-time-Linux" business
for which I am supposed to be shaking in my shoes. However, you are
spewing much hype for which I have no countenance.

Here is a re-write that takes your "min and max" rdtsc readings. You will
note that even the time to write to memory is included in the numbers.

Script started on Wed Aug 28 10:34:10 2002
# cat usermode.c
#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <asm/io.h>

extern int iopl(int);
extern long long tim(void);

volatile int run=0;
void timer(int unused)
{
    run = 0;
}

int main()
{
    unsigned long long ticks_sec;
    unsigned long long calibrate;
    unsigned long long ticks_port;
    unsigned long long worst = 0;
    unsigned long long best  = ~0;
    unsigned int count = 0;
    double ns;
    char foo[1];
    (void)iopl(3);
    (void)tim();
    calibrate = tim();                /* Time to make the function call */
    fprintf(stdout, "Wait.....");
    fflush(stdout);
    (void)signal(SIGALRM, timer);
    (void)alarm(1);
    run++;
    (void)tim();
    while(run)
       ;
    ticks_sec = tim() - calibrate;
    for(;;)
    {
        __asm("cli");
        (void)tim();
        foo[0] = inb(0x378);  /* Actually put into memory */
        ticks_port = tim() - calibrate;
        __asm("sti");
        if(ticks_port > worst)
            worst = ticks_port;
         if(ticks_port < best)
             best = ticks_port;
        if(!(count++ % 1000000))
        {
            ns =  (double)worst / (double)ticks_sec;
            ns *= 1e9;   /* Nanoseconds */
            printf("Worse case ticks = %llu\n", worst);
            printf("Worst port read took %f nanoseconds\n", ns);
            printf("CPU ticks/second = %llu\n", ticks_sec);
            printf("Best case ticks = %llu\n", best);
            ns =  (double)best / (double)ticks_sec;
            ns *= 1e9;   /* Nanoseconds */
            printf("Best port read took %f nanoseconds\n", ns);
            fflush(stdout); 
        }
    }
    return 0;
}

# cat rdtsc.S
#
#
#

.data
lastl:	.long	0
lasth:	.long	0
.text
.align	8	
.globl	tim
.type 	tim@function

#
#  Return the CPU clock difference between successive calls.
#
tim:	pushl	%ebx
	rdtsc
	movl	lastl, %ebx		# Get last low longword
	movl	lasth, %ecx		# Get last high longword
	movl	%eax, lastl		# Save current low longword
	movl	%edx, lasth		# Save current high longword
	subl	%ebx, %eax		# Current - last
	sbbl	%ecx, %edx		# Same with borrow
	popl	%ebx
	ret
.end

# gcc -O2 -o usermode usermode.c rdtsc.S
# ./usermode
Wait.....Worse case ticks = 624
Worst port read took 1572.445620 nanoseconds
CPU ticks/second = 396834073
Best case ticks = 624
Best port read took 1572.445620 nanoseconds
Worse case ticks = 1121
Worst port read took 2824.858237 nanoseconds
CPU ticks/second = 396834073
Best case ticks = 529
Best port read took 1333.050854 nanoseconds
Worse case ticks = 1209
Worst port read took 3046.613389 nanoseconds
CPU ticks/second = 396834073
Best case ticks = 529
Best port read took 1333.050854 nanoseconds
Worse case ticks = 1209
Worst port read took 3046.613389 nanoseconds
CPU ticks/second = 396834073
Best case ticks = 529
Best port read took 1333.050854 nanoseconds
Worse case ticks = 1349
Worst port read took 3399.405676 nanoseconds
CPU ticks/second = 396834073
Best case ticks = 529
Best port read took 1333.050854 nanoseconds
Worse case ticks = 1417
Worst port read took 3570.761929 nanoseconds
CPU ticks/second = 396834073
Best case ticks = 529
Best port read took 1333.050854 nanoseconds
Worse case ticks = 1549
Worst port read took 3903.394656 nanoseconds
CPU ticks/second = 396834073
Best case ticks = 529
Best port read took 1333.050854 nanoseconds
Worse case ticks = 1549
Worst port read took 3903.394656 nanoseconds
CPU ticks/second = 396834073
Best case ticks = 529
Best port read took 1333.050854 nanoseconds
Worse case ticks = 1549
Worst port read took 3903.394656 nanoseconds
CPU ticks/second = 396834073
Best case ticks = 529
Best port read took 1333.050854 nanoseconds
Worse case ticks = 3165
Worst port read took 7975.625621 nanoseconds
CPU ticks/second = 396834073
Best case ticks = 529
Best port read took 1333.050854 nanoseconds

# exit
exit

Script done on Wed Aug 28 10:35:35 2002


The best-case of 529 ticks  seems stable, therefore likely what
an inactive machine will produce this, 1,300 nanoseconds to
get data from a port into memory. 

The worse-case may not have happened yet even though the numbers
are stable, but I show 8 microseconds, no where near 18 microseconds
and, if I disconnect my network card so the PCI/Bus wasn't
continually grabbing everything via Bus Mastering, the best case
and the worse case ticks are within 400 ticks of each other. 

FYI, if you make a real-time system, you must control the Bus Masters
on the bus, otherwise you can't guarantee anything, and again, that
is not "latency". It's something else.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

