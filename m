Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315762AbSFPAsf>; Sat, 15 Jun 2002 20:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315779AbSFPAse>; Sat, 15 Jun 2002 20:48:34 -0400
Received: from hera.cwi.nl ([192.16.191.8]:57045 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S315762AbSFPAse>;
	Sat, 15 Jun 2002 20:48:34 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 16 Jun 2002 02:48:34 +0200 (MEST)
Message-Id: <UTC200206160048.g5G0mYg11216.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not realistic - we have a recursion through the ->follow_link(), and
> a lot of stuff can be called from ->follow_link().  We _do_ have a
> limit on depth of recursion here, but it won't be fun to deal with.

It would not be impossibly difficult to remove the recursion altogether.

As far as I can see, the cycle essentially is
link_path_walk -> do_follow_link -> page_follow_link -> vfs_follow_link ->.

Now page_follow_link does very little after the vfs_follow_link call,
and the same holds for all other filesystem types.
Either foo_follow_link ends in
	return vfs_follow_link(..);
or it does
	err = vfs_follow_link(..);
	if (something_to_free)
		free_it;
	return err;

With a little bit of polishing we could cut off all foo_follow_link
routines just before the vfs_follow_link call and make foo_follow_link
return the arguments it was going to call vfs_follow_link with.

Then of course the something_to_free must be freed by the caller.
What is it?

page_follow_link and nfs_follow_link have

        if (page) {
                kunmap(page);
                page_cache_release(page);
        }

jffs2_follow_link has

	kfree(buf);

If that is done, there is no stack frame for foo_follow_link,
and in principle the three of link_path_walk, do_follow_link,
vfs_follow_link could be single routine. Today do_follow_link
is already inline.

Now symlink resolution can be entirely iterative.
The routine that does this works on a linked list of things
still to consider, and always works on the tail of the list.

Quite a lot of restructuring would be required to produce
a readable source in this style, but it doesn't look too difficult.
The result might even be more efficient.

Andries
