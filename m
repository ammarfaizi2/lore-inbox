Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWDTQ3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWDTQ3N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 12:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWDTQ3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 12:29:13 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:31467 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1751130AbWDTQ3L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 12:29:11 -0400
Date: Thu, 20 Apr 2006 18:29:07 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Ingo Molnar <mingo@elte.hu>
Subject: Van Jacobson's net channels and real-time
Message-ID: <Pine.LNX.4.44L0.0604201819040.19330-100000@lifa01.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before I start, where is VJ's code? I have not been able to find it anywhere.

With the preempt-realtime branch maturing and finding it's way into the
mainline kernel, using Linux (without sub-kernels) for real-time applications
is becomming an realistic option without having to do a lot of hacks in the
kernel on your own. But the network stack could be improved and some of the
ideas in Van Jacobson's net channels could be usefull when receiving network
packages with real-time latencies.

Finding the end point in the receive interrupt and send of the packet to
the receiving process directly is a good idea if it is fast enough to do
so in the interrupt context (and I think it can be done very fast). One
problem in the current setup, is that everything has to go through the
soft interrupt.  That is even if you make a completely new, non-IP
protocol, the latency for delivering the frame to your application is
still limited by the latency of the IP-stack because it still have to go
through soft irq which might be busy working on IP packages. Even if you
open a raw socket, the latency is limited to the latency of the soft irq.
At work we use a widely used commercial RTOS. It got exactly the same
problem of having every network packet being handled by the same thread.

Buffer management is another issue. On the RTOS above you make a buffer pool
per network device for receiving packages. On Linux received packages are taken
from the global memory pool with GFP_ATOMIC. On both systems you can easily run
out of buffers if they are not freed back to the pool fast enough. In that
case you will just have to drop packages as they are received. Without
having the code to VJ's net channels, it looks like they solve the problem:
Each end receiver provides his own receive resources. If a receiver can't cope
with  all the traffic, it will loose packages, the others wont. That makes it
safe to run important real-time traffic along with some unpredictable, low
priority  TCP/IP traffic. If the TCP/IP receivers does not run fast enough,
their packages will be dropped, but the driver will not drop the real-time
packages. The nice thing about a real-time task is that you know it's latency
and therefore know how many receive buffers it needs to avoid loosing
packages in a worst case scenario.

Implementing new protocols in user space is a good idea, too. The developer -
who doesn't need to be a hard-core kernel hacker - can pick whatever language
he wants and has far easier access to debugging tools than in the kernel.
Unfortunately, it does not perform very well.
Using raw sockets is a way to do protocol stacks in user space now, but you
can only listen to packets with a specific protocol id. Therefore you either
have to make one thread or process in userspace receive everything and then
send it to the end receivers, or let all threads receive all and let them
throw away packages not for them. Apparently the filter mechanism for VJ's
net channels (if it is made general enough) would solve that problem, too.

Many realtime applications are time triggered. I.e. they wake up
say every 5 ms and poll their environment for new inputs, do their
calculations and then send out the results again. For such an application
it will be very efficient to make the driver put the network packages in a
mmap'ed area, but not try to wake up the application. The application will
simply poll the mmap'ed channel every 5 ms. Once this is setup there is no
system calls issued for receiving packages at all!
On Linux today - for packet orientated protocols at least - the application has
to issue a system call for every packet received plus a system call in the end
to check there is no more packeges to be read.

Esben

