Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285862AbRLHHZk>; Sat, 8 Dec 2001 02:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285861AbRLHHZ0>; Sat, 8 Dec 2001 02:25:26 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2829 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285860AbRLHHZR>; Sat, 8 Dec 2001 02:25:17 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
Date: Sat, 8 Dec 2001 07:19:32 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9useu4$f4o$1@penguin.transmeta.com>
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <20011207174726.B6640@vestdata.no> <E16CP0X-0000uE-00@starship.berlin> <3C110B3F.D94DDE62@zip.com.au>
X-Trace: palladium.transmeta.com 1007796301 7082 127.0.0.1 (8 Dec 2001 07:25:01 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 8 Dec 2001 07:25:01 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C110B3F.D94DDE62@zip.com.au>,
Andrew Morton  <akpm@zip.com.au> wrote:
>Daniel Phillips wrote:
>> 
>> Because Ext2 packs multiple entries onto a single inode table block, the
>> major effect is not due to lack of readahead but to partially processed inode
>> table blocks being evicted.
>
>Inode and directory lookups are satisfied direct from the icache/dcache,
>and the underlying fs is not informed of a lookup, which confuses the VM.
>
>Possibly, implementing a d_revalidate() method which touches the
>underlying block/page when a lookup occurs would help.

Well, the multi-level caching thing is very much "separate levels" on
purpose, one of the whole points of the icache/dcache being accessed
without going to any lower levels is that going all the way to the lower
levels is slow.

And there are cases where it is better to throw away the low-level
information, and keep the high-level cache, if that really is the access
pattern. For example, if we really always hit in the dcache, there is no
reason to keep any backing store around.

For inodes in particular, though, I suspect that we're just wasting
memory copying the ext2 data from the disk block to the "struct inode".
We might be much better off with

 - get rid of the duplication between "ext2_inode_info" (in struct
   inode) and "ext2_inode" (on-disk representation)
 - add "struct ext2_inode *" and a "struct buffer_head *" pointer to
   "ext2_inode_info".
 - do all inode ops "in place" directly in the buffer cache.

This might actually _improve_ memory usage (avoid duplicate data), and
would make the buffer cache a "slave cache" of the inode cache, which in
turn would improve inode IO (ie writeback) noticeably.  It would get rid
of a lot of horrible stuff in "ext2_update_inode()", and we'd never have
to read in a buffer block in order to write out an inode (right now,
because inodes are only partial blocks, write-out becomes a read-modify-
write cycle if the buffer has been evicted). 

So "ext2_write_inode()" would basically become somehting like

	struct ext2_inode *raw_inode = inode->u.ext2_i.i_raw_inode;
	struct buffer_head *bh = inode->u.ext2_i.i_raw_bh;

	/* Update the stuff we've brought into the generic part of the inode */
	raw_inode->i_size = cpu_to_le32(inode->i_size);
	...
	mark_buffer_dirty(bh);

with part of the data already in the right place (ie the current
"inode->u.ext2_i.i_data[block]" wouldn't exist, it would just exist as
"raw_inode->i_block[block]" directly in the buffer block.

			Linus
