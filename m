Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279013AbRKMU6z>; Tue, 13 Nov 2001 15:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279005AbRKMU6p>; Tue, 13 Nov 2001 15:58:45 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:21753 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S279013AbRKMU62>;
	Tue, 13 Nov 2001 15:58:28 -0500
Date: Tue, 13 Nov 2001 13:56:59 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Andrew Morton <akpm@zip.com.au>,
        Ben Israel <ben@genesis-one.com>, linux-kernel@vger.kernel.org
Subject: Re: File System Performance
Message-ID: <20011113135659.P1778@lynx.no>
Mail-Followup-To: Richard Gooch <rgooch@ras.ucalgary.ca>,
	Mike Fedyk <mfedyk@matchmail.com>, Andrew Morton <akpm@zip.com.au>,
	Ben Israel <ben@genesis-one.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3BEFF9D1.3CC01AB3@zip.com.au> <00da01c16ba2$96aeda00$5101a8c0@pbc.adelphia.net> <3BF02702.34C21E75@zip.com.au> <200111121959.fACJxsj08462@vindaloo.ras.ucalgary.ca> <20011112150740.B32099@mikef-linux.matchmail.com> <200111130004.fAD04v912703@vindaloo.ras.ucalgary.ca> <20011112160822.E32099@mikef-linux.matchmail.com> <200111130026.fAD0QVK13232@vindaloo.ras.ucalgary.ca> <20011112172832.F32099@mikef-linux.matchmail.com> <200111130634.fAD6YiM19519@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200111130634.fAD6YiM19519@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Mon, Nov 12, 2001 at 11:34:44PM -0700
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 12, 2001  23:34 -0700, Richard Gooch wrote:
> > Currently, without any patching, any new directory will be put in a
> > different block group from its parent.
> 
> Your statement seems inconsistent with the comment above
> fs/ext2/ialloc.c:ext2_new_inode():
> /*
>  * There are two policies for allocating an inode.  If the new inode is
>  * a directory, then a forward search is made for a block group with both
>  * free space and a low directory-to-inode ratio; if that fails, then of
>  * the groups with above-average free space, that group with the fewest
>  * directories already is chosen.
>  *
>  * For other inodes, search forward from the parent directory\'s block
>  * group to find a free inode.
>  */

This is only a comment, and not actual code.  The code looks like:

	if (S_ISDIR(mode)) {
		int avefreei = le32_to_cpu(es->s_free_inodes_count) /
			sb->u.ext2_sb.s_groups_count;

		/* Place directory in a group with free inodes and blocks. */
		for (j = 0; j < sb->u.ext2_sb.s_groups_count; j++) {
			tmp = ext2_get_group_desc (sb, j, &bh2);
			if (tmp && le16_to_cpu(tmp->bg_free_inodes_count) &&
			    le16_to_cpu(tmp->bg_free_inodes_count) >= avefreei){
				if (!gdp ||
				    (le16_to_cpu(tmp->bg_free_blocks_count) >
				     le16_to_cpu(gdp->bg_free_blocks_count))) {
					group = j;
					gdp = tmp;
				}
			}
		}
	} else {

So, as you can see, it searches all of the directories for a group which:
a) has any free inodes (redundant with (b), actually)
b) has more than the average number of free inodes
c) has the most free blocks

> So N successive calls to mkdir(2), with the same parent, should result
> in those directories being stored in the same block group as each
> other. And, furthermore, if the parent directory block group is mostly
> empty, then the child directories are placed adjacent to the parent's
> block group.

So, as we see above, the starting directory is irrelevant.  We pick the
best directory with an exhaustive search of all block groups.  Note that
you are correct in that IF the parent block group is mostly empty, then
subdirectories would also be placed there, but the nature of the algorithm
is that EVERYTHING would go there until it is not "better" than any other
group, at which case we have approximately round-robin group allocation.

Maybe a better heuristic is to add a "bonus" to the parent directory's
group, so other things being equal we stay in the same group.  This gives
us some advantage of clustering, but also allows a global optimal choice
to be made in case we are looking for a new group.

> > Now does this make sence?
> 
> It would, if you were correct about the current implementation. Which
> I think isn't the case.
> 
> > Not currently, but the patch that is out will do this.
> 
> I think it currently *does*. Check the comment. Straight from the
> 2.4.14 sources.

You shouldn't base arguments on a comment, because they tend to not be
updated along with changes to the code.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

