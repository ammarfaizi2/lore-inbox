Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263600AbUE1QEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbUE1QEa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 12:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbUE1QE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 12:04:29 -0400
Received: from 8.75.30.213.rev.vodafone.pt ([213.30.75.8]:46859 "EHLO
	odie.graycell.biz") by vger.kernel.org with ESMTP id S263600AbUE1QEX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 12:04:23 -0400
Subject: Re: Process hangs on blk_congestion_wait copying large file to
	cifs filesystem
From: Nuno Ferreira <nuno.ferreira@graycell.biz>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040528142239.GK20657@suse.de>
References: <1085672706.4350.9.camel@taz.graycell.biz>
	 <1085753249.2219.13.camel@taz.graycell.biz>
	 <20040528142239.GK20657@suse.de>
Content-Type: text/plain
Organization: Graycell
Date: Fri, 28 May 2004 17:04:20 +0100
Message-Id: <1085760260.2422.11.camel@taz.graycell.biz>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 May 2004 16:00:23.0329 (UTC) FILETIME=[E2433910:01C444CC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sex, 2004-05-28 at 16:22 +0200, Jens Axboe wrote:
> On Fri, May 28 2004, Nuno Ferreira wrote:
> > On Qui, 2004-05-27 at 16:45 +0100, Nuno Ferreira wrote:
> > > Hi,
> > > I'm trying to copy a large file (200Mb or bigger) from an ext3
> > > filesystem to a windows share mounted using CIFS and the cp process
> > > hangs, sometimes for a long time (several minutes).
> > > Calling ps, I can see that it's blocking on blk_congestion_wait. 
[...]
> 
> A sysrq-t back trace of that process would be interesting to see.

OK, apparently now the cp never finishes and nothing gets written to
disk, so i could not get the full output from sysrq-t.
I wrote the call stack from the process, it that enough?
The call stack from the cp process:
__make_request
schedule_timeout
process_timeout
io_schedule_timeout
blk_congestion_wait
autoremove_wake_function
autoremove_wake_function
get_dirty_limits
balance_dirty_pages
generic_file_aio_write_nolock
__copy_to_user_ll
file_read_actor
__generic_file_aio_read
file_read_actor
generic_file_write_nolock
do_sync_read
do_IRQ
common_interrupt
generic_file_write
cifs_write_wrapper
do_sync_read
vfs_write
sys_write
syscall_call

Also the call from a vi process that was called after the cp reached
that state and was also blocked
schedule_timeout
ext3_mark_inode_dirty
process_timeout
io_schedule_timeout
blk_congestion_wait
autoremove_wake_function
get_dirty_limits
balance_dirty_pages
generic_file_aio_write_nolock
buffered_rmqueue
__alloc_pages
generic_file_aio_write
ext2_file_write
do_sync_write
do_lookup
path_release
sys_access
vfs_write
sys_write
syscall_call

If more detail is needed I can try to capture it but syslog not writing
to disk I don't know how to capture the sysrq-t output

Thanks
-- 
Nuno Ferreira

