Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288255AbSBIEDx>; Fri, 8 Feb 2002 23:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288262AbSBIEDn>; Fri, 8 Feb 2002 23:03:43 -0500
Received: from [63.231.122.81] ([63.231.122.81]:36448 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S288255AbSBIED0>;
	Fri, 8 Feb 2002 23:03:26 -0500
Date: Fri, 8 Feb 2002 21:02:36 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
        davej@suse.de, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] (was Re: Kernel panic: EXT2-fs panic on 2.5.4-pre3)
Message-ID: <20020208210236.Y15496@lynx.turbolabs.com>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net, davej@suse.de,
	Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <20020208234310.GA27610@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020208234310.GA27610@kroah.com>; from greg@kroah.com on Fri, Feb 08, 2002 at 03:43:10PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 08, 2002  15:43 -0800, Greg KH wrote:
> I got this when unmounting my drive after running e2fsck...
>
> Kernel panic: EXT2-fs panic (device ide0(3,5)): load_block_bitmap:
>   block_group >= groups_count - block_group = 131071, groups_count = 33

Well, clearly it has the right to complain, because it is getting a crappy
data as input.  The ext2_panic() function should _probably_ be changed to
a BUG(); instead of panic() because then we can at least get a backtrace.

As to where that bad data came from...

I seem to recall trying to track down this exact same problem about a
year ago.  A quick search on Google shows that there are a lot of oopses
at the same place with block_group = 131071.

The last time I looked at this bug, I thought it was due to an
uninitialized variable i_prealloc_count, but that wasn't the case.
Really, the only path where this can happen is if ext2_free_blocks()
is called with a bad block or count parameter, in such a way that
block + count overflows a 32-bit int and the check at the beginning of
ext2_free_blocks() does not catch it.

It appears we are trying to free block -1 for some reason:

group 131071 = block -1UL / 32768 blocks/group    on a 4kB block fs

If you try to free block = -1 and count >= 1, it will pass the checks
in ext2_free_blocks().  The below patch fixes this, but not necessarily
the original source of the bad block number (I will continue looking
for that).  It is still worthwhile to ensure that we are not using a
bogus block+count.  It would appear that this is not just random
corrupt data from disk, because of the common occurrence of group 131071,
but I can't see where the bad block is coming from right now.

Patch against 2.4.17-pre8, but it should be the same for all kernels in
recent history.

Cheers, Andreas
====================== ext2-2.4.17-panic.diff =============================
--- linux-2.4.17-pre8.orig/fs/ext2/balloc.c	Thu Oct 25 02:02:41 2001
+++ linux-2.4.17-pre8/fs/ext2/balloc.c	Fri Feb  8 18:56:22 2002
@@ -269,8 +267,9 @@
 	}
 	lock_super (sb);
 	es = sb->u.ext2_sb.s_es;
-	if (block < le32_to_cpu(es->s_first_data_block) || 
-	    (block + count) > le32_to_cpu(es->s_blocks_count)) {
+	if (block < le32_to_cpu(es->s_first_data_block) ||
+	    block + count < block ||
+	    block + count >= le32_to_cpu(es->s_blocks_count)) {
 		ext2_error (sb, "ext2_free_blocks",
 			    "Freeing blocks not in datazone - "
 			    "block = %lu, count = %lu", block, count);
--- linux-2.4.17-pre8.orig/fs/ext3/balloc.c	Thu Oct 25 02:02:41 2001
+++ linux-2.4.17-pre8/fs/ext3/balloc.c	Fri Feb  8 18:56:22 2002
@@ -269,8 +267,9 @@
 	}
 	lock_super (sb);
 	es = sb->u.ext3_sb.s_es;
-	if (block < le32_to_cpu(es->s_first_data_block) || 
-	    (block + count) > le32_to_cpu(es->s_blocks_count)) {
+	if (block < le32_to_cpu(es->s_first_data_block) ||
+	    block + count < block ||
+	    block + count >= le32_to_cpu(es->s_blocks_count)) {
 		ext3_error (sb, "ext3_free_blocks",
 			    "Freeing blocks not in datazone - "
 			    "block = %lu, count = %lu", block, count);
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

