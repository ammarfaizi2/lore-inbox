Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313442AbSDPBDj>; Mon, 15 Apr 2002 21:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313443AbSDPBDi>; Mon, 15 Apr 2002 21:03:38 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:29458 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S313442AbSDPBDi>;
	Mon, 15 Apr 2002 21:03:38 -0400
Date: Tue, 16 Apr 2002 10:03:02 +0900 (JST)
Message-Id: <20020416.100302.129343787.taka@valinux.co.jp>
To: davem@redhat.com
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20020414.212308.33849971.davem@redhat.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, David

Thank you for your advice!

davem> Sendpages mechanism will not be implemented.
davem> 
davem> You must implement UDP sendfile() one page at a time, by building up
davem> an SKB with multiple calls similar to TCP with TCP_CORK socket option
davem> set.
davem> 
davem> For datagram sockets, define temporary SKB hung off of struct sock.
davem> Define UDP_CORK socket option which begins the "queue data only"
davem> state.
davem> 
davem> All sendmsg()/sendfile() calls append to temporary SKB, first
davem> sendmsg()/sendfile() call to UDP will create this sock->skb.  First
davem> call may be sendmsg() but subsequent calls for that SKB must be
davem> sendfile() calls.  If this pattern of calls is broken, SKB is sent.
davem> 
davem> Call to set UDP_CORK socket option to zero actually sends the SKB
davem> being built.
davem> 
davem> The normal usage will be:
davem> 
davem> 	setsockopt(fd, UDP_CORK, 1);
davem> 	sendmsg(fd, sunrpc_headers, sizeof(sunrpc_headers));
davem> 	sendfile(fd, ...);
davem> 	setsockopt(fd, UDP_CORK, 0);

Yes, it seems to be the most general way.
OK, I'll do this way first of all.

In the kernel, probaboly I'd impelement as following:

	put a RPC header and a NFS header on "bufferA";
	down(semaphore);
	sendmsg(bufferA, MSG_MORE);
	for (eache pages of fileC)
		sock->opt->sendpage(page, islastpage ? 0 : MSG_MORE)
	up(semaphore);

the semaphore is required to serialize sending data as many knfsd kthreads
use the same socket.

Actually I'd like to implement it like following codes, but unfortunatelly
it wouldn't work on UDP socket of servers as the socket doesn't have specific
destination address at all, and sendpage has no arguments to specify it.
It's not so good....

	put a RPC header and a NFS header on "pageB";
	down(semaphore);
	sock->opt->sendpage(pageB, MSG_MORE);
	for (each pages of fileC)
		sock->opt->sendpage(page, islastpage ? 0 : MSG_MORE)
	up(semaphore);


Thank you,
Hirokazu Takahashi
