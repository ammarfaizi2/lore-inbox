Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285783AbSAPSBH>; Wed, 16 Jan 2002 13:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285704AbSAPR7N>; Wed, 16 Jan 2002 12:59:13 -0500
Received: from chaos.analogic.com ([204.178.40.224]:30593 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S285666AbSAPR6O>; Wed, 16 Jan 2002 12:58:14 -0500
Date: Wed, 16 Jan 2002 12:53:10 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: mcuss@cdlsystems.com, linux-kernel@vger.kernel.org
Subject: Re: Measuring execution time
In-Reply-To: <3C45B715.926A0BA0@nortelnetworks.com>
Message-ID: <Pine.LNX.3.95.1020116124651.13781A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2002, Chris Friesen wrote:

> Mark Cuss wrote:
> 
> > I am working on optimizing some software and would like to be able to
> > measure how long an instruction takes (down to the clock cycle of the CPU).
> > I recall reading somewhere about a kernel time measurement called a "Jiffy"
> > and figured that it would probably apply to this.
> > 
> > If anyone has any tips on how to figure out how to do this I'd really
> > appreciate it.
> 
> Jiffies are quite coarse-grained.  On x86 you want the rdtsc instruction, while
> on ppc you want mfrtcu/mfrtcl or mftbu/mftb depending on the version of the
> chip.  These are used as inline assembly, and if you do a google search you
> should be able to find code snippets.
> 

For Intel.......

Assemble this as rdtsc.S

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


Your code:

/* Really extern long long tim(void); */
extern long tim(void); /* Good enough */

main()
{
    long total_cycles;

    (void)tim();      /* Grab starting time */
    process();        /* Do your code */
    total_cycles = tim();

}

gcc -o tester main.c rdtsc.S



Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


