Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbUBFMSY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 07:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbUBFMSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 07:18:24 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:14053 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S264372AbUBFMSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 07:18:22 -0500
Date: Fri, 6 Feb 2004 13:18:18 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.2: fsync() over NFS hanging unless other I/O going on
Message-ID: <20040206121815.GA8111@cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-NCC-RegID: nl.cistron
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc: to linux-kernel because this might be more general than just NFS]

I've been able to reproduce the problem I've been talking about
before - fsync() over NFS hanging. The weird thing is that it only
happens on an otherwise complete idle system.

Server and client are both  PIV 3.0 Ghz machines, 1 GB RAM running 2.6.2.
Client mounts the server with
mount -o nfsvers=3,rsize=32768,wsize=32768 jenny-eth1:/export/swr /mnt

I have a "dd" like app that writes a file over NFS then fsync()s it.
The fsync() hangs in the kernel, in fs/nfs/write.c:nfs_sync_file()
for up to half a minute, calling nfs_wait_for_requests().

I added some debug code to nfs_sync_file(), which shows the hang
(13:03:35 -> 13:04:02) :

Feb  6 13:03:35 meghan kernel: ENTER nfs_sync_file idx_start=0 npages=0 how=2
Feb  6 13:03:35 meghan kernel: Call Trace:
Feb  6 13:03:35 meghan kernel:  [<f8a06404>] nfs_sync_file+0x48/0x153 [nfs]
Feb  6 13:03:35 meghan kernel:  [<f8a047de>] nfs_writepages+0xe9/0xf0 [nfs]
Feb  6 13:03:35 meghan kernel:  [<c013e4bb>] do_writepages+0x1e/0x38
Feb  6 13:03:35 meghan kernel:  [<c0138eb3>] __filemap_fdatawrite+0xb6/0xb8
Feb  6 13:03:35 meghan kernel:  [<c0138ecc>] filemap_fdatawrite+0x17/0x1b
Feb  6 13:03:35 meghan kernel:  [<c0155cb5>] sys_fsync+0x85/0xcf
Feb  6 13:03:35 meghan kernel:  [<c010920f>] syscall_call+0x7/0xb
Feb  6 13:03:35 meghan kernel:
Feb  6 13:03:35 meghan kernel: nfs_sync_file: waiting for requests
Feb  6 13:04:02 meghan kernel: nfs_sync_file: DONE waiting for requests error 7020
Feb  6 13:04:02 meghan kernel: nfs_sync_file: waiting for requests
Feb  6 13:04:02 meghan kernel: nfs_sync_file: DONE waiting for requests error 0
Feb  6 13:04:02 meghan kernel: nfs_sync_file: flush file
Feb  6 13:04:02 meghan kernel: nfs_sync_file: DONE flushing file error 0
Feb  6 13:04:02 meghan kernel: nfs_sync_file: commit file
Feb  6 13:04:02 meghan kernel: nfs_sync_file: DONE committing file error 50000
Feb  6 13:04:02 meghan kernel: nfs_sync_file: waiting for requests
Feb  6 13:04:04 meghan kernel: nfs_sync_file: DONE waiting for requests error 11924
Feb  6 13:04:04 meghan kernel: nfs_sync_file: waiting for requests
Feb  6 13:04:04 meghan kernel: nfs_sync_file: DONE waiting for requests error 0
Feb  6 13:04:04 meghan kernel: nfs_sync_file: flush file
Feb  6 13:04:04 meghan kernel: nfs_sync_file: DONE flushing file error 0
Feb  6 13:04:04 meghan kernel: nfs_sync_file: commit file
Feb  6 13:04:04 meghan kernel: nfs_sync_file: DONE committing file error 0
Feb  6 13:04:04 meghan kernel: EXIT nfs_sync_file

Now the weird thing is, that if I start the following in another shell
on the same server:

# cd /tmp
# while :; do echo hoi > lala; done

.. then I cannot reproduce the hang. Note that that is just a write on
a local filesystem and doesn't have anything to do with NFS at all ?

Mike.
