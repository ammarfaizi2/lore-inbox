Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270443AbTGWRJo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 13:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270462AbTGWRJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 13:09:43 -0400
Received: from H-135-207-24-16.research.att.com ([135.207.24.16]:5516 "EHLO
	linux.research.att.com") by vger.kernel.org with ESMTP
	id S270443AbTGWRJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 13:09:42 -0400
Date: Wed, 23 Jul 2003 13:24:36 -0400 (EDT)
From: Glenn Fowler <gsf@research.att.com>
Message-Id: <200307231724.NAA90957@raptor.research.att.com>
Organization: AT&T Labs Research
X-Mailer: mailx (AT&T/BSD) 9.9 2003-01-17
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
References: <200307231428.KAA15254@raptor.research.att.com>  <20030723074615.25eea776.davem@redhat.com>  <200307231656.MAA69129@raptor.research.att.com> <20030723100043.18d5b025.davem@redhat.com>
To: davem@redhat.com, gsf@research.att.com
Subject: Re: kernel bug in socketpair()
Cc: dgk@research.att.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Jul 2003 10:00:43 -0700 David S. Miller wrote:
> On Wed, 23 Jul 2003 12:56:12 -0400 (EDT)
> Glenn Fowler <gsf@research.att.com> wrote:

> > the problem is that linux took an implementation shortcut by symlinking
> > 	/dev/fd/N -> /proc/self/fd/N
> > and by the time the kernel sees /proc/self/fd/N the "self"-ness is apparently
> > lost, and it is forced to do the security checks

> None of this is true.  If you open /proc/self/fd/N directly the problem
> is still there.

you missed the point that the original open() call is on /dev/fd/N,
not /proc/PID/fd/N; /proc/PID/fd/N only comes into play because the
linux implementation foists it on the user

> > if the /proc fd open code has access to the original /proc/PID/fd/N path
> > then it can do dup(atoi(N)) when the PID is the current process without
> > affecting security

> If we're talking about the current process, there is no use in using
> /proc/*/fd/N to open a file descriptor in the first place, you can
> simply call open(N,...)

no, in the notation above N is the fd number "so you could simply call dup(N)"

here is one reason why /dev/fd/N is useful:

/dev/fd/N is the underlying mechanism for implementing the bash and ksh

	cmd-1 <(cmd-2 ...) ... <(cmd-n ...)

each <(cmd-i ...) is converted to a pipe() with the write side getting the
output of cmd-i (and marked close on exec) and the read side *not* marked
close on exec; cmd-1 is then executed as

	cmd-1 /dev/fd/PIPE-READ-2 ... /dev/fd/PIPE-READ-n

where PIPE-READ-i is the fd number of the read side of the pipe for cmd-i

