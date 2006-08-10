Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWHJTHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWHJTHR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWHJTHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:07:17 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:57220 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932204AbWHJTHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:07:15 -0400
Subject: Re: [PATCH 5/6] clean up OCFS2 nlink handling
From: Dave Hansen <haveblue@us.ibm.com>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <1155197252.3384.418.camel@quoit.chygwyn.com>
References: <20060809165729.FE36B262@localhost.localdomain>
	 <20060809165733.704AD0F5@localhost.localdomain>
	 <20060809171253.GE7324@infradead.org>
	 <1155150926.19249.175.camel@localhost.localdomain>
	 <1155197252.3384.418.camel@quoit.chygwyn.com>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 12:06:58 -0700
Message-Id: <1155236818.19249.265.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-10 at 09:07 +0100, Steven Whitehouse wrote:
> On Wed, 2006-08-09 at 12:15 -0700, Dave Hansen wrote:
> > On Wed, 2006-08-09 at 18:12 +0100, Christoph Hellwig wrote:
> [snip]
> > > did you look whether gfs2 in -mm needs something similar?
> > 
> > It doesn't appear to.  It doesn't manipulate i_nlink in the same, direct
> > manner.
> 
> I think it will need something similar. I suspect the required changes
> will all be confined to routines in inode.c. If the link count is
> changed by (a) remote node(s), then gfs2_inode_attr_in() might change
> the link count. Also gfs2_change_nlink() is the other place to look. I
> think everywhere else is ok,

Well, I think this is all that it needs.  I'm trying to decide if we
need a set_nlink() function for users like this, but I'm not sure there
are enough of them.

---

 lxc-dave/fs/gfs2/inode.c |    3 +++
 2 files changed, 3 insertions(+)

diff -puN fs/gfs2/inode.c~gfs fs/gfs2/inode.c
--- lxc/fs/gfs2/inode.c~gfs	2006-08-10 09:52:33.000000000 -0700
+++ lxc-dave/fs/gfs2/inode.c	2006-08-10 12:05:06.000000000 -0700
@@ -332,6 +332,9 @@ int gfs2_change_nlink(struct gfs2_inode 
 	ip->i_di.di_ctime = get_seconds();
 	ip->i_inode.i_nlink = nlink;
 
+	if (!nlink)
+		ip->i_inode.i_state |= I_AWAITING_FINAL_IPUT;
+
 	gfs2_trans_add_bh(ip->i_gl, dibh, 1);
 	gfs2_dinode_out(&ip->i_di, dibh->b_data);
 	brelse(dibh);


-- Dave

