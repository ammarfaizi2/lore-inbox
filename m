Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266522AbUHVWvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266522AbUHVWvt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 18:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267346AbUHVWvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 18:51:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62429 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266522AbUHVWvi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 18:51:38 -0400
Message-ID: <4129236E.9020205@pobox.com>
Date: Sun, 22 Aug 2004 18:51:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Netdev <netdev@oss.sgi.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Trivial IPv6-for-Fedora HOWTO
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So, thanks to David Woodhouse for showing me how to do this.  IPv6 
appears to be very, very close to a Just Works(tm) state.

These instructions are for Fedora Core 2 users, and describe how to set 
up IPv6 automatically tunnelling (6to4) on an IPv4 network.  If you are 
stuck on an IPv4-only network (like most of us), this enables 
communication with IPv6 hosts quickly, easily, and transparently.

(this HOWTO is archived at http://yyz.us/ipv6-fc2-howto.html)


Simple setup:

1) Append to /etc/sysconfig/network

NETWORKING_IPV6=yes
IPV6_DEFAULTDEV=tun6to4

2) Append to /etc/sysconfig/ifcfg-eth0

IPV6INIT=yes
IPV6TO4INIT=yes

3) Reboot or restart your network interface.

That's it!



If you have an iptables ipv4 firewall, you'll want to

F1) allow ipv6 tunnelled packets to pass through to ip6tables, by 
allowing protocol 41

iptables -A block -p 41 -j ACCEPT
("block" is a custom chain on my firewall)

F2) duplicate your ipv4 firewall rules for ipv6, using ip6tables.  Some 
things, like masquerade, are not applicable to ipv6.



If you have an ipv4 NATing firewall, which serves as a router for a 
local network, you'll want to set up radvd and routing rules, so that 
your hosts autoconfigure ipv6 automatically based on your router's 
advertisements, and also so that your hosts truly speak native ipv6 
without tunneling [the router does the tunnel wrap/unwrap].

R1.1) in /etc/radvd.conf, set "interface ethX" to reflect your router's 
local LAN interface (eth1 on my own firewall).

R1.2) in radvd.conf, comment out "example of a standard prefix" prefix 
{} block

R1.3) in radvd.conf, edit the line "prefix 0:0:0:1234::/64" and change 
"1234" to a network number of your choice.

R1.4) in radvd.conf, edit line "Base6to4Interface ppp0" to reflect the 
interface doing the 6to4 tunnelling (eth0 on my own firewall).

R2) add routing rules for the local network.

	# ip -6 route add 2002:184a:9ba9:1010::/64 dev eth1
	# ip -6 addr add 2002:184a:9ba9:1010::1 dev eth1

You cat get the 2002:... address (your 6to4 address, formed from your 
ipv4 address) from your ifconfig.  In this example, "eth1" is my local 
LAN interface.  eth0 is the interface to my ISP (DSL modem).

Here is what my ifconfig output looks like, after everything is set up 
on my router/firewall:

eth0      Link encap:Ethernet  HWaddr 00:00:21:DE:DE:B5
           inet addr:24.74.155.XXX  Bcast:255.255.255.255 
Mask:255.255.248.0
           inet6 addr: fe80::200:21ff:fede:deb5/64 Scope:Link
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:8759136 errors:0 dropped:0 overruns:0 frame:0
           TX packets:2238155 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:1647432957 (1571.1 Mb)  TX bytes:166256535 (158.5 Mb)
           Interrupt:209 Base address:0x8c00

eth1      Link encap:Ethernet  HWaddr 00:C0:9F:39:CD:B0
           inet addr:10.10.10.1  Bcast:10.10.10.255  Mask:255.255.255.0
           inet6 addr: 2002:184a:9ab9:110::1/128 Scope:Global
           inet6 addr: 2002:184a:9ab9:110:2c0:9fff:fe39:cdb0/64 Scope:Global
           inet6 addr: fe80::2c0:9fff:fe39:cdb0/64 Scope:Link
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:9073144 errors:0 dropped:0 overruns:0 frame:0
           TX packets:10916350 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:1820645725 (1736.3 Mb)  TX bytes:3611957866 (3444.6
           Base address:0xece0 Memory:fe3e0000-fe400000

lo        Link encap:Local Loopback
           inet addr:127.0.0.1  Mask:255.0.0.0
           inet6 addr: ::1/128 Scope:Host
           UP LOOPBACK RUNNING  MTU:16436  Metric:1
           RX packets:440 errors:0 dropped:0 overruns:0 frame:0
           TX packets:440 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:0
           RX bytes:54209 (52.9 Kb)  TX bytes:54209 (52.9 Kb)

tun6to4   Link encap:IPv6-in-IPv4
           inet6 addr: 2002:184a:9ab9::1/16 Scope:Global
           UP RUNNING NOARP  MTU:1480  Metric:1
           RX packets:1520 errors:0 dropped:0 overruns:0 frame:0
           TX packets:1614 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:0
           RX bytes:886384 (865.6 Kb)  TX bytes:224041 (218.7 Kb)

