Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311193AbSCLNfw>; Tue, 12 Mar 2002 08:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311195AbSCLNfn>; Tue, 12 Mar 2002 08:35:43 -0500
Received: from chaos.analogic.com ([204.178.40.224]:5249 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S311193AbSCLNfV> convert rfc822-to-8bit; Tue, 12 Mar 2002 08:35:21 -0500
Date: Tue, 12 Mar 2002 08:33:23 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andrea Arcangeli <andrea@suse.de>
cc: wli@holomorphy.com, wli@parcelfarce.linux.theplanet.co.uk,
        linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org,
        phillips@bonn-fries.net
Subject: Re: 2.4.19pre2aa1
In-Reply-To: <20020312135605.P25226@dualathlon.random>
Message-ID: <Pine.LNX.3.95.1020312083126.14299A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2002, Andrea Arcangeli wrote:

> On Tue, Mar 12, 2002 at 11:29:00AM +0000, wli@holomorphy.com wrote:
> > For specific reasons why multiplication by a magic constant (related to
> > the golden ratio) should have particularly interesting scattering
> > properties, Knuth cites Vera Turán Sós, Acta Math. Acad. Sci. Hung. 8
> 
> I know about the scattering properties of some number (that is been
> measured empirically if I remeber well what I read). I was asking for
> something else, I was asking if this magical number can scatter better a
> random input as well or not. My answer is no. And I believe the nearest
> you are to random input to the hashfn the less the mul can scatter
> better than the input itself and it will just lose cache locality for
> consecutive pages. So the nearest you are, the better if you avoid the
> mul and you take full advantage of the randomness of the input, rather
> than keeping assuming the input has pattenrs.
> 
> I mean, start reading from /dev/random and see how the distribution goes
> with and without mul, it will be the same I think.
> 
> > I will either sort out the results I have on the waitqueues or rerun
> > tests at my leisure.
> 
> I'm waiting for it, if you've monitor patches I can run something too.
> I'd like to count the number of collisions over time in particular.
> 
> > Note I am only trying to help you avoid shooting yourself in the foot.
> 
> If I've rescheduling problems you're likely to have them too, I'm quite
> sure, if something the fact I keep the hashtable large enough will make
> me less bitten by the collisions. The only certain way to avoid riskying
> regressions would be to backout the wait_table part that was merged in
> mainline 19pre2. the page_zone thing cannot generate any regression for
> instance (same is true for page_address), the wait_table part is gray
> area instead, it's just an heuristic like all the hashes and you can
> always have a corner case bitten hard, it's just that the probabiliy for
> such a corner case to happen has to be small enough for it to be
> acceptable, but you can always be unlucky, no matter if you mul or not,
> you cannot predict the future of what's the next pages that the people
> will wait on from userspace.
> 
> Andrea



This is a simple random number generator. It takes a pointer to your
own private long, somewhere in your code, and returns a long random
number with a period of 0xfffd4011. I ran a program for about a
year, trying to find a magic number that will produce a longer
period.

You could add a ldiv and return the modulus to set hash-table limits.
ANDs are not good because, in principle, you could get many numbers
in which all the low bits are zero.


The advantage of this simple code is it works quickly. The disadvantages
are, of course, its not portable and a rotation of a binary number
is not a mathematical function, lending itself to rigorous analysis.


#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#
#   File rnd.S            Created 04-FEB-2000        Richard B. Johnson
#                                                    rjohnson@analogic.com
#
#   Simple random number generator.
#
#

MAGIC = 0xd0047077 
INTPTR = 0x08
.section	.text
.global		rnd
.type		rnd,@function
.align	0x04
	pushl	%ebx
	movl	INTPTR(%esp), %ebx
	movl	(%ebx), %eax
	rorl	$3, %eax
	addl	$MAGIC, %eax
	movl	%eax, (%ebx)
	popl	%ebx
        ret
.end
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

	Bill Gates? Who?

