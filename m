Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263796AbTL3Lm1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 06:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265754AbTL3Lm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 06:42:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:22240 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263796AbTL3Lm0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 06:42:26 -0500
Date: Tue, 30 Dec 2003 03:42:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-lvm@sistina.com, linux-kernel@vger.kernel.org,
       Nick Piggin <piggin@cyberone.com.au>, Jens Axboe <axboe@suse.de>
Subject: Re: System hangs after echo value >
 /sys/block/dm-0/queue/nr_requests
Message-Id: <20031230034239.27950054.akpm@osdl.org>
In-Reply-To: <20031229130055.GA30647@cistron.nl>
References: <20031229130055.GA30647@cistron.nl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg <miquels@cistron.nl> wrote:
>
> If you echo a value (any value; for example the default 128) to
> /sys/block/dm-0/queue/nr_requests the shell you are in hangs.
> After about 5 seconds, the whole system hangs 100%.

hm, nice.  It does the same thing for /sys/block/md0/queue/nr-requests.

With CONFIG_DEBUG_SPINLOCK enabled we go BUG in __wake_up():

Program received signal SIGTRAP, Trace/breakpoint trap.
__wake_up (q=0xcf299e90, mode=3, nr_exclusive=1) at include/asm/spinlock.h:137
137                     BUG();
(gdb) bt
#0  __wake_up (q=0xcf299e90, mode=3, nr_exclusive=1) at include/asm/spinlock.h:137
#1  0xc02cc847 in queue_requests_store (q=0xcf299df8, page=0xe <Address 0xe out of bounds>, count=14)
    at drivers/block/ll_rw_blk.c:2843
#2  0xc02cc907 in queue_attr_store (kobj=0xcf299f68, attr=0xe, page=0xe <Address 0xe out of bounds>, 
    length=14) at drivers/block/ll_rw_blk.c:2892
#3  0xc01aa84f in flush_write_buffer (file=0xe, buffer=0xc0456100, count=14) at fs/sysfs/file.c:205
#4  0xc01aa8ac in sysfs_write_file (file=0xc0493550, buf=0xe <Address 0xe out of bounds>, count=2, 
    ppos=0xc851cf84) at fs/sysfs/file.c:233
#5  0xc016f458 in vfs_write (file=0xc0493550, buf=0x80b2d00 "128\n", count=4, pos=0xc851cf84)
    at fs/read_write.c:257
#6  0xc016f55e in sys_write (fd=14, buf=0xe <Address 0xe out of bounds>, count=14) at fs/read_write.c:293


Where queue_requests_store() does wake_up(&rl->wait[READ]);

It looks like nobody has called blk_init_queue() for this queue and the
waitqueue head is uninitialised.

No md was in use on this machine: it was simply enabled in kernel config.
