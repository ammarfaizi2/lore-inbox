Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133096AbRDSTst>; Thu, 19 Apr 2001 15:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133120AbRDSTsj>; Thu, 19 Apr 2001 15:48:39 -0400
Received: from runyon.cygnus.com ([205.180.230.5]:54155 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S133101AbRDSTs0>;
	Thu, 19 Apr 2001 15:48:26 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com (Linus Torvalds), alonz@nolaviz.org (Alon Ziv),
        linux-kernel@vger.kernel.org (Kernel Mailing List),
        mkravetz@sequent.com (Mike Kravetz)
Subject: Re: light weight user level semaphores
In-Reply-To: <E14qHRp-0007Yc-00@the-village.bc.nu>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 19 Apr 2001 12:47:02 -0700
In-Reply-To: Alan Cox's message of "Thu, 19 Apr 2001 17:38:23 +0100 (BST)"
Message-ID: <m31yqo3c5l.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Thelxepeia)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > can libraries use fast semaphores behind the back of the user? They might
> > well want to use the semaphores exactly for things like memory allocator
> > locking etc. But libc certainly cant use fd's behind peoples backs.
> 
> libc is entitled to, and most definitely does exactly that. Take a look at
> things like gethostent, getpwent etc etc.

You are mixing two completely different things.

Functions like gethostent() and catopen() are explicitly allowed to be
implemented using file descriptors.  If this is allowed the standard
contains appropriate wording.

Other functions like setlocale() do use file descriptors, yes, but
these are not kept.  Before the function returns they are closed.
This can cause disruptions in other threads which find descriptors not
allocated sequentially but this has to be taken into account.  Rules
for multi-threaded applications are different.  A single-threaded
application will not see such a difference.

Now, the standards do not allow POSIX mutexes to be implemented using
file descriptors.  The same is true for unnamed POSIX semaphores.  So
Linus is right, though for a different reason than he thought.

The situation is a bit different for named POSIX semaphores.  These
can be implemented using file descriptors.  But they don't have to and
IMO they shouldn't.  A memory reference based semaphore implementation
would allow a named semaphore to be implemented using

  fd = open (name)
  addr = mmap (..fd..)
  close (fd)
  sem_syscall (addr)

i.e., it can be mapped to a memory reference again.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
