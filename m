Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262632AbREZKmr>; Sat, 26 May 2001 06:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262633AbREZKmi>; Sat, 26 May 2001 06:42:38 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:14852 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S262632AbREZKm2>;
	Sat, 26 May 2001 06:42:28 -0400
Message-ID: <20010525234106.A4102@bug.ucw.cz>
Date: Fri, 25 May 2001 23:41:06 +0200
From: Pavel Machek <pavel@suse.cz>
To: Hua Zhong <huaz@cs.columbia.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CRAK: a process checkpoint/restart kernel module
In-Reply-To: <20010523162603.A33@toy.ucw.cz> <Pine.LNX.4.33.0105251406340.12446-100000@razor.cs.columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.33.0105251406340.12446-100000@razor.cs.columbia.edu>; from Hua Zhong on Fri, May 25, 2001 at 02:51:50PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Please cc to me - I am currently off the list.

Ok.

> > One question: can crak be used for process migration (assuming nodes
> > share filesystem)? (As in, node of
> > cluster is going down so we checkpoint and resume on some other node?)
> 
> Yes, as long as the resources (opened files) can be accessed on both
> nodes.

Good.

> > PS: Can it checkpoint/restart X applications? I guess some games would
> > be easier with ability to checkpoint ;-)
> 
> Which means we need to support migrating network sockets. I added
> TCP/IPv4 socket support this spring (currently for 2.2.19 and will port to 
> 2.4 shortly), and I tested migrating X. In certain cases I
> successfully migrated some applications like Emacs, Acroread, etc, but
> there is a prob lem. (The socket migration code has not been put online,
> but I'd like to discuss how it works here)
> 
> Basically I took three steps to migrate a TCP  socket. Assuming A and B
> are the two peers:
> 
> 1. shutdown process A while keep B open
> 2. restart A and re-establish the socket which points to B
> 3 . change the socket on B to point to the new location of A

This assumes both A and B are on same machine, right?

> The problem is, during this stage, if B sends packets to A before 3 is
> complete, B's socket will get a RST. In the case of X, if you click or
> move cursor on A's window when A is being migrated, it will crash.

<EVIL SOLUTION>
You might shutdown machine's networking between checkpoint and
restart. That way, packets are silently lost, and there's no RST to be
generated.
</EVIL>

> One solution might be that freezing B when A is being migrated. There are
> two ways to freeze B:
> 
> 1) send a SIGSTOP to B and later SIGCONT it. It's simple to do but woul  d
> result in freezing the whole process, which is bad in certain cases (e.g.,
> the whole X server is stopped - the screen freezes).

Assuming they are on same machine.

> 2) freeze the socket only. I tried to set window sizes of B's socket to
> zero, but it didn't work (I didn't try too hard though). I'd like to know
> whether there i  s a way to do so.

You don't want to decrease window size, you want all packets silently
discarded.

> Unfortunately, even we use 1), it still doesn't solve the whole problem.
> For exmaple, when the X connection is tunneled through ssh, you can only
> freeze the sshd process, but packets are still sent to it when you click
> on the server side, which will crash the connection as ell (at least for
> my current implementation). One reason might be I didn't take care of
> pending packets when I migrage a socket, but in fact, the  real problem of
> socket migration is that you don't know what would happen if the network
> address is changed. Appliactions may depend on it (such a s FTP). A
> virtual network interface should be provided to solve the problem
> gracefully.
> 
> As of migrating games, hmmm, here are my 2cents:
> 
> 1) Most  online games use UDP, and CRAK hasn't implemented UDP support.
> It's much easier than TCP though.

I guess you can't checkpoint/restart when there's remote machine
involved. I was not thinking online games, I was thinking about
tuxracer (game on localhost).

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
