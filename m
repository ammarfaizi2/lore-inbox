Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292130AbSCMCTN>; Tue, 12 Mar 2002 21:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292045AbSCMCSx>; Tue, 12 Mar 2002 21:18:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8979 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292035AbSCMCSk>;
	Tue, 12 Mar 2002 21:18:40 -0500
Date: Wed, 13 Mar 2002 02:18:38 +0000
From: wli@holomorphy.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Andrea Arcangeli <andrea@suse.de>, wli@parcelfarce.linux.theplanet.co.uk,
        linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org,
        phillips@bonn-fries.net
Subject: Re: 2.4.19pre2aa1
Message-ID: <20020313021838.G14628@holomorphy.com>
Mail-Followup-To: wli@holomorphy.com,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Andrea Arcangeli <andrea@suse.de>,
	wli@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org,
	riel@surriel.com, hch@infradead.org, phillips@bonn-fries.net
In-Reply-To: <20020312135605.P25226@dualathlon.random> <Pine.LNX.3.95.1020312083126.14299A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.95.1020312083126.14299A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Tue, Mar 12, 2002 at 08:33:23AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 08:33:23AM -0500, Richard B. Johnson wrote:
> This is a simple random number generator. It takes a pointer to your
> own private long, somewhere in your code, and returns a long random
> number with a period of 0xfffd4011. I ran a program for about a
> year, trying to find a magic number that will produce a longer
> period.

Random number generators are not hash functions. Where is the relevance?
I think you're generating a stream of uniform deviates to test whether
a given hash function performs well with random input.

I'm far more concerned about how the hash function behaves on real input
data and I've been measuring that from the start, and as far as I'm
concerned this microbenchmark is fairly useless. If it defeats it, it
doesn't demonstrate that the hash function behaves poorly on the input
distribution I'm interested in. If it doesn't defeat it it doesn't
demonstrate that the hash function behaves well on the input distribution
I'm interested in. If you want to generate useful random numbers for
simulating workloads for hash table benchmarking you should attempt to
measure and simulate the distribution of hash keys from the hash tables
you're interested in and use statistical tests to verify that you're
actually generating numbers with similar distributions. One easy way
to get those might be, say, dumping all the elements of a hash table
by traversing all the collision chains and sampling the keys' fields.


On Tue, Mar 12, 2002 at 08:33:23AM -0500, Richard B. Johnson wrote:
> You could add a ldiv and return the modulus to set hash-table limits.
> ANDs are not good because, in principle, you could get many numbers
> in which all the low bits are zero.

It sounds like you're generating a stream of random deviates and then
hashing them by mapping to their least residues mod the hash table size
with perhaps a division thrown in.  With a long period you're going to
get quite impressive statistics, not that it means anything. =)


On Tue, Mar 12, 2002 at 08:33:23AM -0500, Richard B. Johnson wrote:
> The advantage of this simple code is it works quickly. The disadvantages
> are, of course, its not portable and a rotation of a binary number
> is not a mathematical function, lending itself to rigorous analysis.

Rigorous mathematical analysis does not require analyticity =) or
number-theoretic tractability. There are things called statistical
analysis and asymptotic analysis, which go great together and are
quite wonderful in combination with empirical testing.


On Tue, Mar 12, 2002 at 08:33:23AM -0500, Richard B. Johnson wrote
	(and I added comments to):

> MAGIC = 0xd0047077 
> INTPTR = 0x08
> .section	.text
> .global		rnd
> .type		rnd,@function
> .align	0x04
> 	pushl	%ebx			# save %ebx
> 	movl	INTPTR(%esp), %ebx	# load argument from stack to %ebx
> 	movl	(%ebx), %eax		# deref arg, loading to %eax
> 	rorl	$3, %eax		# roll %eax right by 3
> 	addl	$MAGIC, %eax		# add $MAGIC to %eax
> 	movl	%eax, (%ebx)		# save result
> 	popl	%ebx			# restore %ebx
>         ret
> .end

So you've invented the following function:

f(n) = 2**29 * (n % 8) + floor(n/8) + 0xd0047077

I wonder what several tests will look like for this, but you should
really test your own random number generator.
I have my own patches to work on.


Cheers,
Bill
