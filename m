Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbUA3Lzm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 06:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbUA3Lzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 06:55:41 -0500
Received: from thor.itep.ru ([194.85.69.254]:63659 "EHLO mail.itep.ru")
	by vger.kernel.org with ESMTP id S263580AbUA3Lzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 06:55:39 -0500
Date: Fri, 30 Jan 2004 14:55:36 +0300
From: Roman Kagan <Roman.Kagan@itep.ru>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [NFS] NFS rpc and stale handles on 2.6.x servers
Message-ID: <20040130115536.GA7285@panda.itep.ru>
References: <16409.43367.545322.356713@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16409.43367.545322.356713@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 10:16:05AM +0000, Neil Brown wrote:
> The "RPC request reserved 0 ..." is very odd. It does immediately
> indicate a major problem, but it should be fixed, if only I could
> figure out what was causing it.

In case it helps: having enabled svcsock debugging by

  echo $[0x0100] > /proc/sys/sunrpc/rpc_debug

I've noticed that those messages always appear in the same pattern:

svc: server c7a3d200 waiting for data (to = 3600000)
svc: socket c6dbfb00(inet c769f220), write_space busy=0
svc: socket c2a9fac0 TCP data ready (svsk c6dbf980)
svc: socket c2a9fac0 served by daemon c7a3d200
svc: socket c2a9fac0 TCP data ready (svsk c6dbf980)
svc: socket c2a9fac0 busy, not enqueued
svc: server c7a3d200, socket c6dbf980, inuse=1
svc: tcp_recv c6dbf980 data 1 conn 0 close 0
svc: socket c6dbf980 recvfrom(c6dbf9d8, 0) = 4
svc: TCP record, 2584 bytes
svc: socket c6dbf980 recvfrom(c6d06a18, 1512) = 2584
svc: TCP complete record (2584 bytes)
svc: socket c2a9fac0 served by daemon c6efe000
svc: got len=2584
svc: socket c2a9fac0 busy, not enqueued
svc: socket c6dbf980 sendto([c436b000 140... ], 140) = 140 (addr 43e17cc1)
svc: socket c2a9fac0 busy, not enqueued
svc: server c7a3d200 waiting for data (to = 3600000)
svc: server c7a3d200, socket c25007a0, inuse=1
svc: tcp_recv c25007a0 data 0 conn 0 close 1
svc: svc_delete_socket(c25007a0)
svc: server socket destroy delayed
svc: got len=0
RPC request reserved 0 but used 140
svc: releasing dead socket
svc: server c7a3d200 waiting for data (to = 3600000)


Note that "tcp_recv" with this set of parameters (data=0 conn=0 close=1)
is always correlated with "RPC request reserved ...", and also the
"used" request length matches the message length in "sendto" on the
seemingly unrelated socket.

Unfortunately I don't understand the code well enough to make a better
bug report, but feel free to ask me to test your patches if you can't
reproduce the problem in your setup.

  Roman.
