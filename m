Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316213AbSFPNN7>; Sun, 16 Jun 2002 09:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316214AbSFPNN6>; Sun, 16 Jun 2002 09:13:58 -0400
Received: from hera.cwi.nl ([192.16.191.8]:18855 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S316213AbSFPNN5>;
	Sun, 16 Jun 2002 09:13:57 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 16 Jun 2002 15:13:25 +0200 (MEST)
Message-Id: <UTC200206161313.g5GDDPX00513.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    >     First of all, _that_ is still recursive.  And it's not easy
    >     to deal with - you need to release the object holding the link body
    >     (BTW, that can be almost anything - page, inode, kmalloc'ed area,
    >     vmalloc'ed area, etc.) after __vfs_follow_link() is done.
    >     And that means (at the very least) a stack of such objects,
    >     along with the information about their nature.
    > 
    > Yes. But in the current tree only the cases page and kmalloc'ed area
    > occur, and it is easy to transform the single occurrence of kmalloc'ed
    > areas (jffs2) into a use of page.

    That's simply not true.  Of the top of my head - /proc/self.

Ah, yes - that has the string on stack.
That changes my inventory into: all callers except two use a page.
One (jffs2) uses a kmalloced area. One (/proc/self) has its data
on the stack.

    Look, it's getting ridiculous.

That is a counterproductive reply.
You say "I tried to improve Linux three years ago and failed,
so you can forget it - no improvement is possible".

Of course improvement is possible. It always is.

Now we find that it is possible to change recursive symlink handling
into iterative handling.  That is good, because the current limit of
5 is really a bit low. It bites every now and then.

Remains the question whether it can be done in a beautiful way.

Let us try. The basic object is a struct link_work that has dentry,
nameidata, link, page and flags and a pointer to the next such struct.
This is a reverse linked list: the thing we work on is in front,
the tail of the list is the thing we originally started to resolve.

The routine that does all this is

int do_link_work(struct link_work **lw) {
	int err = 0;

	while((*lw)->link) {
		if (err == 0)
			err = do_link_item(lw);
		else
			do_bad_link_item(lw);
	}
	return err;
}

where do_link_item() has as duty to handle the next part
of the pathname. That diminishes the work left, unless
that next part was a symlink, in which case resolution
of that is prepended to the list of work we have to do.
If something is wrong, do_bad_link_item() only releases resources.

Looks like a nice and clean setup.
Remains the question how to release the resources allocated
by the filesystems in prepare_follow_link().
There are various possibilities. General ones: the filesystem
provides a callback. Restricted ones: we ask the filesystem
to have one page as the only resource. Kludgy ones: we allow
some explicit short list, like page or kmalloc. Probably others.

But maybe you are not interested in thinking about such things.
You did it already.

Andries
