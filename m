Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129756AbQLAHEH>; Fri, 1 Dec 2000 02:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129516AbQLAHD5>; Fri, 1 Dec 2000 02:03:57 -0500
Received: from fscked.org ([198.88.183.227]:7178 "EHLO fscked.org")
	by vger.kernel.org with ESMTP id <S130109AbQLAHDs>;
	Fri, 1 Dec 2000 02:03:48 -0500
Date: Fri, 1 Dec 2000 00:27:47 -0600
From: Mike Perry <mikepery@fscked.org>
To: linux-kernel@vger.kernel.org
Subject: 2.2.17 IP masq bug
Message-ID: <20001201002747.A27262@is.so.fscked.org>
Mail-Followup-To: Mike Perry <mikepery@fscked.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While setting up a cluster, and I've stumbled across what appears to be a bug
in the IP masqing of 2.2.17. 

Here's my setup:
15 machines on 10.0.0.1-15. 10.0.0.1 has IP aliasing and is also on the
external net, so it can IP masq the other 14 machines. The machines are on a
switch, and share a semi-switched network segment with a bunch of other
external IP'd machines (we are all in the same lab, actually).

The bug: 
When I make a connection from any internal node to the one of the other 
externally routed machines in my lab, then close it, this external machine then 
becomes unreachable to successive connects from that node.

ex:
[root@node2 /root]# telnet 128.174.21.2 22
Trying 128.174.21.2...
Connected to fake.ip.uiuc.edu (128.174.21.2).
Escape character is '^]'.
SSH-1.5-1.2.27
^]
telnet> q
Connection closed.

[root@node2 /root]# telnet 128.174.21.2 22
Trying 128.174.21.2...

...

The problem also happens if I telnet to a closed port a few times in a row.
Soon the machine is unreachable by any network traffic from that node. If I
switch to a new node, I can connect just once from that node, and then
silence.

This problem does NOT manifest itself for connecting to machines outside of 
the local network. That seems to work fine.

More detailed setup info:
If it matters, all internal machines use eepro100's, and netboot via 
dhcp/PXE off of the 10.0.0.1 machine. 

Here's a sample routing table of the internal machines:
[root@node2 /root]# route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
10.0.0.0        0.0.0.0         255.0.0.0       U     0      0        0 eth0
127.0.0.0       0.0.0.0         255.0.0.0       U     0      0        0 lo
0.0.0.0         10.0.0.1        0.0.0.0         UG    0      0        0 eth0

And the world node:
[root@world /root]# route -n                                                   
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
128.174.21.50   0.0.0.0         255.255.255.255 UH    0      0        0 eth0
128.174.21.0    0.0.0.0         255.255.255.0   U     0      0        0 eth0
10.0.0.0        0.0.0.0         255.0.0.0       U     0      0        0 eth0
127.0.0.0       0.0.0.0         255.0.0.0       U     0      0        0 lo
0.0.0.0         128.174.21.11   0.0.0.0         UG    0      0        0 eth0

And the script to load the IP masq modules and setup ipchains:
#!/bin/sh
/sbin/ifconfig eth0:0 10.0.0.1
echo 1 > /proc/sys/net/ipv4/ip_forward
/sbin/ipchains -F input
/sbin/ipchains -F output
/sbin/ipchains -F forward
/sbin/ipchains -P input ACCEPT
/sbin/ipchains -P output ACCEPT
/sbin/ipchains -P forward DENY 
/sbin/ipchains -A forward -s 10.0.0.0/8 -j MASQ 

All the ip masq modules are loadded:
[root@world /root]# lsmod
Module                  Size  Used by
ip_masq_vdolive         1336   0  (unused)
ip_masq_user            2632   0  (unused)
ip_masq_raudio          3000   0  (unused)
ip_masq_quake           1352   0  (unused)
ip_masq_portfw          2560   0  (unused)
ip_masq_mfw             3144   0  (unused)
ip_masq_irc             1592   0  (unused)
ip_masq_ftp             2616   0  (unused)
ip_masq_cuseeme         1080   0  (unused)
ip_masq_autofw          2480   0  (unused)

The problem still occurs with no modules loaded.

-- 
Mike Perry
http://so.fscked.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
