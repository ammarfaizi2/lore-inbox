Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbWBPUei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWBPUei (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 15:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWBPUeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 15:34:37 -0500
Received: from stinky.trash.net ([213.144.137.162]:49297 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S964788AbWBPUeg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 15:34:36 -0500
Message-ID: <43F4E183.2020508@trash.net>
Date: Thu, 16 Feb 2006 21:33:07 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Taprogge <jlt_lk@shamrock.dyndns.org>
CC: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netfilter@lists.netfilter.org
Subject: Re: 2.6.16-rc3 panic related to IP Forwarding and/or Netfilter
References: <20060216001056.GA7446@ranger.taprogge.wh> <43F3C547.8050901@trash.net> <20060216144457.GA1576@ranger.taprogge.wh>
In-Reply-To: <20060216144457.GA1576@ranger.taprogge.wh>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Taprogge wrote:
> The two patches fix the panic.  However routing still does not quite
> work. 
> 
> My setup consits of two masquerading gateways with local adresses
> 192.168.1.128 (2.6.15.1) and 192.168.3.11 (2.6.16-rc3 + patches).  They
> connect the two local networks through an IPSEC tunnel.  With the exact
> same setup that previously (192.168.3.11 running 2.6.13) worked I can
> now only reach from 192.168.1.0/24 to 192.168.3.0/24 and not the other
> way around:
> 
> Pinging from 192.168.1.128 I am getting:
> 	$ ping 192.168.3.15
> 	PING 192.168.3.15 (192.168.3.15): 56 data bytes
> 	64 bytes from 192.168.3.15: icmp_seq=0 ttl=63 time=127.9 ms
> 
> On the other hand pinging from 192.168.3.11 I am getting timeouts.
> 
> This is even the case if I set the nat POSTROUTING rule to: 
> 	$ iptables -t mangle -I PREROUTING -p esp -j MARK --set-mark 111
> 	$ iptables -t nat -F POSTROUTING
> 	$ iptables -t nat -A POSTROUTING -o ppp0 -s 192.168.3.0/24 \
> 		-m mark ! --mark 111 -j MASQUERADE
> 
> on both sides of the tunnel which should disable masquerading for IPSEC
> packages.
> 
> However the tunnel works as soon as I completly disable masquerading.

2.6.16-rc includes patches for proper netfilter IPsec handling. Packets
will now go through the chains once in plain text and once encrypted,
so I guess you're masquerading the packets that should go through the
tunnel to an address that doesn't match the policy anymore and they
are therefore not handled by IPsec (this is also the case my patches
fixed). So you need to make sure you don't have any SNAT rules that
change the unencrypted packets to an address not included in the policy.
