Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266682AbSLPMji>; Mon, 16 Dec 2002 07:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266688AbSLPMji>; Mon, 16 Dec 2002 07:39:38 -0500
Received: from iafilius.xs4all.nl ([213.84.160.212]:21120 "EHLO
	sjoerd.sjoerdnet") by vger.kernel.org with ESMTP id <S266682AbSLPMjg>;
	Mon, 16 Dec 2002 07:39:36 -0500
Date: Mon, 16 Dec 2002 13:47:26 +0100 (CET)
From: Arjan Filius <iafilius@xs4all.nl>
X-X-Sender: arjan@sjoerd.sjoerdnet
Reply-To: Arjan Filius <iafilius@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.5.50 ipsec -> kernel: pmtu discvovery on SA AH/00003d54/ac110032
Message-ID: <Pine.LNX.4.44.0212161343110.8713-100000@sjoerd.sjoerdnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

While using IPSEC in tunnel mode with kernel 2.5.50 and up i get on the
ipsec gateway kernel messages like:
Dec 15 19:46:05 sjoerd kernel: pmtu discvovery on SA AH/00003d54/ac110032
And my sessions just "hangs".

I can reproduce it when requiring the gateway send large enough amount of
data to the client for example logged in with ssh on gateway and do a `cat
/var/log/messages`.
Same effect, when trying with a host behind the gateway.

However, when i don't use ipsec tunnel mode (transport) i can't reproduce it,
and also not without ipsec.


Any help here?
At least i found out that a:
iptables -I FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --set-mss 1300
Does the trick (on the gateway) after some searches about ipsec and mtu
problems.
Manual changing mtu sizes seems not to resolve my problem.

Is this a nonimplemented ipsec-fragmentation issue?

Note i'm useing 801.1q on the gateway, and the client is in a vlan behind a
vlan-enabled c3548Xl switch, which is normally operating OK.

vlan100 is with 802.1q on eth0 (note same MAC, but different manual MTU)

eth0      Link encap:Ethernet  HWaddr 00:00:AF:00:00:00
          inet addr:172.16.0.1  Bcast:172.16.255.255  Mask:255.255.0.0
          inet6 addr: fe80::200:afff:fe00:0/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:9000  Metric:1
          RX packets:23417 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1300 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:1540693 (1.4 Mb)  TX bytes:203391 (198.6 Kb)
          Interrupt:10

sjoerd:/images/kernel/linux-2.5.52 # ifconfig vlan100
vlan100   Link encap:Ethernet  HWaddr 00:00:AF:00:00:00
          inet addr:172.17.0.1  Bcast:172.17.255.255  Mask:255.255.0.0
          inet6 addr: fe80::200:afff:fe00:0/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:1567 errors:0 dropped:0 overruns:0 frame:0
          TX packets:213 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:108910 (106.3 Kb)  TX bytes:39427 (38.5 Kb)

And using on the gateway to set up ipsec:

#!/sbin/setkey -f
flush;
spdflush;

# AH
add 172.17.0.1 172.17.0.50 ah 15700 -A hmac-md5 "****************";
add 172.17.0.50 172.17.0.1 ah 24500 -A hmac-md5 "****************";
# ESP
add 172.17.0.1 172.17.0.50 esp 15701
		-m tunnel
		-E 3des-cbc "************************";
add 172.17.0.50 172.17.0.1 esp 24501
		-m tunnel
		-E 3des-cbc "************************";


spdadd 0.0.0.0/0 172.17.0.50 any -P out ipsec
	   esp/tunnel/172.17.0.1-172.17.0.50/require
           ah/transport//require;

spdadd 172.17.0.50 0.0.0.0/0 any -P in ipsec
	   esp/tunnel/172.17.0.50-172.17.0.1/require
           ah/transport//require;




-- 
Arjan Filius
mailto:iafilius@xs4all.nl

