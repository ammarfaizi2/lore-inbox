Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280944AbRKGTiH>; Wed, 7 Nov 2001 14:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280936AbRKGThr>; Wed, 7 Nov 2001 14:37:47 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:32763 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S280935AbRKGThj>;
	Wed, 7 Nov 2001 14:37:39 -0500
Date: Wed, 7 Nov 2001 12:34:30 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Stephen Tweedie <sct@redhat.com>, ext2-devel@lists.sourceforge.net,
        m@mo.optusnet.com.au, Andrew Morton <akpm@zip.com.au>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Mike Fedyk <mfedyk@matchmail.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] ext2/ialloc.c cleanup
Message-ID: <20011107123430.D5922@lynx.no>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	Stephen Tweedie <sct@redhat.com>, ext2-devel@lists.sourceforge.net,
	m@mo.optusnet.com.au, Andrew Morton <akpm@zip.com.au>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	Mike Fedyk <mfedyk@matchmail.com>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20011106214821.N4137@redhat.com> <Pine.GSO.4.21.0111061808440.29465-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.GSO.4.21.0111061808440.29465-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Tue, Nov 06, 2001 at 06:17:09PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 06, 2001  18:17 -0500, Alexander Viro wrote:
> 	Folks, promised cleanup of ialloc.c is on
> ftp.math.psu.edu:pub/viro/ialloc.c,v
> 
> And yes, it's in RCS.  The thing is split into _really_ small
> steps (commented in the log).  Each is a trivial transformation
> and it should be very easy to verify correctness of any of
> them.
> 
> Please, review.  IMO it's cut fine enough to make the gradual merge
> possible for 2.4 - look and you'll see.

Minor nits, from my changes to this same function:
1) please replace use of "i" for best block group in find_cg_*, to
   something better like "group", just for clarity.
2) in find_cg_*, when you fail the quadratic search, the linear search
   should skip groups that were previously checked in the quadratic search,
   with slight changes to both loops:

	start = dir->u.ext2_i.i_block_group;

	/* Use quadratic hash to find group with a free inode */
	for (j = 1; j < count; j <<= 1) {
		group = start + j;
		if (group >= count)
			group -= count;
		cg = ext2_get_group_desc(sb, group, &bh);
		if (cg && le16_to_cpu(cg->bg_free_inodes_count))
			goto found;
	}

	/* That failed: try linear search for a free inode
	 * skipping groups we checked in the previous loop.
	 */
	for (j = 3; j < count; j++) {
		if ((j & (j - 1)) == 0)
			continue;
		group = start + j;
		if (group > count)
			group -= count;
		cg = ext2_get_group_desc(sb, group, &bh);
		if (cg && le16_to_cpu(cg->bg_free_inodes_count))
			goto found;
	}
3) I know that "cylinder groups" were used in old FFS/whatever implementation,
   but all of the ext2 code/documentation refers to these as block groups.
   Can you stick with that for ext2 (e.g. gdp, not cg; bg_foo, not cg_foo)?
4) sbi can be gotten by "EXT2_SB(sb)".

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

