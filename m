Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWJLTMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWJLTMr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 15:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbWJLTMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 15:12:47 -0400
Received: from dev.mellanox.co.il ([194.90.237.44]:28291 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1750738AbWJLTMq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 15:12:46 -0400
Date: Thu, 12 Oct 2006 21:12:06 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: David Miller <davem@davemloft.net>
Cc: shemminger@osdl.org, steve@chygwyn.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, openib-general@openib.org, rolandd@cisco.com
Subject: Re: Dropping NETIF_F_SG since no checksum feature.
Message-ID: <20061012191206.GA16516@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20061011.144137.18281355.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061011.144137.18281355.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. David Miller <davem@davemloft.net>:
> Subject: Re: Dropping NETIF_F_SG since no checksum feature.
> 
> From: "Michael S. Tsirkin" <mst@mellanox.co.il>
> Date: Wed, 11 Oct 2006 23:23:39 +0200
> 
> > With my patch, there is a huge performance gain by increasing MTU to 64K.
> > And it seems the only way to do this is by S/G.
> 
> Numbers?
> 

I created two subnets on top of the same pair infiniband HCAs:

root@sw069 ~]# ifconfig ib0
ib0       Link encap:UNSPEC  HWaddr
00-00-04-04-FE-80-00-00-00-00-00-00-00-00-00-00
          inet addr:12.4.3.69  Bcast:12.255.255.255  Mask:255.0.0.0
          inet6 addr: fe80::202:c902:20:ee45/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:2044  Metric:1
          RX packets:1382531 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2725206 errors:0 dropped:5 overruns:0 carrier:0
          collisions:0 txqueuelen:128
          RX bytes:71892772 (68.5 MiB)  TX bytes:5290011992 (4.9 GiB)

[root@sw069 ~]# ifconfig ibc0
ibc0      Link encap:UNSPEC  HWaddr
00-03-04-06-FE-80-00-00-00-00-00-00-00-00-00-00
          inet addr:11.4.3.69  Bcast:11.255.255.255  Mask:255.0.0.0
          inet6 addr: fe80::202:c902:20:ee45/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:65484  Metric:1
          RX packets:115647 errors:0 dropped:0 overruns:0 frame:0
          TX packets:253403 errors:0 dropped:4 overruns:0 carrier:0
          collisions:0 txqueuelen:128
          RX bytes:6014720 (5.7 MiB)  TX bytes:16589589008 (15.4 GiB)

The other side was configured with 12.4.3.68 for MTU 65484
and 11.4.3.68 for MTU 2044. 

And then I just run netperf:
[root@sw069 ~]#
[root@sw069 ~]# /mswg/work/mst/netperf-2.4.2/src/netperf -f M -H 12.4.3.68 -c -C
TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 12.4.3.68 (12.4.3.68)
port 0 AF_INET
Recv   Send    Send                          Utilization       Service Demand
Socket Socket  Message  Elapsed              Send     Recv     Send    Recv
Size   Size    Size     Time     Throughput  local    remote   local   remote
bytes  bytes   bytes    secs.    MBytes  /s  % S      % S      us/KB   us/KB

 87380  16384  16384    10.00       286.45   40.20    25.28    5.482   3.448

[root@sw069 ~]# /mswg/work/mst/netperf-2.4.2/src/netperf -f M -H 11.4.3.68
TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 11.4.3.68 (11.4.3.68)
port 0 AF_INET
Recv   Send    Send
Socket Socket  Message  Elapsed
Size   Size    Size     Time     Throughput
bytes  bytes   bytes    secs.    MBytes/sec

 87380  16384  16384    10.01     782.55

This is all very preliminary - but I hope you get the idea -
increasing MTU is very helpful for infiniband, and infiniband adapters
handle large S/G lists without problems, but the verbs
do not include support for IP checksums, so these must be done in software.

So what we would like, is for the infiniband network device to say
"I don't support checksums, I only support S/G" and then for
network layer to do the checksumming for us piggybacking on data copy
at least for cases where it does perform the copy.

Does this makes sense now?

-- 
MST
