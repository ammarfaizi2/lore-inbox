Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284153AbRL2QFR>; Sat, 29 Dec 2001 11:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284204AbRL2QFH>; Sat, 29 Dec 2001 11:05:07 -0500
Received: from waste.org ([209.173.204.2]:53708 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S284153AbRL2QFA>;
	Sat, 29 Dec 2001 11:05:00 -0500
Date: Sat, 29 Dec 2001 10:04:24 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Daniel Phillips <phillips@bonn-fries.net>, <linux-kernel@vger.kernel.org>,
        <ext2-devel@lists.sourceforge.net>,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [Ext2-devel] [RFC] [PATCH] Clean up fs.h union for ext2
In-Reply-To: <20011227111415.D12868@lynx.no>
Message-ID: <Pine.LNX.4.43.0112290957050.18183-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2001, Andreas Dilger wrote:

> On Dec 27, 2001  04:21 +0100, Daniel Phillips wrote:
> > The strategy is to abstract all references to the struct inode union through
> > an inline function:
> >
> > 	static inline struct ext2_inode_info *ext2_i (struct inode *inode)
> > 	{
> > 		return &(inode->u.ext2_inode_info);
> > 	}
> >
> > There is some grist here for the mills of language lawyers here.  Note the
> > compilation warning:
> >
> >    ialloc.c:336: warning: passing arg 1 of `ext2_i' discards qualifiers from
> >    pointer target type
>
> Why not just declare ext2_i like the following?  It _should_ work:
>
> static inline struct ext2_inode_info *ext2_i(const struct inode *inode)
> {
> 	return &(inode->u.ext2_inode_info);
> }

This will get rid of the warning but it doesn't solve the underlying
problem of discarding the potentially useful const information. In C++,
you'd define a pair of functions to deal with this, one with and one
without const.

> Minor nit: this is already done for the ext3 code, but it looks like:
>
> #define EXT3_I	(&((inode)->u.ext3_i))
>
> We already have the EXT3_SB, so I thought I would be consistent with it:
>
> #define EXT3_SB	(&((sb)->u.ext3_sb))
>
> Do people like the inline version better?  Either way, I would like to make
> the ext2 and ext3 codes more similar, rather than less.

The ext3 macros are rather revolting, simply because they assume the
variable name. A parameterized macro might be the best compromise:

#define EXT2_I(i) (&(i->u.ext2_inode_info))

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

