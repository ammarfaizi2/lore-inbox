Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932769AbWKFHeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932769AbWKFHeW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 02:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932768AbWKFHeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 02:34:22 -0500
Received: from sp604001mt.neufgp.fr ([84.96.92.60]:51917 "EHLO Smtp.neuf.fr")
	by vger.kernel.org with ESMTP id S932764AbWKFHeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 02:34:21 -0500
Date: Mon, 06 Nov 2006 08:34:24 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: ZONE_NORMAL memory exhausted by 4000 TCP sockets
In-reply-to: <f55850a70611052207j384e1d3flaf40bb9dd74df7c5@mail.gmail.com>
To: Zhao Xiaoming <xiaoming.nj@gmail.com>
Cc: linux-kernel@vger.kernel.org, Linux Netdev List <netdev@vger.kernel.org>
Message-id: <454EE580.5040506@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <f55850a70611052207j384e1d3flaf40bb9dd74df7c5@mail.gmail.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zhao Xiaoming a écrit :
> Dears,
>    I'm running a linux box with kernel version 2.6.16. The hardware
> has 2 Woodcrest Xeon CPUs (2 cores each) and 4G RAM. The NIC cards is
> Intel 82571 on PCI-e bus.
>    The box is acting as ethernet bridge between 2 Gigabit Ethernets.
> By configuring ebtables and iptables, an application is running as TCP
> proxy which will intercept all TCP connections requests from the
> network and setup another TCP connection to the acture server.  The
> TCP proxy then relays all traffics in both directions.
>    The problem is the memory. Since the box must support thousands of
> concurrent connections, I know the memory size of ZONE_NORMAL would be
> a bottleneck as TCP packets would need many buffers. After setting
> upper limit of net.ipv4.tcp_rmem and net.ipv4.tcp_wmem to 32K bytes,
> our test began.
>    My test scenario employs 2000 concurrent downloading connections
> to a IIS server's port 80. The throughput is about 500~600 Mbps which
> is limited by the capability of the client application. Because all
> traffics are from server to client and the capability of client
> machine is bottleneck, I believe the receiver side of the sockets
> connected with server and the sender side of the sockets connected
> with client should be filled with packets in correspondent windows.
> Thus, roughly there should be about 32K * 2000+ 32K*2000 = 128M bytes
> memory occupied by TCP/IP stack for packet buffering. Data from
> slabtop confermed it. it's about 140M bytes memory cost after I start
> the traffic. That reasonablly matched with my estimation. However,
> /proc/meminfo had a different story. The 'LowFree' dropped from about
> 710M to 80M. In other words, there's addtional 500M memory in
> ZONE_NORMAL allocated by someone other than the slab. Why?

We dont know. You might post some data so that we can have some ideas.

Also, these kind of question is better handled by linux netdev mailing list, 
so I added a CC to this list.

cat /proc/slabinfo
cat /proc/meminfo
cat /proc/net/sockstat
cat /proc/buddyinfo

>   I also made another test that the upper limit of tcp_rmem and
> tcp_wmem being set to 64K. After 2000 connections transfering a lot of
> data for several seconds, the linux box showed some error messages
> such as error allocating memory pages, etc. and became unstable.
>   My questions are:
> 
> 1. To calculate memory request of TCP sockets, is there any other
> large amount of memory requested besides send and receive buffer?
> 2. Is there any logics that emploied by TCP/IP stack that will
> dynamically allocating memory pages directly instead of from slab?

TCP stack is one thing, but other things may consume ram on your kernel.

Also, kernel memory allocation might use twice the ram you intend to use 
because of power of two alignments.

Are you using iptables connection tracking ?

If you plan to use a lot of RAM in kernel, why dont you use a 64 bits kernel, 
so that all ram is available for kernel, not only 900 MB ?

Eric

