Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWGaG3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWGaG3d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 02:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWGaG3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 02:29:33 -0400
Received: from liaag2ab.mx.compuserve.com ([149.174.40.153]:23221 "EHLO
	liaag2ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750762AbWGaG3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 02:29:32 -0400
Date: Mon, 31 Jul 2006 02:21:58 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: fctnl(F_SETSIG) no longer works in 2.6.17, does in
  2.6.16.
To: Orion Poplawski <orion@cora.nwra.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Message-ID: <200607310224_MC3-1-C689-D6DD@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <eabdhq$nca$1@sea.gmane.org>

On Thu, 27 Jul 2006 16:08:53 -0600, Orion Poplawski wrote:
>
> fctnl(F_SETSIG) no longer works in 2.6.17, does in 2.6.16.
>
> The attached program (oplocktest.c) illustrates.

I added some debug statements to your code:

=>      printf("before setlease: signal number = %d\n", fcntl(fd, F_GETSIG));
        ret = fcntl(fd, F_SETLEASE, leasetype);
        if (ret == -1 && errno == EACCES) {
                set_capability(CAP_LEASE);
                ret = fcntl(fd, F_SETLEASE, leasetype);
        }
=>      printf("after setlease: signal number = %d\n", fcntl(fd, F_GETSIG));

And I get:

before setlease: signal number = 34
after setlease: signal number = 0

So the fcntl(F_SETLEASE) is resetting the signal number.  I don't think
it's supposed to do that.

That seems to be caused by:

| From: Trond Myklebust <Trond.Myklebust@netapp.com>
| Date: Mon, 20 Mar 2006 18:44:05 +0000 (-0500)
| Subject: VFS: Fix __posix_lock_file() copy of private lock area
| X-Git-Tag: v2.6.17-rc1
| X-Git-Url: http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=47831
|
| VFS: Fix __posix_lock_file() copy of private lock area
|
| The struct file_lock->fl_u area must be copied using the fl_copy_lock()
| operation.

In this change:

|  */
| void locks_copy_lock(struct file_lock *new, struct file_lock *fl)
| {
|+       locks_release_private(new);
|+
|        new->fl_owner = fl->fl_owner;
|        new->fl_pid = fl->fl_pid;
|        new->fl_file = fl->fl_file;

Which ends up calling this:

static void lease_release_private_callback(struct file_lock *fl)
{
        if (!fl->fl_file)
                return;

        f_delown(fl->fl_file);
=>      fl->fl_file->f_owner.signum = 0;
}

I'm not sure how to fix it, though (if that's really the problem, but I
think it is.)

-- 
Chuck

