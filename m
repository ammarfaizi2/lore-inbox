Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288606AbSANSUw>; Mon, 14 Jan 2002 13:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287862AbSANSUm>; Mon, 14 Jan 2002 13:20:42 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:54400 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S288606AbSANSU0>;
	Mon, 14 Jan 2002 13:20:26 -0500
Date: Mon, 14 Jan 2002 13:20:20 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org, linux-LVM@sistina.com
Subject: Re: [RFLART] kdev_t in ioctls
In-Reply-To: <Pine.LNX.4.33.0201140957040.15128-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0201141309270.224-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Jan 2002, Linus Torvalds wrote:

> The good news is that the bit-for-bit representation of old kdev_t and
> "dev_t" are obviously 100% the same, so we should just make the damn thing
> be dev_t, and user land will never notice anything.
> 
> So we can just change all structures that are exported to user land to use
> "dev_t", and add the required conversion magic. Possibly by duplicating
> the structure, and having "used_lvm_struct_x" and functions to read and
> write them from/to user space.

... that, BTW, would kill the crap like

typedef struct ...
	...
#ifdef __KERNEL__
        struct kiobuf *lv_iobuf;
        sector_t blocks[LVM_MAX_SECTORS];
        struct kiobuf *lv_COW_table_iobuf;
        struct rw_semaphore lv_lock;
        struct list_head *lv_snapshot_hash_table;
        uint32_t lv_snapshot_hash_table_size;
        uint32_t lv_snapshot_hash_mask;
        wait_queue_head_t lv_snapshot_wait;
        int     lv_snapshot_use_rate;
        struct vg_v3    *vg;

        uint lv_allocated_snapshot_le;
#else
        char dummy[200];
#endif
} lv_t;

Yup, structure "shared" by kernel and userland.  Look through the
include/linux/lvm.h - it's choke-full of that.  And quite a few
of them contain fields like
	struct proc_dir_entry *foo
	struct block_device *bar
	struct list_head baz
outside of these #ifdef __KERNEL__...
 
> > Public statement along the lines "any API that passes kdev_t values
> > across the kernel boundary is unacceptable" would be a nice thing...
> 
> Consider that done. ANYTHING that exports kdev_t to user space is
> incredibly broken, and will not work in a few months when the actual bit
> representation (and size) will change.
> 
> Do we have any lvm people willing to fix this? (linux-lvm cc'd, but I know
> they've been very silent on the 2.5.x changes so far)

Umm...  Is the version in main tree actually maintained?

