Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbTJPSw2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 14:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbTJPSw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 14:52:28 -0400
Received: from chaos.analogic.com ([204.178.40.224]:5248 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263056AbTJPSwX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 14:52:23 -0400
Date: Thu, 16 Oct 2003 14:52:11 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Andreas Dilger <adilger@clusterfs.com>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Eli Billauer <eli_billauer@users.sourceforge.net>,
       linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [RFC] frandom - fast random generator module
In-Reply-To: <20031016121825.D7000@schatzie.adilger.int>
Message-ID: <Pine.LNX.4.53.0310161444440.814@chaos>
References: <3F8E552B.3010507@users.sf.net> <3F8E58A9.20005@cyberone.com.au>
 <3F8E70E0.7070000@users.sf.net> <3F8E8101.70009@pobox.com>
 <20031016102020.A7000@schatzie.adilger.int> <3F8EC7D0.5000003@pobox.com>
 <20031016121825.D7000@schatzie.adilger.int>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Oct 2003, Andreas Dilger wrote:

> On Oct 16, 2003  12:31 -0400, Jeff Garzik wrote:
> > Andreas Dilger wrote:
> > > Actually, there are several applications of low-cost RNG inside the kernel.
> > >
> > > For Lustre we need a low-cost RNG for generating opaque 64-bit handles in
> > > the kernel.  The use of get_random_bytes() showed up near the top of
> > > our profiles and we had to invent our own low-cost crappy PRNG instead (it's
> > > good enough for the time being, but when we start working on real security
> > > it won't be enough).
> > >
> > > The tcp sequence numbers probably do not need to be crypto-secure (I could
> > > of course be wrong on that ;-) and with GigE or 10GigE I imagine the number
> > > of packets being sent would put a strain on the current random pool.
> >
> >
> > We don't need "low cost RNG" and "high cost RNG" in the same kernel.
> > That just begs a "reduce RNG cost" solution...  I think security experts
> > can easily come up with arguments as to why creating your own "low-cost
> > crappy PRNG" isn't needed -- you either need crypto-secure, or you
> > don't.  If you don't, then you could just as easily create an ascending
> > 64-bit number for your opaque filehandle, or use a hash value, or some
> > other solution that doesn't require an additional PRNG in the kernel.
>
> Hmm, so every part of the kernel that doesn't need crypto-secure RNG data
> (i.e. fast and relatively unique) should implement its own hash/PRNG then?
> It isn't a matter of unbreakable crypto, but the fact that we want relatively
> unique values that will not be the same on a reboot.  Currently we do just
> as you propose for our "crappy PRNG", which is "grab 8 bytes via
> get_random_bytes and increment", but that is a little _too_ easy to guess
> (although good enough for the time being).
>
> > For VIA CPUs, life is easy.  Use xstore insn and "You've got bytes!"  :)
>
> As you say, we could throw away even our crappy PRNG and get better data
> with a single opcode.  So you advocate we add CPU/arch-specific code into
> our filesystem?  How about we add a wrapper around all the different
> CPU-specific RNG codes and call it the "low cost RNG" which will be faster
> _and_ give better data than any explicitly-coded PRNG. ;-)  For our needs
> at least, the asm-generic code would be on the order of maybe 15 lines of C:
>
> #define RESEED_INTERVAL 65536
>
> int get_fast_random_bytes(char *buf, int nbytes)
> {
> 	static int data_arr[NR_CPUS], count_arr[NR_CPUS]; /* use percpu... */
> 	int *data = &data_arr[smp_processor_id()];
> 	int *count = &count_arr[smp_processor_id()];
>
> 	*count -= nbytes;
> 	if (*count < 0) {
> 		*count = RESEED_INTERVAL;
> 		get_random_bytes(data, sizeof(*data));
> 	}
>
> 	while (nbytes >= sizeof(*data)) {
> 		*(long *)buf = *data;
> 		buf += sizeof(*data);
> 		*data = *data * 1812433253L + 12345L; /* or whatever... */
> 	}
> 	memcpy(buf, data, nbytes);
> }
>
> Cheers, Andreas
> --
> Andreas Dilger
> http://sourceforge.net/projects/ext2resize/
> http://www-mddsp.enel.ucalgary.ca/People/adilger/


Simple FAST (possibly good-enough) random number generator
that is fast enough to not screw up performance. Of course,
purests will claim that no random number generator is good
enough, but.........

This is for Intel. Other code could be generated for other
platforms. 'C' doesn't do a 'rotate' which makes 'C' methods
slow.

Various 'magic numbers' give the following periods, all better
than the rand() method:

Period = fff67290 Magic = cffd5880
Period = fffe3278 Magic = 62040ffd


#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#
#   File rnd.S            Created 04-FEB-1999        Richard B. Johnson
#
#   Simple random number generator. Based upon Alan R. Miller's
#   algorithm. Professor of Metallurgy, University of New Mexico
#   Institute of Mining and Technology, circa 1980. Published
#   In the 8080/Z-80 Assembly Language manual he wrote.
#
#   unsigned size_t rnd((size_t *) seed);
#
#   The seed can be initialized with time(&seed); on each boot.
#

MAGIC  = 0x62040ffd
INTPTR = 0x08
DIVISR = 0x0c
.section	.text
.global		rnd
.type		rnd,@function
.align	0x04
rnd:	pushl	%ebx
	movl	INTPTR(%esp), %ebx
	movl	(%ebx), %eax
	rorl	$3, %eax
	addl	$MAGIC, %eax
	movl	%eax, (%ebx)
	popl	%ebx
        ret

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#
#	This returns a random number between 0 and one less than the
#	input divisor, i.e. n mod rand(x).
#
#	size_t modrnd((size_t *) seed, size_t divisor);
#
.type	modrnd,@function
.global	modrnd
.align	0x04

modrnd:	pushl	%ebx
	movl	INTPTR(%esp), %ebx
	movl	(%ebx), %eax
	rorl	$3, %eax
	addl	$MAGIC, %eax
	movl	%eax, (%ebx)
	xorl	%edx, %edx
	divl	DIVISR(%esp)
	movl	%edx, %eax
	popl	%ebx
        ret
.end
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.
