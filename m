Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316113AbSFPK5I>; Sun, 16 Jun 2002 06:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316127AbSFPK5H>; Sun, 16 Jun 2002 06:57:07 -0400
Received: from hera.cwi.nl ([192.16.191.8]:31639 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S316113AbSFPK5H>;
	Sun, 16 Jun 2002 06:57:07 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 16 Jun 2002 12:56:36 +0200 (MEST)
Message-Id: <UTC200206161056.g5GAuaS29554.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    >     > > Wrong.  That breaks for anything with ->follow_link() that
    >     > > can't be expressed as a single lookup on some path.
    >
    > in-tree systems give no problems; procfs is trivially handled:
    >
    >     err = dentry->d_inode->i_op->prepare_follow_link(dentry, nd, &link, &page);
    >     if (nd->flags & FOLLOW_DONE)
    >         nd->flags &= ~FOLLOW_DONE;
    >     else if (err = 0)
    >         err = __vfs_follow_link(nd, link);
    >     if (page) {
    >         kunmap(page);
    >         page_cache_release(page);
    >     }
    >     ...
    >     return err;
    > }
    > 
    > You must come with more serious objections before I believe your
    > claim that this doesn't work.

    First of all, _that_ is still recursive.  And it's not easy to deal with -
    you need to release the object holding the link body (BTW, that can
    be almost anything - page, inode, kmalloc'ed area, vmalloc'ed area, etc.)
    after __vfs_follow_link() is done.  And that means (at the very least)
    a stack of such objects, along with the information about their nature.

Yes. But in the current tree only the cases page and kmalloc'ed area
occur, and it is easy to transform the single occurrence of kmalloc'ed area
(jffs2) into a use of page.

    Which exposes a lot of information about the filesystem guts.

So, nothing about the filesystem guts is needed, the above code
says it all: when we are done, release page.

Anyway, you cleverly change the topic. First it was impossible and wrong.
Now it is ugly. I even maintain that the new code could be more
beautiful than the old code. And more compact.

The typical prepare_follow_link routine would be

int page_prepare_follow_link(struct dentry *dentry, struct nameidata *nd,
                             const char **llink, struct page **ppage)
{
        *llink = page_getlink(dentry, ppage);
        return 0;
}

Andries
