Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVCXCBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVCXCBT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 21:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262981AbVCXCBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 21:01:19 -0500
Received: from fire.osdl.org ([65.172.181.4]:28062 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261330AbVCXCBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 21:01:10 -0500
Date: Wed, 23 Mar 2005 18:00:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: mbligh@aracnet.com, aebr@win.tue.nl, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: OOM problems on 2.6.12-rc1 with many fsx tests
Message-Id: <20050323180031.209c988f.akpm@osdl.org>
In-Reply-To: <20050324014948.GE14202@opteron.random>
References: <20050316003134.GY7699@opteron.random>
	<20050316040435.39533675.akpm@osdl.org>
	<20050316183701.GB21597@opteron.random>
	<1111607584.5786.55.camel@localhost.localdomain>
	<20050323144953.288a5baf.akpm@osdl.org>
	<17250000.1111619602@flay>
	<20050323152055.6fc8c198.akpm@osdl.org>
	<20050323232656.GA5704@pclin040.win.tue.nl>
	<25760000.1111620606@flay>
	<20050323154232.376f977f.akpm@osdl.org>
	<20050324014948.GE14202@opteron.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Wed, Mar 23, 2005 at 03:42:32PM -0800, Andrew Morton wrote:
> > I'm suspecting here that we simply leaked a refcount on every darn
> > pagecache page in the machine.  Note how mapped memory has shrunk down to
> > less than a megabyte and everything which can be swapped out has been
> > swapped out.
> > 
> > If so, then oom-killing everything in the world is pretty inevitable.
> 
> Agreed, it looks like a memleak of a page_count (while mapcount is fine).
> 
> I would suggest looking after pages part of pagecache (i.e.
> page->mapcount not null) that have a mapcount of 0 and a page_count > 1,
> almost all of them should be like that during the memleak, and almost
> none should be like that before the memleak.
> 
> This seems unrelated to the bug that started the thread that was clearly
> a slab shrinking issue and not a pagecache memleak.
> 

The vmscan.c changes in -rc1 look harmless enough.  That's assuming that
2.6.11 doesn't have the bug.

btw, that new orphanned-page handling code has a printk in it, and nobody
has reported it coming out yet...

