Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264949AbTGHAh7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 20:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264980AbTGHAh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 20:37:59 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:55180 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S264949AbTGHAh6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 20:37:58 -0400
Date: Tue, 8 Jul 2003 01:52:26 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Eric Varsanyi <e0216@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll vs stdin/stdout
Message-ID: <20030708005226.GD12127@mail.jlokier.co.uk>
References: <20030707154823.GA8696@srv.foo21.com> <Pine.LNX.4.55.0307071153270.4704@bigblue.dev.mcafeelabs.com> <20030707194736.GF9328@srv.foo21.com> <Pine.LNX.4.55.0307071511550.4704@bigblue.dev.mcafeelabs.com> <Pine.LNX.4.55.0307071624550.4704@bigblue.dev.mcafeelabs.com> <20030708003247.GB12127@mail.jlokier.co.uk> <Pine.LNX.4.55.0307071730190.3524@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0307071730190.3524@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> > Does this correctly free everything when you:
> >
> > 	declare interest in some events on fd 3
> > 	dup2(3,4)
> > 	close(3)
> > ?
> 
> Neither the old and the new code does it. Cleanup is done either with an
> EPOLL_CTL_DEL (explicitly) or with the file* removal (__fput()). In you
> case when you close(4) if you do not do it explicitly.

The old code didn't need to do it, because the events were registered
for all the fd values pointing to a single file *.  That's cool -
that's exactly what anyone would expect.  The point of dup2() is that
the fds are equivalent, and share state (such as seek pointer).

Now you have two strange (IMHO unclean) behaviours, that an
application programmer needs to be aware of:

   1. Duplicate fds don't share registered event state.

Theoretically this could break an existing app, but I doubt if any
depend on this behaviour at present.  This is not likely to confuse anyone, as long as it is documented.

   2. When process A sends an fd to process B, the events will appear
      in process B _iff_ the fd number in B happens to be the same
      value as in process A.  (Without your patch, the events will always
      appear in process B).

      Furthermore, when process B dups the fd or passes it elsewhere,
      events will appear if the new fd happens to be the same as the
      original fd number in A.

      The only correct application code in this case is to use
      EPOLL_CTL_DEL in A and EPOLL_CTL_ADD in B, although it is
      confusing because you'll have programs which _sometimes_ work
      without that.

Oh, and:

   3. It's almost a memory leak.  Not quite because it's cleaned up
      eventually.  But it looks and feels just like one.

I guess what I'm saying is that hashing on fd number is quite simply
wrong.  The fundamental object is the file *, that's how its meant to be.
:)

-- Jamie
