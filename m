Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbUBXSmx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 13:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbUBXSmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 13:42:53 -0500
Received: from ambr.mtholyoke.edu ([138.110.1.10]:3600 "EHLO
	ambr.mtholyoke.edu") by vger.kernel.org with ESMTP id S262377AbUBXSml
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 13:42:41 -0500
Date: Tue, 24 Feb 2004 13:42:34 -0500 (EST)
From: Ron Peterson <rpeterso@MtHolyoke.edu>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: network / performance problems
In-Reply-To: <20040224102208.4fd285e3.davem@redhat.com>
Message-ID: <Pine.OSF.4.21.0402241330410.320699-100000@mhc.mtholyoke.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Feb 2004, David S. Miller wrote:
> 
> So Ron, as performance gets worse and worse, take a look at what the firewall
> rules in the kernel look like.   I bet you're accumulating netfilter ipchains
> rules over time and this makes packet processing go slower and slower, and it's
> due to some bug in whatever is dynamically adding firewall rules to your system.

Thanks David.

I'm not dynamically altering the rules, though.  On machine 'must', you
can see in the following graph that using 2.4.24, must's latency starts
growing.  With 2.4.20, it doesn't.  I've included the iptables rules I use
on this machine below.

http://depot.mtholyoke.edu:8080/tmp/must-mhc/2002-02-24_8:40/mhc_last_108000.png

The current smokeping graph looks exactly the same, just longer.

I did an 'iptables -v -L' and 'iptables -v -L -t nat' on a couple of
machines that are still running, but slowing down, and see exactly what
I'd expect.  Is there something else I can look at for you?

I *do* run iptables on all of these machines.  The script below
essentially reflects how I do this, with minor variations according to
what ports I want open.  The rules on 'mist' are a little more
complicated; we DHCP mist to be the gateway for unregistered machines,
and I do some SNAT stuff to redirect off-campus web traffic to a
registration page.

########################################################################
IFACE="eth0"
IPTABLES="/sbin/iptables"
echo "1" > /proc/sys/net/ipv4/ip_forward
########################################################################


########################################################################
# Flush existing rules for all chains.
$IPTABLES -F
$IPTABLES -t nat -F

# The default policy for each chain is to DROP the packet.
$IPTABLES -P INPUT DROP
$IPTABLES -P OUTPUT DROP
$IPTABLES -P FORWARD DROP
########################################################################


########################################################################
# Allow ping from on-campus
iptables -A INPUT -s 138.110.0.0/16 --protocol icmp --icmp-type
echo-request -j ACCEPT
########################################################################



########################################################################
# Allow this host to establish new connections.  Otherwise only accept
# established connections.
$IPTABLES -A OUTPUT --match state --state NEW,ESTABLISHED,RELATED -j
ACCEPT
$IPTABLES -A INPUT --match state --state ESTABLISHED,RELATED -j ACCEPT

# Allow incoming ssh connections from on campus
$IPTABLES -A INPUT -s 138.110.0.0/16 --protocol tcp --destination-port 22
-j ACCEPT

# Allow NetBIOS
$IPTABLES -A INPUT --protocol tcp --destination-port 137:139 -j ACCEPT
$IPTABLES -A INPUT --protocol udp --destination-port 137:139 -j ACCEPT
$IPTABLES -A INPUT --protocol tcp --destination-port 445 -j ACCEPT
$IPTABLES -A INPUT --protocol tcp --destination-port 445 -j ACCEPT
$IPTABLES -A INPUT --protocol udp --destination-port 445 -j ACCEPT
# Need to do this to allow nmblookup broadcasts to recieve reply
$IPTABLES -A INPUT --protocol udp --source-port 137:139 -j ACCEPT

# Allow secure web connections
$IPTABLES -A INPUT --protocol tcp --destination-port 443 -j ACCEPT

# Allow incoming postgresql connections from on campus
# $IPTABLES -A INPUT -s 138.110.0.0/16 --protocol tcp --destination-port
5432 -j ACCEPT

# Allow this host to talk to itself.
$IPTABLES -A INPUT -d 127.0.0.1 -i lo -j ACCEPT
#######################################################################

_________________________
Ron Peterson
Network & Systems Manager
Mount Holyoke College

