Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270391AbTGWQlW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 12:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270438AbTGWQlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 12:41:22 -0400
Received: from H-135-207-24-16.research.att.com ([135.207.24.16]:38283 "EHLO
	linux.research.att.com") by vger.kernel.org with ESMTP
	id S270391AbTGWQlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 12:41:20 -0400
Date: Wed, 23 Jul 2003 12:56:12 -0400 (EDT)
From: Glenn Fowler <gsf@research.att.com>
Message-Id: <200307231656.MAA69129@raptor.research.att.com>
Organization: AT&T Labs Research
X-Mailer: mailx (AT&T/BSD) 9.9 2003-01-17
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
References: <200307231428.KAA15254@raptor.research.att.com> <20030723074615.25eea776.davem@redhat.com>
To: davem@redhat.com, dgk@research.att.com
Subject: Re: kernel bug in socketpair()
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


you can eliminate the security implications for all fd types by
simply translating
	open("/dev/fd/N",...)
to
	dup(atoi(N))
w.r.t. fd N in the current process

the problem is that linux took an implementation shortcut by symlinking
	/dev/fd/N -> /proc/self/fd/N
and by the time the kernel sees /proc/self/fd/N the "self"-ness is apparently
lost, and it is forced to do the security checks

if the /proc fd open code has access to the original /proc/PID/fd/N path
then it can do dup(atoi(N)) when the PID is the current process without
affecting security

otherwise there is a bug in the /dev/fd/N -> /proc/self/fd/N implementation
and /dev/fd/N should be separated out to its (original) dup(atoi(N))
semantics

see http://mail-index.netbsd.org/current-users/1994/03/29/0027.html for
an early (bsd) discussion of /dev/fd/N vs. /proc/self/fd/N

-- Glenn Fowler <gsf@research.att.com> AT&T Labs Research, Florham Park NJ --

On Wed, 23 Jul 2003 07:46:15 -0700 David S. Miller wrote:
> On Wed, 23 Jul 2003 10:28:22 -0400 (EDT)
> David Korn <dgk@research.att.com> wrote:

> > This make sense for INET sockets, but I don't understand the security
> > considerations for UNIX domain sockets.  Could you please elaborate?
> > Moreover, /dev/fd/n, (as opposed to /proc/$$/n) is restricted to
> > the current process and its decendents if close-on-exec is not specified.
> > Again, I don't understand why this would create a security problem
> > either since the socket is already accesible via the original
> > descriptor.

> Someone else would have to comment, but I do know we've had
> this behavior since day one.

> And therefore I wouldn't be doing many people much of a favor
> by changing the behavior today, what will people do who need
> their things to work on the bazillion existing linux kernels
> running out there? :-)

> Also, see below for another reason why this behavior is unlikely
> to change.

> > Finally if this is a security problem, why is the errno is set to ENXIO 
> > rather than EACCESS?

> Look at the /proc file we put there for socket FD's.  It's a symbolic
> link with a readable string of the form ("socket:[%d]", inode_nr)

> So your program ends up doing a follow of a symbolic link with that
> string name, which does not exist.

> Thinking more about this, changing this behavior would probably break
> more programs than it would help begin to function, so this is unlikely
> to ever change.

