Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262621AbSJONab>; Tue, 15 Oct 2002 09:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262641AbSJONab>; Tue, 15 Oct 2002 09:30:31 -0400
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:10466 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S262621AbSJONa3>; Tue, 15 Oct 2002 09:30:29 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: Use of yield() in the kernel
Date: Tue, 15 Oct 2002 15:36:38 +0200
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210151536.39029.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The semantics of sched_yield() changed in the 2.5 kernel.
In the 2.4 series it meant "sleep a little".
The new 2.5 semantics are correct (move to the end of the
run queue) but can mean "sleep a lot" under load.

This already bit ext3 transaction batching, c.f. Andrew Morton's

>[PATCH] remove the sched_yield from the ext3 fsync path
>
>The changed sched_yield() semantics have made ext3's transaction
>batching terribly slow.
>
>Apparently a schedule() fixes that, although it probably breaks
>transaction batching.
>
>This patch largely fixes my complaints about the new scheduler being
>extremely sluggish to interactive applications.  Evidently those
>applications were calling fsync() and were spending extremely long
>periods in sched_yield().

Maybe it is worth auditing the kernel source files using yield()?
[There are only 33 of them, so not too bad - see below].
A number of them have comments like /* sleep a little */, so the
authors presumably weren't expecting to get "sleep a lot"...

Here is the list of files using yield(), excluding non-i386 arch specific files:

net/ipv4/tcp_output.c
net/sched/sch_generic.c
net/sunrpc/sched.c
net/unix/af_unix.c
net/socket.c
mm/oom_kill.c
mm/page_alloc.c
kernel/sched.c (in migration_call)
kernel/softirq.c
kernel/suspend.c
init/do_mounts.c
fs/jbd/journal.c
fs/jbd/revoke.c
fs/nfs/pagelist.c
fs/reiserfs/journal.c
fs/ufs/truncate.c
fs/buffer.c
fs/exec.c
fs/locks.c
fs/super.c
drivers/cdrom/cdu31a.c
drivers/cdrom/sonycd535.c
drivers/ide/ide-disk.c
drivers/message/i2o/i2o_core.c
drivers/net/e100/e100_eeprom.c
drivers/net/e100/e100_main.c
drivers/net/e100/e100_phy.c
drivers/net/e100/e100_test.c
drivers/net/depca.c
drivers/net/sb1000.c
drivers/net/sis900.c
drivers/net/slip.c
arch/i386/mm/fault.c

Thoughts?

Duncan.
