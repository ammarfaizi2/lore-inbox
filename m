Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVEAF7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVEAF7m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 01:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbVEAF7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 01:59:42 -0400
Received: from fsmlabs.com ([168.103.115.128]:14502 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261539AbVEAF7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 01:59:33 -0400
Date: Sun, 1 May 2005 00:02:13 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] xprt.c use after free of work_structs
Message-ID: <Pine.LNX.4.61.0504302142460.9467@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This bug was first observed in 2.6.11-rc1-mm2 but i couldn't find the 
exact patch which would unmask it. The work_structs embedded in rpc_xprt 
are freed in xprt_destroy without waiting for all scheduled work to be 
completed, resulting in quite a kerfuffle. Since xprt->timer callback can 
schedule new work, flush the workqueue after killing the timer.

Unmounting NFS filesystems:  RPC: error 5 connecting to server localhost
RPC: failed to contact portmap (errno -5).
general protection fault: 0000 [1]
CPU 0
Modules linked in:
Pid: 4, comm: events/0 Not tainted 2.6.12-rc1-mm2-hotplug_cpu
RIP: 0010:[<ffffffff8013de9a>] <ffffffff8013de9a>{worker_thread+373}
RSP: 0018:ffff81003fd33e88  EFLAGS: 00010083
RAX: 6b6b6b6b6b6b6b6b RBX: ffff81003fe15968 RCX: ffff81003e16b840
RDX: 6b6b6b6b6b6b6b6b RSI: ffff81003e16b848 RDI: 6b6b6b6b6b6b6b6b
RBP: ffff81003fe15978 R08: 6b6b6b6b6b6b6b6b R09: 0000000000000000
R10: ffff81003e994198 R11: 0000000000040001 R12: ffff81003fe15998
R13: ffff81003fd33ec8 R14: 0000000000000000 R15: ffffffff80687fb0
FS:  0000000000000000(0000) GS:ffffffff8067b880(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aaaacfb9000 CR3: 000000003dedc000 CR4: 00000000000006e0
Process events/0 (pid: 4, threadinfo ffff81003fd32000, task ffff810001fa5080)
Stack: 0000000000000283 ffffffffffffffff 0000000000000001 0000000000000000
       ffffffff8012c15b 0000000000010000 0000000000000000 ffff810001fa5080
       0000000000000000 ffff810001fa5080
Call Trace:<ffffffff8012c15b>{default_wake_function+0} <ffffffff8012c15b>{default_wake_function+0}
       <ffffffff8013dd25>{worker_thread+0} <ffffffff8013dd25>{worker_thread+0}
       <ffffffff80141ad0>{kthread+137} <ffffffff8010ef07>{child_rip+8}
       <ffffffff8013dd25>{worker_thread+0} <ffffffff80141a47>{kthread+0}
       <ffffffff8010eeff>{child_rip+0}

Code: 48 89 02 48 89 50 08 48 89 36 48 89 76 08 ff 34 24 9d 48 39
RIP <ffffffff8013de9a>{worker_thread+373} RSP <ffff81003fd33e88>

Message from syslogd@morocco at Sat Apr 30 22:29:50 2005 ...
morocco kernel: general protection fault: 0000 [1]
[  OK  ]
Stopping NFS statd: [  OK  ]
Stopping portmap: [  OK  ]
Shutting down kernel logger: [  OK  ]
Shutting down system logger: [  OK  ]
Shutting down interface eth0:  <3>Slab corruption: start=ffff81003e16b668, len=1024
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<ffffffff80407574>](xprt_destroy+0x4b/0x4f)
1e0: c8 52 65 80 ff ff ff ff 6b 6b 6b 6b 6b 6b 6b 6b
Prev obj: start=ffff81003e16b250, len=1024
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<ffffffff80407574>](xprt_destroy+0x4b/0x4f)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=ffff81003e16ba80, len=1024
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<ffffffff803973f0>](kfree_skbmem+0x9/0x19)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

Index: linux-2.6.12-rc3-mm2/net/sunrpc/xprt.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.12-rc3-mm2/net/sunrpc/xprt.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 xprt.c
--- linux-2.6.12-rc3-mm2/net/sunrpc/xprt.c	1 May 2005 01:05:16 -0000	1.1.1.1
+++ linux-2.6.12-rc3-mm2/net/sunrpc/xprt.c	1 May 2005 05:35:21 -0000
@@ -1667,6 +1667,7 @@ xprt_shutdown(struct rpc_xprt *xprt)
 	rpc_wake_up(&xprt->backlog);
 	wake_up(&xprt->cong_wait);
 	del_timer_sync(&xprt->timer);
+	flush_scheduled_work();
 }
 
 /*
