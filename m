Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285254AbRLMXZ7>; Thu, 13 Dec 2001 18:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285258AbRLMXZl>; Thu, 13 Dec 2001 18:25:41 -0500
Received: from abraham.CS.Berkeley.EDU ([128.32.247.199]:64527 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S285256AbRLMXZV>;
	Thu, 13 Dec 2001 18:25:21 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: User-manageable sub-ids proposals
Date: 13 Dec 2001 23:24:01 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9vbdah$59k$1@abraham.cs.berkeley.edu>
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com> <20011212204333.A4017@pimlott.ne.mediaone.net> <3C1873A2.1060702@namesys.com> <20011213113616.B6547@pern.dea.icai.upco.es>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1008285841 5428 128.32.45.153 (13 Dec 2001 23:24:01 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 13 Dec 2001 23:24:01 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Romano Giannetti  wrote:
>I was thinking about the idea of sub-ids to enable users to run "untrusted"
>binary or "dangerous" one without risk for their files/privacy. 

Can I point you to some work I've done on this topic?
We built a tool called Janus (alas, it required kernel patches).
http://www.cs.berkeley.edu/~daw/janus/

Your basic goal seems like a good one: it'd be really nice if you could
run untrusted code in a sandbox that nothing can escape.  Based on
our experience, though, I've come to believe you probably want a more
sophisticated solution than the one you outlined.

First, the 'nobody' userid (and equivalents) leave a lot to be desired.
A troubling number of system resources can be accessed by 'nobody': there
are usually an enormous quantity of world-readable files; more troubling,
there are tons of world-executable setuid programs, and it's hard with a
purely userid-based mechanism to be sure that they won't provide an escape
hatch; not to mention other resources, such as interprocess communication,
network sockets, and so on.

The conclusion we came to is that you really need something more powerful
than the existing access control measures.  Unix systems are really not
very good at preventing attacks by local users.

A second claim is that you really want to start from the Principle
of Least Privilege: give the untrusted process the absolute minimum
privilege necessary for it to accomplish its task, and nothing more.
Userid-based mechanisms do a lousy job at achieving this.

This, by the way, is analogous to the "default deny" policy that you may
be familiar with from the firewalls world: if you start by giving the
untrusted process zero privileges and then explicitly declare only the
ones you want allowed, you greatly reduce the risk that the untrusted
process can escape and cause harm in some way you didn't expect.

A third observation is that you need to control access to a lot more
than just the filesystem.  You want to control the network (prevent the
spread of viruses; and if anyone uses IP-based authentication, or if
your machine is inside a firewall, prevent the untrusted process from
abusing the good name of the local host).  You want to control resources
like IPC, signals, resource usage, and so on.  And I claim you want more
fine-grained control than POSIX capabilities provide.

A fourth observation is that in practice it's useful to provide more
than just isolation: you often also want to allow some limited degree
of sharing between trusted and untrusted processes.  chroot() is not
so good in this respect, even apart from the fact that it protects only
the filesystem and not any of the other resources on the system.

The Janus approach is to interpose on system calls to impose a more
restrictive security policy.  We use ptrace() and the like to do this
from userspace.  It's a little clunky, especially since support for
process tracing on Linux has shortcomings, but it works.  We've run
a web browser, a web server, etc., inside the restricted environment
Janus provides.  Janus is just one approach, of course, and there are
a number of other projects that have followed related directions (DTE,
consh, mapbox, SubDomain, SELinux, etc.).

Looking to the future, may I direct your attention to the Linux Security
Module project?  They're doing some great work that I think will lay
a fantastic foundation for trying out many different approaches to
this problem.
