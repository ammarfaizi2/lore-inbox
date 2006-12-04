Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935057AbWLDJqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935057AbWLDJqT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 04:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934996AbWLDJqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 04:46:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59814 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S935057AbWLDJqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 04:46:17 -0500
Subject: Re: [GFS2] Fix journal flush problem [56/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: Russell Cattelan <cattelan@thebarn.com>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1164999525.1194.72.camel@xenon.msp.redhat.com>
References: <1164889312.3752.417.camel@quoit.chygwyn.com>
	 <1164999525.1194.72.camel@xenon.msp.redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 04 Dec 2006 09:48:24 +0000
Message-Id: <1165225704.3752.599.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-12-01 at 12:58 -0600, Russell Cattelan wrote:
> On Thu, 2006-11-30 at 12:21 +0000, Steven Whitehouse wrote:
> > >From b004157ab5b374a498a5874cda68c389219d23e7 Mon Sep 17 00:00:00 2001
> > From: Steven Whitehouse <swhiteho@redhat.com>
> > Date: Thu, 23 Nov 2006 10:51:34 -0500
> > Subject: [PATCH] [GFS2] Fix journal flush problem
> > 
> > This fixes a bug which resulted in poor performance due to flushing
> > the journal too often. The code path in question was via the inode_go_sync()
> > function in glops.c. The solution is not to flush the journal immediately
> > when inodes are ejected from memory, but batch up the work for glockd to
> > deal with later on. This means that glocks may now live on beyond the end of
> > the lifetime of their inodes (but not very much longer in the normal case).
> 
> This seems like multiple changes in one patch.
> The inode flush handling is changing quite significantly.
> The log flushing is also being changed. 
> 
They are rather closely linked, so it seems to make sense to change both
at once. See further comments below.

> > 
> > Also fixed in this patch is a bug (which was hidden by the bug mentioned above) in
> > calculation of the number of free journal blocks.
> > 
> > The gfs2_logd process has been altered to be more responsive to the journal
> > filling up. We now wake it up when the number of uncommitted journal blocks
> > has reached the threshold level rather than trying to flush directly at the
> > end of each transaction. This again means doing fewer, but larger, log
> > flushes in general.
> > 
> > Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
> > ---
> >  fs/gfs2/daemon.c    |    7 +++-
> >  fs/gfs2/glock.c     |   17 +--------
> >  fs/gfs2/glock.h     |    1 -
> >  fs/gfs2/glops.c     |   93 +++++++++++++--------------------------------------
> >  fs/gfs2/log.c       |   17 +++++----
> >  fs/gfs2/meta_io.c   |    3 ++
> >  fs/gfs2/ops_super.c |    7 ++--
> >  7 files changed, 46 insertions(+), 99 deletions(-)
> > 
> > diff --git a/fs/gfs2/daemon.c b/fs/gfs2/daemon.c
> > index cab1f68..683cb5b 100644
> > --- a/fs/gfs2/daemon.c
> > +++ b/fs/gfs2/daemon.c
> > @@ -112,6 +112,7 @@ int gfs2_logd(void *data)
> >  	struct gfs2_sbd *sdp = data;
> >  	struct gfs2_holder ji_gh;
> >  	unsigned long t;
> > +	int need_flush;
> >  
> >  	while (!kthread_should_stop()) {
> >  		/* Advance the log tail */
> > @@ -120,8 +121,10 @@ int gfs2_logd(void *data)
> >  		    gfs2_tune_get(sdp, gt_log_flush_secs) * HZ;
> >  
> >  		gfs2_ail1_empty(sdp, DIO_ALL);
> > -
> > -		if (time_after_eq(jiffies, t)) {
> > +		gfs2_log_lock(sdp);
> > +		need_flush = sdp->sd_log_num_buf > gfs2_tune_get(sdp, gt_incore_log_blocks);
> > +		gfs2_log_unlock(sdp);
> Do we really need to lock the log just to get the log_num_buf?
> Seems like a serialization we don't need?
> 
Yes we do need a lock, and bearing in mind that its only a spinlock I
don't see that its going to be that much of a problem. Compared with the
length of time it takes to flush the journal, it must surely be a
completely minimal overhead.

> So why does this loop have a sleep timeout and a flush interval?
> Shouldn't the schedual timeout be the same as the flush interval?
> 
No it shouldn't. There are two things happening in this loop. The first
is running gfs2_ail1_empty() which happens on a much more frequent basis
than the log flushing. The log flushing runs every few seconds, or when
its triggered by the journal getting close to being full:

> > +		if (need_flush || time_after_eq(jiffies, t)) {
> >  			gfs2_log_flush(sdp, NULL);
> >  			sdp->sd_log_flush_time = jiffies;
> >  		}

Steve.

> > diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> > index b8ba4d5..3c2ff81 100644
> > --- a/fs/gfs2/glock.c
> > +++ b/fs/gfs2/glock.c
> > @@ -785,21 +785,6 @@ out:
> >  		gfs2_holder_put(new_gh);
> >  }
> >  
> > -void gfs2_glock_inode_squish(struct inode *inode)
> > -{
> > -	struct gfs2_holder gh;
> > -	struct gfs2_glock *gl = GFS2_I(inode)->i_gl;
> > -	gfs2_holder_init(gl, LM_ST_UNLOCKED, 0, &gh);
> > -	set_bit(HIF_DEMOTE, &gh.gh_iflags);
> > -	spin_lock(&gl->gl_spin);
> > -	gfs2_assert(inode->i_sb->s_fs_info, list_empty(&gl->gl_holders));
> > -	list_add_tail(&gh.gh_list, &gl->gl_waiters2);
> > -	run_queue(gl);
> > -	spin_unlock(&gl->gl_spin);
> > -	wait_for_completion(&gh.gh_wait);
> > -	gfs2_holder_uninit(&gh);
> > -}
> > -
> >  /**
> >   * state_change - record that the glock is now in a different state
> >   * @gl: the glock
> > @@ -1920,7 +1905,7 @@ out:
> >  
> >  static void scan_glock(struct gfs2_glock *gl)
> >  {
> > -	if (gl->gl_ops == &gfs2_inode_glops)
> > +	if (gl->gl_ops == &gfs2_inode_glops && gl->gl_object)
> >  		return;
> >  
> >  	if (gfs2_glmutex_trylock(gl)) {
> > diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
> > index a331bf8..fb39108 100644
> > --- a/fs/gfs2/glock.h
> > +++ b/fs/gfs2/glock.h
> > @@ -106,7 +106,6 @@ void gfs2_glock_dq_uninit_m(unsigned int
> >  void gfs2_glock_prefetch_num(struct gfs2_sbd *sdp, u64 number,
> >  			     const struct gfs2_glock_operations *glops,
> >  			     unsigned int state, int flags);
> > -void gfs2_glock_inode_squish(struct inode *inode);
> >  
> >  /**
> >   * gfs2_glock_nq_init - intialize a holder and enqueue it on a glock
> > diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
> > index 60561ca..b068d10 100644
> > --- a/fs/gfs2/glops.c
> > +++ b/fs/gfs2/glops.c
> > @@ -107,70 +107,6 @@ static void gfs2_pte_inval(struct gfs2_g
> >  }
> >  
> >  /**
> > - * gfs2_page_inval - Invalidate all pages associated with a glock
> > - * @gl: the glock
> > - *
> > - */
> > -
> > -static void gfs2_page_inval(struct gfs2_glock *gl)
> > -{
> > -	struct gfs2_inode *ip;
> > -	struct inode *inode;
> > -
> > -	ip = gl->gl_object;
> > -	inode = &ip->i_inode;
> > -	if (!ip || !S_ISREG(inode->i_mode))
> > -		return;
> > -
> > -	truncate_inode_pages(inode->i_mapping, 0);
> > -	gfs2_assert_withdraw(GFS2_SB(&ip->i_inode), !inode->i_mapping->nrpages);
> > -	clear_bit(GIF_PAGED, &ip->i_flags);
> > -}
> > -
> > -/**
> > - * gfs2_page_wait - Wait for writeback of data
> > - * @gl: the glock
> > - *
> > - * Syncs data (not metadata) for a regular file.
> > - * No-op for all other types.
> > - */
> > -
> > -static void gfs2_page_wait(struct gfs2_glock *gl)
> > -{
> > -	struct gfs2_inode *ip = gl->gl_object;
> > -	struct inode *inode = &ip->i_inode;
> > -	struct address_space *mapping = inode->i_mapping;
> > -	int error;
> > -
> > -	if (!S_ISREG(inode->i_mode))
> > -		return;
> > -
> > -	error = filemap_fdatawait(mapping);
> > -
> > -	/* Put back any errors cleared by filemap_fdatawait()
> > -	   so they can be caught by someone who can pass them
> > -	   up to user space. */
> > -
> > -	if (error == -ENOSPC)
> > -		set_bit(AS_ENOSPC, &mapping->flags);
> > -	else if (error)
> > -		set_bit(AS_EIO, &mapping->flags);
> > -
> > -}
> > -
> > -static void gfs2_page_writeback(struct gfs2_glock *gl)
> > -{
> > -	struct gfs2_inode *ip = gl->gl_object;
> > -	struct inode *inode = &ip->i_inode;
> > -	struct address_space *mapping = inode->i_mapping;
> > -
> > -	if (!S_ISREG(inode->i_mode))
> > -		return;
> > -
> > -	filemap_fdatawrite(mapping);
> > -}
> > -
> > -/**
> >   * meta_go_sync - sync out the metadata for this glock
> >   * @gl: the glock
> >   *
> > @@ -264,11 +200,24 @@ static void inode_go_drop_th(struct gfs2
> >  
> >  static void inode_go_sync(struct gfs2_glock *gl)
> >  {
> > +	struct gfs2_inode *ip = gl->gl_object;
> > +
> > +	if (ip && !S_ISREG(ip->i_inode.i_mode))
> > +		ip = NULL;
> > +
> >  	if (test_bit(GLF_DIRTY, &gl->gl_flags)) {
> > -		gfs2_page_writeback(gl);
> >  		gfs2_log_flush(gl->gl_sbd, gl);
> > +		if (ip)
> > +			filemap_fdatawrite(ip->i_inode.i_mapping);
> >  		gfs2_meta_sync(gl);
> > -		gfs2_page_wait(gl);
> > +		if (ip) {
> > +			struct address_space *mapping = ip->i_inode.i_mapping;
> > +			int error = filemap_fdatawait(mapping);
> > +			if (error == -ENOSPC)
> > +				set_bit(AS_ENOSPC, &mapping->flags);
> > +			else if (error)
> > +				set_bit(AS_EIO, &mapping->flags);
> > +		}
> >  		clear_bit(GLF_DIRTY, &gl->gl_flags);
> >  		gfs2_ail_empty_gl(gl);
> >  	}
> > @@ -283,14 +232,20 @@ static void inode_go_sync(struct gfs2_gl
> >  
> >  static void inode_go_inval(struct gfs2_glock *gl, int flags)
> >  {
> > +	struct gfs2_inode *ip = gl->gl_object;
> >  	int meta = (flags & DIO_METADATA);
> >  
> >  	if (meta) {
> > -		struct gfs2_inode *ip = gl->gl_object;
> >  		gfs2_meta_inval(gl);
> > -		set_bit(GIF_INVALID, &ip->i_flags);
> > +		if (ip)
> > +			set_bit(GIF_INVALID, &ip->i_flags);
> > +	}
> > +
> > +	if (ip && S_ISREG(ip->i_inode.i_mode)) {
> > +		truncate_inode_pages(ip->i_inode.i_mapping, 0);
> > +		gfs2_assert_withdraw(GFS2_SB(&ip->i_inode), !ip->i_inode.i_mapping->nrpages);
> > +		clear_bit(GIF_PAGED, &ip->i_flags);
> >  	}
> > -	gfs2_page_inval(gl);
> >  }
> >  
> >  /**
> > diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
> > index 0cace3d..6456fc3 100644
> > --- a/fs/gfs2/log.c
> > +++ b/fs/gfs2/log.c
> > @@ -261,6 +261,12 @@ static void ail2_empty(struct gfs2_sbd *
> >   * @sdp: The GFS2 superblock
> >   * @blks: The number of blocks to reserve
> >   *
> > + * Note that we never give out the last 6 blocks of the journal. Thats
> > + * due to the fact that there is are a small number of header blocks
> > + * associated with each log flush. The exact number can't be known until
> > + * flush time, so we ensure that we have just enough free blocks at all
> > + * times to avoid running out during a log flush.
> > + *
> >   * Returns: errno
> >   */
> >  
> > @@ -274,7 +280,7 @@ int gfs2_log_reserve(struct gfs2_sbd *sd
> >  
> >  	mutex_lock(&sdp->sd_log_reserve_mutex);
> >  	gfs2_log_lock(sdp);
> > -	while(sdp->sd_log_blks_free <= blks) {
> > +	while(sdp->sd_log_blks_free <= (blks + 6)) {
> >  		gfs2_log_unlock(sdp);
> >  		gfs2_ail1_empty(sdp, 0);
> >  		gfs2_log_flush(sdp, NULL);
> > @@ -643,12 +649,9 @@ void gfs2_log_commit(struct gfs2_sbd *sd
> >  	up_read(&sdp->sd_log_flush_lock);
> >  
> >  	gfs2_log_lock(sdp);
> > -	if (sdp->sd_log_num_buf > gfs2_tune_get(sdp, gt_incore_log_blocks)) {
> > -		gfs2_log_unlock(sdp);
> > -		gfs2_log_flush(sdp, NULL);
> > -	} else {
> > -		gfs2_log_unlock(sdp);
> > -	}
> > +	if (sdp->sd_log_num_buf > gfs2_tune_get(sdp, gt_incore_log_blocks))
> > +		wake_up_process(sdp->sd_logd_process);
> > +	gfs2_log_unlock(sdp);
> >  }
> >  
> >  /**
> > diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
> > index 3912d6a..939a09f 100644
> > --- a/fs/gfs2/meta_io.c
> > +++ b/fs/gfs2/meta_io.c
> > @@ -472,6 +472,9 @@ int gfs2_meta_indirect_buffer(struct gfs
> >  	struct buffer_head *bh = NULL, **bh_slot = ip->i_cache + height;
> >  	int in_cache = 0;
> >  
> > +	BUG_ON(!gl);
> > +	BUG_ON(!sdp);
> > +
> >  	spin_lock(&ip->i_spin);
> >  	if (*bh_slot && (*bh_slot)->b_blocknr == num) {
> >  		bh = *bh_slot;
> > diff --git a/fs/gfs2/ops_super.c b/fs/gfs2/ops_super.c
> > index 8635175..7685b46 100644
> > --- a/fs/gfs2/ops_super.c
> > +++ b/fs/gfs2/ops_super.c
> > @@ -157,7 +157,8 @@ static void gfs2_write_super(struct supe
> >  static int gfs2_sync_fs(struct super_block *sb, int wait)
> >  {
> >  	sb->s_dirt = 0;
> > -	gfs2_log_flush(sb->s_fs_info, NULL);
> > +	if (wait)
> > +		gfs2_log_flush(sb->s_fs_info, NULL);
> >  	return 0;
> >  }
> >  
> > @@ -293,8 +294,6 @@ static void gfs2_clear_inode(struct inod
> >  	 */
> >  	if (inode->i_private) {
> >  		struct gfs2_inode *ip = GFS2_I(inode);
> > -		gfs2_glock_inode_squish(inode);
> > -		gfs2_assert(inode->i_sb->s_fs_info, ip->i_gl->gl_state == LM_ST_UNLOCKED);
> >  		ip->i_gl->gl_object = NULL;
> >  		gfs2_glock_schedule_for_reclaim(ip->i_gl);
> >  		gfs2_glock_put(ip->i_gl);
> > @@ -395,7 +394,7 @@ static void gfs2_delete_inode(struct ino
> >  	if (!inode->i_private)
> >  		goto out;
> >  
> > -	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, LM_FLAG_TRY_1CB | GL_NOCACHE, &gh);
> > +	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, LM_FLAG_TRY_1CB, &gh);
> >  	if (unlikely(error)) {
> >  		gfs2_glock_dq_uninit(&ip->i_iopen_gh);
> >  		goto out;

