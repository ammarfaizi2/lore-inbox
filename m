Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753971AbWKGCu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971AbWKGCu7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 21:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753967AbWKGCu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 21:50:59 -0500
Received: from nz-out-0102.google.com ([64.233.162.196]:60036 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1753970AbWKGCu6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 21:50:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WRrNk2/PuJKSN6B4znGUENBel3BkMZBg40YPKLN2eTDyzunvB0qUVLK6xoXaZFKqeuv3WVg7C6vgUn2muPVO1K8VPUMuZEbRXSBCPp9WYJGESckBlxBRSAwHkoHbEtE9d81oUZPDiEq6KcUv6YRnQWfGLS2mE26REKniXqYPa6o=
Message-ID: <f55850a70611061850i47ca73adt6a5c71e6732db69e@mail.gmail.com>
Date: Tue, 7 Nov 2006 10:50:57 +0800
From: "Zhao Xiaoming" <xiaoming.nj@gmail.com>
Subject: Re: ZONE_NORMAL memory exhausted by 4000 TCP sockets
Cc: linux-kernel@vger.kernel.org, "Linux Netdev List" <netdev@vger.kernel.org>
In-Reply-To: <454F6483.4010307@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <f55850a70611052207j384e1d3flaf40bb9dd74df7c5@mail.gmail.com>
	 <454EE580.5040506@cosmosbay.com> <454F6483.4010307@osdl.org>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/06, Stephen Hemminger <shemminger@osdl.org> wrote:
> Eric Dumazet wrote:
> > Zhao Xiaoming a écrit :
> >> Dears,
> >>    I'm running a linux box with kernel version 2.6.16. The hardware
> >> has 2 Woodcrest Xeon CPUs (2 cores each) and 4G RAM. The NIC cards is
> >> Intel 82571 on PCI-e bus.
> >>    The box is acting as ethernet bridge between 2 Gigabit Ethernets.
> >> By configuring ebtables and iptables, an application is running as TCP
> >> proxy which will intercept all TCP connections requests from the
> >> network and setup another TCP connection to the acture server.  The
> >> TCP proxy then relays all traffics in both directions.
> >>    The problem is the memory. Since the box must support thousands of
> >> concurrent connections, I know the memory size of ZONE_NORMAL would be
> >> a bottleneck as TCP packets would need many buffers. After setting
> >> upper limit of net.ipv4.tcp_rmem and net.ipv4.tcp_wmem to 32K bytes,
> >> our test began.
> >>    My test scenario employs 2000 concurrent downloading connections
> >> to a IIS server's port 80. The throughput is about 500~600 Mbps which
> >> is limited by the capability of the client application. Because all
> >> traffics are from server to client and the capability of client
> >> machine is bottleneck, I believe the receiver side of the sockets
> >> connected with server and the sender side of the sockets connected
> >> with client should be filled with packets in correspondent windows.
> >> Thus, roughly there should be about 32K * 2000+ 32K*2000 = 128M bytes
> >> memory occupied by TCP/IP stack for packet buffering. Data from
> >> slabtop confermed it. it's about 140M bytes memory cost after I start
> >> the traffic. That reasonablly matched with my estimation. However,
> >> /proc/meminfo had a different story. The 'LowFree' dropped from about
> >> 710M to 80M. In other words, there's addtional 500M memory in
> >> ZONE_NORMAL allocated by someone other than the slab. Why?
> The amount of memory per socket is controlled by the socket buffering.
> Your application
> could be setting the value by calling setsockopt(). Otherwise, the tcp
> memory is limited
> by the sysctl settings tcp_rmem (receiver) and tcp_wmem (sender).
>
> For example on this server:
> $ cat /proc/sys/net/ipv4/tcp_wmem
> 4096    16384   131072
>
> Each sending socket would start with 16K of buffering, but could grow up
> to 128K based
> on TCP send autotuning.
>
>
>
Of course I can change the TCP buffers and I already discribed I set
both uppper limit of tcp_rmem and tcp_wmem to 32K. And if you go
through my former posts, you should notic that TCP stack on my machine
only occupied 34K memory pages for buffering which is close to my
theoretical estimation: 128M. But at the same time, my free LOMEM size
decreased from over 700M to less than 100M. The question is where the
additional 500M bytes gone?
