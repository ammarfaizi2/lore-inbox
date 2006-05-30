Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbWE3Uvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWE3Uvk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 16:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWE3Uvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 16:51:40 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:52725 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932412AbWE3Uvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 16:51:39 -0400
Subject: Re: [patch 37/61] lock validator: special locking: dcache
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
In-Reply-To: <20060529183539.08d3463c.akpm@osdl.org>
References: <20060529212109.GA2058@elte.hu> <20060529212608.GK3155@elte.hu>
	 <20060529183539.08d3463c.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 30 May 2006 16:51:08 -0400
Message-Id: <1149022268.21827.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-29 at 18:35 -0700, Andrew Morton wrote:

> > Index: linux/fs/dcache.c
> > ===================================================================
> > --- linux.orig/fs/dcache.c
> > +++ linux/fs/dcache.c
> > @@ -1380,10 +1380,10 @@ void d_move(struct dentry * dentry, stru
> >  	 */
> >  	if (target < dentry) {
> >  		spin_lock(&target->d_lock);
> > -		spin_lock(&dentry->d_lock);
> > +		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
> >  	} else {
> >  		spin_lock(&dentry->d_lock);
> > -		spin_lock(&target->d_lock);
> > +		spin_lock_nested(&target->d_lock, DENTRY_D_LOCK_NESTED);
> >  	}
> > 
>  

[...]

> > +/*
> > + * dentry->d_lock spinlock nesting types:
> > + *
> > + * 0: normal
> > + * 1: nested
> > + */
> > +enum dentry_d_lock_type
> > +{
> > +	DENTRY_D_LOCK_NORMAL,
> > +	DENTRY_D_LOCK_NESTED
> > +};
> > +
> >  struct dentry_operations {
> >  	int (*d_revalidate)(struct dentry *, struct nameidata *);
> >  	int (*d_hash) (struct dentry *, struct qstr *);
> 
> DENTRY_D_LOCK_NORMAL isn't used anywhere.
> 

I guess it is implied with the normal spin_lock.  Since 
  spin_lock(&target->d_lock) and
  spin_lock_nested(&target->d_lock, DENTRY_D_LOCK_NORMAL)
are equivalent. (DENTRY_D_LOCK_NORMAL == 0)

Probably this deserves a comment.

-- Steve


