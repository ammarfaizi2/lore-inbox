Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbWHKJ17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbWHKJ17 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 05:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWHKJ17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 05:27:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36762 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751060AbWHKJ16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 05:27:58 -0400
Subject: Re: [PATCH 5/6] clean up OCFS2 nlink handling
From: Steven Whitehouse <swhiteho@redhat.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <1155236818.19249.265.camel@localhost.localdomain>
References: <20060809165729.FE36B262@localhost.localdomain>
	 <20060809165733.704AD0F5@localhost.localdomain>
	 <20060809171253.GE7324@infradead.org>
	 <1155150926.19249.175.camel@localhost.localdomain>
	 <1155197252.3384.418.camel@quoit.chygwyn.com>
	 <1155236818.19249.265.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 11 Aug 2006 10:38:31 +0100
Message-Id: <1155289111.3384.441.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2006-08-10 at 12:06 -0700, Dave Hansen wrote:
> On Thu, 2006-08-10 at 09:07 +0100, Steven Whitehouse wrote:
> > On Wed, 2006-08-09 at 12:15 -0700, Dave Hansen wrote:
> > > On Wed, 2006-08-09 at 18:12 +0100, Christoph Hellwig wrote:
> > [snip]
> > > > did you look whether gfs2 in -mm needs something similar?
> > > 
> > > It doesn't appear to.  It doesn't manipulate i_nlink in the same, direct
> > > manner.
> > 
> > I think it will need something similar. I suspect the required changes
> > will all be confined to routines in inode.c. If the link count is
> > changed by (a) remote node(s), then gfs2_inode_attr_in() might change
> > the link count. Also gfs2_change_nlink() is the other place to look. I
> > think everywhere else is ok,
> 
> Well, I think this is all that it needs.  I'm trying to decide if we
> need a set_nlink() function for users like this, but I'm not sure there
> are enough of them.
> 
I suspect that something is required for gfs2_inode_attr_in() as well.
Here is the scenario... suppose there are two nodes A and B. On node A a
file is opened, on node B the same file is then unlinked such that its
link count hits zero. If node A then does something to the file (read or
write, it doesn't matter) then it will reread the attributes off disk
via gfs2_inode_attr_in() and discover that the link count is then zero.

We don't play any games in that once the link count has hit zero, thats
it, it will never increment above zero again. The node which actually
deals with the deallocation and clean up is the one that performs the
final close (iput). This is dealt with using the iopen lock to ensure
that we are certain of which node is the last to close the file. The
iopen lock is held in a shared state by all nodes having the file open.
On gfs2_delete_inode we attempt to upgrade the iopen lock to exclusive,
if this succeeds we then presume that no other node has the file open
and proceed with deallocation, as per a normal local filesystem.

So if I've understood what you are doing correctly, the adjustment
you've made below needs to be copied into gfs2_inode_attr_in() as well,

Steve.

> ---
> 
>  lxc-dave/fs/gfs2/inode.c |    3 +++
>  2 files changed, 3 insertions(+)
> 
> diff -puN fs/gfs2/inode.c~gfs fs/gfs2/inode.c
> --- lxc/fs/gfs2/inode.c~gfs	2006-08-10 09:52:33.000000000 -0700
> +++ lxc-dave/fs/gfs2/inode.c	2006-08-10 12:05:06.000000000 -0700
> @@ -332,6 +332,9 @@ int gfs2_change_nlink(struct gfs2_inode 
>  	ip->i_di.di_ctime = get_seconds();
>  	ip->i_inode.i_nlink = nlink;
>  
> +	if (!nlink)
> +		ip->i_inode.i_state |= I_AWAITING_FINAL_IPUT;
> +
>  	gfs2_trans_add_bh(ip->i_gl, dibh, 1);
>  	gfs2_dinode_out(&ip->i_di, dibh->b_data);
>  	brelse(dibh);
> 
> 
> -- Dave
> 

