Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbVK0WGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbVK0WGq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 17:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVK0WGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 17:06:46 -0500
Received: from mx.meyering.net ([82.230.74.64]:16789 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S1751158AbVK0WGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 17:06:45 -0500
From: Jim Meyering <jim@meyering.net>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, bug-coreutils@gnu.org
Subject: another reason to add openat in the kernel: efficiency
In-Reply-To: <E1EZx6Q-0002zw-00@dorka.pomaz.szeredi.hu>
Date: Sun, 27 Nov 2005 23:06:38 +0100
Message-ID: <87acfpn3td.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> What's wrong with using '/proc/self/fd/N' to implement [openat et al]?

It's great that we can emulate openat and related fd-relative
functions using /proc/self/fd/N/FILE, but that is markedly less
efficient than a native implementation.

Here's some real data for comparison.
The problem: remove a just-created hierarchy named
/t/z/z/.../z (1,000,000 levels deep) residing on a tmpfs file system.

Using GNU rm -rf (from coreutils-5.93[1]), that takes about 14s wall clock
time on an otherwise idle system running 2.6.14.  The 5.93 implementation
uses open, fchdir, fstat, opendir/readdir, unlink, etc. to do its job:
i.e., no openat-related functions.

Compare that with GNU rm from the latest CVS sources[2], now f?chdir-free,
using /proc-based openat emulation (including emulation of fdopendir[3],
fstatat, and unlinkat).  Here, the time required about 35 seconds:
more than double.  Even after rewriting the emulation code not to use
snprintf, the resulting times were still about 30s.

Contrast that with Solaris 9 (with kernel-provided openat, fstatat,
fdopendir, etc.), where the openat-based implementation takes
20% *less* time than the 5.93 implementation.

Sure, there may well be other factors that explain some of the difference,
but it'd be nice to avoid the added time and space(stack) overhead of
encoding and decoding each /proc-relative file name.  Of course,
syscall-based interfaces also have the advantage of working even if
/proc is not accessible.


Jim

[1] ftp://ftp.gnu.org/gnu/coreutils/coreutils-5.93.tar.bz2
[2] http://savannah.gnu.org/projects/coreutils/
[3] It's a shame to have to emulate fdopendir via `opendir ("/proc/...',
but that's only temporary, while we wait for glibc-with-fdopendir
to become more mainstream.
