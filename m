Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286660AbRL1Bwc>; Thu, 27 Dec 2001 20:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286655AbRL1BwW>; Thu, 27 Dec 2001 20:52:22 -0500
Received: from dsl-213-023-039-026.arcor-ip.net ([213.23.39.26]:9479 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S286649AbRL1BwM>;
	Thu, 27 Dec 2001 20:52:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@turbolabs.com>
Subject: Re: [Ext2-devel] [RFC] [PATCH] Clean up fs.h union for ext2
Date: Fri, 28 Dec 2001 02:55:09 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <E16JR71-0000cU-00@starship.berlin> <20011227111415.D12868@lynx.no>
In-Reply-To: <20011227111415.D12868@lynx.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16JmEq-00007I-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas

On December 27, 2001 07:14 pm, Andreas Dilger wrote:
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

If that's all we do, then we get 'warning: return discards qualifiers from
pointer target type'.  Adding an explicit cast gets rid of that:

static inline struct ext2_inode_info *ext2_i (const struct inode *inode)
{
	return (struct ext2_inode_info *) &(inode->u.ext2_inode_info);
}

However, then we're lying to the compiler.  I wonder how safe that is.

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

An upcoming version will use an explicit cast:

	return (struct ext2_inode_info *) (inode + 1);

In other words, it doesn't rely on the union, which we're trying to get rid of.
In this case, an inline function provides type saftey and a macro wouldn't.  I
also prefer to pass the inode/sb explicitly, rather than having a macro pick it
up from context.

In the superblock patch, the inline will be 'ext2_s'.  Al seems comfortable with
this terminology, so...

--
Daniel
