Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbUBZVY6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 16:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbUBZVY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 16:24:58 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:393 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261208AbUBZVY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 16:24:56 -0500
Date: Thu, 26 Feb 2004 21:25:01 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Daniel McNeil <daniel@osdl.org>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sync_sb_inodes sync hang
In-Reply-To: <1077822584.1956.285.camel@ibm-c.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0402262116390.21063-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Feb 2004, Daniel McNeil wrote:
> 
> I tried the while loop below on a UP without PREEMPT and it has
> not hung running 2.6.3-mm3 without your patch.
> 
> How long does it take to hang?

About 2 seconds.

> Which file system?

ext2.

(Of course my patch was very stupid one, merely allowing the
busyloop to be broken into and eventually brought to an end:
as I realized just after sending it, but knew I could rely
on Andrew to see through its stupidity!)

Hugh

> On Tue, 2004-02-24 at 08:52, Hugh Dickins wrote:
> > 2.6.3-mm UP without PREEMPT easily hangs looping around pdflush's
> > sync_sb_inodes, failing the down_read_trylock in do_writepages,
> > but giving the concurrent sync no chance to complete: just try
> > while : ; do echo $SECONDS; sync; cp /etc/termcap .; done
> > 
> > I think sync_sb_inodes is the only loop vulnerable to that
> > change in do_writepages, so site the cond_resched() here.
> > 
> > Hugh
> > 
> > --- 2.6.3-mm3/fs/fs-writeback.c	2004-02-23 12:51:49.000000000 +0000
> > +++ linux/fs/fs-writeback.c	2004-02-24 16:14:49.000000000 +0000
> > @@ -326,6 +326,7 @@ sync_sb_inodes(struct super_block *sb, s
> >  			writeback_release(bdi);
> >  		spin_unlock(&inode_lock);
> >  		iput(inode);
> > +		cond_resched();
> >  		spin_lock(&inode_lock);
> >  		if (wbc->nr_to_write <= 0)
> >  			break;

