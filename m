Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318022AbSIESZd>; Thu, 5 Sep 2002 14:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318027AbSIESZd>; Thu, 5 Sep 2002 14:25:33 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:49413 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S318022AbSIESZc>; Thu, 5 Sep 2002 14:25:32 -0400
Message-ID: <3D77A22A.DC3F4D1@zip.com.au>
Date: Thu, 05 Sep 2002 11:27:54 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chuck Lever <cel@citi.umich.edu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
References: <Pine.LNX.4.44.0209051023490.5579-100000@dexter.citi.umich.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Lever wrote:
> 
> hi all-
> 
> it appears that changes in or around invalidate_inode_pages that went into
> 2.5.32/3 have broken certain cache behaviors that the NFS client depends
> on.  when the NFS client calls invalidate_inode_pages to purge directory
> data from the page cache, sometimes it works as before, and sometimes it
> doesn't, leaving stale pages in the page cache.
> 
> i don't know much about the MM, but i can reliably reproduce the problem.
> what more information can i provide?  please copy me, as i'm not a member
> of the linux-kernel mailing list.

The locking became finer-grained.

Up to 2.5.31 or thereabouts, invalidate_inode_pages was grabbing
the global pagemap_lru_lock and walking all the inodes pages inside
that lock.  This basically shuts down the entire VM for the whole
operation.

In 2.5.33, that lock is per-zone, and invalidate takes it on a 
much more fine-grained basis.

That all assumes SMP/preempt.  If you're seeing these problems on
uniproc/non-preempt then something fishy may be happening.

But be aware that invalidate_inode_pages has always been best-effort.
If someone is reading, or writing one of those pages then it
certainly will not be removed.  If you need assurances that the
pagecache has been taken down then we'll need something stronger
in there.
