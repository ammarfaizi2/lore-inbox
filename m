Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753400AbWKFQg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbWKFQg3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 11:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753399AbWKFQg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 11:36:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51946 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753393AbWKFQg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 11:36:27 -0500
Message-ID: <454F6483.4010307@osdl.org>
Date: Mon, 06 Nov 2006 08:36:19 -0800
From: Stephen Hemminger <shemminger@osdl.org>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Zhao Xiaoming <xiaoming.nj@gmail.com>, linux-kernel@vger.kernel.org,
       Linux Netdev List <netdev@vger.kernel.org>
Subject: Re: ZONE_NORMAL memory exhausted by 4000 TCP sockets
References: <f55850a70611052207j384e1d3flaf40bb9dd74df7c5@mail.gmail.com> <454EE580.5040506@cosmosbay.com>
In-Reply-To: <454EE580.5040506@cosmosbay.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:
> Zhao Xiaoming a écrit :
>> Dears,
>>    I'm running a linux box with kernel version 2.6.16. The hardware
>> has 2 Woodcrest Xeon CPUs (2 cores each) and 4G RAM. The NIC cards is
>> Intel 82571 on PCI-e bus.
>>    The box is acting as ethernet bridge between 2 Gigabit Ethernets.
>> By configuring ebtables and iptables, an application is running as TCP
>> proxy which will intercept all TCP connections requests from the
>> network and setup another TCP connection to the acture server.  The
>> TCP proxy then relays all traffics in both directions.
>>    The problem is the memory. Since the box must support thousands of
>> concurrent connections, I know the memory size of ZONE_NORMAL would be
>> a bottleneck as TCP packets would need many buffers. After setting
>> upper limit of net.ipv4.tcp_rmem and net.ipv4.tcp_wmem to 32K bytes,
>> our test began.
>>    My test scenario employs 2000 concurrent downloading connections
>> to a IIS server's port 80. The throughput is about 500~600 Mbps which
>> is limited by the capability of the client application. Because all
>> traffics are from server to client and the capability of client
>> machine is bottleneck, I believe the receiver side of the sockets
>> connected with server and the sender side of the sockets connected
>> with client should be filled with packets in correspondent windows.
>> Thus, roughly there should be about 32K * 2000+ 32K*2000 = 128M bytes
>> memory occupied by TCP/IP stack for packet buffering. Data from
>> slabtop confermed it. it's about 140M bytes memory cost after I start
>> the traffic. That reasonablly matched with my estimation. However,
>> /proc/meminfo had a different story. The 'LowFree' dropped from about
>> 710M to 80M. In other words, there's addtional 500M memory in
>> ZONE_NORMAL allocated by someone other than the slab. Why?
The amount of memory per socket is controlled by the socket buffering. 
Your application
could be setting the value by calling setsockopt(). Otherwise, the tcp 
memory is limited
by the sysctl settings tcp_rmem (receiver) and tcp_wmem (sender).

For example on this server:
$ cat /proc/sys/net/ipv4/tcp_wmem
4096    16384   131072

Each sending socket would start with 16K of buffering, but could grow up 
to 128K based
on TCP send autotuning.


