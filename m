Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759890AbWLDJYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759890AbWLDJYK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 04:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759896AbWLDJYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 04:24:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3225 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1759892AbWLDJYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 04:24:07 -0500
Subject: Re: [GFS2] Shrink gfs2_inode (8) - i_vn [28/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: Russell Cattelan <cattelan@thebarn.com>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1164997530.1194.52.camel@xenon.msp.redhat.com>
References: <1164889002.3752.360.camel@quoit.chygwyn.com>
	 <1164997530.1194.52.camel@xenon.msp.redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 04 Dec 2006 09:26:07 +0000
Message-Id: <1165224367.3752.575.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-12-01 at 12:25 -0600, Russell Cattelan wrote:
> On Thu, 2006-11-30 at 12:16 +0000, Steven Whitehouse wrote:
> > >From bfded27ba010d1c3b0aa3843f97dc9b80de751be Mon Sep 17 00:00:00 2001
> > From: Steven Whitehouse <swhiteho@redhat.com>
> > Date: Wed, 1 Nov 2006 16:05:38 -0500
> > Subject: [PATCH] [GFS2] Shrink gfs2_inode (8) - i_vn
> > 
> > This shrinks the size of the gfs2_inode by 8 bytes by
> > replacing the version counter with a one bit valid/invalid
> > flag.
> What is the version number used for?
> It seems like anything that was specifically carving a 64 container
> has a more specific reason that just ON/OFF?
> 
It was being used to show whether the glock had been released and thus
whether the inode needed to be reread from disk when the glock was next
taken. That doesn't require a 64 bit counter, a simple flag is perfectly
ok to indicate this,

Steve.

> 
> 
> > 
> > Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
> > ---
> >  fs/gfs2/glops.c     |    5 +++--
> >  fs/gfs2/incore.h    |    2 +-
> >  fs/gfs2/inode.c     |    4 ++--
> >  fs/gfs2/ops_inode.c |    2 +-
> >  4 files changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
> > index aad45b7..9c20337 100644
> > --- a/fs/gfs2/glops.c
> > +++ b/fs/gfs2/glops.c
> > @@ -305,8 +305,9 @@ static void inode_go_inval(struct gfs2_g
> >  	int data = (flags & DIO_DATA);
> >  
> >  	if (meta) {
> > +		struct gfs2_inode *ip = gl->gl_object;
> >  		gfs2_meta_inval(gl);
> > -		gl->gl_vn++;
> > +		set_bit(GIF_INVALID, &ip->i_flags);
> >  	}
> >  	if (data)
> >  		gfs2_page_inval(gl);
> > @@ -351,7 +352,7 @@ static int inode_go_lock(struct gfs2_hol
> >  	if (!ip)
> >  		return 0;
> >  
> > -	if (ip->i_vn != gl->gl_vn) {
> > +	if (test_bit(GIF_INVALID, &ip->i_flags)) {
> >  		error = gfs2_inode_refresh(ip);
> >  		if (error)
> >  			return error;
> > diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
> > index c0a8c3b..227a74d 100644
> > --- a/fs/gfs2/incore.h
> > +++ b/fs/gfs2/incore.h
> > @@ -217,6 +217,7 @@ struct gfs2_alloc {
> >  };
> >  
> >  enum {
> > +	GIF_INVALID		= 0,
> >  	GIF_QD_LOCKED		= 1,
> >  	GIF_PAGED		= 2,
> >  	GIF_SW_PAGED		= 3,
> > @@ -228,7 +229,6 @@ struct gfs2_inode {
> >  
> >  	unsigned long i_flags;		/* GIF_... */
> >  
> > -	u64 i_vn;
> >  	struct gfs2_dinode_host i_di; /* To be replaced by ref to block */
> >  
> >  	struct gfs2_glock *i_gl; /* Move into i_gh? */
> > diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> > index f6177fc..e467780 100644
> > --- a/fs/gfs2/inode.c
> > +++ b/fs/gfs2/inode.c
> > @@ -145,7 +145,7 @@ struct inode *gfs2_inode_lookup(struct s
> >  		if (unlikely(error))
> >  			goto fail_put;
> >  
> > -		ip->i_vn = ip->i_gl->gl_vn - 1;
> > +		set_bit(GIF_INVALID, &ip->i_flags);
> >  		error = gfs2_glock_nq_init(io_gl, LM_ST_SHARED, GL_EXACT, &ip->i_iopen_gh);
> >  		if (unlikely(error))
> >  			goto fail_iopen;
> > @@ -242,7 +242,7 @@ int gfs2_inode_refresh(struct gfs2_inode
> >  
> >  	error = gfs2_dinode_in(ip, dibh->b_data);
> >  	brelse(dibh);
> > -	ip->i_vn = ip->i_gl->gl_vn;
> > +	clear_bit(GIF_INVALID, &ip->i_flags);
> >  
> >  	return error;
> >  }
> > diff --git a/fs/gfs2/ops_inode.c b/fs/gfs2/ops_inode.c
> > index 0e4eade..b247f25 100644
> > --- a/fs/gfs2/ops_inode.c
> > +++ b/fs/gfs2/ops_inode.c
> > @@ -844,7 +844,7 @@ static int gfs2_permission(struct inode 
> >  	struct gfs2_holder i_gh;
> >  	int error;
> >  
> > -	if (ip->i_vn == ip->i_gl->gl_vn)
> > +	if (!test_bit(GIF_INVALID, &ip->i_flags))
> >  		return generic_permission(inode, mask, gfs2_check_acl);
> >  
> >  	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY, &i_gh);

