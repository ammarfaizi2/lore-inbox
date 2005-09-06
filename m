Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbVIFR3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbVIFR3d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 13:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbVIFR3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 13:29:33 -0400
Received: from rain.plan9.de ([193.108.181.162]:30139 "EHLO rain.plan9.de")
	by vger.kernel.org with ESMTP id S1750785AbVIFR3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 13:29:32 -0400
Date: Tue, 6 Sep 2005 19:29:30 +0200
From: Marc Lehmann <schmorp@schmorp.de>
To: linux-kernel@vger.kernel.org
Subject: masquerading failure for at least icmp and tcp+sack on amd64
Message-ID: <20050906172930.GA29753@schmorp.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP: "1024D/DA743396 1999-01-26 Marc Alexander Lehmann <schmorp@schmorp.de>
       Key fingerprint = 475A FE9B D1D4 039E 01AC  C217 A1E8 0270 DA74 3396"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I recently upgraded a 32 bit machine to a new amd64 board+cpu. I took the
same kernel (2.6.13-rc7) and just recompiled it for 64 bit, plus upgraded
userspace to 64 bit.

Firewall config stayed the same.

Problem: neither ping nor tcp was being masqueraded properly. I created
the following test-set-up:

   iptables -t mangle -F
   iptables -t filter -F
   iptables -t nat -F
   iptables -t nat -A POSTROUTING -p all -s 10.0.0.0/8 -d \! 10.0.0.0/8 -j MASQUERADE

i..e the above masquerade rule should be the only firewall rule, and all
fules shoul[d have policy ACCEPT.

The effect was that tcp packets and icmp packets coming from 10.0.0.1 on
interface eth0 were properly masqueraded on the outgoing "inet" interface
(ppp0 renamed):

eth0:
   19:17:24.364351 IP 10.0.0.1.44320 > 129.13.162.95.80: S 3745828676:3745828676(0) win 5840 <mss 1460,nop,nop,sackOK>

inet:
   19:17:24.364505 IP 84.56.237.68.44320 > 129.13.162.95.80: S 3745828676:3745828676(0) win 5840 <mss 1452,nop,nop,sackOK>
   19:17:24.378029 IP 129.13.162.95.80 > 84.56.237.68.44320: S 3777391404:3777391404(0) ack 3745828677 win 5840 <mss 1460,nop,nop,sackOK>
   19:17:24.378103 IP 84.56.237.68.44320 > 129.13.162.95.80: R 3745828677:3745828677(0) win 0

However, the reverse packets were rejected. ip_conntrack showed this:

   tcp      6 52 SYN_SENT src=10.0.0.1 dst=129.13.162.95 sport=44320 dport=80 [UNREPLIED] src=129.13.162.95 dst=84.56.237.68 sport=80 dport=44320 mark=0 use=1

ICMP echo replies were also masqueraded, but the reply was ignored.

Weird observation 1:

   ip route del default
   ip add default via 10.0.0.17

Resulted in working masquerading, this time over device "vpn0", which is
a tuntap-interface. Working means that outgoing packets were correctly
re-written with source 10.0.0.5 (local address of vpn0) and replie were
correctly "un"-translated.

Weird obervation 2:

Some sites could be connected to with TCP. It turned out that those
sites did not support TCP SACK. Indeed, turning off SACK either on the
remote side of a connection or on the origonator side resulted in workign
masquerading:

eth0:
   19:23:29.928470 IP 10.0.0.1.45611 > 129.13.162.95.80: S 4113365634:4113365634(0) win 5840 <mss 1460>
   19:23:29.942246 IP 129.13.162.95.80 > 10.0.0.1.45611: S 4161877683:4161877683(0) ack 4113365635 win 5840 <mss 1460>
   19:23:29.942313 IP 10.0.0.1.45611 > 129.13.162.95.80: . ack 1 win 5840

inet:
   19:23:29.928249 IP 84.56.237.68.45611 > 129.13.162.95.80: S 4113365634:4113365634(0) win 5840 <mss 1452>
   19:23:29.942199 IP 129.13.162.95.80 > 84.56.237.68.45611: S 4161877683:4161877683(0) ack 4113365635 win 5840 <mss 1460>
   19:23:29.942332 IP 84.56.237.68.45611 > 129.13.162.95.80: . ack 1 win 5840

However, ICMP still is not masqueraded.

Kernels that worked:

   2.6.13-rc7, 2.6.12.5, 2.6.11 and lower, compiled for x86 with gcc-3.4

Kernels that don't work:

   2.6.13-rc7 (compiled with gcc-3.4 and 4.0.2 debian), 2.6.13 (gcc-4.02)

Kernel configuration was exactly the same for the 2.6.13-rc7 kernels,
modulo the cpu and architectrue selections.

I have a somewhat nontrivial source routing set-up on that machine that I
could document more if that could be a possible reason for that problem. I
am confident that this is not a configuration error, as the configuraiton
worked basically unchanged since the 2.4 days, and I am confident it's not
a iptables setup problem either, as I can reproduce it with empty rules
except for the masquerading rule.

I did not mention UDP because I didn't test it, but it's likely that UDP
masquerading also fails.

Any idea at what I could look at or try out to find out more about this
problem?

-- 
                The choice of a
      -----==-     _GNU_
      ----==-- _       generation     Marc Lehmann
      ---==---(_)__  __ ____  __      pcg@goof.com
      --==---/ / _ \/ // /\ \/ /      http://schmorp.de/
      -=====/_/_//_/\_,_/ /_/\_\      XX11-RIPE
