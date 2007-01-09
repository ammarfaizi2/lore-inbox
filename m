Return-Path: <linux-kernel-owner+w=401wt.eu-S932179AbXAITgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbXAITgc (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 14:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbXAITgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 14:36:31 -0500
Received: from vs02.svr02.mucip.net ([83.170.6.69]:56407 "EHLO mx01.mucip.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932179AbXAITgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 14:36:31 -0500
Date: Tue, 9 Jan 2007 20:36:24 +0100
From: Bernhard Schmidt <berni@birkenwald.de>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [IPv6] PROBLEM? Network unreachable despite correct route
Message-ID: <20070109193624.GA27718@obelix.birkenwald.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having a really ugly problem I'm trying to pinpoint, but failed so
far. I'm neither completely convinced it is not related to my local
setup(s), nor do I have any clue how this might be caused.

I have several boxes with native IPv6 connectivity at various places.
Some of them show symptoms of a lost default route for small periods of
time (10-15 seconds several times a day). By symptoms I mean

- traceroute6 from the affected box to any other host dies immediately
  (the network unreachable does not come from the first hop (the
  upstream router), but from the local stack itself)

- a local running OpenVPN 2.1_rc1b with UDPv6 transport patched in shows
  the following output in the syslog file

  Tue Jan  9 16:48:28 2007 write UDPv6 []: Network is unreachable
  (code=101)

- mtr from the outside to the machine shows that the affected box does
  not respond anymore, while the hop before (the router) is clean.

- new connects to the box (e.g. ssh) from the outside are stuck (packets
  get lost, since I'm running my client with tcp_retries=1 I get a
  timeout

At the same time, established ssh connections to the box work fine. I
can do "ip -6 route" and it shows the default route, both preferred and
valid lifetime not exceeded (far from that). 

The systems I'm observing this are:

- Dell PowerEdge 750 (P4 with HT), Debian Etch, self compiled kernel
  2.6.17.11, connected (e1000) to two upstream Cisco 7200, default route
  is learned from RIPng (Quagga), static addresses

- Dell OptiPlex GX<something> (P4 with HT, Single Core), SuSE 10.2,
  distribution kernel 2.6.18.5-3-default, connected (tg3) to one
  upstream Cisco 6500/Sup720, default route learned through stateless
  autoconfiguration (RA)

- self built AMD Athlon64 (x86_64), Ubuntu Edgy, Distribution kernel
  2.6.17-10-generic, connected (forcedeth) to an upstream Linux box
  (2.6.20-rc3), default route learned through stateless
  autoconfiguration (RA) as well.

My current believe is that this is an regression introduced in 2.6.17.
I have searched for several weeks now why box #1 (the PowerEdge) shows
signs of unreachability in the monitoring, but could not find any clue
(or verify any reachability problems when I got the monitoring alert).
At the same time, a sibling (same hardware, same switch, same network
segment, route also learned through Quagga, but different kernel (2.6.16))
of this box did not show any symptoms, so I ruled out the local network.

Also, I upgraded box #2 from SuSE 10.1 (distribution kernel
2.6.16-something) to SuSE 10.2 yesterday. While it was running the
OpenVPN/UDPv6 daemon the whole time, there has been exactly _one_
occurence of the "Network is unreachable" message in the past two weeks
before the upgrade (and I can correlate this message with network
maintainance where the VPN endpoint was indeed unreachable). Since the
upgrade, I have at least 50 lines of that sort in syslog (in about a
day).

It is pretty hard to trace this. It seems to appear very seldom, it is
not long and I cannot predict the time where it happens by doing more
network load or anything else on that machine. IPv4 is fine and without
loss in all cases. All network components are dual-stacked, so if there
was an L2 issue between the router and the host it would affect IPv4 as
well.

Is anyone aware of any issue which might cause this? I've upgraded the
PowerEdge to 2.6.19.1 now, but it is too early to tell whether this
problem still exists. Does anyone recall a bugreport and maybe a fix for
it? A patch or a link to a changeset would be even better, so I could
report that to SuSE and Ubuntu to have it included in future kernels. 

Thanks,
Bernhard
