Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbUB0Bj1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 20:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbUB0Bj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 20:39:26 -0500
Received: from usen-221x116x13x66.ap-US01.usen.ad.jp ([221.116.13.66]:4486
	"EHLO miyazawa.org") by vger.kernel.org with ESMTP id S261726AbUB0Bin
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 20:38:43 -0500
From: Kazunori Miyazawa <kazunori@miyazawa.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: IPSec: can't get IPv6 IPSec working with racoon
Date: Fri, 27 Feb 2004 10:38:34 +0900
User-Agent: KMail/1.5.4
References: <1077713881.793.25.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1077713881.793.25.camel@teapot.felipe-alfaro.com>
Cc: NetDev Mailinglist <netdev@oss.sgi.com>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402271038.34483.kazunori@miyazawa.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2004/02/25(Wed) 21:58, you wrote:
> 1. Host A tries to send and ICMPv6 ping echo request to host B, but
> since there exists a Security Policy that requires the use of ESP/AH,
> before A can send the ICMPv6 echo request, it must trigger an SA
> negotiation with host B. To start this SA negotiation, host A needs to
> know the link-layer address of peer host B:
>         1.1 Host A sends a Neighbor solicitation message to host B
>         1.2 Host B tries to send a Neigbor discovery packet, but since
>         there exists a Security Policy that requires the use of ESP/AH,
>         before B can send the Neighbor discovery, it triggers SA
>         negotiation.
> 
> This seems to create a loop: host A triggers SA negotiation in first
> place, but needs to know link-layer address of B, thus it sends a
> Neighbor solicitation packet which makes host B trigger SA association.
> Thus, both hosts are trying to establish an SA association, creating a
> deadlock.

It is well known chicken and egg problem about IPv6 IPsec.
You can bypass ICMP packet with putting ICMP bypass policies before
your own policies.
Then you can not trigger IPsec with ICMP ECHO.

spdadd fec0::204:75ff:feab:6fcc fec0::2 ipv6-icmp -P out none;
spdadd fec0::204:75ff:feab:6fcc fec0::2 ipv6-icmp -P in none;

spdadd fec0::204:75ff:feab:6fcc fec0::2 any -P out ipsec
esp/transport//require ah/transport//require;
spdadd fec0::2 fec0::204:75ff:feab:6fcc any -P in  ipsec
esp/transport//require ah/transport//require;

--Kazunori Miyazawa

