Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265749AbUGMS6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265749AbUGMS6h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 14:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265750AbUGMS6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 14:58:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:48046 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265749AbUGMS6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 14:58:35 -0400
Date: Tue, 13 Jul 2004 11:57:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix inode state corruption (2.6.8-rc1-bk1)
Message-Id: <20040713115716.4db55d72.akpm@osdl.org>
In-Reply-To: <E1BkNI0-0007j5-00@dorka.pomaz.szeredi.hu>
References: <E1BkNI0-0007j5-00@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> This patch fixes a hard-to-trigger condition, where the inode is on
>  the inode_in_use list while it's state is dirty.  In this state dirty
>  pages are not written back in sync() or from kupdate, only from direct
>  page reclaim.  And this causes a livelock in balance_dirty_pages after
>  a while.

How ghastly.

Why did you make the list movement conditional on non-zero `wait'?

It would be equivalent to remove these lines from __mark_inode_dirty():

		/*
		 * If the inode is locked, just update its dirty state. 
		 * The unlocker will place the inode on the appropriate
		 * superblock list, based upon its state.
		 */
		if (inode->i_state & I_LOCK)
			goto out;

but probably not so good, because that could cause other tasks to come
around and wait on this inode while it is under writeout instead of writing
back different inodes.

