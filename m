Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937464AbWLEOdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937464AbWLEOdi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 09:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937467AbWLEOdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 09:33:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32881 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937464AbWLEOdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 09:33:37 -0500
Subject: Re: [GFS2] Don't flush everything on fdatasync [70/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20061201110927.ec6ee073.akpm@osdl.org>
References: <1164889448.3752.449.camel@quoit.chygwyn.com>
	 <20061130230158.174e995c.akpm@osdl.org>
	 <1164970738.3752.508.camel@quoit.chygwyn.com>
	 <20061201110927.ec6ee073.akpm@osdl.org>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Tue, 05 Dec 2006 14:36:16 +0000
Message-Id: <1165329376.3752.669.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-12-01 at 11:09 -0800, Andrew Morton wrote:
> On Fri, 01 Dec 2006 10:58:58 +0000
> Steven Whitehouse <swhiteho@redhat.com> wrote:
> 
> > On Thu, 2006-11-30 at 23:01 -0800, Andrew Morton wrote:
> > > On Thu, 30 Nov 2006 12:24:08 +0000
> > > Steven Whitehouse <swhiteho@redhat.com> wrote:
> > > 
> > > >  static int gfs2_fsync(struct file *file, struct dentry *dentry, int datasync)
> > > >  {
> > > > -	struct gfs2_inode *ip = GFS2_I(dentry->d_inode);
> > > > +	struct inode *inode = dentry->d_inode;
> > > > +	int sync_state = inode->i_state & (I_DIRTY_SYNC|I_DIRTY_DATASYNC);
> > > > +	int ret = 0;
> > > > +	struct writeback_control wbc = {
> > > > +		.sync_mode = WB_SYNC_ALL,
> > > > +		.nr_to_write = 0,
> > > > +	};
> > > > +
> > > > +	if (gfs2_is_jdata(GFS2_I(inode))) {
> > > > +		gfs2_log_flush(GFS2_SB(inode), GFS2_I(inode)->i_gl);
> > > > +		return 0;
> > > > +	}
> > > >  
> > > > -	gfs2_log_flush(ip->i_gl->gl_sbd, ip->i_gl);
> > > > +	if (sync_state != 0) {
> > > > +		if (!datasync)
> > > > +			ret = sync_inode(inode, &wbc);
> > > 
> > > filemap_fdatawrite() would be simpler.
> > 
> > I was taking my cue here from ext3 which does something similar. The
> > filemap_fdatawrite() is done by the VFS before this is called with a
> > filemap_fdatawait() afterwards. This was intended to flush the metadata
> > via (eventually) ->write_inode() although I guess I should be calling
> > write_inode_now() instead?
> 
> oh I see, you're jsut trying to write the inode itself, not the pages.
> 
> write_inode_now() will write the pages, which you seem to not want to do.
> Whatever.  The APIs here are a bit awkward.

Well its not so much that we want to avoid it, but since the VFS has
already done that, it should be pretty much a no-op aside from the
waiting which will happen within the call (so that presumably the VFS's
wait after the call will be more or less a no-op).

I notice that fs/sync.c:file_fsync() uses write_inode_now(), so maybe it
is a better choice as it at least means that I don't have to fill in a
struct write_back control for a mapping that I don't really want to
write again,

Steve.


