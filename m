Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTIBHeg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 03:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262452AbTIBHeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 03:34:11 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:38928 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S263688AbTIBHd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 03:33:56 -0400
Date: Tue, 2 Sep 2003 09:33:53 +0200
To: Pekka Pietikainen <pp@ee.oulu.fi>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: 2.4, b44 transmit timeout
Message-ID: <20030902073353.GA935@gamma.logic.tuwien.ac.at>
References: <20030901193235.GA8280@gamma.logic.tuwien.ac.at> <20030901200022.GA3070@ee.oulu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030901200022.GA3070@ee.oulu.fi>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Mon, 01 Sep 2003, Pekka Pietikainen wrote:
> Argh, I had hoped the driver was BugFree (tm)!

grin -- nothing is bug free.

> +		printk(KERN_DEBUG "b44_tx cons: %d cur: %d skb: %p\n",cons,cur,skb);
> 
> +	printk(KERN_DEBUG "b44_start_xmit ctrl: %x addr: %p entry: %d skb: %p",bp->tx_ring[entry].ctrl,bp->tx_ring[entry].addr,entry,skb);
> 
> Also setting B44_FLAG_BUGGY_TXPTR and B44_FLAG_REORDER_BUG in

I have done all of this and here is a syslog excerpt with comments:

* Ok, loading b44 modules
Sep  2 09:20:08 gandalf vmunix: b44.c:v0.9 (Jul 14, 2003)
Sep  2 09:20:08 gandalf vmunix: eth0: Broadcom 4400 10/100BaseT Ethernet 00:c0:9f:1f:59:38

* Configuring by hand with ifconfig eth0 192.168.1.13
Sep  2 09:20:16 gandalf vmunix: b44: eth0: Link is down.
Sep  2 09:20:18 gandalf vmunix: b44: eth0: Link is up at 100 Mbps, full duplex.
Sep  2 09:20:18 gandalf vmunix: b44: eth0: Flow control is on for TX and on for RX.

* pinging the gateway (.1.1), working
Sep  2 09:20:22 gandalf vmunix: b44_start_xmit ctrl: e000002a addr: 5cea5d82 entry: 0 skb: d935b480
Sep  2 09:20:22 gandalf vmunix: b44_tx cons: 0 cur: 1 skb: d935b480
Sep  2 09:20:22 gandalf vmunix: b44_start_xmit ctrl: e0000062 addr: 5f982982 entry: 1 skb: d935b680
Sep  2 09:20:22 gandalf vmunix: b44_tx cons: 1 cur: 2 skb: d935b680
Sep  2 09:20:23 gandalf vmunix: b44_start_xmit ctrl: e0000062 addr: 5f982682 entry: 2 skb: d935b480
Sep  2 09:20:23 gandalf vmunix: b44_tx cons: 2 cur: 3 skb: d935b480
Sep  2 09:20:24 gandalf vmunix: b44_start_xmit ctrl: e0000062 addr: 5f982682 entry: 3 skb: d935b480
Sep  2 09:20:24 gandalf vmunix: b44_tx cons: 3 cur: 4 skb: d935b480
Sep  2 09:20:25 gandalf vmunix: b44_start_xmit ctrl: e0000062 addr: 5f982982 entry: 4 skb: d935b480
Sep  2 09:20:25 gandalf vmunix: b44_tx cons: 4 cur: 5 skb: d935b480
Sep  2 09:20:26 gandalf vmunix: b44_start_xmit ctrl: e0000062 addr: 5f982682 entry: 5 skb: d935b480
Sep  2 09:20:26 gandalf vmunix: b44_tx cons: 5 cur: 6 skb: d935b480
Sep  2 09:20:27 gandalf vmunix: b44_start_xmit ctrl: e000002a addr: 5cea5082 entry: 6 skb: d935ba80
Sep  2 09:20:27 gandalf vmunix: b44_tx cons: 6 cur: 7 skb: d935ba80
Sep  2 09:20:27 gandalf kernel: b44_start_xmit ctrl: e0000062 addr: 5f982982 entry: 7 skb: d935ba80
Sep  2 09:20:27 gandalf kernel: b44_tx cons: 7 cur: 8 skb: d935ba80
Sep  2 09:20:28 gandalf kernel: b44_start_xmit ctrl: e0000062 addr: 5f982682 entry: 8 skb: d935b480
Sep  2 09:20:28 gandalf kernel: b44_tx cons: 8 cur: 9 skb: d935b480
Sep  2 09:20:29 gandalf kernel: b44_start_xmit ctrl: e0000062 addr: 5f982982 entry: 9 skb: d935b480
Sep  2 09:20:29 gandalf kernel: b44_tx cons: 9 cur: 10 skb: d935b480

