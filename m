Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317972AbSFSSzX>; Wed, 19 Jun 2002 14:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317976AbSFSSzW>; Wed, 19 Jun 2002 14:55:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9484 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317972AbSFSSzV>; Wed, 19 Jun 2002 14:55:21 -0400
Date: Wed, 19 Jun 2002 11:55:23 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Daniel Phillips <phillips@bonn-fries.net>, <Andries.Brouwer@cwi.nl>,
       Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH+discussion] symlink recursion
In-Reply-To: <20020619181814.GA16548@win.tue.nl>
Message-ID: <Pine.LNX.4.44.0206191136200.2889-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Jun 2002, Andries Brouwer wrote:
>
> The routine link_path_walk() in namei.c will call do_follow_link()
> in case of a symlink, and this routine will call
> 	dentry->d_inode->i_op->follow_link(),
> say, nfs_follow_link(), which calls vfs_follow_link(),
> which calls link_path_walk(), etc.

Yes. But did you look at the stack frames of those things? It's something
like 16 bytes for ext2_follow_link (it just calls directly back to the VFS
layer), 20 bytes for vfs_follow_link(), and 56 for link_path_walk.

(yeah, it obviously isn't just 64 bytes any more, it's 92 bytes. Maybe I
just counted wrong last time. Or maybe link_path_walk is different
enough).

Oh, and I think the actual ->follow_link pushes 8 bytes of arguments.

So doing a recursion 5 deep is ~500 bytes of stack space.

That was my point: the _only_ difference between "explicit recursion" and
"recurse by hand" is where and how those intermediate bytes are allocated.
There is nothing inherently "evil" in letting the compiler do it for you.

And as you found out yourself, a recursion limit of 5 is actually a lot
more than people normally use.

But hey, guys, if you want to linearize the recursion, I'm easily swayed
by numbers. I've actually done the numbers for stack usage (exactly
because I worried about it some time ago), and I don't worry too much
about that number. I also don't worry about the number "5", simply because
I don't think I've _ever_ gotten a complaint about it that I remember.

But there are other numbers, like performance (sometimes linearizing
recursion loses, sometimes it wins), or somebody doing the math on ia-64
and showing that the 100 bytes/level on x86 is actually more like 2kB on
ia-64 and totally unacceptable.

But trying to sell this thing to me as a "recursion is evil and must be
stamped out" just doesn't work.

			Linus

