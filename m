Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317462AbSFHWmY>; Sat, 8 Jun 2002 18:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317463AbSFHWmX>; Sat, 8 Jun 2002 18:42:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30992 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317462AbSFHWmW>; Sat, 8 Jun 2002 18:42:22 -0400
Date: Sat, 8 Jun 2002 15:42:59 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org, <frankeh@watson.ibm.com>,
        <alan@lxorguk.ukuu.org.uk>, <viro@math.psu.edu>
Subject: Re: [PATCH] Futex Asynchronous Interface
In-Reply-To: <20020607190650.57f25467.rusty@rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0206081531550.11630-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 Jun 2002, Rusty Russell wrote:
>
> Linus, Al, is there an easier way to do this?  I stole this from sockfs,
> but I balked at another 50 lines for a proper inode creation, so I just use
> the same dentry and inode over and over.

There's nothing inherently wrong with re-using the inode and dentry -
that's what /dev/futex would do too, of course.

> It's still an awful lot of irrelevant code: what can I cut?

I don't think it's a matter of cutting, as much as possibly a matter of
tryign to share some common code. pipefs, sockfs and now this: they all do
pretty much exactly the same thing, and there is nothing that says that
they should have separate super_operations, for example, since they are
all identical.

And once you have the same super_operations, you really have the same
"fill_super" functions too. The only thing that separates these
superblocks is the root name, so that /proc gets nice output. So it should
be fine to just have

	sb = create_anon_fs("futex");

and share all of the setup code across futex/pipes/sockfs.

Which still leaves you with the

	get_unused_fd();
	get_empty_filp();
	filp->f_dentry = dget(sb->s_root);
	.. fill it ..
	fd_install(fd, filp);

but by then we're talking single lines of overhead.

		Linus

