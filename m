Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318060AbSIEStO>; Thu, 5 Sep 2002 14:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318061AbSIEStO>; Thu, 5 Sep 2002 14:49:14 -0400
Received: from citi.umich.edu ([141.211.92.141]:50576 "HELO citi.umich.edu")
	by vger.kernel.org with SMTP id <S318060AbSIEStM>;
	Thu, 5 Sep 2002 14:49:12 -0400
Date: Thu, 5 Sep 2002 14:53:48 -0400 (EDT)
From: Chuck Lever <cel@citi.umich.edu>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
In-Reply-To: <3D77A22A.DC3F4D1@zip.com.au>
Message-ID: <Pine.BSO.4.33.0209051439540.12826-100000@citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2002, Andrew Morton wrote:

> That all assumes SMP/preempt.  If you're seeing these problems on
> uniproc/non-preempt then something fishy may be happening.

sorry, forgot to mention:  the system is UP, non-preemptible, high mem.

invalidate_inode_pages isn't freeing these pages because the page count is
two.  perhaps the page count semantics of one of the page cache helper
functions has changed slightly.  i'm still diagnosing.

fortunately the problem is deterministically reproducible.  basic test6,
the readdir test, of 2002 connectathon test suite, fails -- either a
duplicate file entry or a missing file entry appears after some standard
file creation and removal processing in that directory.  the incorrect
entries occur because the NFS client zaps the directory's page cache to
force the next reader to re-read the directory from the server.  but
invalidate_inode_pages decides to leave the pages in the cache, so the
next reader gets stale cached data instead.

> But be aware that invalidate_inode_pages has always been best-effort.
> If someone is reading, or writing one of those pages then it
> certainly will not be removed.  If you need assurances that the
> pagecache has been taken down then we'll need something stronger
> in there.

right, i've always wondered why the NFS client doesn't use
truncate_inode_pages, or something like it, instead.  that can wait for
another day, though.  :-)

	- Chuck Lever
--
corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>

