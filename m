Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbTHTRzl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 13:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbTHTRzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 13:55:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19355 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262092AbTHTRzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 13:55:39 -0400
Date: Wed, 20 Aug 2003 10:48:31 -0700
From: "David S. Miller" <davem@redhat.com>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030820104831.6235f3b9.davem@redhat.com>
In-Reply-To: <3F43B389.5060602@candelatech.com>
References: <1061320363.3744.14.camel@athena.fprintf.net>
	<Pine.LNX.3.96.1030820123600.14414I-100000@gatekeeper.tmr.com>
	<20030820100044.3127d612.davem@redhat.com>
	<3F43B389.5060602@candelatech.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Aug 2003 10:44:41 -0700
Ben Greear <greearb@candelatech.com> wrote:

> It seems that these reasons would not preclude the addition of a flag
> that would default to the current behaviour but allow the behaviour that
> other setups desire easily?

I would accept a patch that did something like
the following in arp_solicit().

	if (skb && inet_addr_type(skb->nh.iph->saddr) == RTN_LOCAL &&
	    (in_dev->conf.shared_media ||
	     inet_addr_onlink(dev, skb->nh.iph->saddr, 0)))
		saddr = skb->nh.iph->saddr;
	else
		saddr = inet_select_addr(dev, target, RT_SCOPE_LINE);

Then people can frob the shared_media sysctl for devices
where they want the behavior to be that we will only use
addresses assigned to the device as the solicitor address.

The shared_media setting defaults to one and thus would preserve
current behavior by default.

The idea is not mine, Alexey suggested it to me the other day.

I hope this pleases people wrt. ARP request solicitor address
handling.
