Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759913AbWLDJ05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759913AbWLDJ05 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 04:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759914AbWLDJ05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 04:26:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41626 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1759913AbWLDJ04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 04:26:56 -0500
Subject: Re: [GFS2] Remove unused function from inode.c [50/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: Russell Cattelan <cattelan@thebarn.com>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1164998159.1194.54.camel@xenon.msp.redhat.com>
References: <1164889273.3752.405.camel@quoit.chygwyn.com>
	 <1164998159.1194.54.camel@xenon.msp.redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 04 Dec 2006 09:28:48 +0000
Message-Id: <1165224528.3752.579.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-12-01 at 12:35 -0600, Russell Cattelan wrote:
> On Thu, 2006-11-30 at 12:21 +0000, Steven Whitehouse wrote:
> > >From dcd2479959c79d44f5dd77e71672e70f1f8b1f06 Mon Sep 17 00:00:00 2001
> > From: Steven Whitehouse <swhiteho@redhat.com>
> > Date: Thu, 16 Nov 2006 11:08:16 -0500
> > Subject: [PATCH] [GFS2] Remove unused function from inode.c
> > 
> > The gfs2_glock_nq_m_atime function is unused in so far as its only
> > ever called with num_gh = 1, and this falls through to the
> > gfs2_glock_nq_atime function, so we might as well call that directly.
> 
> does gfs support a noatime type of option?
> 
Yes it does, but its irrelevant to this patch.
 
> I seems like reason for the split was to allow for that
> possibility?
> 
The function was there because at one stage multiple glocks were being
taken through this interface and this they were being sorted (to avoid
deadlocks between nodes) before each individual glock was acquired.
Since we no longer have any code which requires multiple glocks, there
is no point in retaining this function and we might as well call
directly the code for acquiring a single glock,

Steve.

> > 
> > Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
> > ---
> >  fs/gfs2/inode.c       |   86 -------------------------------------------------
> >  fs/gfs2/inode.h       |    4 --
> >  fs/gfs2/ops_address.c |    8 ++---
> >  fs/gfs2/ops_file.c    |    2 +
> >  4 files changed, 5 insertions(+), 95 deletions(-)
> > 
> > diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> > index ea9ca23..ce7f833 100644
> > --- a/fs/gfs2/inode.c
> > +++ b/fs/gfs2/inode.c
> > @@ -1234,92 +1234,6 @@ fail:
> >  	return error;
> >  }
> >  
> > -/**
> > - * glock_compare_atime - Compare two struct gfs2_glock structures for sort
> > - * @arg_a: the first structure
> > - * @arg_b: the second structure
> > - *
> > - * Returns: 1 if A > B
> > - *         -1 if A < B
> > - *          0 if A == B
> > - */
> > -
> > -static int glock_compare_atime(const void *arg_a, const void *arg_b)
> > -{
> > -	const struct gfs2_holder *gh_a = *(const struct gfs2_holder **)arg_a;
> > -	const struct gfs2_holder *gh_b = *(const struct gfs2_holder **)arg_b;
> > -	const struct lm_lockname *a = &gh_a->gh_gl->gl_name;
> > -	const struct lm_lockname *b = &gh_b->gh_gl->gl_name;
> > -
> > -	if (a->ln_number > b->ln_number)
> > -		return 1;
> > -	if (a->ln_number < b->ln_number)
> > -		return -1;
> > -	if (gh_a->gh_state == LM_ST_SHARED && gh_b->gh_state == LM_ST_EXCLUSIVE)
> > -		return 1;
> > -	if (gh_a->gh_state == LM_ST_SHARED && (gh_b->gh_flags & GL_ATIME))
> > -		return 1;
> > -
> > -	return 0;
> > -}
> > -
> > -/**
> > - * gfs2_glock_nq_m_atime - acquire multiple glocks where one may need an
> > - *      atime update
> > - * @num_gh: the number of structures
> > - * @ghs: an array of struct gfs2_holder structures
> > - *
> > - * Returns: 0 on success (all glocks acquired),
> > - *          errno on failure (no glocks acquired)
> > - */
> > -
> > -int gfs2_glock_nq_m_atime(unsigned int num_gh, struct gfs2_holder *ghs)
> > -{
> > -	struct gfs2_holder **p;
> > -	unsigned int x;
> > -	int error = 0;
> > -
> > -	if (!num_gh)
> > -		return 0;
> > -
> > -	if (num_gh == 1) {
> > -		ghs->gh_flags &= ~(LM_FLAG_TRY | GL_ASYNC);
> > -		if (ghs->gh_flags & GL_ATIME)
> > -			error = gfs2_glock_nq_atime(ghs);
> > -		else
> > -			error = gfs2_glock_nq(ghs);
> > -		return error;
> > -	}
> > -
> > -	p = kcalloc(num_gh, sizeof(struct gfs2_holder *), GFP_KERNEL);
> > -	if (!p)
> > -		return -ENOMEM;
> > -
> > -	for (x = 0; x < num_gh; x++)
> > -		p[x] = &ghs[x];
> > -
> > -	sort(p, num_gh, sizeof(struct gfs2_holder *), glock_compare_atime,NULL);
> > -
> > -	for (x = 0; x < num_gh; x++) {
> > -		p[x]->gh_flags &= ~(LM_FLAG_TRY | GL_ASYNC);
> > -
> > -		if (p[x]->gh_flags & GL_ATIME)
> > -			error = gfs2_glock_nq_atime(p[x]);
> > -		else
> > -			error = gfs2_glock_nq(p[x]);
> > -
> > -		if (error) {
> > -			while (x--)
> > -				gfs2_glock_dq(p[x]);
> > -			break;
> > -		}
> > -	}
> > -
> > -	kfree(p);
> > -	return error;
> > -}
> > -
> > -
> >  static int
> >  __gfs2_setattr_simple(struct gfs2_inode *ip, struct iattr *attr)
> >  {
> > diff --git a/fs/gfs2/inode.h b/fs/gfs2/inode.h
> > index 46917ed..b57f448 100644
> > --- a/fs/gfs2/inode.h
> > +++ b/fs/gfs2/inode.h
> > @@ -50,12 +50,8 @@ int gfs2_unlink_ok(struct gfs2_inode *di
> >  		   struct gfs2_inode *ip);
> >  int gfs2_ok_to_move(struct gfs2_inode *this, struct gfs2_inode *to);
> >  int gfs2_readlinki(struct gfs2_inode *ip, char **buf, unsigned int *len);
> > -
> >  int gfs2_glock_nq_atime(struct gfs2_holder *gh);
> > -int gfs2_glock_nq_m_atime(unsigned int num_gh, struct gfs2_holder *ghs);
> > -
> >  int gfs2_setattr_simple(struct gfs2_inode *ip, struct iattr *attr);
> > -
> >  struct inode *gfs2_lookup_simple(struct inode *dip, const char *name);
> >  
> >  #endif /* __INODE_DOT_H__ */
> > diff --git a/fs/gfs2/ops_address.c b/fs/gfs2/ops_address.c
> > index 2f7ef98..8676c39 100644
> > --- a/fs/gfs2/ops_address.c
> > +++ b/fs/gfs2/ops_address.c
> > @@ -217,7 +217,7 @@ static int gfs2_readpage(struct file *fi
> >  		}
> >  		gfs2_holder_init(ip->i_gl, LM_ST_SHARED, GL_ATIME|LM_FLAG_TRY_1CB, &gh);
> >  		do_unlock = 1;
> > -		error = gfs2_glock_nq_m_atime(1, &gh);
> > +		error = gfs2_glock_nq_atime(&gh);
> >  		if (unlikely(error))
> >  			goto out_unlock;
> >  	}
> > @@ -282,7 +282,7 @@ static int gfs2_readpages(struct file *f
> >  		gfs2_holder_init(ip->i_gl, LM_ST_SHARED,
> >  				 LM_FLAG_TRY_1CB|GL_ATIME, &gh);
> >  		do_unlock = 1;
> > -		ret = gfs2_glock_nq_m_atime(1, &gh);
> > +		ret = gfs2_glock_nq_atime(&gh);
> >  		if (ret == GLR_TRYFAILED)
> >  			goto out_noerror;
> >  		if (unlikely(ret))
> > @@ -354,7 +354,7 @@ static int gfs2_prepare_write(struct fil
> >  
> > 
> >  	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, GL_ATIME|LM_FLAG_TRY_1CB, &ip->i_gh);
> > -	error = gfs2_glock_nq_m_atime(1, &ip->i_gh);
> > +	error = gfs2_glock_nq_atime(&ip->i_gh);
> >  	if (unlikely(error)) {
> >  		if (error == GLR_TRYFAILED)
> >  			error = AOP_TRUNCATED_PAGE;
> > @@ -609,7 +609,7 @@ static ssize_t gfs2_direct_IO(int rw, st
> >  	 * on this path. All we need change is atime.
> >  	 */
> >  	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, GL_ATIME, &gh);
> > -	rv = gfs2_glock_nq_m_atime(1, &gh);
> > +	rv = gfs2_glock_nq_atime(&gh);
> >  	if (rv)
> >  		goto out;
> >  
> > diff --git a/fs/gfs2/ops_file.c b/fs/gfs2/ops_file.c
> > index eabf6c6..c2be216 100644
> > --- a/fs/gfs2/ops_file.c
> > +++ b/fs/gfs2/ops_file.c
> > @@ -253,7 +253,7 @@ static int gfs2_get_flags(struct file *f
> >  	u32 fsflags;
> >  
> >  	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, GL_ATIME, &gh);
> > -	error = gfs2_glock_nq_m_atime(1, &gh);
> > +	error = gfs2_glock_nq_atime(&gh);
> >  	if (error)
> >  		return error;
> >  

