Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312610AbSDOEbE>; Mon, 15 Apr 2002 00:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312684AbSDOEbD>; Mon, 15 Apr 2002 00:31:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:16773 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312610AbSDOEbD>;
	Mon, 15 Apr 2002 00:31:03 -0400
Date: Sun, 14 Apr 2002 21:23:08 -0700 (PDT)
Message-Id: <20020414.212308.33849971.davem@redhat.com>
To: taka@valinux.co.jp
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020415.103013.62679757.taka@valinux.co.jp>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Hirokazu Takahashi <taka@valinux.co.jp>
   Date: Mon, 15 Apr 2002 10:30:13 +0900 (JST)

   I'd like to implenent sendpage of UDP stack which NFS uses heavily.
   It may improve the performance of NFS over UDP dramastically.
   
   I wonder if there were "SENDPAGES" interface instead of sendpage 
   between socket layer and inet layer, we could send some pages
   atomically with low overhead.
   And it could make implementing RPC over UDP easier
   to send multiple pages as one UDP pakcet easily.
   
   How do you think about this approach?
   
Sendpages mechanism will not be implemented.

You must implement UDP sendfile() one page at a time, by building up
an SKB with multiple calls similar to TCP with TCP_CORK socket option
set.

For datagram sockets, define temporary SKB hung off of struct sock.
Define UDP_CORK socket option which begins the "queue data only"
state.

All sendmsg()/sendfile() calls append to temporary SKB, first
sendmsg()/sendfile() call to UDP will create this sock->skb.  First
call may be sendmsg() but subsequent calls for that SKB must be
sendfile() calls.  If this pattern of calls is broken, SKB is sent.

Call to set UDP_CORK socket option to zero actually sends the SKB
being built.

The normal usage will be:

	setsockopt(fd, UDP_CORK, 1);
	sendmsg(fd, sunrpc_headers, sizeof(sunrpc_headers));
	sendfile(fd, ...);
	setsockopt(fd, UDP_CORK, 0);

