Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264095AbUFFULS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbUFFULS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 16:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264117AbUFFULS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 16:11:18 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24968 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S264108AbUFFULH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 16:11:07 -0400
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Matthew Wilcox <willy@debian.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Killing POSIX deadlock detection
References: <200406050725.i557P3hQ004052@supreme.pcug.org.au>
	<20040606130422.0c8946b3.sfr@canb.auug.org.au>
	<20040606132751.GZ5850@parcelfarce.linux.theplanet.co.uk>
	<1086551360.5472.48.camel@lade.trondhjem.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 Jun 2004 14:09:02 -0600
In-Reply-To: <1086551360.5472.48.camel@lade.trondhjem.org>
Message-ID: <m165a4phy9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> writes:

> På su , 06/06/2004 klokka 09:27, skreiv Matthew Wilcox:
> \
> > > T1 locks file F1 -> lock (P1, F1)
> > > P2 locks file F2 -> lock (P2, F2)
> > > P2 locks file F1 -> blocks against (P1, F1)
> > > T1 locks file F2 -> blocks against (P2, F2)
> > 
> > Less contrived example -- T2 locks file F2.  We report deadlock here too,
> > even though T1 is about to unlock file F1.

There is a fairly sane linux specific definition here.  We should
track these things not by pid or tid, but by struct files_struct.

> So what is better: report an error and give the user a chance to
> recover, or allowing the potential deadlock?

Reading the SUS definition below we should only report a deadlock when
it is certain. 

For multiple processes with the same set of file descriptors open
that is an interesting graph problem.  Unless there is nothing
another process can do, to remove the deadlock situation.

> Only the user can resolve problems such as the above threaded problem,
> given the SuS definitions.
> 
> > So, final call.  Any objections to never returning -EDEADLCK?
> 
> Yes: As Chuck points out, that is a fairly nasty change of the userland
> API.

???? Failing to detect a deadlock is not a change in the API.
It is simply a change in behavior.

> Worse: it is a change that fixes only one problem for only a minority of
> users (those that combine locking over multiple NPTL threads - a
> situation which after the "fix" remains just as poorly defined) at the
> expense of reintroducing a series of deadlocking problems for those
> single threaded users that rely on the EDEADLK (and have done so
> throughout the entire 2.4.x series).

Relying on EDEADLK is broken.  That is about as bad as relying on 
getting -EACCESS instead of SIGSEGV.

Detecting deadlocks is certainly a quality of implementation issue.
But unless my memory is shaky detecting deadlocks is a hard problem.

Perhaps what we should do is simply not attempt to detect deadlocks
involving threaded processes.

With threads the problems escalates from one of cycle detection
to something fairly weird.
 
> Finally, EDEADLK does actually appear to be mandatory to implement in
> SUSv3, given that it states:
> 
>         A potential for deadlock occurs if a process controlling a
>         locked region is put to sleep by attempting to lock another
>         process' locked region. If the system detects that sleeping
>         until a locked region is unlocked would cause a deadlock,
>         fcntl() shall fail with an [EDEADLK] error.
>         
> (again see
> http://www.opengroup.org/onlinepubs/009695399/functions/fcntl.html)

Hmm.  I don't see that the system is required to detect a deadlock.
Just what it does after it has detected one.

Eric
