Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266545AbUFVDfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266545AbUFVDfh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 23:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266546AbUFVDff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 23:35:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:60832 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266545AbUFVDf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 23:35:27 -0400
Date: Mon, 21 Jun 2004 20:35:21 -0700
From: Chris Wright <chrisw@osdl.org>
To: Bob Gill <gillb4@telusplanet.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akepner@sgi.com
Subject: Re: [2.6.7-bk] NFS-related kernel panic
Message-ID: <20040621203520.H22989@build.pdx.osdl.net>
References: <1087872607.4066.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1087872607.4066.13.camel@localhost.localdomain>; from gillb4@telusplanet.net on Mon, Jun 21, 2004 at 08:50:08PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Bob Gill (gillb4@telusplanet.net) wrote:
> Ok.  I get (a very similar) error with 2.6.7-bk4.
> The error message I get is:
> Starting portmapper:                            [OK]
> Starting NFS statd: Kernel panic: Aiee, killing interrupt handler!
> bad: scheduling while atomic!
>  [<c02a2c37>] schedule+0x483/0x488
>  [<c0133298>] __get_free_pages+0x33/0x3f
>  [<c026974c>] tcp_poll+0x34/0x15a
>  [<c02a30b5>] schedule_timeout+0xb5/0xb7
>  [<c0248fb3>] sock_poll+0x29/0x31
>  [<c015da2e>] do_pollfd+0x4f/0x90
>  [<c015db10>] do_poll+0xa1/0xc0
>  [<c016dc7e>] sys_poll+0x14f/0x211
>  [<c015d09d>] __pollwait+0x0/0xc6
>  [<c014afd2>] sys_close+0x63/0x96
>  [<c0103eb1>] sysenter_past_esp+0x52/0x71
> In interrupt handler - not syncing

The lockless loopback transmission patch mucks up the preempt count.
Can you give this patch a try?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

===== loopback.c 1.15 vs edited =====
--- 1.15/drivers/net/loopback.c	2004-06-20 17:35:52 -07:00
+++ edited/loopback.c	2004-06-21 20:23:06 -07:00
@@ -143,10 +143,11 @@
 
 	dev->last_rx = jiffies;
 	if (likely(loopback_stats)) {
-		get_cpu_ptr(loopback_stats)->rx_bytes += skb->len;
-		get_cpu_ptr(loopback_stats)->tx_bytes += skb->len;
-		get_cpu_ptr(loopback_stats)->rx_packets++;
-		get_cpu_ptr(loopback_stats)->tx_packets++;
+		struct net_device_stats *stats = get_cpu_ptr(loopback_stats);
+		stats->rx_bytes += skb->len;
+		stats->tx_bytes += skb->len;
+		stats->rx_packets++;
+		stats->tx_packets++;
 		put_cpu_ptr(loopback_stats);
 	}
 
