Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263052AbTJPSUw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 14:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbTJPSUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 14:20:52 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:64246 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S263052AbTJPSUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 14:20:49 -0400
Date: Thu, 16 Oct 2003 12:18:25 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Eli Billauer <eli_billauer@users.sourceforge.net>,
       linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [RFC] frandom - fast random generator module
Message-ID: <20031016121825.D7000@schatzie.adilger.int>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Eli Billauer <eli_billauer@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>
References: <3F8E552B.3010507@users.sf.net> <3F8E58A9.20005@cyberone.com.au> <3F8E70E0.7070000@users.sf.net> <3F8E8101.70009@pobox.com> <20031016102020.A7000@schatzie.adilger.int> <3F8EC7D0.5000003@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F8EC7D0.5000003@pobox.com>; from jgarzik@pobox.com on Thu, Oct 16, 2003 at 12:31:12PM -0400
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 16, 2003  12:31 -0400, Jeff Garzik wrote:
> Andreas Dilger wrote:
> > Actually, there are several applications of low-cost RNG inside the kernel.
> > 
> > For Lustre we need a low-cost RNG for generating opaque 64-bit handles in
> > the kernel.  The use of get_random_bytes() showed up near the top of
> > our profiles and we had to invent our own low-cost crappy PRNG instead (it's
> > good enough for the time being, but when we start working on real security
> > it won't be enough).
> > 
> > The tcp sequence numbers probably do not need to be crypto-secure (I could
> > of course be wrong on that ;-) and with GigE or 10GigE I imagine the number
> > of packets being sent would put a strain on the current random pool.
> 
> 
> We don't need "low cost RNG" and "high cost RNG" in the same kernel. 
> That just begs a "reduce RNG cost" solution...  I think security experts 
> can easily come up with arguments as to why creating your own "low-cost 
> crappy PRNG" isn't needed -- you either need crypto-secure, or you 
> don't.  If you don't, then you could just as easily create an ascending 
> 64-bit number for your opaque filehandle, or use a hash value, or some 
> other solution that doesn't require an additional PRNG in the kernel.

Hmm, so every part of the kernel that doesn't need crypto-secure RNG data
(i.e. fast and relatively unique) should implement its own hash/PRNG then?
It isn't a matter of unbreakable crypto, but the fact that we want relatively
unique values that will not be the same on a reboot.  Currently we do just
as you propose for our "crappy PRNG", which is "grab 8 bytes via
get_random_bytes and increment", but that is a little _too_ easy to guess
(although good enough for the time being).

> For VIA CPUs, life is easy.  Use xstore insn and "You've got bytes!"  :)

As you say, we could throw away even our crappy PRNG and get better data
with a single opcode.  So you advocate we add CPU/arch-specific code into
our filesystem?  How about we add a wrapper around all the different
CPU-specific RNG codes and call it the "low cost RNG" which will be faster
_and_ give better data than any explicitly-coded PRNG. ;-)  For our needs
at least, the asm-generic code would be on the order of maybe 15 lines of C:

#define RESEED_INTERVAL 65536

int get_fast_random_bytes(char *buf, int nbytes)
{
	static int data_arr[NR_CPUS], count_arr[NR_CPUS]; /* use percpu... */
	int *data = &data_arr[smp_processor_id()];
	int *count = &count_arr[smp_processor_id()];

	*count -= nbytes;
	if (*count < 0) {
		*count = RESEED_INTERVAL;
		get_random_bytes(data, sizeof(*data));
	}
		
	while (nbytes >= sizeof(*data)) {
		*(long *)buf = *data;
		buf += sizeof(*data);
		*data = *data * 1812433253L + 12345L; /* or whatever... */
	}
	memcpy(buf, data, nbytes);
}

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

