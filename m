Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266203AbUFJGIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266203AbUFJGIy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 02:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266195AbUFJGIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 02:08:54 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:3083 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S266211AbUFJGHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 02:07:20 -0400
Subject: Re: 2.6.7-rc3: waiting for eth0 to become free
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Christian Kujau <evil@g-house.de>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       NetDev Mailinglist <netdev@oss.sgi.com>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <40C793CE.6000609@g-house.de>
References: <1086722310.1682.1.camel@teapot.felipe-alfaro.com>
	 <20040608124215.291a7072@dell_ss3.pdx.osdl.net>
	 <1086725369.1806.1.camel@teapot.felipe-alfaro.com>
	 <20040608140200.2ddaa6f4@dell_ss3.pdx.osdl.net>
	 <1086794282.1706.2.camel@teapot.felipe-alfaro.com>
	 <40C793CE.6000609@g-house.de>
Content-Type: text/plain
Date: Thu, 10 Jun 2004 08:07:16 +0200
Message-Id: <1086847636.1719.6.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-10 at 00:48 +0200, Christian Kujau wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
> |>What is happening is that some subsystem is holding a reference to the
> device (calling dev_hold())
> |>but not cleaning up (calling dev_put).  It can be a hard to track
> which of the many
> |>things routing, etc are not being cleared properly.  Look for routes
> that still
> |>get stuck (ip route) and neighbor cache entries.  Most of these end up
> being
> |>protocol bugs.
> |
> |
> | The two attached patches, one for net/ipv4/route.c, the other for net/
> | ipv6/route.c fix all my problems when running "cardctl eject" while a
> | program mantains an open network socket (ESTABLISHED).
> |
> | Both patches apply cleanly against 2.6.7-rc3 and 2.6.7-rc3-mm1.
> | I'm not completely sure what has changed in 2.6.7-rc3 that is breaking
> | cardctl for me, as it Just Worked(TM) fine in 2.6.7-rc2.
> 
> do you know, by any chance, if this error is dependent to eth0 only or
> could help for my error message too:
> 
> unregister_netdevice: waiting for ppp0 to become free. Usage count = 1

I think the mentioned error is not dependent on any specific interface
(let it be eth0, or ppp0), but any interface in general which has a
routing entry and is the target/source of IP traffic. This is based on
the fact that my fixes play with the refcounting on any interface. not
just eth0 specifically, and pertain to both IPv4 and IPv6 core.

However, I detected this behavior on my eth0, since this is the only
interface I have on my laptop. You just can try both patches against
2.6.7-rc3 or 2.6.7-rc3-mm1 to see if them cure your problems.

> happened just a few hours ago (2.6.7-rc3), i had to reboot the box
> anyway, but pppd was not able to die (even with kill -9)

In my case, I was able to trigger the problem by running "cardctl eject"
which was then stuck at D state. Killing any program using a network
socket, and waiting for opened connections to transition from
ESTABLISHED to TIME_WAIT and then being closed, allowed "cardctl" to
exit the D state.

