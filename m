Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbVBCBjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbVBCBjD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 20:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbVBCBgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 20:36:33 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:402
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262843AbVBCBaE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 20:30:04 -0500
Date: Wed, 2 Feb 2005 17:23:33 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Einar =?ISO-8859-1?Q?L=FCck?= <lkml@einar-lueck.de>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH 2/2] ipv4 routing: multipath with cache support,
 2.6.10-rc3
Message-Id: <20050202172333.4d0ad5f0.davem@davemloft.net>
In-Reply-To: <41C6B54F.2020604@einar-lueck.de>
References: <41C6B54F.2020604@einar-lueck.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004 12:19:43 +0100
Einar Lück <lkml@einar-lueck.de> wrote:

> This patch is an approach towards solving some problems with the 
> current multipath implementation:
> * routing cache allows only one route to be cached for a certain 
>  search key
> * a mulitpath/load balancing decision is only made in case a 
>  corresponding route is not yet cached
> In the scenarios, that are relevant to us (high amount of outgoing 
> connection requests), this is a serious problem.

I agree that per-connection attempt a new multipath decision
should be made, but within a flow I disagree.

This needs to be flow based.

Can you describe more precisely "the scenerios, that are relevant
to us"?

If you are only interested in more precise multipathing when TCP
connections on the local system are made, this we can implement
via a flag to the ipv4 routing cache which forces a new multipath
decision when TCP sockets have their identity established.
We have a precise interface that is invoked at this time, called
ip_route_connect().  So that is where we would pass in some flag
to indicate that we desire the new multipath behavior.

If you want this behavior on a router, you will need to mark the
packets using something like firewall marking on the SKB, then this
mark would be used at route cache lookup time to determine what
kind of multipath decisions to make.

There is no way we can enable the new behavior for every routing
cache lookup.
