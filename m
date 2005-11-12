Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbVKLOMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbVKLOMR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 09:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbVKLOMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 09:12:17 -0500
Received: from mx.meyering.net ([82.230.74.64]:37050 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S932378AbVKLOMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 09:12:17 -0500
From: Jim Meyering <jim@meyering.net>
To: linux-kernel@vger.kernel.org
Cc: bug-gnulib@gnu.org
Subject: why we need openat et al in the kernel
Date: Sat, 12 Nov 2005 15:12:15 +0100
Message-ID: <87oe4qez0g.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ I have to preface this by saying I'm not interested in the
  attribute-related semantics of openat, but rather in the
  fd-relative-open--related semantics.  ]

Why do we need openat and related functions in the kernel?

  Without openat-like functions[1], it is impossible to process
  an arbitrarily deep hierarchy (efficiently) or even a single
  arbitrarily-distant file without changing the working directory.
  Even on systems with no PATH_MAX limitation, it is prohibitively
  expensive (O(depth**2)) to process a deep hierarchy without
  changing the working directory or using openat-like functions.

  What's wrong with changing the working directory?

    - it makes the code non-reentrant.  Imagine a function that processes
      a directory hierarchy.  In order to deal with an arbitrarily deep
      hierarchy, it uses open and fchdir as it traverses the tree.  If
      this function is called in a multi-threaded application, other
      threads may find the current working directory changed out from
      under them.

    - it may make it impossible to return to the original working directory.
      For example, consider the command `rm -r /tmp/deep dot-relative'.
      Removing /tmp/deep may require changing into /tmp/deep then
      /tmp/deep/sub, then /tmp/deep/sub/2, ...  If the initial working
      directory was not readable (so couldn't be opened) and getcwd fails,
      then there is no way to return and remove.  Yes, this is contrived :-)

Note that glibc (as of Nov 11, 2005) provides openat et. al., but that
its implementation relies on the /proc file system, which isn't always
usable, even on systems with the required kernel options: e.g., in a
restrictive chroot environment.

Why does openat have to be implemented in the kernel?
Because any emulation cannot be 100% effective.  Gnulib's
save_cwd fails if the working directory is not readable
and too deep for getcwd.  restore_cwd can fail if save_cwd
failed to get a file descriptor and the original directory
is gone or inaccessible.

So, is there any interest in adding these functions,
independent of the attribute-related debate?

Jim

[1] The list of functions Solaris provides: openat, fchownat, fstatat,
futimesat, renameat, unlinkat.  Plus, a library-level function: fdopendir.
In rewriting GNU rm (coreutils/src/remove.c) to use these functions,
I've identified one more that is required: euidaccessat.
