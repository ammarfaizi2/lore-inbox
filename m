Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272232AbRIEQge>; Wed, 5 Sep 2001 12:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272225AbRIEQgX>; Wed, 5 Sep 2001 12:36:23 -0400
Received: from mercury.rus.uni-stuttgart.de ([129.69.1.226]:1298 "EHLO
	mercury.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S269786AbRIEQgS>; Wed, 5 Sep 2001 12:36:18 -0400
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: Michael Bacarella <mbac@nyct.net>, linux-kernel@vger.kernel.org
Subject: Re: getpeereid() for Linux
In-Reply-To: <200109051619.LAA58471@tomcat.admin.navo.hpc.mil>
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 05 Sep 2001 18:36:01 +0200
In-Reply-To: <200109051619.LAA58471@tomcat.admin.navo.hpc.mil> (Jesse Pollard's message of "Wed, 5 Sep 2001 11:19:07 -0500 (CDT)")
Message-ID: <tgsne1tx1q.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil> writes:

> > I need the credentials only for local connections, though.  This is
> > technically possible.  A userspace implementation partially cloning
> > ident seems to be a possible approach.
> 
> It won't be reliable.

I don't think so.  At least the 

> Even the documentation for ident (at least the version I looked at a
> while ago, might be different now, but I don't think so) says that
> the data returned is not reliable. (even fuser doesn't always get
> this right when trying to identify processes with open sockets).

The trick is not to identify processes.

> Part of the problem is that TCP sockets don't carry the same information
> that domain sockets have (could be partially wrong here, it just may not
> be filled in since the source of the data can't supply it).

Fortunately, they do carry the necessary data in the Linux kernel.
Otherwise, you would have a pretty hard time to implement the
netfilter owner match rules.

My current approach is the following: fstat() the socket to get its
inode, look up the inode in /proc/net/tcp to get a (local, remote)
pair.  Swap the pair and search /proc/net/tcp again to get the UID the
other end.  No race condition is possible because the kernel may not
create a new (remote, local) pair because we hold open the (local,
remote) socket, so even a SO_REUSEADDR will not do the trick.

> The other part is that it depends on what allocated the socket.

Yes, that might be a problem, but this affects netfilter as well.  The
kernel structure records the effective UID of the process at the time
of the creation of the socket.  It might have changed afterwards.

> Ownership is established at socket allocation time, and the socket
> can be passed to a totally different user. Identity of the user of
> the socket is therefore lost.

Hmm, you can always forward connections, so this isn't a problem.  If
some decides to give his credentials away, he is free to do so. ;-)

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
