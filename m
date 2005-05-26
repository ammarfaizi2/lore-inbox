Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVEZGVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVEZGVw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 02:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVEZGVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 02:21:52 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:14743 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261197AbVEZGVr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 02:21:47 -0400
References: <1117044875.9510.2.camel@localhost>
            <Pine.LNX.4.60.0505252208120.25834@hermes-1.csi.cam.ac.uk>
In-Reply-To: <Pine.LNX.4.60.0505252208120.25834@hermes-1.csi.cam.ac.uk>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: ntfs: remove redundant assignments
Date: Thu, 26 May 2005 09:21:46 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42956AFA.00002502@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton, 

At some point in time, I wrote:
> Index: 2.6-mm/fs/ntfs/super.c
> > ===================================================================
> > --- 2.6-mm.orig/fs/ntfs/super.c	2005-05-25 20:51:57.000000000 +0300
> > +++ 2.6-mm/fs/ntfs/super.c	2005-05-25 20:54:02.000000000 +0300
> > @@ -2283,7 +2283,7 @@
> >  	sb->s_flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
> >  #endif /* ! NTFS_RW */
> >  	/* Allocate a new ntfs_volume and place it in sb->s_fs_info. */
> > -	sb->s_fs_info = kmalloc(sizeof(ntfs_volume), GFP_NOFS);
> > +	sb->s_fs_info = kcalloc(1, sizeof(ntfs_volume), GFP_NOFS);
> >  	vol = NTFS_SB(sb);
> >  	if (!vol) {
> >  		if (!silent)
> > @@ -2292,28 +2292,9 @@
> >  		return -ENOMEM;
> >  	}
> >  	/* Initialize ntfs_volume structure. */
> > -	memset(vol, 0, sizeof(ntfs_volume));
> >  	vol->sb = sb; 
> 
> The above is fine, thanks. 
> 
> > -	vol->upcase = NULL;
> > -	vol->attrdef = NULL;
> > -	vol->mft_ino = NULL;
> > -	vol->mftbmp_ino = NULL;
> >  	init_rwsem(&vol->mftbmp_lock);
> > -#ifdef NTFS_RW
> > -	vol->mftmirr_ino = NULL;
> > -	vol->logfile_ino = NULL;
> > -#endif /* NTFS_RW */
> > -	vol->lcnbmp_ino = NULL;
> >  	init_rwsem(&vol->lcnbmp_lock);
> > -	vol->vol_ino = NULL;
> > -	vol->root_ino = NULL;
> > -	vol->secure_ino = NULL;
> > -	vol->extend_ino = NULL;
> > -#ifdef NTFS_RW
> > -	vol->quota_ino = NULL;
> > -	vol->quota_q_ino = NULL;
> > -#endif /* NTFS_RW */
> > -	vol->nls_map = NULL;

On Wed, 2005-05-25 at 22:10 +0100, Anton Altaparmakov wrote:
> This is not.  memset(0) is not the same as = NULL IMO.  I don't care if 
> the compiler thinks it is the same.  NULL does not have to be 0 so I 
> prefer to initialize pointers explicitly to NULL.  Even more so since this 
> code is not performance critical at all so I prefer clarity here.

I kind of figured out you were doing it on purpose. The fact is, NULL is 
zero on _all_ Linux architectures. If it weren't, we'd have a lot of broken 
code. Let me play the devils advocate here: why do you memset() (now 
kcalloc()) in the first place? 

At some point in time, I wrote:
> > Index: 2.6-mm/fs/ntfs/index.c
> > ===================================================================
> > --- 2.6-mm.orig/fs/ntfs/index.c	2005-05-25 20:51:57.000000000 +0300
> > +++ 2.6-mm/fs/ntfs/index.c	2005-05-25 21:07:38.000000000 +0300
> > @@ -40,16 +40,8 @@
> >  
> >  	ictx = kmem_cache_alloc(ntfs_index_ctx_cache, SLAB_NOFS);
> >  	if (ictx) {
> > +		memset(ictx, 0, sizeof(*ictx));
> >  		ictx->idx_ni = idx_ni;
> > -		ictx->entry = NULL;
> > -		ictx->data = NULL;
> > -		ictx->data_len = 0;
> > -		ictx->is_in_root = 0;
> > -		ictx->ir = NULL;
> > -		ictx->actx = NULL;
> > -		ictx->base_ni = NULL;
> > -		ictx->ia = NULL;
> > -		ictx->page = NULL;

On Wed, 2005-05-25 at 22:10 +0100, Anton Altaparmakov wrote:
> Again, as above, I prefer to have the explicit = NULL instead of a memset.

There's a simple reason why I don't like explicit assignments: it's way too 
easy to forget to initialize something. 

			Pekka 
