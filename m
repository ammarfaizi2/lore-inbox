Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316594AbSIIHjM>; Mon, 9 Sep 2002 03:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316595AbSIIHjM>; Mon, 9 Sep 2002 03:39:12 -0400
Received: from aurora.nsu.ru ([193.124.215.195]:61351 "EHLO aurora.nsu.ru")
	by vger.kernel.org with ESMTP id <S316594AbSIIHjL>;
	Mon, 9 Sep 2002 03:39:11 -0400
Date: Mon, 9 Sep 2002 14:43:45 +0700 (NOVST)
From: "Dmitry N. Hramtsov" <hdn@nsu.ru>
To: linux-kernel@vger.kernel.org
Subject: Connectivity problem (kernel bug?)
Message-ID: <Pine.LNX.4.44.0209091432120.16415-100000@aurora.nsu.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello All,

I've expiriencing a problem using 802.1q vlan in linux.
It is possible a bug in Linux networking code.
I've posted this problem to linux-vlan list too.

Ok, about the problem in details.
Here is my network scheme:

  __________________________________
 | Smart switch with 802.1Q support |
 |-------------------------------------------------------------+
 |      Port1                Port2                Port3        |
 |  VLAN1: untagged      VLAN1: untagged      VLAN1: untagged  |
 |  VLAN2: 802.1Q        VLAN2: 802.1Q        VLAN2: no        |
 |       [*]                   [*]                 [*]         |
 +--------|---------------------|-------------------|----------+
          |                     |                   |
          |                     |                   |
        Cisco                 Linux1              Linux2
  (default gateway)


*** Cisco configuration:

!
interface FastEthernet0/0.1
	ip address 10.0.0.1 255.255.255.0
	encapsulation dot1Q 1 native
!
interface FastEthernet0/0.2
	ip address 10.1.0.1 255.255.255.0
	encapsulation dot1Q 2
!



*** Linux1 configuration

interface eth0
	ip	10.0.0.2
	mask	255.255.255.0
	gateway	10.0.0.1

interface eth0.2
	VLAN ID	2
	ip	10.1.0.2
	mask	255.255.255.0



*** Linux2 configuration

interface eth0
	ip      10.0.0.3
	mask    255.255.255.0
	gateway 10.0.0.1



Now about the problem.
In this scheme all hosts can ping each other by 10.0.0.0/24 ip addresses.
And also cisco and Linux1 can ping each other by 10.1.0.0/24 ip addresses.

But when I am doing "ping 10.1.0.2" from Linux2 i did not receive response.
And even more. Linux1 (10.1.0.2) *sends* no response at all.

I've tried to analyse this and come to a conclusion that this is Linux1 fault.
Well, what is going on:

1. Linux2 (10.0.0.3) send icmp echo request to 10.1.0.2 thru 10.0.0.1
     10.0.0.3 -> 10.0.0.1
2. Cisco receives it and forwards to Linux2 thru VLAN 2
     10.1.0.1 -> 10.1.0.2
3. Linux1 receives icmp request thru eth0.2

All of this stages may be observed using tcpdump on Linux1 and Linux2.

4. Nothing happened any more! ==8-O
No reply sends from Linux1!
Not from eth0 nor from eth0.2!

I am expecting that Linux1 will send reply to 10.0.0.3 using eth0 but it
is not happening.

This bug affects not only icmp packets. No communication can be
established between Linux2 and ip 10.1.0.2 at Linux1.

Any ideas? Comments?

Best regards,
Dmitry N. Hramtsov

p.s. my kernel on Linux1 is 2.4.18



