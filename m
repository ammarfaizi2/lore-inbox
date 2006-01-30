Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWA3OyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWA3OyS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 09:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWA3OyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 09:54:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:44432 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932298AbWA3OyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 09:54:18 -0500
Date: Mon, 30 Jan 2006 15:54:18 +0100
From: Jan Blunck <jblunck@suse.de>
To: Balbir Singh <balbir@in.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, viro@zeniv.linux.org.uk,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       olh@suse.de
Subject: Re: [PATCH] shrink_dcache_parent() races against shrink_dcache_memory()
Message-ID: <20060130145418.GF9181@hasse.suse.de>
References: <20060120203645.GF24401@hasse.suse.de> <43D48ED4.3010306@sw.ru> <20060130120318.GB9181@hasse.suse.de> <20060130143814.GA25817@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060130143814.GA25817@in.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, Balbir Singh wrote:

> >  static inline void prune_one_dentry(struct dentry * dentry)
> >  {
> > +	struct super_block *sb = dentry->d_sb;
> >  	struct dentry * parent;
> >  
> >  	__d_drop(dentry);
> >  	list_del(&dentry->d_u.d_child);
> >  	dentry_stat.nr_dentry--;	/* For d_free, below */
> > +	sb->s_prunes++;
> >  	dentry_iput(dentry);
> >  	parent = dentry->d_parent;
> >  	d_free(dentry);
> >  	if (parent != dentry)
> >  		dput(parent);
> >  	spin_lock(&dcache_lock);
> > +	sb->s_prunes--;
> > +	wake_up(&sb->s_wait_prunes);
> >  }
> >
>   
> We can think about optimizing this to
>    if (!sb->sprunes)
> 	wake_up(&sb->s_wait_prunes);
> 

Hardly. This is only the case when two or more shrinkers are active in
parallel. If that was the case often, we would have seen this much more
frequent IMHO.

> > @@ -634,8 +666,12 @@ void shrink_dcache_parent(struct dentry 
> >  {
> >  	int found;
> >  
> > + again:
> >  	while ((found = select_parent(parent)) != 0)
> >  		prune_dcache(found);
> > +
> > +	if (wait_on_prunes(parent->d_sb))
> > +		goto again;
> >  }
> 
> Is the goto again required? At this point select_parent() should have pruned
> all entries, except those missed due to the race. These should be captured
> by sb->s_prunes. Once the code comes out of wait_on_prunes() everything
> should be ok since a dput has happened on the missed parent dentries.

Yes, because the last select_parent might returned zero because the parent of
the dentry which is just pruned isn't dereferenced yet. Although we can change
it to something like

   do { 
      while(select_parent())
   } while(wait_on_prunes()) 


> > +++ linux-2.6/include/linux/fs.h
> > @@ -833,6 +833,9 @@ struct super_block {
> >  	struct list_head	s_instances;
> >  	struct quota_info	s_dquot;	/* Diskquota specific options */
> >  
> > +	int			s_prunes;
> 
> Can this be an unsigned int? Perhaps you might to mention that is protected
> by the dcache_lock.
> 

Yes, will fix that.

Regards,
	Jan

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de
