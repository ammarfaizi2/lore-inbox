Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288575AbSANBgA>; Sun, 13 Jan 2002 20:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288594AbSANBfv>; Sun, 13 Jan 2002 20:35:51 -0500
Received: from [202.135.142.196] ([202.135.142.196]:46609 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S288575AbSANBfh>; Sun, 13 Jan 2002 20:35:37 -0500
Date: Mon, 14 Jan 2002 12:35:41 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: matthew@hairy.beasts.org, manfred@colorfullife.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Lightweight user-level semaphores
Message-Id: <20020114123541.3d9da876.rusty@rustcorp.com.au>
In-Reply-To: <E16PmKA-0007BS-00@the-village.bc.nu>
In-Reply-To: <Pine.LNX.4.33.0201131216230.24442-100000@sphinx.mythic-beasts.com>
	<E16PmKA-0007BS-00@the-village.bc.nu>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jan 2002 15:13:30 +0000 (GMT)
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > Yep, that'd be fine.  However, you then lose the neatness
> > of "lock==file descriptor", and need something other than
> > read/write for down/up.
> 
> If I have to have 2000 pages and 2000 file handles for 2000 locks I've
> kind of lost interest. read/write syscalls take offsets. I can pread/pwrite
> a lock in a set of locks. The only reason for using an fd I can see is so
> you can poll on a lock. All the other neatness issues are wrapped in the
> library support code anyway.

My interest in this is for TDB (Trivial Database: see sourceforge).  TDB
requires a lock per hash chain (ie. arbitrary number of locks), a number
which does not change.  With an extended version of the fd code (ie. first
mmap controls size of map, and offset control which semaphore you are
referring to, and semaphores created on demand), this requires:

Each TDB would have an associated ".locks" unix domain socket so you can
read the fd from the "master".  This must be atomically created by the
first process to open the TDB, and must be asynchronously serviced by a
process at all times (ie. when the "master" exits, someone else takes
over).

Without even mentioning the impossibility of creating a Unix domain socket
with an arbitrary path name (can't chdir, might not be able to chdir
back), or the problem of cleaning up the socket when noone is using the
tdb, or the horror which is fd passing under Unix, I think it's clear that
the fd solutions are vastly inferior to the "magic cookie" approach.

Still, it was cute hack.
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
