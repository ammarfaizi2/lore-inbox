Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262089AbSJ2QrO>; Tue, 29 Oct 2002 11:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262019AbSJ2QqQ>; Tue, 29 Oct 2002 11:46:16 -0500
Received: from ncc1701.cistron.net ([62.216.30.38]:8463 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S262020AbSJ2QpY>; Tue, 29 Oct 2002 11:45:24 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: TCP hangs in 2.4.20-pre11 (and 2.4.19)
Date: Tue, 29 Oct 2002 16:51:10 +0000 (UTC)
Organization: Cistron
Message-ID: <apme9u$n2n$1@ncc1701.cistron.net>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1035910270 23639 62.216.29.67 (29 Oct 2002 16:51:10 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have one machine rsync'ing a debian mirror through another machine
which runs a HTTPS proxy - rsync can use the HTTP CONNECT method to
proxy-connected to a remote rsyncd.

On the gateway machine, the proxy consistantly hangs in a write().
I've replaced the squid proxy with a simple perl script + nc to
make sure it isn't a squid-related problem..

# netstat -t | grep ftp.debian.nl
Active Internet connections (w/o servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp    70832  14480 cust.94.89.adsl.c:33876 ftp.debian.nl:rsync     ESTABLISHED

# ps -eo pid,tt,user,fname,tmout,f,wchan | grep nc
26782 ?        nobody   nc           - 100 wait_for_tcp_memory

# strace -fp 26782
write(3, "\236\3754\"OU\331\6\36d\33;\270\3776\221\21\364Z\370/\346"..., 3384 <unfinished ...>

# tcpdump -v -e -i eth1 -n host ftp.debian.nl
tcpdump: listening on eth1
17:36:40.946370 0:10:67:0:f8:8f 0:d0:b7:b2:67:82 0800 66: 195.64.82.85.873 > 195.64.94.89.33876: . [tcp sum ok] ack 2887846970 win 0 <nop,nop,timestamp 77491485 14953830> (DF) (ttl 61, id 19377, len 52)
17:36:40.946431 0:d0:b7:b2:67:82 0:10:67:0:f8:8f 0800 66: 195.64.94.89.33876 > 195.64.82.85.873: . [tcp sum ok] ack 1 win 0 <nop,nop,timestamp 14965835 77480589> (DF) (ttl 64, id 30547, len 52)
17:36:51.985379 0:d0:b7:b2:67:82 0:10:67:0:f8:8f 0800 66: 195.64.94.89.33876 > 195.64.82.85.873: . [tcp sum ok] ack 1 win 0 <nop,nop,timestamp 14966939 77480589> (DF) (ttl 64, id 30548, len 52)
17:36:52.032399 0:10:67:0:f8:8f 0:d0:b7:b2:67:82 0800 66: 195.64.82.85.873 > 195.64.94.89.33876: . [tcp sum ok] ack 1 win 0 <nop,nop,timestamp 77492593 14965835> (DF) (ttl 61, id 19378, len 52)
17:38:40.984930 0:10:67:0:f8:8f 0:d0:b7:b2:67:82 0800 66: 195.64.82.85.873 > 195.64.94.89.33876: . [tcp sum ok] ack 1 win 0 <nop,nop,timestamp 77503488 14965835> (DF) (ttl 61, id 19379, len 52)
17:38:40.984987 0:d0:b7:b2:67:82 0:10:67:0:f8:8f 0800 66: 195.64.94.89.33876 > 195.64.82.85.873: . [tcp sum ok] ack 1 win 0 <nop,nop,timestamp 14977838 77492593> (DF) (ttl 64, id 30549, len 52)

.. etc. It never recovers from this.

The machine has 2 eepro100 network cards. One is connected to the
office network (which has its own 2 mbit connected to the outside
world), the other is connected to an ADSL 8 mbit/sec line. Both
connections to the outside world show the same problem. I've tried
both eepro100 and e100 drivers with the same results. 2.4.20-pre11
and 2.4.19 both behave the same. There is no firewall in the
path anywhere. And it doesn't matter which remote
rsync server I used, the connection always eventually hangs.

Wait - I do have a dual routing table setup, so that traffic originating
from the ADSL IP goes out over the ADSL line:

# ip rule show
0:	from all lookup local 
32700:	from 195.64.94.89 lookup adsl 
32766:	from all lookup main 
32767:	from all lookup default 
# ip route show table adsl 
default via 195.64.94.1 dev eth1 

The machine is a PII/300 with 192 MB of RAM, of which it has
plenty free.

What can this be ? Esp. the netstat output looks weird.

Mike.

