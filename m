Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWAKGta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWAKGta (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 01:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbWAKGta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 01:49:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14023 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030185AbWAKGt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 01:49:29 -0500
Date: Tue, 10 Jan 2006 22:49:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: kamezawa.hiroyu@jp.fujitsu.com, cpw@sgi.com, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net, taka@valinux.co.jp
Subject: Re: [PATCH 5/5] Direct Migration V9: Avoid writeback /
 page_migrate() method
Message-Id: <20060110224905.514213de.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0601102225550.20806@schroedinger.engr.sgi.com>
References: <20060110224114.19138.10463.sendpatchset@schroedinger.engr.sgi.com>
	<20060110224140.19138.84122.sendpatchset@schroedinger.engr.sgi.com>
	<20060110220314.70e5793b.akpm@osdl.org>
	<Pine.LNX.4.62.0601102225550.20806@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> On Tue, 10 Jan 2006, Andrew Morton wrote:
> 
> > Christoph Lameter <clameter@sgi.com> wrote:
> > >
> > > +	spin_lock(&mapping->private_lock);
> > >  +
> > >  +	bh = head;
> > >  +	do {
> > >  +		get_bh(bh);
> > >  +		lock_buffer(bh);
> > >  +		bh = bh->b_this_page;
> > >  +
> > >  +	} while (bh != head);
> > >  +
> > 
> > Guys, lock_buffer() sleeps and cannot be called inside spinlock.
> 
> I took it the way it was in the hotplug patches.We are taking the 
> spinlock here to protect the scan over the list of bh's of this page 
> right?
> 
> Is it not sufficient to have the page locked to guarantee that the list of 
> buffers is not changed? Seems that ext3 does that (see 
> ext3_ordered_writepage() etc).

Yes, the page lock protects the buffer ring.

> like this?
> 
> Index: linux-2.6.15/fs/buffer.c
> ===================================================================
> --- linux-2.6.15.orig/fs/buffer.c	2006-01-10 22:13:37.000000000 -0800
> +++ linux-2.6.15/fs/buffer.c	2006-01-10 22:37:28.000000000 -0800
> @@ -3070,8 +3070,6 @@ int buffer_migrate_page(struct page *new
>  	if (migrate_page_remove_references(newpage, page, 3))
>  		return -EAGAIN;
>  
> -	spin_lock(&mapping->private_lock);
> -
>  	bh = head;
>  	do {
>  		get_bh(bh);
> @@ -3094,11 +3092,9 @@ int buffer_migrate_page(struct page *new
>  	} while (bh != head);
>  
>  	SetPagePrivate(newpage);
> -	spin_unlock(&mapping->private_lock);
>  
>  	migrate_page_copy(newpage, page);
>  
> -	spin_lock(&mapping->private_lock);
>  	bh = head;
>  	do {
>  		unlock_buffer(bh);
> @@ -3106,7 +3102,6 @@ int buffer_migrate_page(struct page *new
>  		bh = bh->b_this_page;
>  
>  	} while (bh != head);
> -	spin_unlock(&mapping->private_lock);
>  
>  	return 0;
>  }

Seems right, I think.


So let's see.  Suppose the kernel is about to dink with a page's buffer
ring.  It does:

	get_page(page);
	lock_page(page);
	dink_with(page_buffers(page));

how do these patches ensure that the page doesn't get migrated under my
feet?
