Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317102AbSG1Te1>; Sun, 28 Jul 2002 15:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317140AbSG1Te1>; Sun, 28 Jul 2002 15:34:27 -0400
Received: from neural.psychosis.net ([140.186.18.155]:48791 "EHLO
	neural.psychosis.net") by vger.kernel.org with ESMTP
	id <S317102AbSG1Te0>; Sun, 28 Jul 2002 15:34:26 -0400
Date: Sun, 28 Jul 2002 15:37:47 -0400 (EDT)
From: Karthik Arumugham <kernel@karthik.com>
X-X-Sender: psychos@neural.psychosis.net
To: linux-kernel@vger.kernel.org
Subject: New connections stall with 20k+ open sockets
Message-ID: <Pine.LNX.4.44.0207281510550.9012-100000@neural.psychosis.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am running a large IRC server that at times has held over 40,000
simultaneous connections. Normally the server will hover around 15k - 20k
connections, but at times it goes well past that.

I've been having an issue where when the server goes past 20k connections or
so, it'll start ignoring syn packets on the most heavily used ports. I've
experienced this under 2.4.18 and older 2.4 kernels, and I'm currently
running 2.5.29. Distribution is Debian unstable (not that that should matter
here). I'm using a Netgear GA620 gig-e card, x86 architecture.

One thing I've done is to bind multiple IPs to the box and add additional
ports. The lesser used ports generally accept connections fine. Almost half
of all connections come in to one ip+port pair though, and that's where the
biggest problem is. At 30k users or so, about 80+% of syn packets to that
port are ignored. I can see the incoming syn packets fine in tcpdump,
there's just no syn-ack reply. This makes new users sit there for a long
time timing out rather than successfully connecting. The ignored connections
do not show up as SYN_RECV.

Currently, with 30199 connected users all working properly, I have a total
of 243 sockets in SYN_RECV state. At times (such as if the server is
restarted), there are several hundred connection requests per second, which
generally get handled fine if there are not many users connected. The
problem only occurs when many sockets are open, whether or not the
connection rate is high. tcp_max_syn_backlog is currently set to 4096, and
I've reduced tcp_synack_retries to 2.

Also, there's plenty of memory:

             total       used       free     shared    buffers     cached
Mem:        517452     284576     232876          0          0      13712
-/+ buffers/cache:     270864     246588
Swap:            0          0          0

Any other relevant details I'm missing? I've tried screwing around with
various parameters in /proc/sys/net/ipv4 without luck; unfortunately I don't
understand the internals of how a received syn packet is handled, and what
would cause it to be silently discarded.

