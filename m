Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289178AbSAGPQ3>; Mon, 7 Jan 2002 10:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289225AbSAGPQS>; Mon, 7 Jan 2002 10:16:18 -0500
Received: from dsl-213-023-038-159.arcor-ip.net ([213.23.38.159]:2575 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289178AbSAGPQC>;
	Mon, 7 Jan 2002 10:16:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>, torvalds@transmeta.com,
        viro@math.psu.edu
Subject: Re: PATCH 2.5.2.9: ext2 unbork fs.h (part 1/7)
Date: Mon, 7 Jan 2002 16:19:01 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
In-Reply-To: <20020107132121.241311F6A@gtf.org>
In-Reply-To: <20020107132121.241311F6A@gtf.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16NbYF-0001Qq-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 7, 2002 02:21 pm, Jeff Garzik wrote:
> Here's my idea for the solution.  Each patch in the series has been
> tested individually and can be applied individually, as long as all
> preceding patches are applied.  (ie. to apply and testing patch N,
> patches 1 through N-1 must also be applied)  The light testing consisted
> of unpacking, catting, and removing kernel trees, along with a fillmem
> runs to ensure that slab caches are properly purged.  An fsck was forced
> after each run of tests.
> 
> This is the first of seven steps in the Make Fs.h Happy program.
> It borrows direction from Daniel and Linus as well as my own.
> 
> patch1 (this patch): use accessor function ext2_i to access inode->u.ext2_i
> 	The rest of the patches borrows ideas but no code.  This patch
> 	is the only exception: it borrows substantially Daniel's ext2_i
> 	patch.
> patch2: use accessor function ext2_sb to access sb->u.ext2_sb
> patch3: dynamically allocate sb->u.ext2_sbp
> patch4: dynamically allocate inode->u.ext2_ip
> patch5: move include/linux/ext2*.h to fs/ext2
> 
> 	at this point we've reached the limits of how far the current
> 	VFS API will go.  inode and superblock fs-level private info
> 	is dynamically allocated.
> 
> patch6: add sb->s_op->{alloc,destroy}_inode to VFS API
> patch7: implement ext2 use of s_op->{alloc,destroy}

The two main problems I see with this are:

  - If a filesystem doesn't want to use genericp_ip/sbp then fs.h has
    to know about it.  Why should fs.h know about every filesystem in
    the world?

  - You are dreferencing a pointer, and have two allocations for every
    inode instead of one.

It's not horrible, it's just not optimal.

Moving the ext2 headers from include/linux to fs/ext2 is an interesting
feature of your patch, though it isn't essential to the idea you're
presenting.  But is there a good reason why ext2_fs_i.h and ext2_fs_sb.h
should remain separate from ext2_fs.h?  It looks like gratuitous
modularity to me.

Minor nit:

        if (!inode->u.ext2_ip)
                BUG();

You don't have to do this, if the pointer is null you will get a perfectly
fine oops.

--
Daniel
