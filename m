Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267333AbUIJJN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267333AbUIJJN7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 05:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267334AbUIJJN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 05:13:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:39110 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267333AbUIJJN4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 05:13:56 -0400
Date: Fri, 10 Sep 2004 02:11:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: Q: bugs in generic_forget_inode()?
Message-Id: <20040910021132.44d6c812.akpm@osdl.org>
In-Reply-To: <41416E1A.5050905@sw.ru>
References: <413C52E2.10809@sw.ru>
	<20040906123534.3487839e.akpm@osdl.org>
	<41416E1A.5050905@sw.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> wrote:
>
> Andrew Morton wrote:
> > Kirill Korotaev <dev@sw.ru> wrote:
> > 
> >>Hello,
> >>
> >>1. I found that generic_forget_inode() calls write_inode_now() dropping 
> >>inode_lock and destroys inode after that. The problem is that 
> >>write_inode_now() can sleep and during this sleep someone can find inode 
> >>in the hash, w/o I_FREEING state and with i_count = 0.
> > 
> > The filesystem is in the process of being unmounted (!MS_ACTIVE).  So the
> > question is: who is doing inode lookups against a soon-to-be-defunct
> > filesystem?
> 
> Yup, I'm studing this issue.

Do you mean to say that you are observing the above scenario with an
unmodified kernel.org filesystem?  Which one?

I suggest you add a

	BUG_ON(!(inode->i_sb->s_flags & MS_ACTIVE));

in the hash lookup code.

> But while looking at code I found this interesting place:
> 
> __writeback_single_inode()
> {
>          while (inode->i_state & I_LOCK) {
>                  __iget(inode);			<<<<<<
>                  spin_unlock(&inode_lock);
>                  __wait_on_inode(inode);
>                  iput(inode);			<<<<<<
>                  spin_lock(&inode_lock);
>         }
> 	return __sync_single_inode(inode, wbc); <<<<<<
> }
> 
> the problem here is iget/iput.
> 
> There are 2 possible cases:
> 1. all callers of this function do hold reference on inode, then 
> iget/iput is unneeded.
> 2. if 1) is incorrect then it's a bug, since inode is used after iput.
> 
> This place looks really ugly, or I don't understand something here?

You're right - the iget/iput is not needed.  The only caller here who does
not already have a ref on the inode is pdflush, and we already did an
__iget on that callpath.

