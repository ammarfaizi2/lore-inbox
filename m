Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317482AbSH1AVH>; Tue, 27 Aug 2002 20:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317517AbSH1AVH>; Tue, 27 Aug 2002 20:21:07 -0400
Received: from adsl-67-117-146-62.dsl.snfc21.pacbell.net ([67.117.146.62]:27397
	"EHLO localhost") by vger.kernel.org with ESMTP id <S317482AbSH1AVG>;
	Tue, 27 Aug 2002 20:21:06 -0400
From: "Stephen C. Biggs" <s.biggs@softier.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 27 Aug 2002 17:25:17 -0700
MIME-Version: 1.0
Subject: Bug in kernel code?
Message-ID: <3D6BB5FD.16049.2F324B@localhost>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted this to the newsgroup news:linux-kernel but got no response... 
I'll try here.

While going thru the kernel code for 2.4.17 (uClinux patch) I noticed a 
problem with functions in 3 files:
dcache_init in fs/dcache.c, inode_init in fs/inode.c and in mnt_init in 
fs/namespace.c

At least on my Redhat 7.3 2.4.18-10 source, in the function

static void __init dcache_init(unsigned long mempages)
{
	struct list_head *d;
	unsigned long order;
	unsigned int nr_hash;
	int i;

	/* 
	 * A constructor could be added for stable state like the lists,
	 * but it is probably not worth it because of the cache nature
	 * of the dcache. 
	 * If fragmentation is too bad then the SLAB_HWCACHE_ALIGN
	 * flag could be removed here, to hint to the allocator that
	 * it should not try to get multiple page regions.  
	 */
	dentry_cache = kmem_cache_create("dentry_cache",
					 sizeof(struct dentry),
					 0,
					 SLAB_HWCACHE_ALIGN,
					 NULL, NULL);
	if (!dentry_cache)
		panic("Cannot create dentry cache");

#if PAGE_SHIFT < 13
	mempages >>= (13 - PAGE_SHIFT);
#endif
	mempages *= sizeof(struct list_head);
	for (order = 0; ((1UL << order) << PAGE_SHIFT) < mempages; order++)
		;

	do {
		u32 tmp;

		nr_hash = (1UL << order) * PAGE_SIZE /
			sizeof(struct list_head);
		d_hash_mask = (nr_hash - 1);

		tmp = nr_hash;
		d_hash_shift = 0;
		while ((tmp >>= 1UL) != 0UL)
			d_hash_shift++;

		dentry_hashtable = (struct list_head *)
			__get_free_pages(GFP_ATOMIC, order);
	} while (dentry_hashtable == NULL && --order >= 0);


........... Notice the --order >=0 in the do while test... since order 
is declared as an unsigned long, this test is a pointless comparison and 
never fails, causing an infinite loop if the hashtable is empty.  

My fix to this is to change the test to have
while (dentry_hashtable == NULL && order-- != 0);

Could someone check me on this?


