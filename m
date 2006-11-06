Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423580AbWKFIKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423580AbWKFIKH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 03:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423571AbWKFIKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 03:10:06 -0500
Received: from nz-out-0102.google.com ([64.233.162.198]:15260 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1423572AbWKFIKE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 03:10:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=am8p33LaDfw0REQwD0TGFoz9IigdPzIhI7pAqgUOC37D57cBfiAgLsC92myav6795qnS+u//Cm7sfkfq59IMRxU6l7dWyTIbStoW4/CNYyjyJrlZ+yTAgOBI3zTsc6KQsJH0IxqNQJ+vpiKDVb8e96oQ7Yqj4yjiPTeyeNJaNWc=
Message-ID: <f55850a70611060010q3ce9d6d2h4026259d688c6db1@mail.gmail.com>
Date: Mon, 6 Nov 2006 16:10:03 +0800
From: "Zhao Xiaoming" <xiaoming.nj@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ZONE_NORMAL memory exhausted by 4000 TCP sockets
In-Reply-To: <454EE580.5040506@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <f55850a70611052207j384e1d3flaf40bb9dd74df7c5@mail.gmail.com>
	 <454EE580.5040506@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/11/6, Eric Dumazet <dada1@cosmosbay.com>:
> Zhao Xiaoming a écrit :
> > Dears,
> >    I'm running a linux box with kernel version 2.6.16. The hardware
> > has 2 Woodcrest Xeon CPUs (2 cores each) and 4G RAM. The NIC cards is
> > Intel 82571 on PCI-e bus.
> >    The box is acting as ethernet bridge between 2 Gigabit Ethernets.
> > By configuring ebtables and iptables, an application is running as TCP
> > proxy which will intercept all TCP connections requests from the
> > network and setup another TCP connection to the acture server.  The
> > TCP proxy then relays all traffics in both directions.
> >    The problem is the memory. Since the box must support thousands of
> > concurrent connections, I know the memory size of ZONE_NORMAL would be
> > a bottleneck as TCP packets would need many buffers. After setting
> > upper limit of net.ipv4.tcp_rmem and net.ipv4.tcp_wmem to 32K bytes,
> > our test began.
> >    My test scenario employs 2000 concurrent downloading connections
> > to a IIS server's port 80. The throughput is about 500~600 Mbps which
> > is limited by the capability of the client application. Because all
> > traffics are from server to client and the capability of client
> > machine is bottleneck, I believe the receiver side of the sockets
> > connected with server and the sender side of the sockets connected
> > with client should be filled with packets in correspondent windows.
> > Thus, roughly there should be about 32K * 2000+ 32K*2000 = 128M bytes
> > memory occupied by TCP/IP stack for packet buffering. Data from
> > slabtop confermed it. it's about 140M bytes memory cost after I start
> > the traffic. That reasonablly matched with my estimation. However,
> > /proc/meminfo had a different story. The 'LowFree' dropped from about
> > 710M to 80M. In other words, there's addtional 500M memory in
> > ZONE_NORMAL allocated by someone other than the slab. Why?
>
> We dont know. You might post some data so that we can have some ideas.
>
> Also, these kind of question is better handled by linux netdev mailing list,
> so I added a CC to this list.
>
> cat /proc/slabinfo
> cat /proc/meminfo
> cat /proc/net/sockstat
> cat /proc/buddyinfo
>
> >   I also made another test that the upper limit of tcp_rmem and
> > tcp_wmem being set to 64K. After 2000 connections transfering a lot of
> > data for several seconds, the linux box showed some error messages
> > such as error allocating memory pages, etc. and became unstable.
> >   My questions are:
> >
> > 1. To calculate memory request of TCP sockets, is there any other
> > large amount of memory requested besides send and receive buffer?
> > 2. Is there any logics that emploied by TCP/IP stack that will
> > dynamically allocating memory pages directly instead of from slab?
>
> TCP stack is one thing, but other things may consume ram on your kernel.
>
> Also, kernel memory allocation might use twice the ram you intend to use
> because of power of two alignments.
>
> Are you using iptables connection tracking ?
>
> If you plan to use a lot of RAM in kernel, why dont you use a 64 bits kernel,
> so that all ram is available for kernel, not only 900 MB ?
>
> Eric
>
>
Thanks for the answer. I know it's more likely relats to netdev.
However, it's always a strange thing to have 400~500M bytes LOWMEM
'gone' while it's not reported to be occupied by slab. Both meminfo
and buddyinfo tell the same.

with traffics of 2000 concurrent sessions:

cat /proc/meminfo
MemTotal:      4136580 kB
MemFree:       3298460 kB
Buffers:          4096 kB
Cached:          21124 kB
SwapCached:          0 kB
Active:          47416 kB
Inactive:        12532 kB
HighTotal:     3276160 kB
HighFree:      3214592 kB
LowTotal:       860420 kB
LowFree:         83868 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:              12 kB
Writeback:           0 kB
Mapped:          42104 kB
Slab:           293952 kB
CommitLimit:   2068288 kB
Committed_AS:    58892 kB
PageTables:       1112 kB
VmallocTotal:   116728 kB
VmallocUsed:      2940 kB
VmallocChunk:   110548 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB


without traffics:

cat /proc/meminfo
MemTotal:      4136580 kB
MemFree:       3924276 kB
Buffers:          4460 kB
Cached:          21020 kB
SwapCached:          0 kB
Active:          47592 kB
Inactive:        12848 kB
HighTotal:     3276160 kB
HighFree:      3214716 kB
LowTotal:       860420 kB
LowFree:        709560 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:              40 kB
Writeback:           0 kB
Mapped:          42368 kB
Slab:           132172 kB
CommitLimit:   2068288 kB
Committed_AS:    59220 kB
PageTables:       1140 kB
VmallocTotal:   116728 kB
VmallocUsed:      2940 kB
VmallocChunk:   110548 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB


Xiaoming.
