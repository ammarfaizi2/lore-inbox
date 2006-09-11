Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWIKNk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWIKNk7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 09:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWIKNk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 09:40:59 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:40789 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S932205AbWIKNk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 09:40:58 -0400
Message-ID: <45056763.8090104@tls.msk.ru>
Date: Mon, 11 Sep 2006 17:40:51 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PF_UNIX socket files ownership/permissions?
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's not kernel-programming-related email, but userspace question
about kernel-provided interfaces.

The thing is that UNIX sockets, while live in filesystem (not
couning "abstract namespace"), are somewhat second-class
citizens here.

I mean, Linux does NOT ignore permissions on socket files,
in order for a process to be able to connect to a socket
it should have write permission for it.  So far so good.

But at the same time, setting ownership and permission
bits for sockets is somewhat problematic.

Imagine a generic inetd-like application which is able
to create AF_UNIX sockets too (classical inetd(8) is of
this category).  Since Linux checks socket permissions
on connect(), there must be a way to specify ownership
and permissions for the sockets created by inetd, and
inetd should perform some steps to create socket files
with proper permission bits and ownership.

The problem is that fchown(2) and fchmod(2) don't work
for sockets, even AF_UNIX ones, and using chown() and
chmod() (without f) is racy.

It's possible to work around this issue for at least
permission bits, by setting umask correctly before
calling listen(2), so that newly created file will
have the desired permissions since the beginning.

But it isn't that easy to work-around file ownership
issue.  I see the following possible solutions (in
no particular order):

o chown(socketfile) to proper owner.  This is racy if
  the directory containing the file is owned by non-
  root user - between listen() and chown(), it is possible
  to create a (sym)link to some system file of the name
  of a socket being created, and after [l]chown() you'll
  have some system file (like /etc/passwd) owned by the
  owner of the directory, hence effectively an owner of
  that dir becomes equal to root.

o temporary switch uid when creating the socket, to the
  desired owner of the socket.  At least 4 problems:
   1).  On some systems it will be possible to attach
     debugger to that process while running as 'desired
     owner'.  It's not possible on Linux and, hopefully,
     FreeBSD.
   2) but it IS possible to send unexpected signals to the
     process during temporary-setuid window.  If you consider
     inetd, it'd be very bad if someone will be able to kill
     it randomly.
   3) it will be impossible to create socket owned by foo in
     a directory owned by bar.  But inetd is running as root,
     so it is logical to expect its ability to create any
     sockets anywhere.
   4) bsd setgid semantics comes to the game - it's impossible
     to specify group ownership if the parent dir has g+s bit.

o using temporary root-owned directory to create+setup the socket,
  and rename(2) it to place when it's ready.  It's the best solution
  from security standpoint, but the most complex and ugly one, as
  it's not obvious where to create that directory (in the root of the
  filesystem?  But if it's owned by non-root too?)

o implementing fchown() and fchmod() for sockets.  This is the best
  and cleanest solution from userspace standpoint, but it's not portable.

o throw away inetd and write custom code every time you need to use PF_UNIX
  sockets.  Not good, but this currently is the ONLY working solution.

Comments?

Thanks.

/mjt
