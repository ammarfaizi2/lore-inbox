Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbVI3Pgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbVI3Pgv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 11:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbVI3Pgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 11:36:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56004 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030336AbVI3Pgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 11:36:50 -0400
Date: Fri, 30 Sep 2005 08:36:30 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>, fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: truncate(2) sometimes updates ctime and sometimes ctime and
 mtime!
In-Reply-To: <1128092687.5715.12.camel@imp.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0509300823160.3378@g5.osdl.org>
References: <1128092687.5715.12.camel@imp.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Sep 2005, Anton Altaparmakov wrote:
> 
> There is an inconsistency in the way truncate works which was introduced
> (relatively) recently.
> 
> fs/open.c::sys_truncate
>   -> do_sys_truncate
>     -> do_truncate does:
> 
>         newattrs.ia_size = length;
>         newattrs.ia_valid = ATTR_SIZE | ATTR_CTIME;
> 
>         down(&dentry->d_inode->i_sem);
>         err = notify_change(dentry, &newattrs);
>         up(&dentry->d_inode->i_sem);
> 
> This changes the ctime only.

Hmm.. That looks wrong, partly because I don't think it should even set 
ATTR_CTIME _either_. However, I don't see any recent changes to that code, 
so it must have been logn for a long time. That line in do_truncate() has 
been like that since at _least_ 2002.

So what changed to make you notice?

The _code_ actually expects the low-level filesystem to just do it when it 
does the actual truncate itself. That's certainly what ext3 does, for 
example.

A comment or two to that effect might be useful, though.

In other words: some attributes are "implicit". For example, mtime is 
supposed to be set automatically by the filesystem whenever it sees a 
write. The VFS layer will _not_ do a "inode state notify" event for that. 

The same is true of truncation.

But I agree that it's inconsistent. Anybody have any deep opinions?

		Linus
