Return-Path: <linux-kernel-owner+w=401wt.eu-S965472AbWLPRjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965472AbWLPRjw (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 12:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965465AbWLPRjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 12:39:51 -0500
Received: from sbcs.cs.sunysb.edu ([130.245.1.15]:48681 "EHLO
	sbcs.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965463AbWLPRju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 12:39:50 -0500
Date: Sat, 16 Dec 2006 12:39:45 -0500 (EST)
From: Nikolai Joukov <kolya@cs.sunysb.edu>
X-X-Sender: kolya@compserv1
To: Al Boldi <a1426z@gawab.com>
cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: [ANNOUNCE] RAIF: Redundant Array of Independent Filesystems
In-Reply-To: <200612161635.49502.a1426z@gawab.com>
Message-ID: <Pine.GSO.4.53.0612161118010.24531@compserv1>
References: <Pine.GSO.4.53.0612122217360.22195@compserv1>
 <200612150802.55396.a1426z@gawab.com> <Pine.GSO.4.53.0612151156130.26813@compserv1>
 <200612161635.49502.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am looking at filling the net-pipe, and it only reaches 40-75% max, with
> some short 100% bursts, and a slow 10% start.  It seems that caching
> somewhat delays the writes, which then batch up and sync at various speeds.
> So you have the cache really hiding slow sync speeds.  To tune this, it may
> be helpful to turn off caching, which in turn could surface the actual
> bottlenecks.

Well, RAIF is an external kernel module and as such cannot change the
caching behavior much.  The notorious problem of all Linux stackable file
systems is double-caching of data.  Every stackable file system caches the
data at its own level and copies it from/to the lower file system's cached
pages when necessary.  This has some advantages for file systems that
change the data (e.g., encrypt or compress).  However, this effectively
reduces the system's cache memory size by two or more times.

Among all the existing stackable file systems, Tracefs and RAIF have the
highest requirements for low overheads.  Here are the solutions to the
double-caching problem that we tried:

1. Redirect read and write requests to the lower file systems directly.
   This allows to avoid caching of data at the RAIF level.  However, this
   optimization must be turned off as soon as a file is mmap'ed to avoid
   cache inconsistencies.  Also, even if the file is not mmap'ed, RAIF1
   still keeps the data copies for all the lower branches.  This
   optimization is implemented in RAIF but is not turned on by default.
   (We strip this and many other #ifdef'ed code fragments from the
   code releases automatically.)

2. We cache the data at the RAIF level.  When we write to the lower file
   systems we do allocate the lower pages and do copy the data but we
   also mark the lower pages with PG_reclaim flag before calling the
   lower writepage operation.  This releases all the lower pages right
   after the write completes.  This works fine for mmap'ed files and this
   is the default RAIF behavior now.  This solves the problem for most
   workloads that mix reads and writes.  For example, it improved
   Postmark's performance several times.  Unfortunately, this optimization
   does not improve performance for big sequential writes - the workload
   that you tried.  So essentially, you had a quarter of your original page
   cache while running your workload.

3. A known ideal solution for this problem is sharing of the cached pages
   between file systems.  We attempted to do it for Tracefs but the
   resulting code is not beautiful and is potentially racy:
   <http://marc.theaimsgroup.com/?l=linux-fsdevel&m=113193082115222&w=2>
   Unfortunately, for fan-out file systems this solution requires even
   more support from the OS.  However, this is what most OSs do
   (including BSD and Windows) but unfortunately not Linux :-(

> little overhead.  So for RAIF to be viable, it needs to have low overhead,
> which doesn't seem impossible to implement, given RAIF's simple but
> beautiful approach.

Thanks a lot!

Nikolai.
---------------------
Nikolai Joukov, Ph.D.
Filesystems and Storage Laboratory
Stony Brook University
