Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265847AbUGHJcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265847AbUGHJcm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 05:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265939AbUGHJcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 05:32:42 -0400
Received: from rev.193.226.233.85.euroweb.hu ([193.226.233.85]:18325 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S265847AbUGHJci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 05:32:38 -0400
To: linux-kernel@vger.kernel.org
Subject: soft deadlock in blk_congestion_wait (2.6.7)
Message-Id: <E1BiVFa-0003uQ-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 08 Jul 2004 11:31:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While running LTP tests (more specifically the ftest* testcases) on
FUSE (http://sourceforge.net/projects/avf), I run into the following
problem: the process serving the FUSE filesystem requests does some
debugging write to an ext3 filesystem, and deadlocks in
blk_congestion_wait:

fusexmp       D C043E760     0  2130   2125                     (NOTLB)
c0c99c50 00200082 c09bb3f0 c043e760 00000664 c791f6b0 c043ec08 00000000
       c0c99c64 c0c99c50 00200246 00000801 f70d3b39 00000664 c09bb598 0066663b
       c0c99c64 c03ce968 c0c99c8c c033195e c0c99c64 0066663b c0115051 c0443f00
Call Trace:
 [<c033195e>] schedule_timeout+0x5e/0xb0
 [<c03318f1>] io_schedule_timeout+0x11/0x20
 [<c02275be>] blk_congestion_wait+0x6e/0x90
 [<c01369ce>] balance_dirty_pages+0xde/0x150
 [<c01332a4>] generic_file_aio_write_nolock+0x4f4/0xc00
 [<c0133ac1>] generic_file_aio_write+0x81/0xa0
 [<c018609f>] ext3_file_write+0x3f/0xd0
 [<c014eab7>] do_sync_write+0x87/0xc0
 [<c014eb9a>] vfs_write+0xaa/0x130
 [<c014ecbf>] sys_write+0x3f/0x60
 [<c010423b>] syscall_call+0x7/0xb

Some other process performing a read will kick it out of this coma,
but if left alone it will wait there forever.

The FUSE request being served is a write, called from
aops->commit_write().  So my guess is that the kernel does not handle
this sort of recursive write too well.  

Can someone explain what blk_congestion_wait() is waiting for, and why
does that event not happen?

I've seen a very similar report for CIFS here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=108807439504273&w=2

So it's not even FUSE specific, though it could be a bug in the
filesystems themselves in both cases, or possibly a core kernel bug.

Thanks,
Miklos
