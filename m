Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUCWE1o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 23:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbUCWE1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 23:27:43 -0500
Received: from [198.247.175.96] ([198.247.175.96]:1450 "EHLO jethro.hick.org")
	by vger.kernel.org with ESMTP id S261987AbUCWE1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 23:27:38 -0500
Date: Mon, 22 Mar 2004 22:26:03 -0600 (CST)
From: Matt Miller <mmiller@hick.org>
To: linux-kernel@vger.kernel.org
cc: mmiller@hick.org
Subject: Re: [PATCH] 2.6: mmap complement, fdmap
In-Reply-To: <20040323005204.GF8366@waste.org>
Message-ID: <Pine.LNX.4.58.0403221900480.131@jethro.hick.org>
References: <20040322190047.GC8366@waste.org> <PFEHKADDODPLDDIJFACJAEJHEAAA.mmiller@hick.org>
 <20040323005204.GF8366@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2004, Matt Mackall wrote:
> On Mon, Mar 22, 2004 at 01:26:01PM -0600, Matt Miller wrote:
> > > How about tmpfs/ramfs instead? Open a file on tmpfs and mmap it and
> > > you've got the same thing without any of the nasty corner cases.
> >
> > Because tmpfs does not allow you to map a file descriptor to a specific
> > memory
> > range inside a process.  tmpfs allows you to open a file that exists only
> > in memory, yes, but it does not accomplish what fdmap tries to accomplish.
> > fdmap allows you to access arbitrary memory ranges as if they were a file.
> > tmpfs allows you to access a file that happens to only exist in memory.
> > You do not control the address range that tmpfs/ramfs map to.
>
> You don't? Is this not what the first argument of mmap provides? I'm
> afraid I can't see how it matters, as you'd have to populate said map
> afterwards anyway.

Disadvantages with tmpfs/ramfs:

  1. mountpoint requirement for user-mode access.
  2. proper file permission controls for non-root user access.
  3. mapping an arbitrary memory range to a file descriptor requires
     opening a file and copying the memory to it via write or mmap on
     tmpfs/ramfs.

Advantages of fdmap:

  1. none of the above three problems.
  2. more optimized due to the avoidance of open/write/lseek associated
     with using tmpfs to map an arbitrary memory range, such as user
     stack.
  3. acts as a logical complement to mmap; read below for why.
  4. others I've listed previously.

I am not at all discounting that tmpfs/ramfs are useful.  They are quite
useful.  However, I'm stating that they do not completely accomplish what
fdmap accomplishes due to a differing approach.  The underlying difference
can be defined in terms of one, fdmap, being able to map arbitrary memory
ranges in the context of the process to a file descriptor without having
to synchronize the file to 'disk' (whether the disk be a tmpfs emulated
file system or an actual harddrive).  The synchronization part involves a
copying of the memory in the case of tmpfs/ramfs.  In fdmap, it does not.

> Point is, mmap() is already its own complement and what you're
> proposing is a hairy solution in search of a problem as the VFS
> maintainer already pointed out.

mmap is not its own complement.  If it were you would be able to
associate an arbitrary memory range, such as a user thread stack, with a
file descriptor (and no, /proc/self/mem does not count).  The point is
that you cannot do this, and as such you need a solution like fdmap.

How is it a hairy solution?  Other than the unix domain socket passing of
file descriptors (which I grant you is an odd case), I don't think there
are any problems that I've run into which are that tough to solve with
regards to fdmap's implementation and design.

I would like to hear other's opinions on supporting fd passing between
tasks.  Problems I see:

  1. Process A passes an fdmap'd fd to process B.  If B does a write() on
     the file descriptor, should that update memory in A?
  2. If it should update memory in A, now we have a potential race
     condition:
     a. Qauntum expires on B just as it is about to call write on the fd.
        Meanwhile, A exits completely.  What will happen when B is
        rescheduled?

One interesting side effect to this is that it could be used as another
form of IPC (note, emphasis on could, not should).  Granted, this is very
much similar to shmem, but reached via a different mechanism.  Just a
thought, but not much of one.


Matt
