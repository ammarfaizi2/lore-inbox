Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbVIIRjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbVIIRjh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 13:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbVIIRjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 13:39:37 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:34797 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1030286AbVIIRjg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 13:39:36 -0400
Date: Fri, 9 Sep 2005 19:39:28 +0200
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
Subject: TCP segmentation offload performance
Message-ID: <20050909173928.GI4823@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello, world!

	I tried to find out whether the TCP segmentation offload
can perform better on my server than no TSO at all. My server
is dual Opteron 244 with Tyan S2882 board with the following NIC:

eth0: Tigon3 [partno(BCM95704A7) rev 2003 PHY(5704)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:27:de:17
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
eth0: dma_rwctrl[769f4000]

The server runs ProFTPd with sendfile(2) enabled (and I have verified
that it is being used with strace(8)). The kernel is 2.6.12.2.

	I have found that according to ethtool -k eth0 the TSO is switched
off by default. So I tried to switch it on (altough I wondered why it is
not switched on by default, provided that the hardware supports this feature).

	I tried to measure the difference by downloading an ISO image of
FC4 i386 CD1 (665434112 bytes) from two hosts connected to the same
switch. I did 10 transfers of the same file with each settings, and took
the average and maximum of the last five transfers only (to avoid any
start-up temporary conditions). The client Alpha was dual Opteron 248
with Tyan S2882 board, and the client Beta was quad Opteron 848 on HP
DL-585 board.

Client	TSO	Average speed	Max speed
Alpha	off	108.7 MB/s	110.5 MB/s
Alpha	on	100.9 MB/s	101.2 MB/s
Beta	off	102.1 MB/s	102.4 MB/s
Beta	on	93.2 MB/s	95.5 MB/s

	Surprisingly enough, the tests without TSO were faster than with TSO
enabled. Looking at tcpdump it seems that the system with TSO enabled
sends only a 15 KB-sized frames to the NIC instead of full 64 KB-sized
ones:

18:45:38.993150 IP odysseus.ftp-data > alpha.33125: P 127424:143352(15928) ack 1 win 1460 <nop,nop,timestamp 2408404 698142942>
18:45:38.993203 IP odysseus.ftp-data > alpha.33125: P 143352:159280(15928) ack 1 win 1460 <nop,nop,timestamp 2408404 698142942>

	So I wonder what is wrong with TSO on my hardware and whether
the TSO is expected to be faster than generating MTU-sized packets in the
TCP stack. I did not measure the CPU usage on the server, only the
network speed.

Thanks!

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
>>> $ cd my-kernel-tree-2.6                                              <<<
>>> $ dotest /path/to/mbox  # yes, Linus has no taste in naming scripts  <<<
