Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbTHUEE7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 00:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbTHUEE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 00:04:59 -0400
Received: from [61.135.132.105] ([61.135.132.105]:11424 "EHLO smtp02.sohu.com")
	by vger.kernel.org with ESMTP id S262397AbTHUEE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 00:04:56 -0400
From: r6144 <r6k@sohu.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="twDDmdOh74"
Content-Transfer-Encoding: 7bit
Message-ID: <16196.17541.700609.752058@localhost.localdomain>
Date: Thu, 21 Aug 2003 12:03:17 +0800
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test3] unregister_netdevice: waiting for tap0 to become free.
X-Mailer: VM 7.14 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--twDDmdOh74
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit

When running user-mode linux on 2.6.0-test3, sometimes the TAP device
cannot be correctly removed when someone request to delete it, by
closing /dev/net/tun after setting TUNSETPERSIST to 0.  The message
is:

unregister_netdevice: waiting for tap0 to become free.  Usage count = 1

The message repeats forever, system time is 100%, related processes
are all in D state, ifconfig locks up, and the system cannot be shut down
normally (can only use Alt-Sysrq-SUB).

Looks like a refcount leak.  Maybe it is IPv6 related since without
setting IPv6 routes to the tap device there seems to be no problem,
but I'm not sure of that.

By the way, I think creation and removal of netdevices should be done
in a mount-like manner, which means that they are persistent
(originally non-persistent tap devices should just be removed
automatically when they are no longer used), can be removed by hand,
and if they are being used -EBUSY should be returned.

What I did run:

1. Run "tunctl", which just creates a persistent tap0 device.

2. Run the attached script that starts UML.  I guess it is enough to
just look at the "route", "ip" and "arp" commands.  The UML process
just provides the data for the tunnel.

Running it several times is also okay, I didn't see any higher
reference counts.

3. Run "tunctl -d tap0" which sets tap0 as non-persistent, thus it will
be removed.  The command locks up, and the aforementioned message then
appears.

I may be able to make the problem more reproducible, but it takes many
reboots so I want to ask for your advice first.

I'm not a subscriber, please CC me.


--twDDmdOh74
Content-Type: text/plain
Content-Description: The script to start UML
Content-Disposition: inline;
	filename="start"
Content-Transfer-Encoding: 7bit

#!/bin/sh

if [ -z "$UML" ] ; then UML=linux ; fi
ifconfig tun6to4 > /dev/null 2>&1 || { echo "Please initialize ipv6."; exit 1; }

TAP_DEV=$1
if [ -z "$TAP_DEV" ] ; then TAP_DEV=tap0 ; fi
ifconfig "$TAP_DEV" > /dev/null 2>&1 || { echo "Please initialize $TAP_DEV."; exit 1; }
UML_IPV4_ADDR=$2
UML_IPV4_GW_ADDR=192.168.1.1
if [ -z "$UML_IPV4_ADDR" ] ; then UML_IPV4_ADDR=192.168.1.2 ; fi

fail()
{
    echo "User mode linux startup failed."
    exit 1
}

run()
{
    run_cmd=$1
    shift
    echo "* $run_cmd $@"
    $run_cmd "$@" || fail
}

IPV4_ADDR=`ipv4-addr`
IPV6_ADDR=`ipv6-addr`
IPV6_PREFIX=$(echo $IPV6_ADDR | awk -F: 'BEGIN { OFS=":"; } {print $1,$2,$3; }')
UML_IPV6_NUM=$(echo $UML_IPV4_ADDR | awk -F. '{ print $4; }')
UML_IPV6_ADDR="$IPV6_PREFIX:1::$UML_IPV6_NUM"
UML_IPV6_GW_ADDR="$IPV6_PREFIX:1::1"
ROOT_FS=/usr/imgs/root_fs
COW_FILE=$ROOT_FS.cow_$UML_IPV4_ADDR
echo "IPv4 addr: $IPV4_ADDR"
echo "IPv6 addr: $IPV6_ADDR"
echo "UML IPv4 addr: $UML_IPV4_ADDR"
echo "UML IPv6 addr: $UML_IPV6_ADDR"
echo "UML IPv6 gateway addr: $UML_IPV6_GW_ADDR"
echo "TAP device: $TAP_DEV"
run rm -f $COW_FILE
run ifconfig "$TAP_DEV" "$UML_IPV4_GW_ADDR" up
echo 1 > /proc/sys/net/ipv4/ip_forward
run route add -host "$UML_IPV4_ADDR" dev "$TAP_DEV"
echo 1 > /proc/sys/net/ipv4/conf/$TAP_DEV/proxy_arp
run arp -Ds "$UML_IPV4_ADDR" eth0 pub
run ip -6 addr add $UML_IPV6_GW_ADDR/128 dev "$TAP_DEV"
run ip -6 route add $UML_IPV6_ADDR dev "$TAP_DEV"
echo 1 > /proc/sys/net/ipv6/conf/all/forwarding
# Already set in /etc/rc.d/rc.local
# run iptables -t nat -F POSTROUTING
# run iptables -t nat -s 192.168.1.0/24 -d ! 192.168.1.0/24 -A POSTROUTING -j SNAT --to-source $IPV4_ADDR
xhost +$UML_IPV4_ADDR
$UML root=/dev/ubd0p1 con=port:9000 con0=fd:0,fd:1 ubd0=$COW_FILE,$ROOT_FS eth0=tuntap,$TAP_DEV ip=$UML_IPV4_ADDR ip6=$UML_IPV6_ADDR ip6gw=$UML_IPV6_GW_ADDR

ip -6 route del "$UML_IPV6_ADDR"
ip -6 addr del "$UML_IPV6_GW_ADDR/128" dev "$TAP_DEV"
arp -i eth0 -d "$UML_IPV4_ADDR" pub
route del -host "$UML_IPV4_ADDR"
ifconfig "$TAP_DEV" down

--twDDmdOh74--

