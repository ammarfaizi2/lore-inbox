Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263187AbVCKFj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbVCKFj1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 00:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbVCKFj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 00:39:26 -0500
Received: from [205.233.219.253] ([205.233.219.253]:8661 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S263187AbVCKFdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 00:33:15 -0500
Date: Fri, 11 Mar 2005 00:31:44 -0500
From: Jody McIntyre <scjody@modernduck.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, willy@debian.org,
       Nathan Scott <nathans@sgi.com>
Subject: Re: [PATCH, RFC 1/3] Add sem_getcount() to arches that lack it
Message-ID: <20050311053144.GP1111@conscoop.ottawa.on.ca>
References: <20050311000646.GJ1111@conscoop.ottawa.on.ca> <20050310205503.6151ab83.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310205503.6151ab83.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 08:55:03PM -0800, Andrew Morton wrote:
> Jody McIntyre <scjody@modernduck.com> wrote:
> >
> > parisc and frv define sem_getcount() in semaphore.h, which returns the
> >  current semaphore value.  This is cleaner than doing
> >  atomic_read(&semaphore.count), currently done in
> >  drivers/ieee1394/nodemgr.c and fs/xfs/linux-2.6/xfs_buf.c, and will work
> >  on all architectures if sem_getcount() is added.
> 
> That's a fairly bizarre thing to want to do.  Would it be hard to modify
> xfs and 1394 to stop wanting to read a semaphore's up() count?

The count is the number of free transaction labels (1394 async is
transaction-based) and is initialized to 64.  When a new transaction label
is needed, the requestor does a down(), then locks the tlabel variables
and allocates a new one.  When a transaction label is freed, an up()
occurs.  The semaphore's up() count is therefore the number of free
tlabels, and the number of outstanding transactions is (64 - count).  I
can imagine situations in which this would be a useful statistic, but
I'm not sure any of them actually exist.

I haven't investigated xfs, but modifying 1394 would be fairly easy.  I
could add a second variable that tracks the up() count, or just drop the
sysfs attribute that reports the number.  The first option seems a bit
wasteful, but only slightly.  I thought this patch was worthwhile based
on xfs wanting to do this and 3 arches already having (unused)
implementations of sem_getcount/sema_count.

If this patch isn't accepted, we should get rid of the xfs and 1394
hacks and delete sem_getcount (parisc, frv) and sema_count (arm) as they
are unused.

Jody

> 
> (Why do they want to do this anyway?)

-- 
