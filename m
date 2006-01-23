Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWAWPN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWAWPN2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 10:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWAWPN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 10:13:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:20696 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751467AbWAWPN1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 10:13:27 -0500
Date: Mon, 23 Jan 2006 16:13:26 +0100
From: Jan Blunck <jblunck@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: viro@zeniv.linux.org.uk, dev@sw.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shrink_dcache_parent() races against shrink_dcache_memory()
Message-ID: <20060123151326.GB26653@hasse.suse.de>
References: <20060120203645.GF24401@hasse.suse.de> <20060122212243.20ce26c5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060122212243.20ce26c5.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, Andrew Morton wrote:

> > -void dput(struct dentry *dentry)
> > +static void dput_locked(struct dentry *dentry, struct list_head *list)
> >  {
> >  	if (!dentry)
> >  		return;
> >  
> > -repeat:
> > -	if (atomic_read(&dentry->d_count) == 1)
> > -		might_sleep();
> > -	if (!atomic_dec_and_lock(&dentry->d_count, &dcache_lock))
> > +	if (!atomic_dec_and_test(&dentry->d_count))
> >  		return;
> >  
> > +
> >
> > ...
> >
> > +void dput(struct dentry *dentry)
> > +{
> > +	LIST_HEAD(free_list);
> > +
> > +	if (!dentry)
> > +		return;
> > +
> > +	if (atomic_add_unless(&dentry->d_count, -1, 1))
> > +		return;
> > +
> > +	spin_lock(&dcache_lock);
> > +	dput_locked(dentry, &free_list);
> > +	spin_unlock(&dcache_lock);
> 
> This seems to be an open-coded copy of atomic_dec_and_lock()?
> 

Yes, it is. Otherwise the reference counting would be like

 if(!atomic_dec_and_lock())
	return;
 atomic_inc();
 dput_locked();

or something similar stupid/racy.

Regards,
	Jan

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de
