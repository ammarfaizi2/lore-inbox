Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317966AbSFSSSQ>; Wed, 19 Jun 2002 14:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317967AbSFSSSP>; Wed, 19 Jun 2002 14:18:15 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:2058 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S317966AbSFSSSO>;
	Wed, 19 Jun 2002 14:18:14 -0400
Date: Wed, 19 Jun 2002 20:18:14 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>, Andries.Brouwer@cwi.nl,
       Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH+discussion] symlink recursion
Message-ID: <20020619181814.GA16548@win.tue.nl>
References: <E17KghU-0000oC-00@starship> <Pine.LNX.4.44.0206190900560.2053-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0206190900560.2053-100000@home.transmeta.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2002 at 09:05:53AM -0700, Linus Torvalds wrote:

> Actually, the trip to the filesystem itself is not recursive. We only have
> one lookup _active_ at a time, so the stack depth is fairly well bounded.

In your previous letter you wanted to play semantical tricks with the
word recursive, even though you understood perfectly well what I meant
with "nonrecursive" (and you yourself used the same terminology in older
posts).

Now I hesitate whether I should react to the above statement.
Maybe this time there are semantical tricks with the word active,
but it sounds a bit as if you misunderstand the situation.

Let me state the facts instead of worrying about semantics.

The routine link_path_walk() in namei.c will call do_follow_link()
in case of a symlink, and this routine will call
	dentry->d_inode->i_op->follow_link(),
say, nfs_follow_link(), which calls vfs_follow_link(),
which calls link_path_walk(), etc.

You see that in a stack of N invocations, there will also
be N stack frames of foofs_follow_link().
So, yes, in the way I use recursive, routines like nfs_follow_link()
are indeed recursive: they end up calling themselves.

Last Sunday or so I gave a demo patch that takes the filesystems
out of the loop. Then symlink resolution is still recursive but
there will be at most one invocation of foofs_follow_link().

Yesterday I showed that it is also easy to avoid recursion altogether.

These are independent stages, and one might consider doing one
and not the other.

Andries


[Now that I write anyway, let me address others:
(i) The "depth" that is limited by 5 is the number of symlinks
that is being resolved at the same time; there is a much larger
limit (40) on the total number of symlinks resolved during a
path lookup.
(ii) 5 sounds like a very small number, but a Google search turns
up very few people who have problems. It would be nice to be able
to say "echo 32 > /proc/sys/fs/max-symlink-depth" to get a different
limit, and with the present implementation that is impossible,
but the fact remains that it is not a real problem that many people
have problems with. This is more a scalability problem.]
