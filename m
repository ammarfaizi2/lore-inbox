Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965098AbWFTJgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965098AbWFTJgc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 05:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965241AbWFTJgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 05:36:32 -0400
Received: from souterrain.chygwyn.com ([194.39.143.233]:11477 "EHLO
	souterrain.chygwyn.com") by vger.kernel.org with ESMTP
	id S965098AbWFTJgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 05:36:31 -0400
From: Steven Whitehouse <steve@chygwyn.com>
To: Theodore Tso <tytso@thunk.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060619153108.418349000@candygram.thunk.org>
References: <20060619152003.830437000@candygram.thunk.org>
	 <20060619153108.418349000@candygram.thunk.org>
Organization: ChyGwyn Limited
Date: Tue, 20 Jun 2006 10:43:16 +0100
Message-Id: <1150796596.3856.1333.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Subject: Re: [RFC] [PATCH 1/8] inode_diet: Replace inode.u.generic_ip with
	inode.i_private
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.0 (built Sat, 04 Sep 2004 19:17:51 +0100)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2006-06-19 at 11:20 -0400, Theodore Tso wrote:
> plain text document attachment (inode-slim-1)
> The filesystem or device-specific pointer in the inode is inside a
> union, which is pretty pointless given that all 30+ users of this
> field have been using the void pointer.  Get rid of the union and
> rename it to i_private, with a comment to explain who is allowed to
> use the void pointer.  This is just a cleanup, but it allows us to
> reuse the union 'u' for something something where the union will
> actually be used.
> 
> Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
> 
> Index: linux-2.6.17/include/linux/fs.h
> ===================================================================
> --- linux-2.6.17.orig/include/linux/fs.h	2006-06-18 18:58:51.000000000 -0400
> +++ linux-2.6.17/include/linux/fs.h	2006-06-18 18:58:55.000000000 -0400
> @@ -534,9 +534,7 @@
>  
>  	atomic_t		i_writecount;
>  	void			*i_security;
> -	union {
> -		void		*generic_ip;
> -	} u;
> +	void			*i_private; /* fs or device private pointer */
>  #ifdef __NEED_I_SIZE_ORDERED
>  	seqcount_t		i_size_seqcount;
>  #endif

As a further suggestion, I wonder do we really need i_private at all?
Since we have sb->s_op->alloc_inode and inode->i_sb->s_op->destroy_inode
if all filesystems did something along the following lines:

struct myfs_inode {
	struct inode i_inode;
	...
};

#define MYFS_I(inode) container_of((inode), struct myfs_inode, i_inode)

then it would seem that i_private is redundant. If there is a file
system which does genuinely need a pointer here (if indeed such a
filesystem does exist, I haven't actually checked that) then a pointer
can just be added as the one single other member of (in my example)
struct myfs_inode.

Steve.


