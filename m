Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262542AbVDYGA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbVDYGA7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 02:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbVDYGA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 02:00:59 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:36250 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262540AbVDYGAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 02:00:47 -0400
To: jamie@shareable.org
CC: viro@parcelfarce.linux.theplanet.co.uk, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-reply-to: <20050424213822.GB9304@mail.shareable.org> (message from Jamie
	Lokier on Sun, 24 Apr 2005 22:38:22 +0100)
Subject: Re: [PATCH] private mounts
References: <E1DPnOn-0000T0-00@localhost> <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <20050424213822.GB9304@mail.shareable.org>
Message-Id: <E1DPwdo-0006xF-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 25 Apr 2005 08:00:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > ... is the same as for the same question with "set of mounts" replaced
> > with "environment variables".
> 
> Not quite.
> 
> After changing environment variables in .profile, you can copy them to
> other shells using ". ~/.profile".
> 
> There is no analogous mechanism to copy namespaces.
> 
> I agree with you that Miklos' patch is not the right way to do it.

I'm not sure that it is either.  But, see bellow...

> Much better is the proposal to make namespaces first-class objects,
> that can be switched to.  Then users can choose to have themselves a
> namespace containing their private mounts, if they want it, with
> login/libpam or even a program run from .profile switching into it.

It would be good if it could be done just in libpam.  But that would
require every libpam user to call into it after the fork() or
whatever, so unshare() and join_namespace() don't mess up the server
running environment.

If not, then it would mean modifying numerous programs, having these
modifications integrated, then having distributions pick up the
changes, etc.  I would imagine quite a long cycle for this to be
acutally useful.

> While users can be allowed to create their own namespaces which affect
> the path traversal of their _own_ directories, it's important that the
> existence of such namespaces cannot affect path traversal of other
> directories such as /etc, or /autofs/whatever - and that creation of
> namespaces by a user cannot prevent the unmounting of a non-user
> filesystem either.
> 
> The way to do that is shared subtrees, or something along those lines.

Yes, but we would be achieving essentially the same as my patch, just
with more complexity.  And my patch achieves what FUSE does in 2 lines
of code, namely hide the mount from other users by returning -EACCESS
in case fsuid does not mach the mount owner.

I aggree that your solution is more flexible, but it's also hugely
more complex.  If somebody want's to implement it, fine.  But don't
expect me to do it, unless some company hires my for fs development
(hint, hint ;)

Thanks,
Miklos
