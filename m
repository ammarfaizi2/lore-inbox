Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264577AbUESVGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264577AbUESVGP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 17:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264578AbUESVGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 17:06:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26058 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264577AbUESVGE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 17:06:04 -0400
Date: Wed, 19 May 2004 22:06:03 +0100
From: Matthew Wilcox <willy@debian.org>
To: Chris Wright <chrisw@osdl.org>
Cc: Mingming Cao <cmm@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] Re: [PATCH] use-before-uninitialized value in ext3(2)_find_ goal
Message-ID: <20040519210603.GW6484@parcelfarce.linux.theplanet.co.uk>
References: <20040519043235.30d47edb.akpm@osdl.org> <1084992705.15395.1276.camel@w-ming2.beaverton.ibm.com> <20040519125328.J22989@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040519125328.J22989@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2004 at 12:53:28PM -0700, Chris Wright wrote:
> I know it's a slightly bigger patch, but would it make sense to just enforce
> this as part of api?  Just a thought...(patch untested)

No, that doesn't work.  Look:

reread:
	...

        if (ext2_find_goal(inode, iblock, chain, partial, &goal) < 0)
                goto changed;

changed:
        while (partial > chain) {
                brelse(partial->bh);
                partial--;
        }
        goto reread;

So it's spaghetti code that can modify goal.  Yuck.

5 labels in one function?  3 backwards jumps?  Disgusting.

> --- linux-2.6.6-mm3/fs/ext2/inode.c~goal	2004-05-09 19:32:00.000000000 -0700
> +++ linux-2.6.6-mm3/fs/ext2/inode.c	2004-05-19 12:27:11.968054560 -0700
> @@ -366,6 +366,7 @@ static inline int ext2_find_goal(struct 
>  				 unsigned long *goal)
>  {
>  	struct ext2_inode_info *ei = EXT2_I(inode);
> +	unsigned long _goal = 0;
>  	write_lock(&ei->i_meta_lock);
>  	if (block == ei->i_next_alloc_block + 1) {
>  		ei->i_next_alloc_block++;
> @@ -377,10 +378,11 @@ static inline int ext2_find_goal(struct 
>  		 * failing that at least try to get decent locality.
>  		 */
>  		if (block == ei->i_next_alloc_block)
> -			*goal = ei->i_next_alloc_goal;
> -		if (!*goal)
> -			*goal = ext2_find_near(inode, partial);
> +			_goal = ei->i_next_alloc_goal;
> +		if (!_goal)
> +			_goal = ext2_find_near(inode, partial);
>  		write_unlock(&ei->i_meta_lock);
> +		*goal = _goal;
>  		return 0;
>  	}
>  	write_unlock(&ei->i_meta_lock);
> --- linux-2.6.6-mm3/fs/ext3/inode.c~goal	2004-05-13 11:19:42.000000000 -0700
> +++ linux-2.6.6-mm3/fs/ext3/inode.c	2004-05-19 12:25:48.441752488 -0700
> @@ -461,6 +461,7 @@ static int ext3_find_goal(struct inode *
>  			  Indirect *partial, unsigned long *goal)
>  {
>  	struct ext3_inode_info *ei = EXT3_I(inode);
> +	unsigned long _goal = 0;
>  	/* Writer: ->i_next_alloc* */
>  	if (block == ei->i_next_alloc_block + 1) {
>  		ei->i_next_alloc_block++;
> @@ -474,9 +475,10 @@ static int ext3_find_goal(struct inode *
>  		 * failing that at least try to get decent locality.
>  		 */
>  		if (block == ei->i_next_alloc_block)
> -			*goal = ei->i_next_alloc_goal;
> -		if (!*goal)
> -			*goal = ext3_find_near(inode, partial);
> +			_goal = ei->i_next_alloc_goal;
> +		if (!_goal)
> +			_goal = ext3_find_near(inode, partial);
> +		*goal = _goal;
>  		return 0;
>  	}
>  	/* Reader: end */
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: SourceForge.net Broadband
> Sign-up now for SourceForge Broadband and get the fastest
> 6.0/768 connection for only $19.95/mo for the first 3 months!
> http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
> _______________________________________________
> Ext2-devel mailing list
> Ext2-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ext2-devel

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
