Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262552AbVCKF5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262552AbVCKF5g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 00:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263186AbVCKF5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 00:57:35 -0500
Received: from fire.osdl.org ([65.172.181.4]:36486 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262552AbVCKF52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 00:57:28 -0500
Date: Thu, 10 Mar 2005 21:56:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jody McIntyre <scjody@modernduck.com>
Cc: linux-kernel@vger.kernel.org, willy@debian.org, nathans@sgi.com
Subject: Re: [PATCH, RFC 1/3] Add sem_getcount() to arches that lack it
Message-Id: <20050310215652.76c47856.akpm@osdl.org>
In-Reply-To: <20050311053144.GP1111@conscoop.ottawa.on.ca>
References: <20050311000646.GJ1111@conscoop.ottawa.on.ca>
	<20050310205503.6151ab83.akpm@osdl.org>
	<20050311053144.GP1111@conscoop.ottawa.on.ca>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jody McIntyre <scjody@modernduck.com> wrote:
>
> On Thu, Mar 10, 2005 at 08:55:03PM -0800, Andrew Morton wrote:
> > Jody McIntyre <scjody@modernduck.com> wrote:
> > >
> > > parisc and frv define sem_getcount() in semaphore.h, which returns the
> > >  current semaphore value.  This is cleaner than doing
> > >  atomic_read(&semaphore.count), currently done in
> > >  drivers/ieee1394/nodemgr.c and fs/xfs/linux-2.6/xfs_buf.c, and will work
> > >  on all architectures if sem_getcount() is added.
> > 
> > That's a fairly bizarre thing to want to do.  Would it be hard to modify
> > xfs and 1394 to stop wanting to read a semaphore's up() count?
> 
> The count is the number of free transaction labels (1394 async is
> transaction-based) and is initialized to 64.  When a new transaction label
> is needed, the requestor does a down(), then locks the tlabel variables
> and allocates a new one.  When a transaction label is freed, an up()
> occurs.  The semaphore's up() count is therefore the number of free
> tlabels, and the number of outstanding transactions is (64 - count).  I
> can imagine situations in which this would be a useful statistic, but
> I'm not sure any of them actually exist.

That's a nice application of semaphores.  I can see that there's also a
need to be able to read the value back for reporting purposes.  Dang.

But I guess it's a bit hard to justify adding more infrastructure to
support a single callsite which has a simple alternative.  So if you could
please add the separate counter?

> ...
> 
> If this patch isn't accepted, we should get rid of the xfs and 1394
> hacks and delete sem_getcount (parisc, frv) and sema_count (arm) as they
> are unused.

True.
