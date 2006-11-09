Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424166AbWKIRdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424166AbWKIRdV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 12:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424167AbWKIRdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 12:33:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45190 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1424166AbWKIRdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 12:33:18 -0500
Date: Thu, 9 Nov 2006 17:33:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 1/3] new_inode_autonum: add per-sb lastino counter and add new_inode_autonum function that guarantees i_ino uniqueness
Message-ID: <20061109173317.GA11406@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <1163085879.21469.45.camel@dantu.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163085879.21469.45.camel@dantu.rdu.redhat.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2006 at 10:24:39AM -0500, Jeff Layton wrote:
> +/**
> + *	new_inode_autonum 	- obtain an inode with a unique i_ino value
> + *	@sb: superblock
> + *
> + *	Allocates a new inode for given superblock. Ensures that i_ino is
> + *	unique on the filesystem.
> + */
> +struct inode *new_inode_autonum(struct super_block *sb)
> +{
> +	struct inode *inode;
> +
> +	inode = __new_inode(sb);
> +	inode->i_ino = iunique(sb, 0);
> +	return inode;

Why do we need this wrapper?  The callers could aswell just do the
iunique call themselves.  It's already exported aswell.

> +/**
> + *	new_inode 	- obtain an inode -- i_ino not guaranteed unique
> + *	@sb: superblock
> + *
> + *	Allocates a new inode for given superblock. i_ino is not guaranteed to
> + *	be unique. Should only be used when i_ino is going to be clobbered.
> + */
> +struct inode *new_inode(struct super_block *sb)
> +{
> +	struct inode *inode;
> +
> +	inode = __new_inode(sb);
> +	inode->i_ino = 0; /* 0 to try to catch callers that don't reset it */
> +	return inode;

And this wrapper is rather pointless as inode_init_once already zeroes the
whole inode.  Just keep the name new_inode for the basic don't assigned
inode number thing.

> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -961,6 +961,14 @@ #endif
>  	/* Granularity of c/m/atime in ns.
>  	   Cannot be worse than a second */
>  	u32		   s_time_gran;
> +
> +	/* per-sb inode counter for new_inode. Make it a 32-bit counter when
> +	   we have the possibility of dealing with 32-bit apps */
> +#ifdef CONFIG_COMPAT
> +	unsigned int		s_nextino;
> +#else
> +	unsigned long		s_nextino;
> +#endif

This is more thanb ugly.  CONFIG_COMPAT should not modify core kernel
behaviour.  It's also short sightened as we once again plan to support
64bit inode numbers on 32bit hosts.

