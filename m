Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262481AbSKTVGq>; Wed, 20 Nov 2002 16:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262500AbSKTVGq>; Wed, 20 Nov 2002 16:06:46 -0500
Received: from air-2.osdl.org ([65.172.181.6]:20421 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262481AbSKTVGp>;
	Wed, 20 Nov 2002 16:06:45 -0500
Subject: Re: Call trace at mm/page-writeback.c in 2.5.47
From: Mark Haverkamp <markh@osdl.org>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1037826852.8555.83.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 20 Nov 2002 13:14:12 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-20 at 11:07, Andrew Morton wrote: 
> Mark Haverkamp wrote:
> > 
> > While running a memory stress workload test on a 16 processor numa
> > system, I received a number of call traces like the following:
> 
> What is the workload?  And in which journalling mode was ext3
> being used?

I am using bash-shared-mapping and the ext3 journaling mode was the
default.

> Was the workload actually being run against ext3?

Yes.

> > buffer layer error at mm/page-writeback.c:559
> > Pass this trace through ksymoops for reporting
> > Call Trace:
> >  [<c013f1fb>] __set_page_dirty_buffers+0x3b/0x150
> >  [<c012d746>] zap_pte_range+0x1d6/0x2c0
> >  [<c0183401>] do_get_write_access+0x4a1/0x4d0
> >  [<c012d89c>] zap_pmd_range+0x6c/0x80
> 
> A non-uptodate page mapped into pagetables.  I _think_ I
> can see how that can happen.  If the workload was, say,
> bash-shared-mapping...
> 
> If it is reproducible, does the removal of the ClearPageUptodate
> statement from mm/truncate.c:truncate_complete_page() make it
> go away?

I get about 10 of these each time I run.  Usually after a few minutes of
run time and all at once.  Then no more.

I tried your suggestion and still got the call traces:

buffer layer error at mm/page-writeback.c:559
Pass this trace through ksymoops for reporting
Call Trace:
 [<c0142fcb>] __set_page_dirty_buffers+0x3b/0x180
 [<c012fec6>] zap_pte_range+0x1d6/0x2c0
 [<c0188188>] do_get_write_access+0x508/0x530
 [<c013001c>] zap_pmd_range+0x6c/0x80
 [<c0130070>] unmap_page_range+0x40/0x60
 [<c01301a3>] zap_page_range+0x113/0x1e0
 [<c013109a>] vmtruncate_list+0x5a/0x80
 [<c013116f>] vmtruncate+0xaf/0x170
 [<c0161189>] inode_setattr+0x59/0x130
 [<c017fa5a>] ext3_setattr+0x16a/0x1e0
 [<c01613d6>] notify_change+0x106/0x216
 [<c0147648>] do_truncate+0x58/0x80
 [<c01494cc>] vfs_write+0xbc/0x180
 [<c0122d6b>] do_softirq+0x5b/0xc0
 [<c0147bb6>] sys_ftruncate64+0x106/0x120
 [<c0108ecf>] syscall_call+0x7/0xb

Mark.


-- 

Mark Haverkamp <markh@osdl.org>

