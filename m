Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936321AbWLAK55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936321AbWLAK55 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 05:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936364AbWLAK55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 05:57:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49287 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936321AbWLAK54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 05:57:56 -0500
Subject: Re: [GFS2] Don't flush everything on fdatasync [70/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20061130230158.174e995c.akpm@osdl.org>
References: <1164889448.3752.449.camel@quoit.chygwyn.com>
	 <20061130230158.174e995c.akpm@osdl.org>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 01 Dec 2006 10:58:58 +0000
Message-Id: <1164970738.3752.508.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2006-11-30 at 23:01 -0800, Andrew Morton wrote:
> On Thu, 30 Nov 2006 12:24:08 +0000
> Steven Whitehouse <swhiteho@redhat.com> wrote:
> 
> >  static int gfs2_fsync(struct file *file, struct dentry *dentry, int datasync)
> >  {
> > -	struct gfs2_inode *ip = GFS2_I(dentry->d_inode);
> > +	struct inode *inode = dentry->d_inode;
> > +	int sync_state = inode->i_state & (I_DIRTY_SYNC|I_DIRTY_DATASYNC);
> > +	int ret = 0;
> > +	struct writeback_control wbc = {
> > +		.sync_mode = WB_SYNC_ALL,
> > +		.nr_to_write = 0,
> > +	};
> > +
> > +	if (gfs2_is_jdata(GFS2_I(inode))) {
> > +		gfs2_log_flush(GFS2_SB(inode), GFS2_I(inode)->i_gl);
> > +		return 0;
> > +	}
> >  
> > -	gfs2_log_flush(ip->i_gl->gl_sbd, ip->i_gl);
> > +	if (sync_state != 0) {
> > +		if (!datasync)
> > +			ret = sync_inode(inode, &wbc);
> 
> filemap_fdatawrite() would be simpler.

I was taking my cue here from ext3 which does something similar. The
filemap_fdatawrite() is done by the VFS before this is called with a
filemap_fdatawait() afterwards. This was intended to flush the metadata
via (eventually) ->write_inode() although I guess I should be calling
write_inode_now() instead?

Steve.


