Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbUDAQyr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 11:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbUDAQyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 11:54:47 -0500
Received: from [212.44.21.70] ([212.44.21.70]:30119 "EHLO mailgate.zeus.co.uk")
	by vger.kernel.org with ESMTP id S262514AbUDAQyn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 11:54:43 -0500
Date: Thu, 1 Apr 2004 17:54:35 +0100 (BST)
From: Ben <ben@zeus.com>
X-X-Sender: ben@stones.cam.zeus.com
To: linux-kernel@vger.kernel.org
Subject: epoll reporting events when it hasn't been asked to
Message-ID: <Pine.LNX.4.58.0404011731290.4013@stones.cam.zeus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanner: exiscan *1B95Sd-0007wX-00*fW2BsM/Mgjk* (Zeus Technology Ltd)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

epoll seems to behave oddly with TCP sockets that return ECONNRESET on a
read. Here's an abridged strace snippet:
(my strace doesn't cope very well with epoll syscalls, so I've mixed in
 some of the program's debug output as well)

epoll_create(0x400)                     = 5

...

socket(PF_INET, SOCK_STREAM, IPPROTO_TCP) = 10
setsockopt(10, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
setsockopt(10, SOL_SOCKET, SO_KEEPALIVE, [1], 4) = 0
bind(10, {sa_family=AF_INET, sin_port=htons(2342), sin_addr=inet_addr("10.100.1.208")}, 16) = 0

         EPollMultiplexer::Add( fd 10 events 1 )
epoll_ctl(0x5, 0x1, 0xa, 0xbffff010)    = 0

         EPollMultiplexer::Poll()
epoll_wait(0x5, 0x831b390, 0x20, 0x3e8) = 1
fd 10 has events 1

accept(10, {sa_family=AF_INET, sin_port=htons(47255), sin_addr=inet_addr("10.100.1.208")}, [16]) = 7

         EPollMultiplexer::Add( fd 7 events 1 )
epoll_ctl(0x5, 0x1, 0x7, 0xbffff5c0)    = 0

socket(PF_INET, SOCK_STREAM, IPPROTO_TCP) = 11
connect(11, {sa_family=AF_INET, sin_port=htons(21), sin_addr=inet_addr("10.100.1.5")}, 16) = -1 EINPROGRESS (Operation now in progress)

         EPollMultiplexer::Add( fd 11 events 1 )
epoll_ctl(0x5, 0x1, 0xb, 0xbffff3f0)    = 0

         EPollMultiplexer::Poll()
epoll_wait(0x5, 0x831b390, 0x20, 0x3e8) = 1
fd 11 has events 1

         EPollMultiplexer::Poll()
epoll_wait(0x5, 0x831b390, 0x20, 0x3e8) = 2
fd 10 has events 1
fd 7 has events 25

read(7, 0x8336240, 4096)                = -1 ECONNRESET (Connection reset by peer)

         EPollMultiplexer::Poll()
         Setting events on fd 7 to 0
epoll_ctl(0x5, 0x3, 0x7, 0x8301550)     = 0
epoll_wait(0x5, 0x831b390, 0x20, 0x3e8) = 2
fd 11 has events 1
fd 7 has events 16


This is odd. The epoll_ctl() got rid of all events for FD 7, yet the
epoll_wait() following it returns event 16 (EPOLLHUP). Is this a bug?
I don't normally see this behaviour for most connections, is it perhaps
to do with the read returning ECONNRESET ?

(This is on 2.6.2-rc1-mm1 and on 2.6.5-rc3-mm3, on x86 and x86_64)


Ben
