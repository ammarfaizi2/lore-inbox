Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbTHSUBP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 16:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbTHSUAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 16:00:50 -0400
Received: from zero.aec.at ([193.170.194.10]:47109 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261449AbTHSUAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 16:00:32 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
From: Andi Kleen <ak@muc.de>
Date: Tue, 19 Aug 2003 22:00:09 +0200
In-Reply-To: <mkbE.6Rk.35@gated-at.bofh.it> (Alan Cox's message of "Tue, 19
 Aug 2003 21:20:18 +0200")
Message-ID: <m3ada5s9iu.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <mfYi.374.31@gated-at.bofh.it> <mkbE.6Rk.35@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
>
> One thing I agree with you about is that an ARP resolution for an
> address via one path should not block a resolution for it by another
> path since to begin with the two paths may be to different routers
> one of which is down.

ARP resolution is per device. You can have multiple neighbours per
route, either using a multipath route (ip route add ... nexthop 1 nexthop ...)
or using default routing failover for the default route. When there
is an existing neighbour entry (valid or invalid) on a device there
cannot be another one, but there could be one on another device.
The routing code could transparently fail over to other devices using
suitable routes.

One long standing problem however in that code is that there is no 
feedback from ARP to the multipath routing code to trigger failover. 
The only way  currently to get a failover in the multipath route is to run
a daemon with a keepalive protocol (like gated/zebra with OSPF) that does 
ifconfig down for bad interfaces, triggering the route failover.
The kernel already has such a keepalive protocol in the form
of ARP, just it doesn't use the information for routing.

For multiple default routes it should work already transparently
in the kernel, just not for normal multipath routes.

I suspect if someone fixed this (implementing feedback from the
neighbour state engine to the rt cache/FIB code for failover) cleanly
the network maintainers would consider it favourably.

-Andi
