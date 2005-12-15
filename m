Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbVLOWtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbVLOWtj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 17:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbVLOWti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 17:49:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45723 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751177AbVLOWti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 17:49:38 -0500
Date: Thu, 15 Dec 2005 17:49:33 -0500
From: Ulrich Drepper <drepper@redhat.com>
Message-Id: <200512152249.jBFMnXAA016747@devserv.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] *at syscalls: Intro
Cc: akpm@osdl.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a series of patches which introduce in total 11 new system calls
which take a file descriptor/filename pair instead of a single file name.
These functions, openat etc, have been discussed on numerous occasions.
They are needed to implement race-free filesystem traversal, they are
necessary to implement a virtual per-thread current working directory
(think multi-threaded backup software), etc.

We have in glibc today implementations of the interfaces which use the
/proc/self/fd magic.  But this code is rather expensive.  Here are some
results (similar to what Jim Meyering posted before):

The test creates a deep directory hierarchy on a tmpfs filesystem.
Then rm -fr is used to remove all directories.  Without syscall support
I get this:

real    0m31.921s
user    0m0.688s
sys     0m31.234s

With syscall support the results are much better:

real    0m20.699s
user    0m0.536s
sys     0m20.149s


The implemenation is really small:

 arch/i386/kernel/syscall_table.S |   11 ++
 arch/x86_64/ia32/ia32entry.S     |   11 ++
 fs/compat.c                      |   48 +++++++++--
 fs/exec.c                        |    2 
 fs/namei.c                       |  167 ++++++++++++++++++++++++++++++---------
 fs/open.c                        |   60 +++++++++++---
 fs/stat.c                        |   54 ++++++++++--
 include/asm-i386/unistd.h        |   13 ++-
 include/asm-x86_64/ia32_unistd.h |   13 ++-
 include/asm-x86_64/unistd.h      |   24 +++++
 include/linux/fcntl.h            |    7 +
 include/linux/fs.h               |    7 +
 include/linux/namei.h            |    7 -
 include/linux/time.h             |    2 
 14 files changed, 355 insertions(+), 71 deletions(-)

I've split the patch in three parts.  The first part is the actual
code change.  It mostly consists of passing down an additional parameter
with a file descriptor and add wrapper functions which pass down the
default parameter AT_FDCWD.  Three new constants are defined in
<linux/fcntl.h> which must correspond to the values already in use
in glibc.  In a few cases I've modified some code which would not
necesarily need changing but the change makes it a bit more efficient
in presence of the wrapper functions.

The real change needed is the additional else-clause in what is now
do_path_lookup.  That's it.

The other two patches contain the syscall definitions for x86 and x86-64.
I've tested the code on x86-64, including the ia32 compat code.  Because
there is no architecture specific change all should work well on other
archs once the syscalls are added.
