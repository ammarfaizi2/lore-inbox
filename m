Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932598AbWAKGis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbWAKGis (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 01:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932797AbWAKGis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 01:38:48 -0500
Received: from omx3-ext.sgi.com ([192.48.171.26]:2238 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932598AbWAKGir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 01:38:47 -0500
Date: Tue, 10 Jan 2006 22:38:37 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: kamezawa.hiroyu@jp.fujitsu.com
cc: Andrew Morton <akpm@osdl.org>, cpw@sgi.com, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net, taka@valinux.co.jp
Subject: Re: [PATCH 5/5] Direct Migration V9: Avoid writeback / page_migrate()
 method
In-Reply-To: <20060110220314.70e5793b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0601102225550.20806@schroedinger.engr.sgi.com>
References: <20060110224114.19138.10463.sendpatchset@schroedinger.engr.sgi.com>
 <20060110224140.19138.84122.sendpatchset@schroedinger.engr.sgi.com>
 <20060110220314.70e5793b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2006, Andrew Morton wrote:

> Christoph Lameter <clameter@sgi.com> wrote:
> >
> > +	spin_lock(&mapping->private_lock);
> >  +
> >  +	bh = head;
> >  +	do {
> >  +		get_bh(bh);
> >  +		lock_buffer(bh);
> >  +		bh = bh->b_this_page;
> >  +
> >  +	} while (bh != head);
> >  +
> 
> Guys, lock_buffer() sleeps and cannot be called inside spinlock.

I took it the way it was in the hotplug patches.We are taking the 
spinlock here to protect the scan over the list of bh's of this page 
right?

Is it not sufficient to have the page locked to guarantee that the list of 
buffers is not changed? Seems that ext3 does that (see 
ext3_ordered_writepage() etc).

like this?

Index: linux-2.6.15/fs/buffer.c
===================================================================
--- linux-2.6.15.orig/fs/buffer.c	2006-01-10 22:13:37.000000000 -0800
+++ linux-2.6.15/fs/buffer.c	2006-01-10 22:37:28.000000000 -0800
@@ -3070,8 +3070,6 @@ int buffer_migrate_page(struct page *new
 	if (migrate_page_remove_references(newpage, page, 3))
 		return -EAGAIN;
 
-	spin_lock(&mapping->private_lock);
-
 	bh = head;
 	do {
 		get_bh(bh);
@@ -3094,11 +3092,9 @@ int buffer_migrate_page(struct page *new
 	} while (bh != head);
 
 	SetPagePrivate(newpage);
-	spin_unlock(&mapping->private_lock);
 
 	migrate_page_copy(newpage, page);
 
-	spin_lock(&mapping->private_lock);
 	bh = head;
 	do {
 		unlock_buffer(bh);
@@ -3106,7 +3102,6 @@ int buffer_migrate_page(struct page *new
 		bh = bh->b_this_page;
 
 	} while (bh != head);
-	spin_unlock(&mapping->private_lock);
 
 	return 0;
 }
