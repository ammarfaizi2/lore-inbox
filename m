Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266933AbTBLDE2>; Tue, 11 Feb 2003 22:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266938AbTBLDE2>; Tue, 11 Feb 2003 22:04:28 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6155 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266933AbTBLDEY>; Tue, 11 Feb 2003 22:04:24 -0500
Date: Tue, 11 Feb 2003 19:10:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Jacobowitz <dan@debian.org>
cc: Roland McGrath <roland@redhat.com>, Ingo Molnar <mingo@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: another subtle signals issue
In-Reply-To: <20030212030527.GA15854@nevyn.them.org>
Message-ID: <Pine.LNX.4.44.0302111904010.2667-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Feb 2003, Daniel Jacobowitz wrote:
> 
> For things with a timeout, shouldn't they be converted to use
> ERESTART_RESTARTBLOCK?  The situation Roland is describing is just
> about the same as the original problem with nanosleep.

The thing is, I don't think the case Roland is describing is the _real_ 
case.

The real case you want to look at is a simple pipe read. See fs/pipe.c, 
pipe_read(), and grok it (or "pipe_write()", for that matter).

It should not return early for something like a SIGWINCH that is ignored.  
Returning early literally breaks things like old versions of "tar" that
want full-sized reads and don't do internal blocking on their own etc.

Now, if a user does ^Z or somebody ptrace's you, we _have_ to return out
of the read(), and return a partial result. Fair enough. We'd prefer a 
ptrace to not perturb the results at all, but that's just not possible 
with the way tracing works. But there are signals that truly don't do 
anything, and those we _can_ avoid causing partial reads. SIGWINCH is one 
(very common) example. 

I think this is even codified in POSIX, but if it isn't, I don't much 
care: it's also a quality of implementation issue.

And the simple way to do this right is to not set TIF_SIGPENDING if you 
don't have to.

		Linus

