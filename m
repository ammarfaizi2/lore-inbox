Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVAWHg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVAWHg2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 02:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVAWHg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 02:36:27 -0500
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:58382 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S261243AbVAWHgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 02:36:16 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: seccomp for 2.6.11-rc1-bk8
Date: Sun, 23 Jan 2005 07:34:24 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <csvk20$6qa$1@abraham.cs.berkeley.edu>
References: <20050121100606.GB8042@dualathlon.random> <20050121093902.O469@build.pdx.osdl.net> <csrje8$bsn$1@abraham.cs.berkeley.edu> <20050121111700.Q469@build.pdx.osdl.net>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1106465664 6986 128.32.168.222 (23 Jan 2005 07:34:24 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Sun, 23 Jan 2005 07:34:24 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright  wrote:
>* David Wagner (daw@taverner.cs.berkeley.edu) wrote:
>> There is a simple tweak to ptrace which fixes that: one could add an
>> API to specify a set of syscalls that ptrace should not trap on.  To get
>> seccomp-like semantics, the user program could specify {read,write}, but
>> if the user program ever wants to change its policy, it could change that
>> set.  Solaris /proc (which is what is used for tracing) has this feature.
>> I coded up such an extension to ptrace semantics a long time ago, and
>> it seemed to work fine for me, though of course I am not a ptrace expert.
>
>Hmm, yeah, that'd be nice.  That only leaves the issue of tracer dying
>(say from that crazy oom killer ;-).

Yes, I also implemented was a ptrace option which causes the child to be
slaughtered if the parent dies for any reason.  I could dig up the code,
but I don't recall it being very hard.  This was ages ago (a 2.0.x kernel)
and I have no idea what might have changed.  Also, am definitely not a
guru on kernel internals, so it is always possible I missed something.
But, at least on the surface this doesn't seem hard to implement.

A third thing I implemented was a option which would cause ptrace() to be
inherited across forks.  The way that strace does this (last I looked)
is an unreliable abomination: when it sees a request to call fork(), it
sets a breakpoint at the next instruction after the fork() by re-writing
the code of the parent, then when that breakpoint triggers it attaches to
the child, restores the parent's code, and lets them continue executing.
This is icky, and I have little confidence in its security to prevent
children from escaping a ptrace() jail, so I added a feature to ptrace()
that remedies the situation.

Anyway, back to the main topic: ptrace() vs seccomp.  I think one
plausible reason to prefer some mechanism that allows user level to
specify the allowed syscall set is that it might provide more flexibility.
What if 6 months from now we discover that we really should have enabled
one more syscall in seccomp to accomodate other applications?

At the same time, I truly empathize Andrea's position that something
like seccomp ought to be a lot easier to verify correct than ptrace().
I think several people here are underestimating the importance of
clean design.  ptrace() is, frankly, a godawful mess, and I don't
know about this thinking that you can take a godawful mess and then
audit it carefully and call it secure -- well, that seems unlikely to
ever lead to the same level of assurance that you can get with a much
cleaner design.  (This business of overloading as a means of sending
ptrace events to user level was in retrospect probably a bad design
decision, for instance.  See, e.g., Section 12 of my MS thesis for more.
http://www.cs.berkeley.edu/~daw/papers/janus-masters.ps)  Given this,
I can see real value in seccomp.

Perhaps there is a compromise position.  What if one started from seccomp,
but then extended it so the set of allowed syscalls can be specified by
user level?  This would push policy to user level, while retaining the
attractive simplicity and ease-of-audit properties of the seccomp design.
Does something like this make sense?

Let me give you some idea of new applications that might be enabled
by this kind of functionality.  One cool idea is a 'delegating
architecture' for jails.  The jailed process inherit an open file
descriptor to its jailor, and is only allowed to call read(), write(),
sendmsg(), and recvmsg().  If the jailed process wants to interact
with the outside world, it can send a request to its jailor to this
effect.  For instance, suppose the jailed process wants to create a
file called "/tmp/whatever", so it sends this request to the jailor.
The jailor can decide whether it wants this to be allowed.  If it is
to be allowed, the jailor can create this file and transfer a file
descriptor to the jailed process using sendmsg().  Note that this
mechanism allows the jailor to completely virtualize the system call
interface; for instance, the jailor could transparently instead create
"/tmp/jail17/whatever" and return a fd to it to the jailed process,
without the jailed process being any the wiser.  (For more on this,
see http://www.stanford.edu/~talg/papers/NDSS04/abstract.html and
http://www.cs.jhu.edu/~seaborn/plash/plash.html)

So this is one example of an application that is enabled by adding
recvmsg() to the set of allowed syscalls.  When it comes to the broader
question of seccomp vs ptrace(), I don't know what strategy makes most
sense for the Linux kernel, but I hope these ideas help give you some
idea of what might be possible and how these mechanisms could be used.
