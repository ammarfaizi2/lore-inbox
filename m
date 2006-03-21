Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965074AbWCUTQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbWCUTQT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 14:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbWCUTQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 14:16:18 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36480 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S965073AbWCUTQL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 14:16:11 -0500
Date: Tue, 21 Mar 2006 11:16:05 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: trond.myklebust@fys.uio.no, chrisw@sous-sol.org, matthew@wil.cx,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: DoS with POSIX file locks?
Message-ID: <20060321191605.GB15997@sorel.sous-sol.org>
References: <E1FLIlF-0007zR-00@dorka.pomaz.szeredi.hu> <20060320121107.GE8980@parisc-linux.org> <E1FLJLs-00085u-00@dorka.pomaz.szeredi.hu> <20060320123950.GF8980@parisc-linux.org> <E1FLJsF-0008A7-00@dorka.pomaz.szeredi.hu> <20060320153202.GH8980@parisc-linux.org> <1142878975.7991.13.camel@lade.trondhjem.org> <E1FLdPd-00020d-00@dorka.pomaz.szeredi.hu> <1142962083.7987.37.camel@lade.trondhjem.org> <E1FLl7L-0002u9-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FLl7L-0002u9-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Miklos Szeredi (miklos@szeredi.hu) wrote:
> > > Apps using LinuxThreads seem to be candidates:
> > > 
> > >      According to POSIX 1003.1c, a successful `exec*' in one of the
> > >      threads should automatically terminate all other threads in the
> > >      program.  This behavior is not yet implemented in LinuxThreads.
> > >      Calling `pthread_kill_other_threads_np' before `exec*' achieves
> > >      much of the same behavior, except that if `exec*' ultimately
> > >      fails, then all other threads are already killed.
> > > 
> > > steal_locks() was probably added as a workaround for this case, no?
> > 
> > Possibly, but LinuxThreads were never really POSIX thread compliant
> > anyway. Anyhow, the problem isn't really LinuxThreads, it is rather that
> > the existence of the standalone CLONE_FILES flag allows you to do a lot
> > of weird inheritance crap with 'posix locks' that the POSIX standards
> > committees never even had to consider.
> 
> Yes.  The execve-with-multiple-threads/posix-locks interaction is not
> documented for LinuxThreads but removing steal_locks() makes that
> implementation slighly differently incompatible to POSIX.  Some
> application _might_ be relying on the current behavior.
> 
> It's just a question of how much confidence do we have, that no app
> will break if steal_locks() is removed.  This function was added by
> Chris Wright on 2003-12-29 (Cset 1.1371.111.3):
> 
>   Add steal_locks helper for use in conjunction with unshare_files to
>   make sure POSIX file lock semantics aren't broken due to
>   unshare_files.
> 
> Chris, do you remember if this was due to some concrete breakage or
> just a preemtive measure?

Concrete breakage.  Something like:

clone(CLONE_FILES)
  /* in child */
  lock
  execve
  lock

w/out the kludge[1], the lock fails.  I should have a test program about
that I wrote to test this, although it was originally triggered via some
LTP or LSB type of test (don't recall which).

thanks,
-chris

[1] happy to see it go.  i concur with Trond, there's no sane way to get
rid of it w/out formalizing CLONE_FILES and locks on exec
