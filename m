Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTEGNIk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 09:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263177AbTEGNIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 09:08:40 -0400
Received: from pat.uio.no ([129.240.130.16]:42681 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263176AbTEGNIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 09:08:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16057.2112.934735.338852@charged.uio.no>
Date: Wed, 7 May 2003 15:21:04 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [NFS] bk update ready for 2.5.69
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please do a

	bk pull http://nfsclient.bkbits.net/linux-2.5

This will update the following files:

 fs/fs-writeback.c           |    3 
 fs/lockd/host.c             |   14 --
 fs/lockd/mon.c              |    1 
 fs/nfs/dir.c                |    2 
 fs/nfs/file.c               |    2 
 fs/nfs/write.c              |    6 -
 include/linux/sunrpc/xdr.h  |    5 
 include/linux/sunrpc/xprt.h |    2 
 mm/page-writeback.c         |    2 
 net/sunrpc/clnt.c           |   58 ++++++-----
 net/sunrpc/sched.c          |    5 
 net/sunrpc/xdr.c            |  111 ++++++++++++++++++++-
 net/sunrpc/xprt.c           |  229 ++++++++++++++++++++++----------------------
 13 files changed, 281 insertions(+), 159 deletions(-)

through these ChangeSets:

<trond.myklebust@fys.uio.no> (03/05/07 1.1098)
   UDP and TCP zero copy code for the NFS client. The main interest
   of this patch is to eliminate the use of xdr_kmap() and xdr_unmap()
   by replacing them with MSG_MORE. xdr_kmap() is deadlock-prone
   due to the fact that it has to kmap() several pages at the same time.

<trond.myklebust@fys.uio.no> (03/05/07 1.1097)
   Ensure that Lockd and the NSM (statd) clients always use privileged
   ports. Remove the existing code to temporarily raise privileges in
   fs/lockd/host.c, and use the new code in net/sunrpc/xprt.c
   
   There should no longer be a need to temporarily change the fsuid.
   Remove this feature.

<cel@citi.umich.edu> (03/05/07 1.1096)
   the recently-applied patch to fix the rpc_show_tasks() Oops is incomplete.
   this applies over 2.5.68 and should address all of the issues in
   rpc_show_tasks().

<trond.myklebust@fys.uio.no> (03/05/07 1.1095)
   Add the sk->callback_lock spinlocks to the RPC socket callbacks
   in order to protect the socket from being released by one
   CPU while the other is in a soft interrupt.

<trond.myklebust@fys.uio.no> (03/05/07 1.1094)
   Ensure that if we need to reconnect the socket, we also resend
   the entire RPC message
   
   Assorted TCP reconnection fixes.
   
   Temporarily raise the necessary CAP_NET_BIND_SERVICE capability
   if we need to bind the socket to a reserved port during a TCP
   reconnection. Check for CAP_NET_BIND_SERVICE at mount time.

<trond.myklebust@fys.uio.no> (03/05/07 1.1093)
   Don't use an RPC child process when reconnecting to a TCP server.
   This is more efficient, and also fixes an existing deadlock
   situation in which the child could be waiting for an xprt_write_lock
   that was being held by the parent.

<trond.myklebust@fys.uio.no> (03/05/07 1.1092)
   Fix a TCP race: check whether or not the socket has been disconnected
   before we allow an RPC request to wait on a reply.

<trond.myklebust@fys.uio.no> (03/05/07 1.1091)
   Fix typos in close-to-open cache consistency checking.

<trond.myklebust@fys.uio.no> (03/05/07 1.1090)
   Decrement the nr_unstable page state after the COMMIT RPC call
   completes instead of before. This ensures that writeback 
   WB_SYNC_ALL does wait on completion.
   
   Don't overreport the number of pages we wrote out. It is safer to
   underreport.
   
   Fix missing NFSv3 unstable write accounting in fs/fs-writeback.c
   and mm/page-writeback.c

