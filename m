Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbTJIXRY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 19:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbTJIXRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 19:17:23 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:7921 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S262652AbTJIXRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 19:17:22 -0400
Date: Thu, 9 Oct 2003 17:16:52 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Ulrich Drepper <drepper@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
Message-ID: <20031009171652.K1593@schatzie.adilger.int>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Ulrich Drepper <drepper@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <16261.56894.8109.858323@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16261.56894.8109.858323@charged.uio.no>; from trond.myklebust@fys.uio.no on Thu, Oct 09, 2003 at 06:16:30PM -0400
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 09, 2003  18:16 -0400, Trond Myklebust wrote:
>   We appear to have a problem with the new statfs interface
> in 2.6.0...
> 
> The problem is that as far as userland is concerned, 'struct statfs'
> reports f_blocks, f_bfree,... in units of the "optimal transfer size":
> f_bsize (backwards compatibility).
> 
> OTOH 'struct statvfs' reports the same values in units of the fragment
> size (the blocksize of the underlying filesyste): f_frsize. (says
> Single User Spec v2)
> 
> Both are apparently supposed to syscall down via sys_statfs()...
> 
> Question: how we're supposed to reconcile the two cases for something
> like NFS, where these 2 values are supposed to differ?

Actually, what is also a problem is that there is no hook for the system
to return different results for the 32-bit and 64-bit statfs structs.
Because Lustre is used on very large filesystems (i.e. 100TB+) we can't
fit the result into 32 bits without increasing f_bsize and reducing
f_bavail/f_bfree/f_blocks proportionately.

It would be nice if we could know in advance if we are returning values
for sys_statfs() or sys_statfs64() (e.g. by sys_statfs64() calling an
optional sb->s_op->statfs64() method if available) so we didn't have to
do this munging.  We can't just assume 64-bit results, or callers of
sys_statfs() will get EOVERFLOW instead of slightly innacurate results.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

