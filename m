Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261616AbREYSwO>; Fri, 25 May 2001 14:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261670AbREYSwE>; Fri, 25 May 2001 14:52:04 -0400
Received: from cs.columbia.edu ([128.59.16.20]:22956 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S261616AbREYSvw>;
	Fri, 25 May 2001 14:51:52 -0400
Date: Fri, 25 May 2001 14:51:50 -0400 (EDT)
From: Hua Zhong <huaz@cs.columbia.edu>
To: Pavel Machek <pavel@suse.cz>
cc: Hua Zhong <huaz@cs.columbia.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: CRAK: a process checkpoint/restart kernel module
In-Reply-To: <20010523162603.A33@toy.ucw.cz>
Message-ID: <Pine.LNX.4.33.0105251406340.12446-100000@razor.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please cc to me - I am currently off the list.

On Wed, 23 May 2001, Pavel Machek wrote:

> Hi!!
>
> One question: can crak be used for process migration (assuming nodes
> share filesystem)? [As in, node of
> cluster is going down so we checkpoint and resume on some other node?]

Yes, as long as the resources (opened files) can be accessed on both
nodes.

> PS: Can it checkpoint/restart X applications? I guess some games would
> be easier with ability to checkpoint ;-)

Which means we need to support migrating network sockets.  I added
TCP/IPv4 socket support this spring (currently for 2.2.19 and will port to
2.4 shortly), and I tested migrating X.  In certain cases I
successfully migrated some applications like Emacs, Acroread, etc, but
there is a problem.  (The socket migration code has not been put online,
but I'd like to discuss how it works here)

Basically I took three steps to migrate a TCP socket.  Assuming A and B
are the two peers:

1. shutdown process A while keep B open
2. restart A and re-establish the socket which points to B
3. change the socket on B to point to the new location of A

The problem is, during this stage, if B sends packets to A before 3 is
complete, B's socket will get a RST.  In the case of X, if you click or
move cursor on A's window when A is being migrated, it will crash.

One solution might be that freezing B when A is being migrated.  There are
two ways to freeze B:

1) send a SIGSTOP to B and later SIGCONT it.  It's simple to do but would
result in freezing the whole process, which is bad in certain cases (e.g.,
the whole X server is stopped - the screen freezes).

2) freeze the socket only.  I tried to set window sizes of B's socket to
zero, but it didn't work (I didn't try too hard though).  I'd like to know
whether there is a way to do so.

Unfortunately, even we use 1), it still doesn't solve the whole problem.
For exmaple, when the X connection is tunneled through ssh, you can only
freeze the sshd process, but packets are still sent to it when you click
on the server side, which will crash the connection as well (at least for
my current implementation).  One reason might be I didn't take care of
pending packets when I migrage a socket, but in fact, the real problem of
socket migration is that you don't know what would happen if the network
address is changed.  Appliactions may depend on it (such as FTP).  A
virtual network interface should be provided to solve the problem
gracefully.

As of migrating games, hmmm, here are my 2cents:

1) Most online games use UDP, and CRAK hasn't implemented UDP support.
It's much easier than TCP though.
2) I am not sure of what the effect would be if we changed the network
address.  Most games requires you to join a group before you start, and
maybe the group membership is based on network address.

At last, there are a lot of work left to do to make process migration work
truly reliably, and CRAK is still far from that.  For example, what if an
application depends on pid?  What if a process uses temporary files
(/tmp) which are not present on other nodes?  Or what if an application
deletes files that are still opened (evil programs like make)?  Not all of
these are possible, or possible without enough kernel cooperation.
Particularly hard when CRAK is just a kernel module.

I am still a lerner.  I wrote CRAK mostly for fun, but I'd like to
hear some advice from the kernel hacker community if people think it has
some value.

> --
> Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
> details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.
>

----------------------------------------------------------------
Hua Zhong

Central Research Facilities	Department of Computer Science
Columbia University		New York, NY 10027
Email: huaz@cs.columbia.edu	http://www.cs.columbia.edu/~huaz
----------------------------------------------------------------


