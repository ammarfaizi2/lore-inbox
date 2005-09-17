Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbVIQDBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbVIQDBb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 23:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbVIQDBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 23:01:31 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:37321 "HELO
	develer.com") by vger.kernel.org with SMTP id S1750836AbVIQDBa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 23:01:30 -0400
Message-ID: <432B8702.3060801@develer.com>
Date: Sat, 17 Sep 2005 05:01:22 +0200
From: Bernardo Innocenti <bernie@develer.com>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: netfilter-devel@lists.netfilter.org
Subject: Intermittent NAT failure when multiple hosts send UDP packets
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=FC6A66CA;
	url=https://www.develer.com/~bernie/gpgkey.txt
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This smells like a bug in UDP ip_nat_proto_udp.c or nearby.
I'm seeing this on 2.6.12-1.1447_FC4, but code in 2.6.13 is
still the same.

I've setup SNAT the usual way:

 iptables -A POSTROUTING -t nat -o ppp0 -j SNAT --to-source 151.38.19.110

When multiple clients in the LAN send UDP packets to the same port of
the same remote host, I see something like this in my /proc/net/ip_conntrack:

 udp      17 170 src=10.3.3.2 dst=194.185.88.60 sport=5060 dport=5060 src=194.185.88.60 dst=151.38.19.110 sport=5060 dport=5060 [ASSURED] use=1
 udp      17 29 src=10.3.3.2 dst=212.97.59.76 sport=5060 dport=5060 [UNREPLIED] src=212.97.59.76 dst=151.38.19.110 sport=5060 dport=5060 use=1
 udp      17 177 src=10.3.3.250 dst=194.185.88.60 sport=5060 dport=5060 src=194.185.88.60 dst=151.38.19.110 sport=5060 dport=1024 [ASSURED] use=1

In the last line, the destination port has been properly remapped from
5060 to 1024 to distingish between incoming packets.

However, I see packets going out over ppp0 without the source
address properly rewritten to 151.38.19.110:

 04:38:28.739514 IP 10.3.3.2.5060 > 194.185.88.60.5060: UDP, length 536

This doesn't happen when there's just a single host sending to port 5060.
Sometimes I must restart the interface to trigger this bug.  



-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

