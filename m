Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbUDERM3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 13:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263031AbUDERM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 13:12:28 -0400
Received: from mail1.slu.se ([130.238.96.11]:7369 "EHLO mail1.slu.se")
	by vger.kernel.org with ESMTP id S263028AbUDERMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 13:12:25 -0400
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16497.37720.607342.193544@robur.slu.se>
Date: Mon, 5 Apr 2004 19:11:52 +0200
To: dipankar@in.ibm.com
Cc: Andrea Arcangeli <andrea@suse.de>,
       Robert Olsson <Robert.Olsson@data.slu.se>,
       "David S. Miller" <davem@redhat.com>, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, paulmck@us.ibm.com,
       akpm@osdl.org
Subject: Re: route cache DoS testing and softirqs
In-Reply-To: <20040331214342.GD4543@in.ibm.com>
References: <20040329222926.GF3808@dualathlon.random>
	<200403302005.AAA00466@yakov.inr.ac.ru>
	<20040330211450.GI3808@dualathlon.random>
	<20040330133000.098761e2.davem@redhat.com>
	<20040330213742.GL3808@dualathlon.random>
	<20040331171023.GA4543@in.ibm.com>
	<16491.4593.718724.277551@robur.slu.se>
	<20040331203750.GB4543@in.ibm.com>
	<20040331212817.GQ2143@dualathlon.random>
	<20040331214342.GD4543@in.ibm.com>
X-Mailer: VM 7.17 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dipankar Sarma writes:

 > Robert, btw, this rcu-softirq patch is slightly different
 > from the earlier one in the sense that now every softirq
 > handler completion is a quiescent point. Earlier each iteration
 > of softirqs was a quiescent point. So this has more quiescent
 > points.

Hello!

Yes it seems reduce RCU latency in our setup as well. It does not eliminate 
overflows but reduces with ~50% and increases the throughput a bit. dst cache 
overflow depends on RCU-delay + gc_min_interval and the number of entries
freed per sec so this means RCU has improved. Also the user app doing gettimeofday 
seems to be better scheduled. The worst starvation improved from ~7.5 to ~4.4 sec. 

Cheers.
							--ro

Setup as described before.

Without patch
=============

2 * 283 kpps (eth0, eth2) 32768 flows and 10 pkts flow 

Kernel Interface table
Iface   MTU Met  RX-OK RX-ERR RX-DRP RX-OVR  TX-OK TX-ERR TX-DRP TX-OVR Flags
eth0   1500   0 5419435 8802471 8802471 4580569     44      0      0      0 BRU
eth1   1500   0     45      0      0      0 5417465      0      0      0 BRU
eth2   1500   0 5372943 8849348 8849348 4627060     44      0      0      0 BRU
eth3   1500   0     46      0      0      0 5371007      0      0      0 BRU

/proc/net/rt_cache_stat (3:rd last is ovfr) 
000034d0  0046284e 000c8986 00000000 00000000 00000000 00000000 00000000  00000000 00000000 00000000 000bf952 000bf173 000007b8 000007b3 0081b228 00000000 
000034d0  004559f4 000ca247 00000000 00000000 00000000 00000000 00000000  00000000 00000000 00000000 000c369c 000c2edf 00000799 00000792 008057a4 00000000 

User app max delay 7.5 Sec

WIth RCU patch
===============


2 * 284 kpps 32768 flows and 10 pkts flow 

Iface   MTU Met  RX-OK RX-ERR RX-DRP RX-OVR  TX-OK TX-ERR TX-DRP TX-OVR Flags
eth0   1500   0 5838522 8704663 8704663 4161481     44      0      0      0 BRU
eth1   1500   0     45      0      0      0 5837586      0      0      0 BRU
eth2   1500   0 5957987 8643714 8643714 4042016     44      0      0      0 BRU
eth3   1500   0     46      0      0      0 5957051      0      0      0 BRU

/proc/net/rt_cache_stat
0002dcb5  004b6add 000dac08 00000000 00000000 00000000 00000000 00000000  00000000 00000000 00000000 000d029a 000cfec3 000003aa 000003a9 008c80b2 00000000 
0002dcb5  004d2db5 000dbbda 00000000 00000000 00000000 00000000 00000000  00000000 00000000 00000000 000cfa51 000cf67e 000003b1 000003aa 008eb195 00000000 

User app max delay 4.4 Sec
