Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVCGIrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVCGIrM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 03:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVCGIrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 03:47:12 -0500
Received: from tempo.di-net.ru ([213.248.12.5]:47629 "EHLO tempo.di-net.ru")
	by vger.kernel.org with ESMTP id S261705AbVCGIoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 03:44:44 -0500
Date: Mon, 7 Mar 2005 11:43:50 +0300
From: Leo Yuriev <leo@yuriev.ru>
X-Mailer: The Bat! (v3.0.1.33) Professional
Reply-To: Leo Yuriev <leo@yuriev.ru>
X-Priority: 3 (Normal)
Message-ID: <856676954.20050307114350@yuriev.ru>
To: Ben Greear <greearb@candelatech.com>, Patrick McHardy <kaber@trash.net>
CC: linux-kernel@vger.kernel.org, Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re[2]: [PATCH] ethernet-bridge: update skb->priority in case forwarded frame has VLAN-header
In-Reply-To: <422BABCE.3030904@candelatech.com>
References: <1199527299.20050305165713@yuriev.ru>
 <422BABCE.3030904@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-1.6 (tempo.di-net.ru [213.248.12.5]); Mon, 07 Mar 2005 11:44:08 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LY>> Kernel 2.6 (2.6.11)
LY>>
LY>> When ethernet-bridge forward a packet and such ethernet-frame has
LY>> VLAN-tag, bridge should update skb->prioriry for properly QoS
LY>> handling.
LY>>
LY>> This small patch does this. Currently vlan_TCI-priority directly
LY>> mapped to skb->priority, but this looks enough.

PM> It needs to verify the tag is present and accessible using
PM> pskb_may_pull(). But I think an ebtables target similar to the iptables
PM> CLASSIFY target is a better place for this. It could allow setting
PM> skb->priority to an arbitary value or derive it from vlan priority or IP
PM> tos.

BG> The VLAN code has it's own (user-configurable) mapping from skb->priority to .1q priority,
BG> and .1q priority to skb->priority.  You might want to clone or somehow
BG> use the .1q mapping logic to allow something other than just a
BG> straight .1q -> skb->priority mapping.

BG> If this packet came in from an 802.1Q VLAN device, the VLAN code already
BG> has the logic necessary to map the .1q priority to an arbitrary skb->priority.

- Yes, but linux-box can be a all-vlan-bridge without the 8021q
module. So, in a some cases of configuration (like currently is my
own) nobody in kernel can set skb->priority in the forwarded packets.
But I (as a user) can expect than the bridge with QoS will able to
plain and evident prioritization without my immersion into ebtables...

1) I will put the verification by pskb_may_pull() as pointed Patrick
McHardy. It is just my mistake/bug.

2) Despite of opportunities ebtables I think, that this addition is
necessary. As small forces, by default, provide more correct and
expected behaviour of system, without conflicts to other
opportunities.

3) But I think, it is not necessary to provide a customization of
mapping .1q priority to skb->priority (e.g. clone a code from
VLAN-module) for the following reasons:
    - my patch is intended only for the basic, obvious behaviour;
    - ebtables already provide a powerful abilities;
    - user can expect that the bridge will not require more
      configuration that currently is provided;


