Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbUBYM7o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 07:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbUBYM7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 07:59:43 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:37381 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261305AbUBYM7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 07:59:02 -0500
Subject: IPSec: can't get IPv6 IPSec working with racoon
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: NetDev Mailinglist <netdev@oss.sgi.com>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-k1T2kIW4Lr2CAVJ1bOcj"
Message-Id: <1077713881.793.25.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Wed, 25 Feb 2004 13:58:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-k1T2kIW4Lr2CAVJ1bOcj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi!

I have been unable to make IPSecv6 work between two hosts running 2.6.3
kernels and racoon. It works perfectly with IPv4, but with IPv6 there
seems to be the following problem:

Host A and Host B are configured so any IPv6 and IPv6 packet exchange
MUST use ESP/AH:

1. Host A tries to send and ICMPv6 ping echo request to host B, but
since there exists a Security Policy that requires the use of ESP/AH,
before A can send the ICMPv6 echo request, it must trigger an SA
negotiation with host B. To start this SA negotiation, host A needs to
know the link-layer address of peer host B:
        1.1 Host A sends a Neighbor solicitation message to host B
        1.2 Host B tries to send a Neigbor discovery packet, but since
        there exists a Security Policy that requires the use of ESP/AH,
        before B can send the Neighbor discovery, it triggers SA
        negotiation.

This seems to create a loop: host A triggers SA negotiation in first
place, but needs to know link-layer address of B, thus it sends a
Neighbor solicitation packet which makes host B trigger SA association.
Thus, both hosts are trying to establish an SA association, creating a
deadlock.

With IPv4 and IPSec, the simplified packet trace is:

A -> B ISAKMP Security Association
B -> A ISAKMP Security Association
A -> B ISAKMP Key Exchange
B -> A ISAKMP Key Exchange
A -> B ISAKMP Identification
B -> A ISAKMP Identification

But, with IPv6 and IPSec, this is the packet trace I'm seeing:

A -> B ICMPv6 Neighbor solicitation
A -> B ICMPv6 Neighbor solicitation
B -> A ISAKMP Security Association (initiator)
A -> B ICMPv6 Neighbor solicitation
A -> B ICMPv6 Neighbor solicitation
...

Let be host A configured with the following IPv6 address:

	inet addr   192.168.0.100
	inet6 addr: fec0::204:75ff:feab:6fcc/64 Scope:Site
	inet6 addr: 2000::204:75ff:feab:6fcc/64 Scope:Global
	inet6 addr: fe80::204:75ff:feab:6fcc/64 Scope:Link

Let be host B configured with the following IPv6 addresses:

	inet addr   192.168.0.2
	inet6 addr: fec0::2/64 Scope:Site
	inet6 addr: 2000::204:75ff:fe75:9765/64 Scope:Global
	inet6 addr: fe80::204:75ff:fe75:9765/64 Scope:Link

I'm using the following setkey commands on host A:

flush;
spdflush;
spdadd 192.168.0.100 192.168.0.2 any -P out ipsec esp/transport//require
ah/transport//require;
spdadd 192.168.0.2 192.168.0.100 any -P in ipsec esp/transport//require
ah/transport//require;
spdadd fec0::204:75ff:feab:6fcc fec0::2 any -P out ipsec
esp/transport//require ah/transport//require;
spdadd fec0::2 fec0::204:75ff:feab:6fcc any -P in  ipsec
esp/transport//require ah/transport//require;

The same commands (reversing the order) are applied on host B.

I'm running 2.6.3 and racoon on both hosts. IPSec over IPv4 works
perfectly, but does not work over IPv6. I trigger the IPSecv6
negotiation by doing a ping6 from host A to host B.

Am I right when I think there is a deadlock when negotiating the
Security Association between host A and host B? I've attached a trace
for IPv4 for a complete IPSec SA establishment, and a trace for IPv6
(which doesn't work).

--=-k1T2kIW4Lr2CAVJ1bOcj
Content-Disposition: attachment; filename=IPv4
Content-Type: application/octet-stream; name=IPv4
Content-Transfer-Encoding: base64

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

--=-k1T2kIW4Lr2CAVJ1bOcj
Content-Disposition: attachment; filename=IPv6
Content-Type: application/octet-stream; name=IPv6
Content-Transfer-Encoding: base64

1MOyoQIABAAAAAAAAAAAAP//AAABAAAAuJU8QGUEDgBWAAAAVgAAADMz/wAAAQAEdatvzIbdYAAA
AAAgOv/+wAAAAAAAAAIEdf/+q2/M/wIAAAAAAAAAAAAB/wAAAYcAsCMAAAAA/sAAAAAAAAAAAAAA
AAAAAQEBAAR1q2/MuJU8QGwzDgBWAAAAVgAAADMz/wAAAgAEdatvzIbdYAAAAAAgOv/+wAAAAAAA
AAIEdf/+q2/M/wIAAAAAAAAAAAAB/wAAAocAsCEAAAAA/sAAAAAAAAAAAAAAAAAAAgEBAAR1q2/M
uJU8QFY4DgCOAAAAjgAAAAAEdatvzAAEdXWXZYbdYAAAAABYEUD+wAAAAAAAAAAAAAAAAAAC/sAA
AAAAAAACBHX//qtvzAH0AfQAWAs0qzQixbJmFTEAAAAAAAAAAAEQAgAAAAAAAAAAUAAAADQAAAAB
AAAAAQAAACgBAQABAAAAIAEBAACACwABgAxwgIABAAWAAwADgAIAAYAEAAK5lTxAQS8OAFYAAABW
AAAAMzP/AAACAAR1q2/Mht1gAAAAACA6//7AAAAAAAAAAgR1//6rb8z/AgAAAAAAAAAAAAH/AAAC
hwCwIQAAAAD+wAAAAAAAAAAAAAAAAAACAQEABHWrb8y6lTxA+S4OAFYAAABWAAAAMzP/AAACAAR1
q2/Mht1gAAAAACA6//7AAAAAAAAAAgR1//6rb8z/AgAAAAAAAAAAAAH/AAAChwCwIQAAAAD+wAAA
AAAAAAAAAAAAAAACAQEABHWrb8w=

--=-k1T2kIW4Lr2CAVJ1bOcj--

