Return-Path: <linux-kernel-owner+w=401wt.eu-S1750824AbXAHX5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbXAHX5b (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 18:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbXAHX5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 18:57:31 -0500
Received: from smtp.osdl.org ([65.172.181.24]:55888 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743AbXAHX5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 18:57:30 -0500
Date: Mon, 8 Jan 2007 15:56:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Chinner <dgc@sgi.com>
Cc: linux-kernel Mailing List <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: xfs_file_ioctl / xfs_freeze: BUG: warning at
 kernel/mutex-debug.c:80/debug_mutex_unlock()
Message-Id: <20070108155636.a68dce33.akpm@osdl.org>
In-Reply-To: <20070107213734.GS44411608@melbourne.sgi.com>
References: <20070104001420.GA32440@m.safari.iki.fi>
	<20070107213734.GS44411608@melbourne.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2007 08:37:34 +1100
David Chinner <dgc@sgi.com> wrote:

> On Thu, Jan 04, 2007 at 02:14:21AM +0200, Sami Farin wrote:
> > just a simple test I did...
> > xfs_freeze -f /mnt/newtest
> > cp /etc/fstab /mnt/newtest
> > xfs_freeze -u /mnt/newtest
> > 
> > 2007-01-04 01:44:30.341979500 <4>BUG: warning at kernel/mutex-debug.c:80/debug_mutex_unlock()
> > 2007-01-04 01:44:30.385771500 <4> [<c0103cfb>] dump_trace+0x215/0x21a
> > 2007-01-04 01:44:30.385774500 <4> [<c0103da3>] show_trace_log_lvl+0x1a/0x30
> > 2007-01-04 01:44:30.385775500 <4> [<c0103dcb>] show_trace+0x12/0x14
> > 2007-01-04 01:44:30.385777500 <4> [<c0103ec8>] dump_stack+0x19/0x1b
> > 2007-01-04 01:44:30.385778500 <4> [<c013a3af>] debug_mutex_unlock+0x69/0x120
> > 2007-01-04 01:44:30.385779500 <4> [<c04b4aac>] __mutex_unlock_slowpath+0x44/0xf0
> > 2007-01-04 01:44:30.385780500 <4> [<c04b4887>] mutex_unlock+0x8/0xa
> > 2007-01-04 01:44:30.385782500 <4> [<c018d0ba>] thaw_bdev+0x57/0x6e
> > 2007-01-04 01:44:30.385791500 <4> [<c026a6cf>] xfs_ioctl+0x7ce/0x7d3
> > 2007-01-04 01:44:30.385793500 <4> [<c0269158>] xfs_file_ioctl+0x33/0x54
> > 2007-01-04 01:44:30.385794500 <4> [<c01793f2>] do_ioctl+0x76/0x85
> > 2007-01-04 01:44:30.385795500 <4> [<c0179570>] vfs_ioctl+0x59/0x1aa
> > 2007-01-04 01:44:30.385796500 <4> [<c0179728>] sys_ioctl+0x67/0x77
> > 2007-01-04 01:44:30.385797500 <4> [<c0102e73>] syscall_call+0x7/0xb
> > 2007-01-04 01:44:30.385799500 <4> [<001be410>] 0x1be410
> > 2007-01-04 01:44:30.385800500 <4> =======================
> > 
> > fstab was there just fine after -u.
> 
> Oh, that still hasn't been fixed? Generic bug, not XFS - the global
> semaphore->mutex cleanup converted the bd_mount_sem to a mutex, and
> mutexes complain loudly when a the process unlocking the mutex is
> not the process that locked it.
> 
> Basically, the generic code is broken - the bd_mount_mutex needs to
> be reverted back to a semaphore because it is locked and unlocked
> by different processes. The following patch does this....
> 
> ...
> 
> Revert bd_mount_mutex back to a semaphore so that xfs_freeze -f /mnt/newtest;
> xfs_freeze -u /mnt/newtest works safely and doesn't produce lockdep warnings.

Sad.  The alternative would be to implement
mutex_unlock_dont_warn_if_a_different_task_did_it().  Ingo?  Possible?

