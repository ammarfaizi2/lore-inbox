Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160995AbWCUR6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160995AbWCUR6y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 12:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161000AbWCUR6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 12:58:54 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:34527 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1160995AbWCUR6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 12:58:53 -0500
To: trond.myklebust@fys.uio.no
CC: chrisw@osdl.org, matthew@wil.cx, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <1142962083.7987.37.camel@lade.trondhjem.org> (message from Trond
	Myklebust on Tue, 21 Mar 2006 12:28:03 -0500)
Subject: Re: DoS with POSIX file locks?
References: <E1FLIlF-0007zR-00@dorka.pomaz.szeredi.hu>
	 <20060320121107.GE8980@parisc-linux.org>
	 <E1FLJLs-00085u-00@dorka.pomaz.szeredi.hu>
	 <20060320123950.GF8980@parisc-linux.org>
	 <E1FLJsF-0008A7-00@dorka.pomaz.szeredi.hu>
	 <20060320153202.GH8980@parisc-linux.org>
	 <1142878975.7991.13.camel@lade.trondhjem.org>
	 <E1FLdPd-00020d-00@dorka.pomaz.szeredi.hu> <1142962083.7987.37.camel@lade.trondhjem.org>
Message-Id: <E1FLl7L-0002u9-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 21 Mar 2006 18:58:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Apps using LinuxThreads seem to be candidates:
> > 
> >      According to POSIX 1003.1c, a successful `exec*' in one of the
> >      threads should automatically terminate all other threads in the
> >      program.  This behavior is not yet implemented in LinuxThreads.
> >      Calling `pthread_kill_other_threads_np' before `exec*' achieves
> >      much of the same behavior, except that if `exec*' ultimately
> >      fails, then all other threads are already killed.
> > 
> > steal_locks() was probably added as a workaround for this case, no?
> 
> Possibly, but LinuxThreads were never really POSIX thread compliant
> anyway. Anyhow, the problem isn't really LinuxThreads, it is rather that
> the existence of the standalone CLONE_FILES flag allows you to do a lot
> of weird inheritance crap with 'posix locks' that the POSIX standards
> committees never even had to consider.

Yes.  The execve-with-multiple-threads/posix-locks interaction is not
documented for LinuxThreads but removing steal_locks() makes that
implementation slighly differently incompatible to POSIX.  Some
application _might_ be relying on the current behavior.

It's just a question of how much confidence do we have, that no app
will break if steal_locks() is removed.  This function was added by
Chris Wright on 2003-12-29 (Cset 1.1371.111.3):

  Add steal_locks helper for use in conjunction with unshare_files to
  make sure POSIX file lock semantics aren't broken due to
  unshare_files.

Chris, do you remember if this was due to some concrete breakage or
just a preemtive measure?

Miklos
