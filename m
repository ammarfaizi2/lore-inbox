Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284017AbRLIULY>; Sun, 9 Dec 2001 15:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284010AbRLIULP>; Sun, 9 Dec 2001 15:11:15 -0500
Received: from dsl-213-023-043-206.arcor-ip.net ([213.23.43.206]:53771 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S284017AbRLIULE>;
	Sun, 9 Dec 2001 15:11:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
Date: Sun, 9 Dec 2001 21:13:34 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0112082012330.1344-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0112082012330.1344-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16DAKP-00019T-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 9, 2001 05:19 am, Linus Torvalds wrote:
> On Sun, 9 Dec 2001, Daniel Phillips wrote:
> >
> > The difference is, there's only one superblock per mount.  There are
> > bazillions of inodes.
> 
> .. and they share buffers.

Not consistently, though this is something that could and should be improved.
Try "ls -i | sort" to see what I mean.

> I bet that having a pointer to the buffer will _reduce_ average
> average footprint rather than increase it. The inodes are fairly densely
> laid out in the buffers, so I dare you to find any real-world (or even
> very contrieved) usage patterns where it ends up being problematic.

I didn't have to look any further than my laptop.  Home and etc look like 
near-worst cases (because of slow growth and doubtful inode allocation 
policy); /bin looks pretty close to the best case, but still it's very rare 
to find a full 32 inodes densely allocated.  The tradeoff is this: for each 
itable block member that happens to be in cache simultaneously you can save 
68 bytes by pinning the itable block buffer and pointing directly at it, 
while incurring the cache cost of pinning an additional 60 bytes that are 
never accessed outside read/update_inode.  For each itable block member that 
isn't in cache (perhaps because it wasn't allocated) you pin an extra 128 
bytes.  The break-even is 6 uncached inodes/block - any more and you're 
pinning more cache than you're saving.

The case that hurts is where inode access order is non-coherent, which is the 
case we're trying to fix.  If inode access order *is* coherent, you don't 
have a problem because once you're done with an entire itable block it can be 
evicted and not read back any time soon.

You're also touching an extra cacheline/inode by following the pointer, for 
what it's worth [not much, because we're doing get_block/truncate when 
following the link, making the cacheline hit look microscopic].

Continuing the little warts list, there's Alan's comment re needing endian 
reversal on big endian machines.  I'm also looking at the locking 
suspiciously.  Directly operating on the buffer it looks like we can happily 
change the data even in the middle of a dma.  This is murky stuff, I'd be 
happy to be corrected on it.  I wonder what Ext3 impact we'd have here?

> Remember: we'd save 15*4=60 bytes per inode, at the cost of pinning the
> block the inode is in. But _usually_ we'd have those blocks in memory
> anyway, especially if the inode gets touched (which dirties it, and
> updates atime, which forces us to do writeback).

So by always pinning the itable block you'd be eroding the benefit that can 
be obtained through inhibiting atime updating.  Even with atime, at least 
it's only the in-memory inode being dirtied.  When it comes time to update, 
itable blocks can be read in as necessary, updated and evicted as the icache 
continues to exert pressure.  Caveat: I'm rapidly wandering off into obscure 
cache balancing issues here, little understood and probably poorly handled.

> For the initial IO we obviously _have_ to have them in memory.
> 
> And we'll get rid of inodes under memory pressure too, so the pinning will
> go away when memory is really tight. Yes, you can try to "attack" the
> machine by trying to open all the right inodes, but the basic attack is
> there already. ulimit is your friend.

Unfortunately, it's not an attack, it's a not-so-rare real life situation - 
not to the extreme of my example, but close enough to hurt.

> > It's worth keeping in mind that tweaking the icache efficiency in this 
> > case is really just curing a symptom - the underlying problem is a 
> > mismatch between readdir order and inode order.
> 
> Well, the inode writeback read-modify-write synchronization and related
> efficiency problems actually has nothing to do with the readdir order.

I've measured the effect.  Ignoring seeks, the worst case access order is:

    hit_inum(i%n*m + i/n)

where n is the number of itable blocks and m is inodes/block, i.e., for each 
itable block, access a single inode on it, repeat until all inodes have been 
accessed.  Here, pinning inode blocks is going to multiply the number of 
inode evictions, even if we set noatime.  Cases that approach this degree of 
non-coherence aren't rare at all.

The bottom line is, I think you can find cases where your strategy for 
reducing double caching saves a little, whereas I can find case where it 
hurts a lot.

What if we could do inode-granular transfers through an inode address_space?  
This will eliminate the double caching entirely, because we're always able to 
generate the full on-disk inode from the cached inode.  Then it costs little 
to evict the inode buffer immediately after every transfer.  It seems to me 
that the cost of this would be just a table of states per address_space unit, 
plus some fiddling with bio, which we're doing anyway.

--
Daniel

