Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932584AbWCIMTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbWCIMTk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 07:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWCIMTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 07:19:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55249 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932584AbWCIMTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 07:19:39 -0500
Date: Thu, 9 Mar 2006 04:14:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jan Kara <jack@suse.cz>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: Bug fixes in -mm that should go into 2.6.16
Message-Id: <20060309041422.03cf4577.akpm@osdl.org>
In-Reply-To: <20060309115919.GB11524@atrey.karlin.mff.cuni.cz>
References: <20060308220208.GP4006@stusta.de>
	<20060308151845.30b8d672.akpm@osdl.org>
	<20060309115919.GB11524@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara <jack@suse.cz> wrote:
>
> > Adrian Bunk <bunk@stusta.de> wrote:
> > >
> > > Hi Andrew,
> > > 
> > > the following two patches in -mm should IMHO go into 2.6.16:
> > >   fix-oops-in-invalidate_dquots.patch
> > 
> > Maybe.  I worry about the intrusiveness versus probability-of-oops.
>   Yes, I guess the oops is not very probable - at least the bug was
> there unnoticed for several months...
>   BTW Recently I found out in discussion with Neil Brown that probably
> there is a similar problem with umount. The problem is that an inode in
> both generic_delete_inode() and generic_forget_inode() is removed from
> i_sb_list and i_list. Then I_FREEING is set and inode_lock released. Now
> if umount is called, I did not find anything that protects
> invalidate_inodes() from missing those pending inodes. So it could
> happen that we succeed with unmounting the filesystem but there are
> still some live inodes... So we should either leave those inodes in some
> superblock list where invalidate_inodes() can reach them or we should
> implement some other measure that blocks umount from proceeding before
> all those pending inodes are really processed (one idea was some
> active_inode counter in the superblock). And if we solve this problem
> for umount, then quota can possibly use similar approach for handling
> the problem with invalidate_dquots().
>   Any ideas?

Could be - I guess the first step would be seeing if it can be triggered.

One option might be to take sb->s_umount for reading while those inodes are
adrift.

