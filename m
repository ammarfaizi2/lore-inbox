Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132589AbREAMK3>; Tue, 1 May 2001 08:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133018AbREAMKT>; Tue, 1 May 2001 08:10:19 -0400
Received: from mons.uio.no ([129.240.130.14]:40112 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S132589AbREAMKH>;
	Tue, 1 May 2001 08:10:07 -0400
MIME-Version: 1.0
Message-ID: <15086.42872.321353.67228@charged.uio.no>
Date: Tue, 1 May 2001 14:09:28 +0200
To: Ion Badulescu <ionut@cs.columbia.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrea Arcangeli <andrea@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.19 locks up on SMP
In-Reply-To: <Pine.LNX.4.33.0105010140270.12259-100000@age.cs.columbia.edu>
In-Reply-To: <Pine.LNX.4.33.0105010051490.12259-100000@age.cs.columbia.edu>
	<Pine.LNX.4.33.0105010140270.12259-100000@age.cs.columbia.edu>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Ion Badulescu <ionut@cs.columbia.edu> writes:

     > On Tue, 1 May 2001, Ion Badulescu wrote:
    >> I'll do another test, 2.2.18 + the NFS/SunRPC changes, and see
    >> how it goes. Hopefully they'll apply easily...

     > As I suspected, 2.2.18 + all the NFS/NFSd/SunRPC changes
     > present in 2.2.19pre10 locks up with wait_on_bh as soon as I
     > run ls -lR on a large NFS directory tree, while at the same
     > time pummeling the network and the local disks.

     > NFS is not enough to trigger the bug, the extra disk/network
     > stress *is* necessary. The network stress actually seems to be
     > enough, I just triggered the bug again...

     > 2.2.18 vanilla is fine.

     > So I guess the next round is in Trond's court. :-)

Did you apply the following patch which I put out on the lists a
couple of weeks ago?

Cheers,
  Trond

--- net/sunrpc/xprt.c.orig	Sun Mar 25 18:37:42 2001
+++ net/sunrpc/xprt.c	Wed Apr 18 11:10:21 2001
@@ -1145,9 +1145,11 @@
 		unsigned long	oldflags;
 		spin_lock_irqsave(&xprt_sock_lock, oldflags);
 		xprt->snd_task = NULL;
-		if (!rpc_wake_up_next(&xprt->sending) && xprt->stream)
+		if (!rpc_wake_up_next(&xprt->sending) && xprt->stream) {
+			spin_unlock_irqrestore(&xprt_sock_lock, oldflags);
 			xprt_add_tcp_timer(xprt, RPCXPRT_TIMEOUT);
-		spin_unlock_irqrestore(&xprt_sock_lock, oldflags);
+		} else
+			spin_unlock_irqrestore(&xprt_sock_lock, oldflags);
 	}
 }
 
