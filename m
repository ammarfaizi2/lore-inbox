Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131576AbRAOVWY>; Mon, 15 Jan 2001 16:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131573AbRAOVWO>; Mon, 15 Jan 2001 16:22:14 -0500
Received: from [66.37.66.32] ([66.37.66.32]:35601 "EHLO crib.corepower.com")
	by vger.kernel.org with ESMTP id <S131502AbRAOVV5>;
	Mon, 15 Jan 2001 16:21:57 -0500
Date: Mon, 15 Jan 2001 16:20:23 -0500 (EST)
From: Jeff Raubitschek <raubitsj@crib.corepower.com>
Reply-To: Jeff Raubitschek <raubitsj@writeme.com>
To: linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@atrey.karlin.mff.cuni.cz>
Subject: Bonnie on NBD w/ memory pressure deadlocks (problem in wait_for_tcp_memory?)
Message-ID: <Pine.LNX.4.21.0101151615190.10348-100000@crib.corepower.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

running 2.4.0 with kdb patch

[1.] Bonnie on NBD w/ memory pressure deadlocks (problem in wait_for_tcp_memory?)
[2.] Full description
This bug appears to be totally reproducable on different hardware and kernel versions.

The conditions that create the problem:
	2 machines (client, server) (both p4 1.4G) networked with 100Mb 
	the server runs:  ./nbd-server 8899 /dev/hda6 1937804k
	the client runs:  ./nbd-client serverip 8899 /dev/nb5
	                  mke2fs /dev/nb5
			  mount /dev/nb5 -t ext2 /mnt/nb5
			  ./Bonnie -d /mnt/nb5 -s 100

(nbd-client and nbd-server from http://atrey.karlin.mff.cuni.cz/~pavel/nbd/nbd.html)

NBD seems to do fine with normal disk use, but when Bonnie is run with large file sizes
it causes memory pressure and this triggers the problem being seen.

Bonnie output:
FILE '/mnt/nbd5/Bonnie.8776', ssize: 104857600
Writing with putc()...done
Rewriting...  [and here it hangs]

What I think is going on:
I compiled kdb into the kernel after unsuccessfully being able to figure it out by just
looking at the source.  Doing this seemed to confirm my suspicions about the cause but
I was unable to figure out the exact problem.

using kdb I found the backtraces of important processes in the client and server:

Client
------
pid 5: bdflush
	schedule+0x2d8
	schedule+timeout+0x17
	wait_for_tcp_memory+0x12e
	tcp_sendmsg+0x666
	inet_sendmsg+0x40
	sock_sendmsg+0x7a
	[nbd]nbd_xmit+0xda
	[nbd]nbd_send_req+0x8f
	[nbd]do_nbd_request+0x104
	__make_request+0x5be
	generic_make_request+0xd7
	submit_bh+0x58
	ll_rw_block+0x12f
	flush_dirty_buffers+0x81
	bdflush+0x7b
	kernel_thread+0x23
pid 8740: nbd_client
	schedule+0x2d8
	__down+0x61
	__down_failed+0xb
	[nbd].text.lock+0x19
	[nbd]nbd_do_it+0x41
	[nbd]nbd_ioctl+0x316
	blkdev_ioctl+0x2c
	sys_ioctl+0x174
	system_call+0x33
pid 8753: Bonnie
	schedule+0x2d8
	__lock_page+0x8b
	lock_page+0x18
	do_generic_file_read+0x29b
	generic_file_read+0x5d
	sys_read+0x91
	system_call+0x33

Server
------
pid 8431: nbd-server
	schedule+0x2d8
	schedule_timeout+0x17
	wait_for_tcp_memory+0x12e(0xc6ebe400, 0x7fffffff)
	tcp_sendmsg+0x666(0xc6ebe400,0xc60bdf7c, 0x1010)
	inet_sendmsg+0x40(0xc640aa04,0xc60bdf7c,0x1010, 0xc60bdf44, 0xc640aa04)
	sock_sendmsg+0x7a(0xc640aa04,0xc60bdf7c,0x1010)
	sock_write+0x8f(0xc7ebd00, 0xbfffa548, 0x1010, 0xc70ebd20)
	sys_write+0x95(0x4,0xbfffa548, 0x1010, 0x1010, 0xbfffa548)
	system_call+0x33

both machines are low in memory but have buffer memory still:
server: mem total=126216 used=124504 free=1712 shared=0 buffers=109844 cached=4912
        -/+ buffers/cache: 9748 116468
client: mem total=126216 used=124264 free=1952 shared=0 buffers= 29940 cached=15568
	-/+ buffers/cache: 78756 47460

What I think is going on is the client is busy reading blocks from the server over nbd
and dirtying them, eventually the buffer cache consumes all memory.  This memory pressure
causes bdflush to try to flush dirty buffers which requires it to send the blocks to the
server.  This does not complete because wait_for_tcp_memory never succeeds ?? (I am still
a bit unsure of what is going on with wait_for_tcp_memory)

Thus the client can not send any more requests because nbd is locked by bdflush which is
trying to flush dirty buffers but appearently cannot.

Also the server seems to be in the same wait_for_tcp_memory loop.  I think if I understand
better what is going on in wait_for_tcp_memory I will be closer to figureing out how to
solve this problem.

Any help would be appreciated, I have much more info if anything more is
needed.

Thank you very much,
-jeff


[3.] keywords: nbd, networking, low memory
[4.] Linux version 2.4.0-kdb (raubitsj@jr-lnx) (gcc version egcs-2.91.66 19990314/Linux 
	(egcs-1.1.2 release)) #2 Thu Jan 11 21:00:11 PST 2001
[5.] no oops
[6.] this problem is 100% reproducable, seems to be reproducable on different hardware,
	w/ different kernel versions too
[7.] Environment (this listing is limited, but can be provided if needed)
cpuinfo: P4 1.4GHz 128MB ram
modules: acenic, nbd


-------------------------------------------------------------------------------
 Jeff Raubitschek 
 Computer Engineer
 raubitsj@writeme.com
-------------------------------------------------------------------------------



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
