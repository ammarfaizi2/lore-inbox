Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934422AbWLDJjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934422AbWLDJjT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 04:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933351AbWLDJjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 04:39:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10914 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S934422AbWLDJjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 04:39:18 -0500
Subject: Re: [GFS2] Reduce number of arguments to meta_io.c:getbuf() [58/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: Russell Cattelan <cattelan@thebarn.com>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1164999019.1194.66.camel@xenon.msp.redhat.com>
References: <1164889331.3752.421.camel@quoit.chygwyn.com>
	 <1164999019.1194.66.camel@xenon.msp.redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 04 Dec 2006 09:41:27 +0000
Message-Id: <1165225287.3752.592.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-12-01 at 12:50 -0600, Russell Cattelan wrote:
> On Thu, 2006-11-30 at 12:22 +0000, Steven Whitehouse wrote:
> > >From cb4c03131836a55bf95e1c165409244ac6b4f39f Mon Sep 17 00:00:00 2001
> > From: Steven Whitehouse <swhiteho@redhat.com>
> > Date: Thu, 23 Nov 2006 11:16:32 -0500
> > Subject: [PATCH] [GFS2] Reduce number of arguments to meta_io.c:getbuf()
> > 
> > Since the superblock and the address_space are determined by the
> > glock, we might as well just pass that as the argument since all
> > the callers already have that available.
> 
> This taking a poorly named function with a questionable api 
> and making is worse.
> If getbuf does not have a need for a glock structure then
> there is no point in passing it in.
> Simply reducing the number of arguments in this case serves
> no purpose.
> 
> The existing parameters seem correct but the function 
> should probably be named something like gfs2_get_bh.
> 

So send me a patch or propose something better if you really don't like
it that much... The reason for passing the glock is that the function is
getting metadata blocks, and in gfs2 those are directly associated with
a glock. It makes more sense to pass that directly to the function than
to pass the superblock and address space as separate items,

Steve.

> 
> > 
> > Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
> > ---
> >  fs/gfs2/meta_io.c |   26 ++++++++++++--------------
> >  1 files changed, 12 insertions(+), 14 deletions(-)
> > 
> > diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
> > index fbeba81..0e34d99 100644
> > --- a/fs/gfs2/meta_io.c
> > +++ b/fs/gfs2/meta_io.c
> > @@ -127,17 +127,17 @@ void gfs2_meta_sync(struct gfs2_glock *g
> >  
> >  /**
> >   * getbuf - Get a buffer with a given address space
> > - * @sdp: the filesystem
> > - * @aspace: the address space
> > + * @gl: the glock
> >   * @blkno: the block number (filesystem scope)
> >   * @create: 1 if the buffer should be created
> >   *
> >   * Returns: the buffer
> >   */
> >  
> > -static struct buffer_head *getbuf(struct gfs2_sbd *sdp, struct inode *aspace,
> > -				  u64 blkno, int create)
> > +static struct buffer_head *getbuf(struct gfs2_glock *gl, u64 blkno, int create)
> >  {
> > +	struct address_space *mapping = gl->gl_aspace->i_mapping;
> > +	struct gfs2_sbd *sdp = gl->gl_sbd;
> >  	struct page *page;
> >  	struct buffer_head *bh;
> >  	unsigned int shift;
> > @@ -150,13 +150,13 @@ static struct buffer_head *getbuf(struct
> >  
> >  	if (create) {
> >  		for (;;) {
> > -			page = grab_cache_page(aspace->i_mapping, index);
> > +			page = grab_cache_page(mapping, index);
> >  			if (page)
> >  				break;
> >  			yield();
> >  		}
> >  	} else {
> > -		page = find_lock_page(aspace->i_mapping, index);
> > +		page = find_lock_page(mapping, index);
> >  		if (!page)
> >  			return NULL;
> >  	}
> > @@ -202,7 +202,7 @@ static void meta_prep_new(struct buffer_
> >  struct buffer_head *gfs2_meta_new(struct gfs2_glock *gl, u64 blkno)
> >  {
> >  	struct buffer_head *bh;
> > -	bh = getbuf(gl->gl_sbd, gl->gl_aspace, blkno, CREATE);
> > +	bh = getbuf(gl, blkno, CREATE);
> >  	meta_prep_new(bh);
> >  	return bh;
> >  }
> > @@ -220,7 +220,7 @@ struct buffer_head *gfs2_meta_new(struct
> >  int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
> >  		   struct buffer_head **bhp)
> >  {
> > -	*bhp = getbuf(gl->gl_sbd, gl->gl_aspace, blkno, CREATE);
> > +	*bhp = getbuf(gl, blkno, CREATE);
> >  	if (!buffer_uptodate(*bhp))
> >  		ll_rw_block(READ_META, 1, bhp);
> >  	if (flags & DIO_WAIT) {
> > @@ -379,11 +379,10 @@ void gfs2_unpin(struct gfs2_sbd *sdp, st
> >  void gfs2_meta_wipe(struct gfs2_inode *ip, u64 bstart, u32 blen)
> >  {
> >  	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
> > -	struct inode *aspace = ip->i_gl->gl_aspace;
> >  	struct buffer_head *bh;
> >  
> >  	while (blen) {
> > -		bh = getbuf(sdp, aspace, bstart, NO_CREATE);
> > +		bh = getbuf(ip->i_gl, bstart, NO_CREATE);
> >  		if (bh) {
> >  			struct gfs2_bufdata *bd = bh->b_private;
> >  
> > @@ -484,7 +483,7 @@ int gfs2_meta_indirect_buffer(struct gfs
> >  	spin_unlock(&ip->i_spin);
> >  
> >  	if (!bh)
> > -		bh = getbuf(gl->gl_sbd, gl->gl_aspace, num, CREATE);
> > +		bh = getbuf(gl, num, CREATE);
> >  
> >  	if (!bh)
> >  		return -ENOBUFS;
> > @@ -535,7 +534,6 @@ err:
> >  struct buffer_head *gfs2_meta_ra(struct gfs2_glock *gl, u64 dblock, u32 extlen)
> >  {
> >  	struct gfs2_sbd *sdp = gl->gl_sbd;
> > -	struct inode *aspace = gl->gl_aspace;
> >  	struct buffer_head *first_bh, *bh;
> >  	u32 max_ra = gfs2_tune_get(sdp, gt_max_readahead) >>
> >  			  sdp->sd_sb.sb_bsize_shift;
> > @@ -547,7 +545,7 @@ struct buffer_head *gfs2_meta_ra(struct 
> >  	if (extlen > max_ra)
> >  		extlen = max_ra;
> >  
> > -	first_bh = getbuf(sdp, aspace, dblock, CREATE);
> > +	first_bh = getbuf(gl, dblock, CREATE);
> >  
> >  	if (buffer_uptodate(first_bh))
> >  		goto out;
> > @@ -558,7 +556,7 @@ struct buffer_head *gfs2_meta_ra(struct 
> >  	extlen--;
> >  
> >  	while (extlen) {
> > -		bh = getbuf(sdp, aspace, dblock, CREATE);
> > +		bh = getbuf(gl, dblock, CREATE);
> >  
> >  		if (!buffer_uptodate(bh) && !buffer_locked(bh))
> >  			ll_rw_block(READA, 1, &bh);
> > -- 
> > 1.4.1
> > 
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

