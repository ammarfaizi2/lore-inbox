Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315540AbSHaBZB>; Fri, 30 Aug 2002 21:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315746AbSHaBZA>; Fri, 30 Aug 2002 21:25:00 -0400
Received: from pat.uio.no ([129.240.130.16]:39386 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S315540AbSHaBY6>;
	Fri, 30 Aug 2002 21:24:58 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15728.7151.27079.551845@charged.uio.no>
Date: Sat, 31 Aug 2002 03:29:19 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Dave McCracken <dmccr@us.ibm.com>
Subject: Re: [PATCH] Introduce BSD-style user credential [3/3]
In-Reply-To: <Pine.LNX.4.44.0208301741430.5561-100000@home.transmeta.com>
References: <15728.3233.550886.99549@charged.uio.no>
	<Pine.LNX.4.44.0208301741430.5561-100000@home.transmeta.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Linus Torvalds <torvalds@transmeta.com> writes:

     > On Sat, 31 Aug 2002, Trond Myklebust wrote:
    >>
    >> task-> ucred is not the unit for implementing shared creds
    >> between threads.

     > Fair enough, but some solution to this has to be found. I do
     > not want to apply something that simply cannot work sanely, and
     > I want to have at least a _plan_ on the table.

The plan is pretty rough at the moment, and not all of the code has
been written yet. Basically, it boils down to:

  Add the COW structure 'vfs_cred'

  Make VFS changes to replace all instances of
  current->fsuid/fsgid/ngroups/groups with a single 'vfs_cred' that
  never can be changed by CLONE_CRED after we call down into the VFS.
  This means that we have to actually invent mechanisms for passing
  those creds down to address_space_operations, inode_operations.

  Add the more volatile 'pcred' a.k.a. 'task_cred' (see below), which
  forms the necessary basis for CLONE_CRED tasks.

  Audit 'task_cred' to ensure that CLONE_CRED won't introduce new
  security holes. Things like capabilities, which can sometimes
  override 'standard credentials', will for instance need to be looked
  into.

  .... end of process -> add CLONE_CRED flag to 'clone()'

     > This really ties in with the patches Dave has done (which are
     > equivalent to your "pcred"), and I'd like to see them work
     > together in practice.

Dave and I have already been discussing this on l-k, and we appear now
to be in agreement on general procedure. Dave has said that he'd like
to contribute once we get vfs_cred well established. I'm hoping he'll
help out on the latter too ;-)

     > (I would suggest calling the FS credentials "struct vfs_cred",
     > while the regular user credentials might just be "struct cred".
     > Other suggestions?)

I'm fine about 'vfs'cred', but how about 'struct task_cred' instead
for the second? That ties them directly in to the task_struct, and
avoids people mistaking for 'ucred'. Since the distinction between COW
and non-COW is pretty profound, it might be useful in order to help
emphasize to which category they belong...

Cheers,
   Trond
