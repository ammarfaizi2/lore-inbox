Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263612AbUDGPmX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 11:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263719AbUDGPmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 11:42:22 -0400
Received: from mail1.slu.se ([130.238.96.11]:38536 "EHLO mail1.slu.se")
	by vger.kernel.org with ESMTP id S263612AbUDGPmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 11:42:11 -0400
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16500.7408.240318.350476@robur.slu.se>
Date: Wed, 7 Apr 2004 17:23:28 +0200
To: dipankar@in.ibm.com
Cc: Robert Olsson <Robert.Olsson@data.slu.se>,
       Andrea Arcangeli <andrea@suse.de>, "David S. Miller" <davem@redhat.com>,
       kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       paulmck@us.ibm.com, akpm@osdl.org
Subject: Re: route cache DoS testing and softirqs
In-Reply-To: <20040406195249.GA4581@in.ibm.com>
References: <20040330133000.098761e2.davem@redhat.com>
	<20040330213742.GL3808@dualathlon.random>
	<20040331171023.GA4543@in.ibm.com>
	<16491.4593.718724.277551@robur.slu.se>
	<20040331203750.GB4543@in.ibm.com>
	<20040331212817.GQ2143@dualathlon.random>
	<20040331214342.GD4543@in.ibm.com>
	<16497.37720.607342.193544@robur.slu.se>
	<20040405212220.GH4003@in.ibm.com>
	<16498.43191.733850.18276@robur.slu.se>
	<20040406195249.GA4581@in.ibm.com>
X-Mailer: VM 7.17 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dipankar Sarma writes:

 > Robert, you should try out rs-throttle-rcu.patch. The idea is that
 > we don't run too many callbacks in a single rcu. In my setup,
 > at 100kpps, I see as many as 30000 rcu callbacks in a single
 > tasklet handler. That is likely hurting even the softirq-only
 > RCU grace periods. Setting rcupdate.maxbatch=4 will do only 4 per
 > tasklet thus providing more quiescent points to the system.

Hello!

No bad things happens, lots of overflows and drop in performance
and the userland app can stall for 32 sec. We seems to spin in
softirq to much and still don't get things done. 

Cheers.
					--ro

Without patch
=============
Iface   MTU Met  RX-OK RX-ERR RX-DRP RX-OVR  TX-OK TX-ERR TX-DRP TX-OVR Flags
eth0   1500   0 5568922 8823920 8823920 4431083     46      0      0      0 BRU
eth1   1500   0     45      0      0      0 5567591      0      0      0 BRU
eth2   1500   0 5742954 8731915 8731915 4257049     42      0      0      0 BRU
eth3   1500   0     46      0      0      0 5741617      0      0      0 BRU

/proc/net/rt_cache_stat [overflow 3:rd last]

00009e0f  004809d5 000cefee 00000000 00000000 00000000 00000000 00000000  00000000 00000000 00000000 000c8c85 000c8725 0000053a 00000533 0085c6f6 00000000 
00009e0f  004aa57e 000cfc18 00000000 00000000 00000000 00000000 00000000  00000000 00000000 00000000 000c4920 000c43b8 00000541 0000053d 0088c546 00000000 


With patch
===========

RCU: maxbatch = 4, plugticks = 0 

Iface   MTU Met  RX-OK RX-ERR RX-DRP RX-OVR  TX-OK TX-ERR TX-DRP TX-OVR Flags
eth0   1500   0 922395 9792296 9792296 9077609     45      0      0      0 BRU
eth1   1500   0     47      0      0      0 909892      0      0      0 BRU
eth2   1500   0 922586 9789706 9789706 9077417     45      0      0      0 BRU
eth3   1500   0     48      0      0      0 909992      0      0      0 BRU

/proc/net/rt_cache_stat [overflow 3:rd last]

00000018  000bc6e3 00024c63 00000000 00000000 00000000 00000000 00000000  00000000 00000000 00000000 00021077 0001df2f 000030e2 000030d9 0011ed4d 00000000 
00000018  000bc27d 0002518a 00000000 00000000 00000000 00000000 00000000  00000000 00000000 00000000 00020d75 0001dbba 0000313c 00003135 00122fc9 00000000 
