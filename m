Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTKRBGt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 20:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbTKRBGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 20:06:49 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:13727 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S262196AbTKRBGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 20:06:47 -0500
Date: Mon, 17 Nov 2003 17:06:43 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1549] New: /bin/sync hangs running reaim on 8-way	x86 using ext2 file system
Message-ID: <61180000.1069117603@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1549

           Summary: /bin/sync hangs running reaim on 8-way x86 using ext2
                    file system
    Kernel Version: 2.6.0-test9-bk19
            Status: NEW
          Severity: normal
             Owner: akpm@digeo.com
         Submitter: dmo@osdl.org


Distribution:rh9
Hardware Environment:8-processor, 700 mgz pentium III, 8 gibabytes memory
Software Environment:reaim test:http://sourceforge.net/projects/re-aim-7
Problem Description: test hangs because /bin/sync never completes.  The sync
binaries are usually hung either trying to lock a page in the page cache (this
is the most common case):
sync          D DA1D1E3C  4048 13674      1         13807 13806 (NOTLB)
da1d1e48 00000082 da1d0000 da1d1e3c c0231e48 f70f6c00 f69c6a00 c0226e16
       f69c6a00 c633cbc0 f69c6a00 f69c6a00 dd7d0040 c633cbc0 000038ea ef356c53
       00000092 f700e040 c633cbc0 c11a2908 c6281bf4 da1d1e54 c011e7f8 00000000
Call Trace:
 [<c0231e48>] deadline_next_request+0x28/0x40
 [<c0226e16>] elv_next_request+0x16/0x110
 [<c011e7f8>] io_schedule+0x28/0x40
 [<c013e8ef>] __lock_page+0xbf/0xf0
 [<c011fb10>] autoremove_wake_function+0x0/0x50
 [<c011fb10>] autoremove_wake_function+0x0/0x50
 [<c0185748>] mpage_writepages+0x318/0x350
 [<c0167ca0>] blkdev_writepage+0x0/0x30
 [<c01691ff>] generic_writepages+0x1f/0x23
 [<c014447e>] do_writepages+0x1e/0x40
 [<c013e209>] __filemap_fdatawrite+0xe9/0x110
 [<c013e247>] filemap_fdatawrite+0x17/0x20
 [<c0160ac6>] sync_blockdev+0x26/0x50
 [<c01840d9>] sync_inodes+0x89/0xa0
 [<c0160c54>] do_sync+0x44/0x70
 [<c0160c8f>] sys_sync+0xf/0x20
 [<c0109729>] sysenter_past_esp+0x52/0x71

This happens with both deadline and anticipatory IO schedulers.
It happens about once every 3 or 4 runs of the "database" form of the
test.

Steps to reproduce:

submit the reaim test to an stp8 machine.  specify no arguments to the reaim
will run the database test form.  It may take 3 or 4 runs to observe this
test failure.  Watch for tests that run for more than 3 hours. This also happens
less frequently on a four-way machine.

