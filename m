Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWJTKP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWJTKP6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 06:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWJTKP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 06:15:58 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:29700 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S932245AbWJTKP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 06:15:57 -0400
Message-ID: <4538A196.1040705@shadowen.org>
Date: Fri, 20 Oct 2006 11:14:46 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, Zach Brown <zach.brown@oracle.com>,
       ext4 <linux-ext4@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc2-mm1 warning in invalidate_inode_pages2_range()
References: <1161297546.26843.33.camel@dyn9047017100.beaverton.ibm.com>	 <20061019160225.fee4c25f.akpm@osdl.org> <1161299545.26843.41.camel@dyn9047017100.beaverton.ibm.com>
In-Reply-To: <1161299545.26843.41.camel@dyn9047017100.beaverton.ibm.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> On Thu, 2006-10-19 at 16:02 -0700, Andrew Morton wrote:
>> On Thu, 19 Oct 2006 15:39:06 -0700
>> Badari Pulavarty <pbadari@us.ibm.com> wrote:
>>
>>> Hi Zach,
>>>
>>> While running IO tests I get following messages on 2.6.19-rc2-mm1
>>>
>>> BUG: warning at mm/truncate.c:400/invalidate_inode_pages2_range()
>>>
>>> Call Trace:
>>>  [<ffffffff8020b481>] show_trace+0x41/0x70
>>>  [<ffffffff8020b4c2>] dump_stack+0x12/0x20
>>>  [<ffffffff80257f17>] invalidate_inode_pages2_range+0x297/0x2e0
>>>  [<ffffffff8024fcb5>] generic_file_direct_IO+0xf5/0x130
>>>  [<ffffffff8024fd64>] generic_file_direct_write+0x74/0x140
>>>  [<ffffffff802507cc>] __generic_file_aio_write_nolock+0x36c/0x4b0
>>>  [<ffffffff80250977>] generic_file_aio_write+0x67/0xd0
>>>  [<ffffffff8808f6d3>] :ext4dev:ext4_file_write+0x23/0xc0
>>> DWARF2 unwinder stuck at ext4_file_write+0x23/0xc0 [ext4dev]
>>> Leftover inexact backtrace:
>>>  [<ffffffff8027379f>] do_sync_write+0xcf/0x120
>>>  [<ffffffff802772b7>] cp_new_stat+0xe7/0x100
>>>  [<ffffffff8023db90>] autoremove_wake_function+0x0/0x30
>>>  [<ffffffff804805bf>] __mutex_lock_slowpath+0x1df/0x1f0
>>>  [<ffffffff8027408d>] vfs_write+0xbd/0x180
>>>  [<ffffffff802747b3>] sys_write+0x53/0x90
>>>  [<ffffffff80209c1e>] system_call+0x7e/0x83
>>>
>> that's warning that we weren't able to invalidate some pagecache.  That's
>> not really suprising.  Perhaps we should be more careful in deciding when
>> to fail the call (ie: leaving behind a clean page is ok, leaving behind a
>> dirty page is bad).
>>
>> Probably it's leaving behind dirty pagecache and you're about to lose your
>> data.  Which I bet is your own darn fault for doing silly things.
>>
>> What workload was in use?
> 
> Running fsx and fsstress.

I have the same thing popping out on our automated testing.  I can
confirm its been there since at least 2.6.19-rc1-git8, though -git7
failed for different reasons and could have the issue too.

/me pokes in git.  Oh, in fact we may or may not have been seeing this
further back as this debug appears to have been introduce by akpm in
2.6.19-rc1-git8.

commit 8258d4a574d3a8c01f0ef68aa26b969398a0e140
Author: Andrew Morton <akpm@osdl.org>
Date:   Wed Oct 11 01:21:53 2006 -0700

    [PATCH] invalidate_inode_pages2_range() debug

Ok, so this doesn't fail on every platform regularly.  The one I am
seeing it on a blade, with and ext3 root filesystem.  This was with
fsx-linux.

BUG: warning at mm/truncate.c:398/invalidate_inode_pages2_range()

Call Trace:
 [<ffffffff802684f7>] invalidate_inode_pages2_range+0x257/0x277
 [<ffffffff8026244a>] generic_file_direct_IO+0xce/0xe9
 [<ffffffff802624cc>] generic_file_direct_write+0x67/0x110
 [<ffffffff80262e19>] __generic_file_aio_write_nolock+0x2b7/0x365
 [<ffffffff8026241e>] generic_file_direct_IO+0xa2/0xe9
 [<ffffffff80262f2e>] generic_file_aio_write+0x67/0xc7
 [<ffffffff802ca30e>] ext3_file_write+0x16/0x91
 [<ffffffff802852dc>] do_sync_write+0xc9/0x10c
 [<ffffffff802450ce>] autoremove_wake_function+0x0/0x2e
 [<ffffffff80285aea>] vfs_write+0xce/0x174
 [<ffffffff802860a7>] sys_write+0x45/0x6e
 [<ffffffff80209b6e>] system_call+0x7e/0x83

But I have one report of the same error on ReiserFS over nbd, with
fsstress according to the report:

Badness in invalidate_inode_pages2_range at mm/truncate.c:399
Call Trace:
[C00000007476EEB0] [C00000000000EDF4] .show_stack+0x68/0x1b0 (unreliable)
[C00000007476EF50] [C000000000022730] .program_check_exception+0x1b8/0x5ac
[C00000007476EFF0] [C0000000000047EC] program_check_common+0xec/0x100
--- Exception: 700 at .invalidate_inode_pages2_range+0x2d8/0x330
    LR = .invalidate_inode_pages2_range+0x264/0x330
[C00000007476F430] [C000000000096CE4] .generic_file_direct_IO+0x11c/0x15c
[C00000007476F4E0] [C000000000096DB0] .generic_file_direct_write+0x8c/0x16c
[C00000007476F5A0]
[C000000000097978] .__generic_file_aio_write_nolock+0x318/0x3e0
[C00000007476F6D0] [C000000000097AC0] .generic_file_aio_write+0x80/0x114
[C00000007476F790] [C0000000000C2C64] .do_sync_write+0xd8/0x138
[C00000007476F920] [C00000000012BF50] .reiserfs_file_write+0x1e4c/0x1f9c
[C00000007476FCF0] [C0000000000C36FC] .vfs_write+0xd0/0x1b4
[C00000007476FD90] [C0000000000C3E1C] .sys_write+0x4c/0x8c
[C00000007476FE30] [C00000000000871C] syscall_exit+0x0/0x40

-apw
