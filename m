Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314602AbSHaATn>; Fri, 30 Aug 2002 20:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315260AbSHaATn>; Fri, 30 Aug 2002 20:19:43 -0400
Received: from pat.uio.no ([129.240.130.16]:58070 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S314602AbSHaATl>;
	Fri, 30 Aug 2002 20:19:41 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15728.3233.550886.99549@charged.uio.no>
Date: Sat, 31 Aug 2002 02:24:01 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Introduce BSD-style user credential [3/3]
In-Reply-To: <Pine.LNX.4.44.0208301634580.5430-100000@home.transmeta.com>
References: <15727.64653.78081.277222@charged.uio.no>
	<Pine.LNX.4.44.0208301634580.5430-100000@home.transmeta.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Linus Torvalds <torvalds@transmeta.com> writes:

     > Also, I don't see how this is going to solve the credential
     > clone problem, which basically says that sometimes you do _not_
     > want to do COW on the credentials (when changing them when they
     > are shared with other threads) and sometimes you do (when
     > changing them when they are shared with a background filesystem
     > lookup).

     > Any ideas on that?

task->ucred is not the unit for implementing shared creds between
threads. In the BSD design (on which this is loosely based) the ucred
is a structure designed for caching user credentials so that you can
pass them around inside the VFS. It is supposed to ensure that despite
shared creds, we always use the same authentication for a given
'atomic' sequence of VFS ops.

For instance the sequence

  lookup(cred, dir, dentry)
  permission(cred, dentry->d_inode, MAY_WRITE);
  dentry_open(cred, dentry, mnt, FMODE_WRITE)

should all be using the same credentials, so here you will always want
'cred' to be a COW structure even if it is shared among several
threads.

For CLONE_CRED, the idea is that once we've got the ucred firmly
established as part of the VFS' API, we can add the concept of process
credentials ('pcred' in *BSD parlance). The latter are indeed shared
between the threads, and their contents are *not* COW. They will be
something of the form

struct pcred {
       atomic_t	count;
       uid_t	uid, euid, suid;
       gid_t	gid, egid, sgid;
       struct ucred  *cred;
       kernel_cap_t ... capabilities ...
       struct user_struct *user;
};

For 'pcred' any one thread could be allowed to swap any one of its
member elements without breaking the filesystem auth checking
premises. i.e. it would still not be allowed to change the member
elements of cred, but it could swap out one struct ucred for another.

     > (And I _really_ don't like those trivial inline functions in
     > [1/3] - I think it's much better to just show that we're doing
     > a pointer dereference than trying to hide it behind some silly
     > "current_fsuid()" inline function).

The current_fsuid() thing is an artifice that is designed to make the
actual patches smaller and more readable. I would expect all of them
to have disappeared once we get to the point of full VFS support for
ucreds in place. When that is done, I would something like open()
should be doing a single

cred = current_getucred();

and then passing the resulting ucred directly down to the file
subsystems. References to current_fsuid() will be unnecessary and
indeed *wrong* once we get to that point, since they will break the
'atomicity' premise as described above.
In fact, at some point we could probably set
   #define current_fsuid() BUG()

Cheers,
  Trond
