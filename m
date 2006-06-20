Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWFTUjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWFTUjJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 16:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbWFTUjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 16:39:08 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:719 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750989AbWFTUjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 16:39:07 -0400
Subject: Re: 2.6.17-rc6-mm1
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: davej@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060620132431.e00a5c68.akpm@osdl.org>
References: <20060607104724.c5d3d730.akpm@osdl.org>
	 <20060608050047.GB16729@redhat.com>
	 <1150825349.2891.219.camel@laptopd505.fenrus.org>
	 <20060620132431.e00a5c68.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 22:38:59 +0200
Message-Id: <1150835940.2891.225.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 13:24 -0700, Andrew Morton wrote:
> On Tue, 20 Jun 2006 19:42:29 +0200
> Arjan van de Ven <arjan@infradead.org> wrote:
> 
> >  /*
> > + * Lock a file handle/inode to be used as parent dir for another
> > + * NOTE: both fh_lock and fh_unlock are done "by hand" in
> > + * vfs.c:nfsd_rename as it needs to grab 2 i_mutex's at once
> > + * so, any changes here should be reflected there.
> > + */
> > +static inline void
> > +fh_lock_parent(struct svc_fh *fhp)
> > +{
> > +	struct dentry	*dentry = fhp->fh_dentry;
> > +	struct inode	*inode;
> > +
> > +	dfprintk(FILEOP, "nfsd: fh_lock(%s) locked = %d\n",
> > +			SVCFH_fmt(fhp), fhp->fh_locked);
> > +
> > +	if (!fhp->fh_dentry) {
> > +		printk(KERN_ERR "fh_lock: fh not verified!\n");
> > +		return;
> > +	}
> > +	if (fhp->fh_locked) {
> > +		printk(KERN_WARNING "fh_lock: %s/%s already locked!\n",
> > +			dentry->d_parent->d_name.name, dentry->d_name.name);
> > +		return;
> > +	}
> > +
> > +	inode = dentry->d_inode;
> > +	mutex_lock_nested(&inode->i_mutex, I_MUTEX_PARENT);
> > +	fill_pre_wcc(fhp);
> > +	fhp->fh_locked = 1;
> > +}
> 
> yikes, five callsites, and fill_pre_wcc() is inlined too.

if this patch works for Dave I'll make one that just inlines this (and
the other one) as well; as you said.. 5+ call sites...
(and in fact there used to be an out-of-line function for this at some
point so.. it's not unheard of)