* stopping ping, ifconfig eth0 down, starting pump for getting dhcp
* address, no success!
Sep  2 09:20:41 gandalf pumpd[7584]: starting at (uptime 0 days, 2:04:19) Tue Sep  2 09:20:41 2003  
Sep  2 09:20:41 gandalf pumpd[7584]: PUMP: sending discover 
Sep  2 09:20:44 gandalf vmunix: b44: eth0: Link is up at 100 Mbps, full duplex.
Sep  2 09:20:44 gandalf vmunix: b44: eth0: Flow control is on for TX and on for RX.
Sep  2 09:20:55 gandalf pumpd[7584]: PUMP: sending discover 
Sep  2 09:20:58 gandalf vmunix: b44: eth0: Link is up at 100 Mbps, full duplex.
Sep  2 09:20:58 gandalf vmunix: b44: eth0: Flow control is on for TX and on for RX.

* killing pump, ifconfig manually again
Sep  2 09:21:43 gandalf vmunix: b44: eth0: Link is up at 100 Mbps, full duplex.
Sep  2 09:21:43 gandalf vmunix: b44: eth0: Flow control is on for TX and on for RX.

* pinging the gateway, not working this time
Sep  2 09:21:48 gandalf vmunix: NETDEV WATCHDOG: eth0: transmit timed out
Sep  2 09:21:48 gandalf vmunix: b44: eth0: transmit timed out, resetting
Sep  2 09:21:48 gandalf vmunix: b44_start_xmit ctrl: e000002a addr: 5cea5682 entry: 0 skb: d935c680
Sep  2 09:21:48 gandalf vmunix: b44_start_xmit ctrl: e000002a addr: 5cea5082 entry: 1 skb: d8de1b80
Sep  2 09:21:49 gandalf vmunix: b44_start_xmit ctrl: e000002a addr: 5cea5782 entry: 2 skb: d935b480
Sep  2 09:21:49 gandalf vmunix: b44: eth0: Link is down.
Sep  2 09:21:50 gandalf vmunix: b44_start_xmit ctrl: e000002a addr: 5cea5d82 entry: 3 skb: d935c480
Sep  2 09:21:51 gandalf vmunix: b44_start_xmit ctrl: e000002a addr: 5cea5882 entry: 4 skb: d8de1e80
Sep  2 09:21:51 gandalf vmunix: b44: eth0: Link is up at 100 Mbps, full duplex.
Sep  2 09:21:51 gandalf vmunix: b44: eth0: Flow control is on for TX and on for RX.
Sep  2 09:21:52 gandalf vmunix: b44_start_xmit ctrl: e000002a addr: 5cea5982 entry: 5 skb: d935cb80
Sep  2 09:21:53 gandalf vmunix: b44_start_xmit ctrl: e000002a addr: 5cea5482 entry: 6 skb: d8de1680
Sep  2 09:21:54 gandalf vmunix: b44_start_xmit ctrl: e000002a addr: 5cea5b82 entry: 7 skb: d935c580
Sep  2 09:21:55 gandalf vmunix: b44_start_xmit ctrl: e000002a addr: 5cea5e82 entry: 8 skb: d8de1980
Sep  2 09:21:56 gandalf vmunix: b44_start_xmit ctrl: e000002a addr: 5f982982 entry: 9 skb: d8de1480
Sep  2 09:21:57 gandalf vmunix: b44_start_xmit ctrl: e000002a addr: 4863ac82 entry: 10 skb: d935ce80
Sep  2 09:21:58 gandalf vmunix: b44_start_xmit ctrl: e000002a addr: 4863ae82 entry: 11 skb: d8de1880
Sep  2 09:21:59 gandalf vmunix: b44_start_xmit ctrl: e000002a addr: 5cea5a82 entry: 12 skb: d8de1280
Sep  2 09:22:00 gandalf vmunix: b44_start_xmit ctrl: e000002a addr: 4863ab82 entry: 13 skb: d8de1780

I can reproduce this.

Anything I can do more? Hope this helps.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
GLOADBY MARWOOD (n.)
Someone who stops Jon Cleese on the street and demands that he does a
funny walk.
			--- Douglas Adams, The Meaning of Liff
