Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129652AbQLNAGO>; Wed, 13 Dec 2000 19:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129539AbQLNAGE>; Wed, 13 Dec 2000 19:06:04 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:38158 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129652AbQLNAFq>; Wed, 13 Dec 2000 19:05:46 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Thu, 14 Dec 2000 10:15:10 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14904.766.686541.548702@notabene.cse.unsw.edu.au>
Cc: Jasper Spaans <jasper@spaans.ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] raid5 crash with 2.4.0-test12 [Was: Linux-2.4.0-test12]
In-Reply-To: message from Linus Torvalds on Tuesday December 12
In-Reply-To: <14902.49167.834682.925490@notabene.cse.unsw.edu.au>
	<Pine.LNX.4.10.10012121900380.22326-100000@penguin.transmeta.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday December 12, torvalds@transmeta.com wrote:
> 
> 
> On Wed, 13 Dec 2000, Neil Brown wrote:
> > 
> > Yes... you are right.  Alright, I can't escape it any other way so I
> > guess I must admit that  it is a raid5 bug.
> > 
> > But how can raid5 be calling b_end_io on a buffer_head that was never
> > passed to generic_make_request?
> > Answer, it snoops on the buffer cache to try to do complete stripe
> > writes.
> 
> Ahh, yes. It seems to just do a "get_hash_table()", and put that bh into
> the queues. Bad.
> 
> > The following patch disabled that code.
> 
> If this fix makes the oops go away, then the proper fix for the problem is
> not the #if 0, but do add something like
> 
> 	bh->b_end_io = buffer_end_io_sync;
> 
> to just before the "add_stripe_bh(sh, bh, i, WRITE);"
> 
> We've already locked the thing, so that should be ok.

Yes, that should work, except that end_buffer_io_sync is static in
ll_rw_blk.c :-)

However I don't think there is a lot of point in maintaining this
piece of code.  It was a useful optimisation in 2.2, but it is
substantially less effective in 2.4.

In 2.2 filesystems kept allcache data - file content, meta data, etc,
in the physically addressed buffer cache.  As it was physically
addressed, raid5 could go looking for other data in the same stripe as
the stripe that it was writing, and thereby improve performance.

But in 2.4, filesystems (well, ext2 at least) keep only the metadata
in the buffer cache, and if you are using something like LVM or RAID0
on top of the RAID5 array, there wont be anything in the buffer cache
for the raid5 device.

I think I can get similar performance improvements by "plugging" the
raid5 device appropriately, but I haven't quite figured out all the
issues in making that work completely.

> 
> I wonder about that "md_test_and_set_bit(BH_Lock ...);" thing there,
> though. If the buffer we find was dirty but already locked, we won't be
> using that buffer at all (because the md_test_and_set_bit() will fail),
> which probably means that the RAID5 checksum won't be right. Hmm..
> 
> Why is there an dirty aliased buffer head anyway? That sounds like a
> recipe for disaster - maybe we should have synched all the stripe devices
> before we set up the raid? Is that a raid5 rebuild issue? What's going on
> here?

I we find a dirty, locked buffer, then it means that some other thread
has got through ll_rw_block with that buffer, but is blocked, or is
about to be blocked, in raid5_make_request (calling get_lock_stripe
probably).  When the current write phase completes, that dirty block
will come through and cause another write phase on this stripe.
Each time the parity will be correct.
This is completely separate from parity re-syncing.  The resync code
doesn't use buffers in the buffer cache at all.  It just uses the
buffers in the raid5 stripe cache.

NeilBrown

> 
> 		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
