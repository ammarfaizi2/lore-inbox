Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267681AbUHENhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267681AbUHENhI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 09:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267677AbUHENhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 09:37:08 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:7143 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S267681AbUHENe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 09:34:29 -0400
Date: Thu, 5 Aug 2004 15:33:59 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jgarzik@pobox.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Multicast Driver Testing Quick How-To v 0.3 [was: Re: List of pending v2.4 kernel bugs]
Message-ID: <20040805133359.GA15129@k3.hellgate.ch>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <20040720142640.GB2348@dmt.cyclades> <20040721112336.GA9537@k3.hellgate.ch> <20040730155613.GD2748@logos.cnet> <410A8077.7020308@pobox.com> <20040730172939.GA24235@k3.hellgate.ch> <410A8F17.8070401@pobox.com> <20040730182006.GA26545@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040730182006.GA26545@k3.hellgate.ch>
X-Operating-System: Linux 2.6.8-rc3 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2004 20:20:06 +0200, Roger Luethi wrote:
> Hmm.. Maybe I should brush up the multicast testing quick how-to and
> post it somewhere for future reference. There seems to be a distinct
> lack of testing in this area.

Related information: As of Linux 2.6.7, results for atp, winbond, and
tulip_core would be most interesting. For 2.4.26, candidates include
winbond and tulip_core.

Here goes:

================================================================================
Multicast Driver Testing Quick How-To (Version 0.3)
=====================================
0.2 - Add minimal test app by David Stevens
0.3 - Spell out limitations on Ethernet switches (David Stevens)
    - Link to Manfred Spraul's test app

This document is meant to facilitate testing of basic multicast
functionality in Linux (Ethernet) drivers.

1) Preparation
--------------
Make sure the host you are testing replies to broadcasts:

target# cat /proc/sys/net/ipv4/icmp_echo_ignore_all
0
target# cat /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts
0

Our test packets need to go to the target host, so either have a
route or use ping "-r -I <ifname>" option:
tester# route add -net 224.0.0.0 netmask 240.0.0.0 eth0

2) Test default group
---------------------
Since every multicast capable host interface joins 224.0.0.1, you
can already ping your target:

tester# ping -r -I eth0 -t 1 -c 2 224.0.0.1

Your target host should answer this (so may your tester, depending on
your setup).

3a) Join group on Ethernet level
--------------------------------
Note: If you add multicast addresses via "ip maddr" in the way described
below, it won't work for some hardware configurations. In particular,
if you have an Ethernet switch that does IGMP snooping, the switch won't
replicate multicast packets on ports that haven't had IGMP reports for
the multicast address you're testing. In that case, having it in the
hardware MAF (Multicast Address Filter) doesn't help, and you'll need
to do the IP-level join (see 3b) to get them delivered.


We haven't joined the next group yet, so there should be no answer:

tester# ping -r -I eth0 -t 1 -c 2 224.1.1.37

Use packet sniffer to confirm that target is not seeing the request
(use -p option for tcpdump or tethereal to prevent promiscuous mode)

Now join the group (Ethernet level):

target# ip maddr add 01:00:5e:01:01:25 dev eth0

tester# ping -r -I eth0 -t 1 -c 2 224.1.1.37

Use packet sniffer to confirm that target is seeing the request now.

3b) Join group on IP level
--------------------------
The program below will join a multicast group at IP level and thus
at Ethernet level as well -- provided driver and hardware work
properly. Group membership end with termination of the program.

Remove hardware filter (if any left from previous test):

target# ip maddr del 01:00:5e:01:01:25 dev eth0

Join multicast group:

target# ./mcjoin eth0 224.1.1.37

tester# ping -r -I eth0 -t 1 -c 2 224.1.1.37

No need for packet sniffer this time, the target will answer since the
IP layer is aware of our group membership.

A) Other Resources
------------------
Manfred Spraul maintains a multicast test application at:
http://www.colorfullife.com/~manfred/TestApps/multicast/

--------------------------------------------------------------------------------
/* Purpose: Join a multicast group (for testing)	*/
/* Author: David Stevens <dlstevens at us.ibm.com>, 2004	*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <net/if.h>

int
main(int argc, char *argv[])
{
	struct ip_mreqn mreqn;
	int s;

	if (argc != 3) {
		fprintf(stderr, "usage: %s <dev> <group>\n", argv[0]);
		exit(1);
	}
	s = socket(PF_INET, SOCK_DGRAM, 0);
	if (s < 0) {
		perror("socket");
		exit(1);
	}
	memset(&mreqn, 0, sizeof(mreqn));
	mreqn.imr_ifindex = if_nametoindex(argv[1]);
	if (!mreqn.imr_ifindex) {
		fprintf(stderr, "%s: \"%s\" invalid interface\n", argv[0],
		        argv[1]);
		exit(1);
	}
	if (inet_pton(AF_INET, argv[2], &mreqn.imr_multiaddr) <= 0) {
		fprintf(stderr, "%s: \"%s\" invalid group address\n", argv[0],
		        argv[2]);
		exit(1);
	}
	if (setsockopt(s, SOL_IP, IP_ADD_MEMBERSHIP, &mreqn,sizeof mreqn) < 0) {
		perror("IP_ADD_MEMBERSHIP");
		exit(1);
	}
	printf("joined group %s on %s (pausing...)\n", argv[2], argv[1]);
	fflush(stdout);
	pause();
	exit(0);
}
--------------------------------------------------------------------------------
================================================================================

