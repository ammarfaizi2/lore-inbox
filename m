Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271112AbRH1Ol1>; Tue, 28 Aug 2001 10:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271124AbRH1OlS>; Tue, 28 Aug 2001 10:41:18 -0400
Received: from marvin.mvlan.net ([64.39.178.10]:55818 "HELO mailhost.mvlan.net")
	by vger.kernel.org with SMTP id <S271112AbRH1OlG>;
	Tue, 28 Aug 2001 10:41:06 -0400
Date: Tue, 28 Aug 2001 10:41:18 -0400
From: Jean-Sebastien Morisset <jsmoriss@mvlan.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: iproute2 routing problem.
Message-ID: <20010828104118.C26589@marvin.mvlan.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-OS: Linux marvin 2.2.19 #16 Sun Aug 26 18:53:31 EDT 2001 i686 unknown
X-Uptime: 10:19am  up 19:49,  3 users,  load average: 1.02, 1.02, 1.02
X-PGP-Key: http://jsmoriss.mvlan.net/pgp-public-keys.txt
X-PGP-Fingerprint: 93 67 23 4C 40 92 0E 7C  09 DD 55 FA 9C 6C 88 39  C6 1A 8A 78
X-Seti: Name=jsm-mv #WU=1448 CPU=797 days (Best Scores: Spike=0.779698 Gaussian=0.491700)
X-ICQ: 47027114
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This might be slightly off topic, but since the official iproute2 list is
down, I thought you guys might be able to help me...

I have an ADSL modem on ppp0, and a CableModem on eth1. The plan is to
make all services available on the ADSL, and use the CableModem as my
default route (load balancing and fail-over are planned). Unfortunately,
Linux gets confused if a public IP comes in on ppp0 since it's default
route is eth1.  It starts logging messages about 'martian sources' and the
reply packet gets lost. The solution is to mark incoming packets on ppp0
and eth1 differently.  iproute2 can then use these fwmarks to route the
reply packets back to the correct interface. In practice, I've gotten ppp0
to work using fwmarks, but eth1 is being stubborn. Let me go through my
configuration:

# My firewall (rcf v5.2.1c2 at http://rcf.mvlan.net/) inserts the
# following chains to mark packets.

ipchains -I ppp0i -m 20 -p tcp -s any/0 -d 64.39.178.10 0:65535
ipchains -I eth1i -m 10 -p tcp -s any/0 -d 24.201.178.12 0:65535

# Here is my iproute2 routing table

root@marvin:/etc/rc.d/init.d$ ip ru ls
0:      from all lookup local
32764:  from all fwmark       10 lookup cable
32765:  from all fwmark       20 lookup adsl
32766:  from all lookup main
32767:  from all lookup 253

# The /etc/iproute2/rt_tables file.

201     cable
202     adsl

# And here are the routing tables. I've added a route to my
# private network to route masqueraded traffic properly.

root@marvin:/etc/rc.d/init.d$ ip ro ls table cable
10.1.1.0/24 dev eth0  scope link
default via 24.202.124.1 dev eth1

root@marvin:/etc/rc.d/init.d$ ip ro ls table adsl
10.1.1.0/24 dev eth0  scope link
default via 64.39.160.16 dev ppp0

# The standard routing table. Note that ppp0 is being used as the
# default route right now (lower metric). Until I can get the fwmark
# based routing to work properly on eth1, I can't use it as my
# default route.

root@marvin:/tmp$ ip ro ls table main
10.1.1.60 dev eth0  scope link  src 10.1.1.60
255.255.255.255 dev eth0  scope link
64.39.160.16 dev ppp0  proto kernel  scope link  src 64.39.178.10
10.1.1.10 dev eth0  scope link  window 16384
10.1.1.50 dev eth0  scope link  src 10.1.1.50
10.1.1.1 dev eth0  scope link  src 10.1.1.1
10.1.1.0/24 dev eth0  proto kernel  scope link  src 10.1.1.10
24.202.124.0/24 dev eth1  proto kernel  scope link  src 24.202.124.110
127.0.0.0/8 dev lo  scope link  window 16384
default via 64.39.160.16 dev ppp0  metric 20
default via 24.202.124.1 dev eth1  metric 30

Everything is working fine on ppp0, but when packets come in on eth1, the
replies are getting lost. Here are the syslog messages from ipchains when
I log everything:

# Incoming packet gets marked.

Aug 28 09:09:06 marvin kernel: Packet log: eth1i - eth1 PROTO=6
64.231.253.60:49000 24.202.124.110:443 L=60 S=0x00 I=45912 F=0x4000 T=53
SYN (#2)

# Various anti-spoofing filters, etc.

Aug 28 09:09:06 marvin kernel: Packet log: eth1i spoofi eth1 PROTO=6
64.231.253.60:49000 24.202.124.110:443 L=60 S=0x00 I=45912 F=0x4000 T=53
SYN (#14)
Aug 28 09:09:06 marvin kernel: Packet log: eth1i ianai eth1 PROTO=6
64.231.253.60:49000 24.202.124.110:443 L=60 S=0x00 I=45912 F=0x4000 T=53
SYN (#15)
Aug 28 09:09:06 marvin kernel: Packet log: eth1i prii eth1 PROTO=6
64.231.253.60:49000 24.202.124.110:443 L=60 S=0x00 I=45912 F=0x4000 T=53
SYN (#34)

# Packet is accepted.

Aug 28 09:09:06 marvin kernel: Packet log: eth1i ACCEPT eth1 PROTO=6
64.231.253.60:49000 24.202.124.110:443 L=60 S=0x00 I=45912 F=0x4000 T=53
SYN (#44)

The following syslog messages are identical. There are no reply packets
sent back on this interface or any other. I've also snooped all the
interfaces to make sure the reply packet wasn't sent anywhere else. It
just seems to get lost... Here's the tcpdump output for the above
connection:

root@marvin:/tmp$ tcpdump -vvv -X -n -i eth1 port 443
tcpdump: listening on eth1
09:16:30.773407 64.231.253.60.49010 > 24.202.124.110.443: S
3229195700:3229195700(0) win 5808 <mss 1412,sackOK,timestamp
109455285[|tcp]> (DF) (ttl 53, id 47617)
0x0000   4500 003c ba01 4000 3506 b85e 40e7 fd3c        E..<..@.5..^@..<
0x0010   18ca 7c6e bf72 01bb c079 9db4 0000 0000        ..|n.r...y......
0x0020   a002 16b0 1094 0000 0204 0584 0402 080a        ................
0x0030   0686 27b5 0000                                 ..'...

Does anyone see anything I've missed?

BTW, as you can tell, I'm using ipchains under linux 2.2.19. My iproute2
versions is ss990630.

Thanks,
js.
-- 
Jean-Sebastien Morisset, Sr. UNIX Administrator <jsmoriss@mvlan.net>
Personal Homepage <http://jsmoriss.mvlan.net/>; UNIX, Internet, 
Homebrewing, Cigars, PCS, PalmOS, CP2020 and other Fun Stuff...
This is Linux Country. On a quiet night you can hear Windows NT reboot!
