Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964770AbWHHLci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964770AbWHHLci (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 07:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWHHLci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 07:32:38 -0400
Received: from rere.qmqm.pl ([86.63.132.164]:6365 "EHLO rere.qmqm.pl")
	by vger.kernel.org with ESMTP id S964770AbWHHLch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 07:32:37 -0400
Date: Tue, 8 Aug 2006 13:32:27 +0200
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To: dm-devel@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: BUG/OOPS fix
Message-ID: <20060808113227.GA26434@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Previous copy probably got into redhat.com's spambox]

Fix BUG I tripped on while testing failover and multipathing.

BUG shows up on error path in multipath_ctr() when parse_priority_group() fails
after returning at least once without error. The fix is to initialize m->ti
early - just after alloc()ing it.

BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c027c3d2
*pde = 00000000
Oops: 0000 [#3]
Modules linked in: qla2xxx ext3 jbd mbcache sg ide_cd cdrom floppy
CPU:    0
EIP:    0060:[<c027c3d2>]    Not tainted VLI
EFLAGS: 00010202   (2.6.17.3 #1)
EIP is at dm_put_device+0xf/0x3b
eax: 00000001   ebx: ee4fcac0   ecx: 00000000   edx: ee4fcac0
esi: ee4fc4e0   edi: ee4fc4e0   ebp: 00000000   esp: c5db3e78
ds: 007b   es: 007b   ss: 0068
Process multipathd (pid: 15912, threadinfo=c5db2000 task=ef485a90)
Stack: ec4eda40 c02816bd ee4fc4c0 00000000 f7e89498 f883e0bc c02816f6 f7e89480
       f7e8948c c0281801 ffffffea f7e89480 f883e080 c0281ffe 00000001 00000000
       00000004 dfe9cab8 f7a693c0 f883e080 f883e0c0 ca4b99c0 c027c6ee 01400000
Call Trace:
 <c02816bd> free_pgpaths+0x31/0x45  <c02816f6> free_priority_group+0x25/0x2e
 <c0281801> free_multipath+0x35/0x67  <c0281ffe> multipath_ctr+0x123/0x12d
 <c027c6ee> dm_table_add_target+0x11e/0x18b  <c027e5b4> populate_table+0x8a/0xaf
 <c027e62b> table_load+0x52/0xf9  <c027ec23> ctl_ioctl+0xca/0xfc
 <c027e5d9> table_load+0x0/0xf9  <c0152146> do_ioctl+0x3e/0x43
 <c0152360> vfs_ioctl+0x16c/0x178  <c01523b4> sys_ioctl+0x48/0x60
 <c01029b3> syscall_call+0x7/0xb
Code: 97 f0 00 00 00 89 c1 83 c9 01 80 e2 01 0f 44 c1 88 43 14 8b 04 24 59 5b 5e 5f 5d c3 53 89 c1 89 d3 ff 4a 08 0f 94 c0 84 c0 74 2a <8b> 01 8b 10 89 d8 e8 f6 fb ff ff 8b 03 8b 53 04 89 50 04 89 02
EIP: [<c027c3d2>] dm_put_device+0xf/0x3b SS:ESP 0068:c5db3e78

Signed-off-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>

diff -urN linux-2.6.17.8-routes-esfq/drivers/md/dm-mpath.c linux-2.6.17.8-routes-esfq-mq/drivers/md/dm-mpath.c
--- linux-2.6.17.8-routes-esfq/drivers/md/dm-mpath.c	2006-07-05 18:29:10.000000000 +0200
+++ linux-2.6.17.8-routes-esfq-mq/drivers/md/dm-mpath.c	2006-08-07 15:25:07.000000000 +0200
@@ -711,6 +711,8 @@
 		return -EINVAL;
 	}
 
+	m->ti = ti;
+
 	r = parse_features(&as, m, ti);
 	if (r)
 		goto bad;
@@ -752,7 +754,6 @@
 	}
 
 	ti->private = m;
-	m->ti = ti;
 
 	return 0;

