Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131942AbQKKS7n>; Sat, 11 Nov 2000 13:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132182AbQKKS7d>; Sat, 11 Nov 2000 13:59:33 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:13041 "EHLO
	e34.esmtp.ibm.com") by vger.kernel.org with ESMTP
	id <S131942AbQKKS7Y>; Sat, 11 Nov 2000 13:59:24 -0500
Importance: Normal
Subject: problems with sync_all_inode() in prune_icache() and kupdate()
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
X-Mailer: Lotus Notes Release 5.0.2a (Intl) 23 November 1999
Message-ID: <OFF8FB6856.584FAA00-ON88256994.0064C480@LocalDomain>
From: "Ying Chen/Almaden/IBM" <ying@almaden.ibm.com>
Date: Sat, 11 Nov 2000 11:01:25 -0800
X-MIMETrack: Serialize by Router on D03NM042/03/M/IBM(Release 5.0.5 |September 22, 2000) at
 11/11/2000 10:59:16 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm wondering if someone can tell me why sync_all_inodes() is called in
prune_icache().
sync_all_inodes() can cause problems in some situations when memory is
short and shrink_icache_memory() is called.
For instance, when the system is really short of memory,
do_try_to_free_pages() is invoked (either by application or kswapd) and
shrink_icache_memory() is also invoked, but when prune_icache() is called,
the first thing is does is to sync_all_inodes(). If the inode block is not
in memory, it may have to bread the inode block in, so the kswapd() can
block until the inode block is brought into memory. Not only that, since
the system is short of memory, there may not even be memory available for
the inode block. Even if there is, given that there is only a single kswapd
thread who is doing sync_all_inodes(), if the dirty inode list if
relatively long (like a tens of thousands as in something like SPEC SFS),
it'll take practically forever for sync_all_inodes() to finish. To user,
this looks like the system is hang (although it isn't really). It's just
taking a looooooong time to do shrink_icache_memory!

One solution to this is not to call sync_all_inodes() at all in
prune_icache(), since other parts of the kernel, like kupdate() will also
try to sync_inodes periodically anyway, but I don't know if this has other
implications or not. I don't see a problem with this myself. In fact, I
have been using this fix in my own test9 kernel, and I get much smoother
kernel behavior when running high load SPEC SFS than using the default
prune_icache(). Actually if sync_all_inodes() is called, SPEC SFS sometimes
simply fails due to the long response time on the I/O requests.

The similar theory goes with kupdate() daemon. That is, since there is only
a single thread that does the inode and buffer flushing, under high load,
kupdate() would not get a chance to call flush_dirty_buffers() until after
sync_inodes() is completed. But sync_inodes() can take forever since inodes
are flushed serially to disk. Imagine how long it might take if each inode
flushing causes one read from disk! In my experience with SPEC SFS,
sometimes, if kupdate() is invoked during the SPEC SFS run, it simply
cannot finish sync_inode() until the entire benchmark run is finished! So,
all the dirty buffers that flush_dirty_buffer(1) is supposed to flush would
never be called during the benchmark run and system is constantly running
in the bdflush() mode, which is really supposed to be called only in a
panic mode!

Again, the solution can be simple, one can create multiple
dirty_buffer_flushing daemon threads that calls flush_dirty_buffer()
without sync_super or sync_inode stuff. I have done so in my own test9
kernel, and the results with SPEC SFS is much more pleasant.

Ying

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
