Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317856AbSFNAZx>; Thu, 13 Jun 2002 20:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317858AbSFNAZw>; Thu, 13 Jun 2002 20:25:52 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:38577 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317856AbSFNAZv>;
	Thu, 13 Jun 2002 20:25:51 -0400
Date: Thu, 13 Jun 2002 20:25:50 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Dawson Engler <engler@csl.Stanford.EDU>
cc: Linus Torvalds <torvalds@transmeta.com>, Andi Kleen <ak@muc.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
In-Reply-To: <200206132150.OAA14200@csl.Stanford.EDU>
Message-ID: <Pine.GSO.4.21.0206131953270.21548-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Jun 2002, Dawson Engler wrote:

> > It has to be known to checker.  Explicitly, since
> > 	a) automatically deducing it is not realistic
> > 	b) cutting off the stuff behind that loop will cut off a _lot_ of
> > things - both in filesystems and in VFS (and in block layer, while we are
> > at it).
> 
> We're all about jamming system specific information into the checking
> extensions.  It's usually just a few if statements.  So to be clear: we
> can simply assume that the loop 
>    link_path_walk
> 	->do_follow_link
> 		->foofs_follow_link
> 			->vfs_follow_link
> 				->link_path_walk
> can happen exactly 5 times?

static inline int do_follow_link(struct dentry *dentry, struct nameidata *nd)
{   
        int err;
        if (current->link_count >= 5)
                goto loop;
...
        current->link_count++;
...
        err = dentry->d_inode->i_op->follow_link(dentry, nd);
        current->link_count--;
        return err;
loop:
        path_release(nd);
        return -ELOOP;
}

->link_count is modified only by the code above.

INIT_TASK has zero link_count.

new task inherits ->link_count of parent at the moment of do_fork()

It means that:
	* at any moment ->link_count is between 0 and 5
	* at any moment the call chain contains at most 6 instances of
do_follow_link()
	* if there are 6 such instances then the last of them is either the
last element of chain or it is followed by path_release().

	BTW, it shows a potential subtle problem - if we ever call do_fork()
while resolving a symlink (the only way that can happen is kernel_thread()
being called in process of symlink resolution) we will get a kernel thread
with limit for nested symlinks lower than 5.  Proposed fix (both 2.4 and 2.5):

ed kernel/fork.c <<EOF
/swappable/a
        p->link_count = 0;
.
w
EOF

Linus?

