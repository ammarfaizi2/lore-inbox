Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276688AbRJUUPw>; Sun, 21 Oct 2001 16:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276709AbRJUUPd>; Sun, 21 Oct 2001 16:15:33 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:30982 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S276688AbRJUUPY>; Sun, 21 Oct 2001 16:15:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
Subject: Re: Kernel Compile in tmpfs crumples in 2.4.12 w/epoll patch
Date: Sun, 21 Oct 2001 22:15:03 +0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <016a01c15831$ef51c5c0$5c044589@legato.com> <20011021093547.A24227@work.bitmover.com> <9qv1to$ase$1@penguin.transmeta.com>
In-Reply-To: <9qv1to$ase$1@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011021201554Z16069-4005+1095@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 21, 2001 07:50 pm, Linus Torvalds wrote:
> In article <20011021093547.A24227@work.bitmover.com>,
> Larry McVoy  <lm@bitmover.com> wrote:
> >
> >One of the engineers here has also seen this.  The root cause is that
> >readdir() is returning a file multiple times.  We've seen it on tmpfs.
> 
> Yes.  "tmpfs" will consider the position in the dentry lists to be the
> "offset" in the file, and if you remove files from the directory as you
> do a readdir(), you can get the same file twice (or you can fail to see
> files).
> 
> If somebody has a good suggestion for what could be used as a reasonably
> efficient "cookie" for virtual filesystems like tmpfs, speak up.  In the
> meantime, one way to _mostly_ avoid this should be to give a big buffer
> to readdir(), so that you end up getting all entries in one go (which
> will be protected by the semaphore inside the kernel), rather than
> having to do multiple readdir() calls. 

Assuming the "cookie" is an ordinal position in some predictable traversal of 
a directory, e.g., storage order, then the problem can be resolved with some 
cooperation from create and delete.  For a create, the cookie should be 
incremented if the position of the create is before the cookie.  Likewise, 
for a delete, the cookie should be decremented if the delete is before the 
cookie.

> (But we don't have an EOF cookie either, so..)
> 
> The logic, in case people care is just "dcache_readdir()" in
> fs/readdir.c, and that logic is used for all virtual filesystems, so
> fixing that will fix not just tmpfs..
> 
> Now, that said it might be worthwhile to be more robust on an
> application layer by simply just sorting the directory.  As you point
> out, NFS to some servers can have the same issues, for very similar
> reasons - on many filesystems a directory "position" is not a stable
> thing if you remove or add files at the same time.
> 
> So I would consider the current tmpfs behaviour a beauty wart and
> something to be fixed, but at the same time I also think you're
> depending on behaviour that is not in any way guaranteed, and I would
> argue that the tmpfs behaviour (while bad) is not actually strictly a
> bug but more a quality-of-implementation issue. 
> 
> 			Linus

--
Daniel
