Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWHUSuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWHUSuJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 14:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWHUSt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 14:49:56 -0400
Received: from cantor2.suse.de ([195.135.220.15]:22461 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750778AbWHUStu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 14:49:50 -0400
Date: Mon, 21 Aug 2006 11:48:07 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, agk@redhat.com,
       mirq-linux@rere.qmqm.pl, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 17/20] dm: BUG/OOPS fix
Message-ID: <20060821184807.GS21938@kroah.com>
References: <20060821183818.155091391@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="dm-bug-oops-fix.patch"
In-Reply-To: <20060821184527.GA21938@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Michal Miroslaw <mirq-linux@rere.qmqm.pl>

Fix BUG I tripped on while testing failover and multipathing.

BUG shows up on error path in multipath_ctr() when parse_priority_group()
fails after returning at least once without error.  The fix is to
initialize m->ti early - just after alloc()ing it.

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

Signed-off-by: Michal Miroslaw <mirq-linux@rere.qmqm.pl>
Acked-by: Alasdair G Kergon <agk@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/md/dm-mpath.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.17.9.orig/drivers/md/dm-mpath.c
+++ linux-2.6.17.9/drivers/md/dm-mpath.c
@@ -711,6 +711,8 @@ static int multipath_ctr(struct dm_targe
 		return -EINVAL;
 	}
 
+	m->ti = ti;
+
 	r = parse_features(&as, m, ti);
 	if (r)
 		goto bad;
@@ -752,7 +754,6 @@ static int multipath_ctr(struct dm_targe
 	}
 
 	ti->private = m;
-	m->ti = ti;
 
 	return 0;
 

--
