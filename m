Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131724AbQLNCqB>; Wed, 13 Dec 2000 21:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132148AbQLNCpw>; Wed, 13 Dec 2000 21:45:52 -0500
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:28702 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id <S132147AbQLNCpf>; Wed, 13 Dec 2000 21:45:35 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Pthreads, linux, gdb, oh my! (and ptrace must die!)
Date: 14 Dec 2000 02:14:01 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <919ad9$cjl$1@abraham.cs.berkeley.edu>
In-Reply-To: <Pine.BSI.4.02.10012081445290.26743-100000@frogger.telerama.com> <s3ilmtka14t.fsf@debye.wins.uva.nl> <87zohzoqsb.fsf_-_@subterfugue.org>
Reply-To: daw@cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Coleman  wrote:
>My limited mental abilities notwithstanding, I think this is one more reason
>to ditch ptrace for a better method of process tracing/control.  It's served
>up to this point, but ptrace has a fundamental flaw, which is that it tries to
>do a lot of interprocess signalling and interlocking in an in-band way, doing
>process reparenting to try to take advantage of existing code.  In the end
>this seems to be resulting in an inscrutable, flaky mess.

Yes!  Overloading signals and the process parent tree is a kludgy hack
with many unanticipated, painful effects (like this bug mentioned here,
or the way ptrace breaks the semantics of wait(), etc.). 

>What would a better process tracing facility be like?

Like the Solaris /proc tracing facility.  Take a look at it -- I think
it would make an excellent starting point.  It is truly well done, at
least in every way that has ever affected my use of tracing (my experience
is in the area of sandboxing for security).

/proc is transparent.  It doesn't overload some existing mechanism, so
it doesn't have all the pain of changing the semantics of various corner
cases.  /proc uses fd's as the mechanism for communicating events from
the kernel to user-land, which gives a cleaner architecture.

/proc allows to trap on both syscalls and syscall-exits, and to specify
which events the user-land process is interested in (greatly lowers the
cost of tracing, if you only care about some subset of the events).
ptrace() doesn't let you specify (more than one bit of) per-process
tracing state, which makes this very difficult to do.

/proc is extensible: whenever it allows one tracer, it allows many
tracers.  /proc allows any-to-any tracing.  ptrace() only allows a
traced app to have at most one tracer at any time.  This limitation
of ptrace() makes it hard to securely (atomically) hand off tracing
of an app from one tracer to another.  /proc fixes this.

/proc handles fork() more cleanly.  In /proc, the tracer receives a
tracing event when the fork returns in the newly created child process,
as well as when it returns in the parent; in ptrace(), you only see an
event when the fork() returns in the parent, which makes it harder to
follow the process tree while tracing apps that call fork().
Go read strace code to see how it works around this problem, and you'll
see what a disgusting hack strace is forced to use (blech!).

Much of the ptrace() code in the kernel isn't architecture-independent.
I find this amazing.  IMHO, it would be much cleaner to have all syscalls
immediately call some arch-independent function with the appropriate
arguments, and interpose on the set of arch-independent functions.

I'm not saying you should duplicate the Solaris /proc facility, but it
would be very useful to learn from what Solaris got right and ptrace()
got wrong.

An even better process tracing facility might allow interposition on
other interfaces in the kernel: Rather than just receiving events on
syscalls and signals, how about on the VFS filesystem interface or
the network layer interface?  Just a thought.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
