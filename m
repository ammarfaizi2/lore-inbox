Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031873AbWLGJIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031873AbWLGJIO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 04:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031875AbWLGJIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 04:08:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48047 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031873AbWLGJIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 04:08:12 -0500
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
Date: Thu, 07 Dec 2006 09:11:26 +0000
Message-Id: <1165482686.3752.816.camel@quoit.chygwyn.com>
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

I've added a comment to explain whats going on here, and also the
following patch. I know it could be better, but its still an improvement
on what was there before,

Steve.

--------------------------------------------------------------------------------------------

>From 34126f9f41901ca9d7d0031c2b11fc0d6c07b72d Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Thu, 7 Dec 2006 09:13:14 -0500
Subject: [PATCH] [GFS2] Change gfs2_fsync() to use write_inode_now()

This is a bit better than the previous version of gfs2_fsync()
although it would be better still if we were able to call a
function which only wrote the inode & metadata. Its no big deal
though that this will potentially write the data as well since
the VFS has already done that before calling gfs2_fsync(). I've
also added a comment to explain whats going on here.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>
---
 fs/gfs2/ops_file.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/ops_file.c b/fs/gfs2/ops_file.c
index 7bd971b..b3f1e03 100644
--- a/fs/gfs2/ops_file.c
+++ b/fs/gfs2/ops_file.c
@@ -510,6 +510,11 @@ static int gfs2_close(struct inode *inod
  * is set. For stuffed inodes we must flush the log in order to
  * ensure that all data is on disk.
  *
+ * The call to write_inode_now() is there to write back metadata and
+ * the inode itself. It does also try and write the data, but thats
+ * (hopefully) a no-op due to the VFS having already called filemap_fdatawrite()
+ * for us.
+ *
  * Returns: errno
  */
 
@@ -518,10 +523,6 @@ static int gfs2_fsync(struct file *file,
 	struct inode *inode = dentry->d_inode;
 	int sync_state = inode->i_state & (I_DIRTY_SYNC|I_DIRTY_DATASYNC);
 	int ret = 0;
-	struct writeback_control wbc = {
-		.sync_mode = WB_SYNC_ALL,
-		.nr_to_write = 0,
-	};
 
 	if (gfs2_is_jdata(GFS2_I(inode))) {
 		gfs2_log_flush(GFS2_SB(inode), GFS2_I(inode)->i_gl);
@@ -530,7 +531,7 @@ static int gfs2_fsync(struct file *file,
 
 	if (sync_state != 0) {
 		if (!datasync)
-			ret = sync_inode(inode, &wbc);
+			ret = write_inode_now(inode, 0);
 
 		if (gfs2_is_stuffed(GFS2_I(inode)))
 			gfs2_log_flush(GFS2_SB(inode), GFS2_I(inode)->i_gl);
-- 
1.4.1



