Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267608AbTAGXwZ>; Tue, 7 Jan 2003 18:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267605AbTAGXwZ>; Tue, 7 Jan 2003 18:52:25 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:4230 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S267608AbTAGXwX>; Tue, 7 Jan 2003 18:52:23 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Wed, 8 Jan 2003 11:00:51 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15899.27187.242036.85294@notabene.cse.unsw.edu.au>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Define hash_mem in lib/hash.c to apply hash_long to an
 arbitraty piece of memory.
In-Reply-To: message from Linus Torvalds on Monday January 6
References: <1041924803.27637.3.camel@ixodes.goop.org>
	<Pine.LNX.4.44.0301062341210.1394-100000@home.transmeta.com>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday January 6, torvalds@transmeta.com wrote:
> 
> On 6 Jan 2003, Jeremy Fitzhardinge wrote:
> > 
> > I think they have a different set of design requirements.  They're both
> > designed to not only generate hashes, but make the hashes
> > cryptographically strong (ie, impossible to generate collisions with
> > less effort than brute force).  They're naturally slower than a simple
> > hash, so you'd only use them if you need the stronger requirements.
> 
> The filesystem hashes also have another design criteria: they need to 
> reliably give the _same_ hash on different machines.
> 
> In particular, the suggested hash_mem() thing is endian-unsafe, meaning
> that it will give different answers on an x86 than on a sparc CPU, for
> example. Which can be ok if the only thing you care about is some
> temporary hash, but is unacceptable for a lot of uses. The filesystem
> hashes (well, at least some of them) are also designed to hash out files
> on the disk, which means that they _have_ to be the same regardless of
> architecture, or you can't move disks between machines.

Not only endian-unsafe but also word-length-unsafe!
I certainly never imagined hash_mem would be a replacement for an
externally visible hash function such as those used by ext3.  Rather I
was wondering if one of those used by ext3 would be a suitable
candidate for hash_mem, and found that they weren't convincingly
better.

> 
> Quite frankly, I think the suggested hash_mem() is too special-cased to
> make any sense as a generic function. The endian problems means that it
> _isn't_ really generic anyway, and as such it might as well just be some
> internal nfs helper function rather than something in <linux/string.h>
> 
That's a shame.... It fills a similar purpose to full_name_hash in
dcache.h.  It might be nice to have just one function for internal
hashing of names.
The proposed hash_mem() seems slightly better than full_name_hash, and
much the same speed (Depending on how you measure it...)

Maybe full_name_hash et.al could be moved to linux/hash.h and I could
use that ...

My current preferred internal 'hash-a-string' function is:

static inline unsigned long hash_str(unsigned char *name, int bits, char term)
{
	unsigned long hash = 0;
	unsigned long l = 0;
	int len = 0;
	unsigned char c;
	while (likely(c = *name++) && likely(c != term)) {
		l = (l << 8) | c;
		len++;
		if ((len & (BITS_PER_LONG/8-1))==0)
			hash = hash_long(hash^l, BITS_PER_LONG);
	}
	l = l << 8 ^ len;
	return hash_long(hash^l, bits);
}

Given that we need to search for a terminator, using *(unsigned long*)
doesn't really help.

This hash_str could be used in place of the namei/dcache hashing, and
can be used where I need to hash a string.

Would anyone like to independantly compare it with:
		c = *(const unsigned char *)name;

		hash = init_name_hash();
		do {
			name++;
			hash = partial_name_hash(c, hash);
			c = *(const unsigned char *)name;
		} while (c && (c != '/'));

which is the comparable function from namei.c

NeilBrown
