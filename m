Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267261AbTGHMUG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 08:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267262AbTGHMUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 08:20:05 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:7053 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S267261AbTGHMTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 08:19:53 -0400
Date: Tue, 8 Jul 2003 13:34:21 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Eric Varsanyi <e0216@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll vs stdin/stdout
Message-ID: <20030708123421.GB14827@mail.jlokier.co.uk>
References: <20030707154823.GA8696@srv.foo21.com> <Pine.LNX.4.55.0307071153270.4704@bigblue.dev.mcafeelabs.com> <20030707194736.GF9328@srv.foo21.com> <Pine.LNX.4.55.0307071511550.4704@bigblue.dev.mcafeelabs.com> <Pine.LNX.4.55.0307071624550.4704@bigblue.dev.mcafeelabs.com> <20030708003247.GB12127@mail.jlokier.co.uk> <Pine.LNX.4.55.0307071730190.3524@bigblue.dev.mcafeelabs.com> <20030708005226.GD12127@mail.jlokier.co.uk> <Pine.LNX.4.55.0307071802360.3531@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0307071802360.3531@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> >    2. When process A sends an fd to process B, the events will appear
> >       in process B _iff_ the fd number in B happens to be the same
> >       value as in process A.  (Without your patch, the events will always
> >       appear in process B).
> >
> >       Furthermore, when process B dups the fd or passes it elsewhere,
> >       events will appear if the new fd happens to be the same as the
> >       original fd number in A.
> >
> >       The only correct application code in this case is to use
> >       EPOLL_CTL_DEL in A and EPOLL_CTL_ADD in B, although it is
> >       confusing because you'll have programs which _sometimes_ work
> >       without that.
> 
> This is false.

Actually it's true :)

> Is like saying that :
> [...]
> is a memory leak ;)

Well, yeah :)

You'll have to document this loud and clear: anyone who closes, dup2s
over or passed an epoll-activated file descriptor _must_ use
EPOLL_CTL_DEL first, otherwise heisenbugs may eventually follow.

> > I guess what I'm saying is that hashing on fd number is quite simply
> > wrong.  The fundamental object is the file *, that's how its meant to be.
> 
> The architecture is all based on the file*, it is there that events shows
> up. The (file*, fd) key is a constraint.

Unfortunately I just thought of a real problem :(

What happens when process A sends (or forks) a dup of its fd 3 to
process B which also has it as fd 3, and both processes use epoll on
it?  (This is a fairly common scenario, to have one process/thread
reading and the other writing a tty or socket).  The two processes
will clash because they have the same (file *, fd) pair, yet there is
no way for them to know they are clashing.

With current epoll code this is a problem already, because keying on
(file *) alone is not enough.  Unfortunately (file *,fd) key doesn't
fix this one.

-- Jamie
