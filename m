Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269001AbUJTTOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269001AbUJTTOo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 15:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269003AbUJTTOC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:14:02 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:26321 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S269250AbUJTTMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:12:19 -0400
Date: Wed, 20 Oct 2004 21:12:04 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: 2.6.9 network regression killing amanda - 3c59x?
Message-ID: <20041020191203.GA14356@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-net@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Note I'm not subscribed to linux-net, remember to Cc: replies]

Greetings,

after upgrading from 2.6.8.1 to 2.6.9, my Amanda server is no longer
receiving backups from its clients (except the one on its own loopback
interface) although estimates succeed (tcpdump excerpt below).

I am suspecting network driver trouble, as the server never sees the
sendbackup packets from remote clients and tcpdump logs a bad udp
checksum (which, I believe, causes Linux to discard the packet) in
2.6.9, but "udp sum ok" and working backup in 2.6.8.1, 2.6.7 and SuSE's
2.6.5-7.108-default.

Hardware: server uses amanda 2.4.4p2 and these cards
eth0 - 3Com 3c900 Combo (Boomerang) with 10Base2 Coax/BNC to client A
eth1 - 3Com 3c905 100BaseTX (Boomerang) with 10BaseT HD to DSL modem
eth2 - 3Com 3c905 100BaseTX (Boomerang) with 100BaseTX FD to client B
eth3 - VIA VT6102 (Rhine-II), unconnected

br0 bridges eth0 and eth2, with net.bridge.bridge-nf-call-iptables = 0.

client A uses a 3Com 3C900B-Combo and Linux 2.6.5
client B uses an Intel 82550 Pro/100 Ethernet and FreeBSD 4.10-RELEASE-p3


Has the 3c59x driver changed between 2.6.8.1 and 2.6.9?

Which patches or changesets are worth backing out?

Any directions for debugging?


Here are tcpdumps, taken on the server with -ibr0, client is connected
to eth0, the "Combo" card. The client was unchanged between the server
reboots:

Linux 2.6.9:

20:11:47.529071 IP (tos 0x0, ttl  64, id 27, offset 0, flags [DF], length: 153) 192.168.0.48.10080 > 192.168.0.1.985: [bad udp cksum a00!] UDP, length: 125
0x0000   4500 0099 001b 4000 4011 b8b7 c0a8 0030        E.....@.@......0
0x0010   c0a8 0001 2760 03d9 0085 b9ec 416d 616e        ....'`......Aman
0x0020   6461 2032 2e34 2052 4550 2048 414e 444c        da.2.4.REP.HANDL
0x0030   4520 3030 302d 4630 4241 3038 3038 2053        E.000-F0BA0808.S
0x0040   4551 2031 3039 3832 3935 3634 360a 434f        EQ.1098295646.CO
0x0050   4e4e 4543 5420 4441 5441 2033 3238 3830        NNECT.DATA.32880
0x0060   204d 4553 4720 3332 3838 3120 494e 4445        .MESG.32881.INDE
0x0070   5820 3332 3838 3200 4f50 5449 4f4e 5320        X.32882.OPTIONS.
0x0080   6665 6174 7572 6573 3d66 6666 6666 6566        features=fffffef
0x0090   6639 6666 6530 663b 0a                         f9ffe0f;.

Linux 2.6.8.1:

20:48:25.880812 IP (tos 0x0, ttl  64, id 51, offset 0, flags [DF], length: 153) 192.168.0.48.10080 > 192.168.0.1.706 [udp sum ok] UDP, length: 125
0x0000   4500 0099 0033 4000 4011 b89f c0a8 0030        E....3@.@......0
0x0010   c0a8 0001 2760 02c2 0085 b90c 416d 616e        ....'`......Aman
0x0020   6461 2032 2e34 2052 4550 2048 414e 444c        da.2.4.REP.HANDL
0x0030   4520 3030 302d 4630 4241 3038 3038 2053        E.000-F0BA0808.S
0x0040   4551 2031 3039 3832 3937 3933 340a 434f        EQ.1098297934.CO
0x0050   4e4e 4543 5420 4441 5441 2033 3239 3133        NNECT.DATA.32913
0x0060   204d 4553 4720 3332 3931 3420 494e 4445        .MESG.32914.INDE
0x0070   5820 3332 3931 350a 4f50 5449 4f4e 5320        X.32915.OPTIONS.
0x0080   6665 6174 7572 6573 3d66 6666 6666 6566        features=fffffef
0x0090   6639 6666 6530 663b 0a                         f9ffe0f;.

-- 
Matthias Andree
