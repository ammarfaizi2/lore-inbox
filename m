Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbULPQkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbULPQkD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 11:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbULPQkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 11:40:02 -0500
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:57514 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S261523AbULPQjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 11:39:39 -0500
Subject: automated filesystem testing for multiple Linux fs
From: Steve French <smfrench@austin.rr.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, cliffw@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041216121151.GH8246@logos.cnet>
References: <41BDC9CD.60504@austin.rr.com>
	 <20041213092057.5bf773fb.cliffw@osdl.org> <41BDE0B4.6020003@austin.rr.com>
	 <41BDE2CF.9060402@austin.rr.com>  <20041216121151.GH8246@logos.cnet>
Content-Type: text/plain
Message-Id: <1103215183.12201.39.camel@smfhome.smfdom>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 16 Dec 2004 10:39:43 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-16 at 06:11, Marcelo Tosatti wrote:
> you mention several filesystem, that would increase the amount of results
>  dramatically.
> 

Selfishly, thinking about what I would like to see for Samba servers on
Linux ...  I could live with testing Samba well on a relatively small
number of local filesystems perhaps JFS or even XFS, but at least
testing on one local filesystem and CIFS (and even to a lesser extent
NFS) are needed for us to feel more comfortable with Samba/Linux.  Since
at present only XFS and JFS have the full combination of server
features: better quotas, DMAPI, xattr support, ACL support and
nanosecond file timestamps on disk - (and only JFS has case insensitive
format option which is useful for Samba benchmarking with Windows
clients), and since those two perform quite well on the Netbench
benchmark that is most quoted - those two local filesystems are of the
most interest to me (at least until future versions of Reiser or ext4
...).  For perf tests run Linux CIFS client to Samba/Linux  - JFS on the
server seems to perform best among the five major local filesystems so
far.

The somewhat harder part of course is adding in CIFS and perhaps NFSv3
and NFSv4 testing since that is a little harder to script the setup for
and a few small pieces of a couple of the fs functional tests only run
on a subset of the filesystems.  Part of the problem that I run into is
that LTP has lots of tests but the filesystem tests are rather strangely
not all in the kernel/testcases/fs directory - they are spread across
multiple directories including an nfs one (for the posix connectathon fs
test) and networking directory (e.g. for sendfile) and try finding the
flock and DNOTIFY and SETLEASE and GETLEASE calls ones and the ones that
hit O_DIRECT or O_ASYNC or test O_SYNC(the ones that might be Linux
specific or have slightly different Linux behavior like those are among
the more interesting but quite hard for me to find). 


> I would like to see different variations of memory size and CPU (1-2-4-8 CPU variation 
> is already being done by STP), have been asking Cliff for such functionality for 
> the past days.

That is useful but we need to walk before we run and address the
critical problems first.  I count at least four bad regressions in the
two big network filesystems caused by sideeffects of other vfs changes -
just this year.  We have need for much more basic functional tests and
perf test to prevent more regressions - e.g to catch earlier or avoid
completely cases like the mm writepage performance regression that hit
NFS earlier this year and again the bug that hit nfs that caused 2.6.8
-> 2.6.8.1 regression and the two vfs fcntl changes (dnotify and
posix_lock_file) that regressed cifs. Part of the problem is that AFAIK
we don't have a good Linux fcntl test suite that is easy enough to run
that everyone doing an fs runs it :) 

The other thing I noticed on the STP site is that the three types of
tests are not easily distinguished on the site:
	1) filesystem functional (e.g. connecathon "basic" and "special"
	 subtests, fsx, and some of the ltp tests etc.)
vs.
	2)filesystem stress testing (fsstress etc.)
vs.
	3) filesystem perf testing 
		microbenchmarks (iozone, bonnie etc.)
		bigger benchmarks (dbench, specsfs, specweb etc.)



